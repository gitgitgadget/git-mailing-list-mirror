Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445BA1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 12:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeIARFa (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 13:05:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46693 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeIARFa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 13:05:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so10893296edr.13
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=IXbUA+4rIcrtduWs4vkwpM/2j8paYCdlf3Ou27YUnkg=;
        b=hcTV0juvg/qxdiUoe0BZMDGF17xPFJApWMgj1Dy+2S8mDFl+wKAtEiNYuiAjRy3UnT
         B6PDngge80nbRA7McZom2Zh2ZirV2Ez8d0+o5Z1ejz1bRcvASTe2YOO1nt5btSVHesK7
         NbrU4fouPXmxfArZVBr5JmX+kl1lehzE2/8WRAS0nSWxuM2IkmmMji71MIU+7UZDkEc9
         LdX2dzQgDRRJ2eV59KrhxiSW34fgtG4F9QUmkbd/TQv4TZcJkG12K0uIqBc0EH7ua5bX
         kSXt+FX8J/e2gaGYPJdwqb6KqBtTgRY6hSX8bRE/P7+J4+sw0UpZ0AuUGnKeB4ds+KqV
         m2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=IXbUA+4rIcrtduWs4vkwpM/2j8paYCdlf3Ou27YUnkg=;
        b=JamVqw+L3CFlFe91/4t0e4LEjt986y7cazw38TR/m++jiSpHRP4G8tJWcVCmP39p1q
         KvnkxnAP3yLgAHOKpmTqO+rI7O2NpUBl1OHMALUvMuWgFghJlvnD+XBRaxauS9nOXE8m
         SDUsMftBLFYJ3tRzo0KjDt5vcxHxJWMCNye7i6/FBy3I7edmLhmor7/BXdz2xwc7oQsS
         TKRazDo9Po8Q0V2aJM7DtVJ+W6sLaV0WVUKtU5WrK7zrwsNHcYBL1VIZXf88i0M/z7E1
         hSEfkvyUEHw1+G+o56bDzEVE8mpPEoNMj6KUMR7MLC27u7u2EQB8m87oSHJrceoQOo6G
         QiGg==
X-Gm-Message-State: APzg51DfKw05kazKI30FsnanEe0Z8E6RB1dBZVSf7eO+oA9mmAiqk0xP
        3exuHWRb06T2jsHhJsYHZzOgsq8Y8nI=
X-Google-Smtp-Source: ANB0Vdb99Ljpgs37BgaPSj4LduQOMta6boxeYMG42sZm24oLIMgFPUiO7g3zpEMypimpcjPBQgomWg==
X-Received: by 2002:a50:f69b:: with SMTP id d27-v6mr22956848edn.103.1535806410708;
        Sat, 01 Sep 2018 05:53:30 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id y27-v6sm5554017edb.20.2018.09.01.05.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 05:53:29 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
Subject: Re: non-smooth progress  indication for git fsck and git gc
References: <5B751FA1020000A10002CD2F@gwsmtp1.uni-regensburg.de> <20180816155714.GA22739@sigill.intra.peff.net> <87bma2qcba.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87bma2qcba.fsf@evledraar.gmail.com>
Date:   Sat, 01 Sep 2018 14:53:28 +0200
Message-ID: <87y3clbcqf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 16 2018, Ævar Arnfjörð Bjarmason wrote:

> On Thu, Aug 16 2018, Jeff King wrote:
>
>> On Thu, Aug 16, 2018 at 08:54:25AM +0200, Ulrich Windl wrote:
>>
>>> I'd like to point out some minor issue observed while processing some
>>> 50000-object repository with many binary objects, but most are rather
>>> small:
>>>
>>> Between the two phases of "git fsck" (checking directories and
>>> checking objects) there was a break of several seconds where no
>>> progress was indicated.
>>>
>>> During "git gc" the writing objects phase did not update for some
>>> seconds, but then the percentage counter jumped like from 15% to 42%.
>>>
>>> I understand that updating the progress output too often can be a
>>> performance bottleneck, while upating it too rarely might only bore
>>> the user... ;-)
>>
>> We update the counter integer for every object we process, and then
>> actually update the display whenever the percentage increases or a
>> second has elapsed, whichever comes first.
>>
>> What you're seeing is likely an artifact of _what_ we're counting:
>> written objects. Not all objects are the same size, so it's not uncommon
>> to see thousands/sec when dealing with small ones, and then several
>> seconds for one giant blob.
>>
>> The only way to solve that is to count bytes. We don't have a total byte
>> count in most cases, and it wouldn't always make sense (e.g., the
>> "Compressing objects" meter can show the same issue, but it's not really
>> putting through bytes in a linear way).  In some cases we do show
>> transmitted size and throughput, but that's just for network operations.
>> We could do the same for "gc" with the patch below. But usually
>> throughput isn't all that interesting for a filesystem write, because
>> bandwidth isn't the bottleneck.
>>
>> Possibly we could have a "half throughput" mode that counts up the total
>> size written, but omits the speed indicator. That's not an unreasonable
>> thing to show for a local pack, since you end up with the final pack
>> size. The object counter would still be jumpy, but you'd at least have
>> one number updated at least once per second as you put through a large
>> blob.
>>
>> If you really want a smooth percentage, then we'd have to start counting
>> bytes instead of objects. Two reasons we don't do that are:
>>
>>   - we often don't know the total byte size exactly. E.g., for a
>>     packfile write, it depends on the result of deflating each object.
>>     You can make an approximation and just pretend at the end that you
>>     hit 100%.  Or you can count the pre-deflate sizes, but then your
>>     meter doesn't match the bytes from the throughput counter.
>>
>>   - for something like fsck, we're not actually writing out bytes.  So I
>>     guess you'd be measuring "here's how many bytes of objects I
>>     fsck-ed". But is that on-disk compressed bytes, or decompressed
>>     bytes?
>>
>>     If the former, that's only marginally better as a measure of effort,
>>     since delta compression means that a small number of on-disk bytes
>>     may require a big effort (imagine processing a 100 byte blob versus
>>     a 100 byte delta off of a 100MB blob).
>>
>>     The latter is probably more accurate. But it's also not free to
>>     pre-generate the total. We can get the number of objects or the size
>>     of the packfile in constant-time, but totaling up the uncompressed
>>     size of all objects is O(n). So that's extra computation, but it
>>     also means a potential lag before we can start the progress meter.
>>
>>     I'm also not sure how meaningful a byte count is for a user there.
>>
>> So there. That's probably more than you wanted to know about Git's
>> progress code. I think it probably _could_ be improved by counting
>> more/different things, but I also think it can be a bit of a rabbit
>> hole. Which is why AFAIK nobody's really looked too seriously into
>> changing it.
>>
>> -Peff
>
> This is all interesting, but I think unrelated to what Ulrich is talking
> about. Quote:
>
>     Between the two phases of "git fsck" (checking directories and
>     checking objects) there was a break of several seconds where no
>     progress was indicated
>
> I.e. it's not about the pause you get with your testcase (which is
> certainly another issue) but the break between the two progress bars.
>
> Here's a test case you can clone:
> https://github.com/avar/2015-04-03-1M-git (or might already have
> "locally" :)
>
> If you fsck this repository it'll take around (on my spinning rust
> server) 30 seconds between 100% of "Checking object directories" before
> you get any output from "Checking objects".
>
> The breakdown of that is (this is from approximate eyeballing):
>
>  * We spend 1-3 seconds just on this:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L181
>
>  * We spend the majority of the ~30s on this:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L70-L79
>
>  * Wes spend another 3-5 seconds on this QSORT:
>    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L105
>
> I.e. it's not about objects v.s. bytes, but the structural problem with
> the code that we pass a progress bar down to verify_pack() which does a
> lot of work in verify_pack_index() and verify_packfile() before we even
> get to iterating over the objects in the file, and only then do we start
> displaying progress.

This patch almost entirely fixes the problem, except for the 1-3 seconds
we take on the qsort:

    diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
    index df0630bc6d..6d6b9b54c4 100644
    --- a/sha1dc/sha1.c
    +++ b/sha1dc/sha1.c
    @@ -25,6 +25,7 @@

     #include "sha1.h"
     #include "ubc_check.h"
    +#include "../progress.h"

     #if (defined(__amd64__) || defined(__amd64) || defined(__x86_64__) || defined(__x86_64) || \
          defined(i386) || defined(__i386) || defined(__i386__) || defined(__i486__)  || \
    @@ -1820,6 +1821,8 @@ void SHA1DCSetCallback(SHA1_CTX* ctx, collision_block_callback callback)
     void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
     {
            unsigned left, fill;
    +       struct progress *progress;
    +       size_t len_cp = len, done = 0;

            if (len == 0)
                    return;
    @@ -1836,6 +1839,8 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
                    len -= fill;
                    left = 0;
            }
    +
    +       progress = start_delayed_progress(_("Hashing"), len_cp);
            while (len >= 64)
            {
                    ctx->total += 64;
    @@ -1848,7 +1853,12 @@ void SHA1DCUpdate(SHA1_CTX* ctx, const char* buf, size_t len)
     #endif /* defined(SHA1DC_ALLOW_UNALIGNED_ACCESS) */
                    buf += 64;
                    len -= 64;
    +               done += 64;
    +               display_progress(progress, done);
            }
    +       display_progress(progress, len_cp);
    +       stop_progress(&progress);
    +
            if (len > 0)
            {
                    ctx->total += len;

With this we'll get output like:

    $ ~/g/git/git  -C ~/g/2015-04-03-1M-git/  --exec-path=$PWD fsck
    Checking object directories: 100% (256/256), done.
    Hashing: 100% (452634108/452634108), done.
    Hashing: 100% (1073741824/1073741824), done.
    Hashing: 100% (1073741824/1073741824), done.
    Hashing: 100% (1008001572/1008001572), done.
    Checking objects:   2% (262144/13064614)
    ^C

All tests pass with this. Isn't it awesome? Except it's of course a
massive hack, we wouldn't want to just hook into SHA1DC like this.

The problem comes down to us needing to call git_hash_sha1_update() with
some really huge input, that function is going to take a *long* time,
and the only way we're getting incremental progress is:

 1) If we ourselves split the input into N chunks
 2) If we hack into the SHA1 library itself

This patch does #2, but for this to be acceptable we'd need to do
something like #1.

The least hacky way I can think of doing this is something like the
following: We'd define two git_hash_algo entries for SHA-1, one that could give you
progress reports, and that one would only ever hash in chunks of at most
size N, and would wrap git_SHA1_Update() in something similar to the
progress code above.

We'd also need to extend the git_hash_algo struct to e.g. have a char *
we'd use as a description, instead of just "Hashing".

Then the caller here could just switch out the hash algo if
show_progress was true, temporarily some "int do_progress" and "char
*progress_description" entries in the struct, and off we go:

    https://github.com/git/git/blob/63749b2dea5d1501ff85bab7b8a7f64911d21dea/pack-check.c#L69-L80

Still a hack, but I can't see another way of making it work without
compromising all hashing performance with some progress reporting.
