Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291C61F404
	for <e@80x24.org>; Thu, 16 Aug 2018 20:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbeHPXgc (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 19:36:32 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:33031 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeHPXgb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 19:36:31 -0400
Received: by mail-ed1-f50.google.com with SMTP id x5-v6so3389705edr.0
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8cZW90Pybs8GjV/FdX9xHrzWFtBSsiGFnJMFRUgAAGs=;
        b=WbpvFNygXr18HRXKnZa/EJzEEFrY+FevvJNU2cTPHQ37M3xPG9u9+RR/cWSMO6JNIP
         d55tkuZdNJDEhsoD58s/MER7wH7PERu9U+zxlAwBmJ3wyK70OAmZWelV5b/i7OUq4qIe
         7CS8Tn8Z4t/yG67RgEzbWdbcNe62aJcqLTsgr35KSg0iH7KuTIBjCOZ0AoHyFegpxvsj
         6GQj3s6tWtOQ7TNQ5V4TcsZ/YZZvkCYUA9gDToLm3w49QzNO1nYuIEhN3XJY8KTMyxls
         aKa+qRZKXmHzZB3ka/bMjPwSUQHT4/7KDquLC0Rz0uQcockfjWNsdGxCIZqguP2OjVDA
         E2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8cZW90Pybs8GjV/FdX9xHrzWFtBSsiGFnJMFRUgAAGs=;
        b=VQMV79+7jeFPdRFXv7TsLWyTdtVLZGozULYhD2HfO2yt77BiwLMPyjRTJjNg40FT0u
         Tn5X2p9VuAj8KIJq5AYXruTsEXjk4PyuVUzEtrxQGYziaVWM8wuXkKX6pk+biiKSrYVH
         PeQmEjlovet4qhM4oNjaYUM9xK44VgYSrMTo5SZtKMPpswA6RoRIarTN/2gnLbI6aYSb
         xgq2kFlOBRLLp2L2FXtcvhrdM103d/Io7KELA/5LuQJ8F13TxiY53yI/mojvJWuZaRuX
         2hpq6EgP1UGqv6u0781XSvmFUP9lSjZhx+RuP2DD91pU71I+8nnTuHYQmkyMLyiKtMuz
         h9Sg==
X-Gm-Message-State: AOUpUlE/MTZ091wNcLwB83f726WEoFw2B90ea4LoRJX6eCcJSkiy9aLD
        itWM2Du/8CntU6BKy5CtzaMSMz+cPFQ=
X-Google-Smtp-Source: AA+uWPxiBHxMkKQ7Mr8+2iJQfg+UWCGQIJJ7FuC8aufZF86uPI36YdOmh8JPkgUWSD6g8W6zjbnZBQ==
X-Received: by 2002:a50:c292:: with SMTP id o18-v6mr40123798edf.188.1534451755273;
        Thu, 16 Aug 2018 13:35:55 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id m20-v6sm848813eds.5.2018.08.16.13.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 13:35:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de> <20180816155714.GA22739@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180816155714.GA22739@sigill.intra.peff.net>
Date:   Thu, 16 Aug 2018 22:35:53 +0200
Message-ID: <87bma2qcba.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 16 2018, Jeff King wrote:

> On Thu, Aug 16, 2018 at 08:54:25AM +0200, Ulrich Windl wrote:
>
>> I'd like to point out some minor issue observed while processing some
>> 50000-object repository with many binary objects, but most are rather
>> small:
>>
>> Between the two phases of "git fsck" (checking directories and
>> checking objects) there was a break of several seconds where no
>> progress was indicated.
>>
>> During "git gc" the writing objects phase did not update for some
>> seconds, but then the percentage counter jumped like from 15% to 42%.
>>
>> I understand that updating the progress output too often can be a
>> performance bottleneck, while upating it too rarely might only bore
>> the user... ;-)
>
> We update the counter integer for every object we process, and then
> actually update the display whenever the percentage increases or a
> second has elapsed, whichever comes first.
>
> What you're seeing is likely an artifact of _what_ we're counting:
> written objects. Not all objects are the same size, so it's not uncommon
> to see thousands/sec when dealing with small ones, and then several
> seconds for one giant blob.
>
> The only way to solve that is to count bytes. We don't have a total byte
> count in most cases, and it wouldn't always make sense (e.g., the
> "Compressing objects" meter can show the same issue, but it's not really
> putting through bytes in a linear way).  In some cases we do show
> transmitted size and throughput, but that's just for network operations.
> We could do the same for "gc" with the patch below. But usually
> throughput isn't all that interesting for a filesystem write, because
> bandwidth isn't the bottleneck.
>
> Possibly we could have a "half throughput" mode that counts up the total
> size written, but omits the speed indicator. That's not an unreasonable
> thing to show for a local pack, since you end up with the final pack
> size. The object counter would still be jumpy, but you'd at least have
> one number updated at least once per second as you put through a large
> blob.
>
> If you really want a smooth percentage, then we'd have to start counting
> bytes instead of objects. Two reasons we don't do that are:
>
>   - we often don't know the total byte size exactly. E.g., for a
>     packfile write, it depends on the result of deflating each object.
>     You can make an approximation and just pretend at the end that you
>     hit 100%.  Or you can count the pre-deflate sizes, but then your
>     meter doesn't match the bytes from the throughput counter.
>
>   - for something like fsck, we're not actually writing out bytes.  So I
>     guess you'd be measuring "here's how many bytes of objects I
>     fsck-ed". But is that on-disk compressed bytes, or decompressed
>     bytes?
>
>     If the former, that's only marginally better as a measure of effort,
>     since delta compression means that a small number of on-disk bytes
>     may require a big effort (imagine processing a 100 byte blob versus
>     a 100 byte delta off of a 100MB blob).
>
>     The latter is probably more accurate. But it's also not free to
>     pre-generate the total. We can get the number of objects or the size
>     of the packfile in constant-time, but totaling up the uncompressed
>     size of all objects is O(n). So that's extra computation, but it
>     also means a potential lag before we can start the progress meter.
>
>     I'm also not sure how meaningful a byte count is for a user there.
>
> So there. That's probably more than you wanted to know about Git's
> progress code. I think it probably _could_ be improved by counting
> more/different things, but I also think it can be a bit of a rabbit
> hole. Which is why AFAIK nobody's really looked too seriously into
> changing it.
>
> -Peff

This is all interesting, but I think unrelated to what Ulrich is talking
about. Quote:

    Between the two phases of "git fsck" (checking directories and
    checking objects) there was a break of several seconds where no
    progress was indicated

I.e. it's not about the pause you get with your testcase (which is
certainly another issue) but the break between the two progress bars.

Here's a test case you can clone:
https://github.com/avar/2015-04-03-1M-git (or might already have
"locally" :)

If you fsck this repository it'll take around (on my spinning rust
server) 30 seconds between 100% of "Checking object directories" before
you get any output from "Checking objects".

The breakdown of that is (this is from approximate eyeballing):

 * We spend 1-3 seconds just on this:
   https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L181

 * We spend the majority of the ~30s on this:
   https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79

 * Wes spend another 3-5 seconds on this QSORT:
   https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L105

I.e. it's not about objects v.s. bytes, but the structural problem with
the code that we pass a progress bar down to verify_pack() which does a
lot of work in verify_pack_index() and verify_packfile() before we even
get to iterating over the objects in the file, and only then do we start
displaying progress.
