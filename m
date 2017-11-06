Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F365E20450
	for <e@80x24.org>; Mon,  6 Nov 2017 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbdKFOEG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 09:04:06 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46649 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753316AbdKFOEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 09:04:05 -0500
Received: by mail-wm0-f54.google.com with SMTP id r68so14054455wmr.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 06:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=jZTQCZAA/Jbgq/D3TT7IH7HD2V/xc5qfTdNOA1EsVqI=;
        b=buSFfHicbyYDVCXft489kknLXtTfKMNFpT0L+ZFXER49AsQfZMezfzNorIOYc1OCfm
         mF4SJGQ6nKUXSXsFnH6+RNCWPL3tb0RpEFHxKaOdtZViUqPln6NY72f0gmOjNV7SW9SZ
         bc40BdQVCGLmY6KpfXaY4Y4aCqDpolpAh4UtsuMJefEdOqE0OC8CUlb0EKRagIHemPWq
         HkBroBWHDjRtnLKKos9YcJG4JplgK+I0scAHy3HusycS2/pKiAs/gNsLY2xD83Z74jWR
         lBHpyta1yQg8E5PEFxO/TNjbajfx3xIcV2B1ct+JALRg8f81NogoRwwNlrdmipEFGZjG
         ccZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=jZTQCZAA/Jbgq/D3TT7IH7HD2V/xc5qfTdNOA1EsVqI=;
        b=OzeDarSiydWiyT73FSKleb2jVPBLIPAD7m6XBOREUzEV404xoR2ET+rZVV04RkSGNR
         DN/AH0P6K++hKrqR7//gQomSKtyEW14zi1fFtqe5MzMYkfUPREfU2J0B4fqHvg6V/Zyl
         rP8gFTOSPJfJ5tbCIFimMOV9pyx87i4ic7tbTbxJE7hFEneK/UQO7LAvDnLn7ysW7MBu
         SdrDmBdK2QxlVYJxjjL5e4ZNh3QNfD+Ct8HxrSdjLhAiKXx6iU2zO+TAFrqHj1FC2QR/
         O5fY4KhKQJL3siQsqwHR9ZERT+HUOFxdMmPSN2IzAmeTBl2CjN1US+LnRg60Y46GbaO6
         h5KA==
X-Gm-Message-State: AMCzsaXoY2nHKOxAPSx9Nr4P84cD+/llBht2A/SlWy0d2ooHPeGfGoBl
        nzbvadvCWhjFK0hrxNi00Po=
X-Google-Smtp-Source: ABhQp+RoheUS3/weyXvtjumsyIY4ESvByL/zt6WHCoghP4HWGQQLkFY1wfb0s3B0Gn8+G3oPGxt10w==
X-Received: by 10.80.130.67 with SMTP id 61mr20639595edf.3.1509977044156;
        Mon, 06 Nov 2017 06:04:04 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f27sm10597528edj.82.2017.11.06.06.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Nov 2017 06:04:03 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eBi0Q-0000r7-FI; Mon, 06 Nov 2017 15:04:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, git@vger.kernel.org
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org> <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net> <4e2bc579-429f-9927-4502-5929e5235740@aegee.org> <20171106103125.fwtrxv6zycrbihcv@sigill.intra.peff.net> <878tfj62y2.fsf@evledraar.booking.com> <20171106122411.dhi2ltyegzquebhk@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171106122411.dhi2ltyegzquebhk@sigill.intra.peff.net>
Date:   Mon, 06 Nov 2017 15:04:02 +0100
Message-ID: <877ev35wrx.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 06 2017, Jeff King jotted:

> On Mon, Nov 06, 2017 at 12:50:45PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> Some replies to the thread in general, didn't want to spread this out
>> into different replies.
>>
>>  * Yes this sucks.
>>
>>  * Just emitting a warning without an appropriate exit code would suck
>>    more, would break batch jobs & whatnot that expcept certain results
>>    from grep.
>
> That was my first thought, too, but something that does:
>
>   git grep foo && echo found
>
> would behave basically the same. Do you mean here scripts that actually
> do:
>
>   git grep foo
>   case "$?" in
>   0) echo found ;;
>   1) echo not found ;;
>   *) echo wtf? ;;
>   esac
>
> I agree it would be nice to at least have _some_ way to distinguish
> between those final two cases.

Maybe we should emit a different exit code, but I just had in mind that
we could continue but the same non-zero as when the grep fails now, but
with an additional warning.

> Though something like "git log --grep" is even more complicated. We
> perhaps _would_ want to distinguish between:
>
>   - match (in which case we print the commit)
>
>   - no match (in which case we do not)
>
>   - error (in which case we do not print, but also mark the exit code as
>     failing)
>
>>  * As you point out it would be nice to print out the file name we
>>    didn't match on, we'd need to pass the grep_source struct down
>>    further, it goes as far as grep_source_1 but stops there and isn't
>>    passed to e.g. look_ahead(), which calls patmatch() which calls the
>>    engine-specific matcher and would need to report the error. We could
>>    just do this, would slow down things a bit (probably trivally) but we
>>    could emit better error messages in genreal.
>
> I'm not sure if the grep_source has enough information for all cases.
> E.g., if you hit an error while grepping in commit headers, you'd
> probably want to mention the oid of the commit. There's an "identifier"
> field in the grep_source, but it's opaque.
>
> The caller may also want to do more things than just print an error
> (like the exit code adjustment I mentioned above). Which implies to me
> we should be passing the error information up, not trying to bring the
> context down.

Indeed, I was just thinking of the case where we're grepping a file in
the tree, not when the engine is used for --grep et al.

>>  * You can adjust these limts in PCRE in Git, although it doesn't help
>>    in this case, you just add (*LIMIT_MATCH=NUM) or
>>    (*LIMIT_RECURSION=NUM) (or both) to the start of the pattern. See
>>    pcresyntax(3) or pcre2syntax(3) man pages depending on what version
>>    you have installed.
>
> I saw that in the pcre manual, but I had the impression you can't
> actually raise the limits above the defaults with that, only lower them.

You can, you just can't set them to anything less conservative than
limits already set via the C API, but we don't set any of those.

I.e. PCRE allows you to say expose a regex field in a web form (as we do
with gitweb) with really conservative settings that can't be overriden
via a (*LIMIT) set in the pattern.

But since we don't use that C API PCRE runs in a mode where the user
gets set whatever limit they want in the pattern (or other
pattern-altering switch), which makes sense for interactive git-grep
use.

>>  * While regexec() won't return an error its version of dealing with
>>    this is (at least under glibc) to balloon CPU/memory use until the
>>    OOMkiller kills git (although not on this particular pattern).
>
> So in a sense our current behavior with pcre is the same. We just have
> to provoke the death ourselves. ;)

Indeed :)
