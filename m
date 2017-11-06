Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C71202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 11:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbdKFLuu (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 06:50:50 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:45950 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdKFLut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 06:50:49 -0500
Received: by mail-wm0-f54.google.com with SMTP id y80so13154827wmd.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 03:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6hwygJ8MEwplr9UBDy/XNkiSwRsZUTBp1lRo0EUiPi0=;
        b=MnkLht7CPsWof3Z2rZlx1ckPhbcxwm2CZEjQ3fAjSUGCyASoP33KyTQwwXC21UAv+G
         PteBTGunK6ple3ueNwl9zELNoswI3Gxg/62EOZkn3mcJCCxJNNl+pn0tr011oY3AZt84
         YPrQkkC5Rbr91TSZVJ0R2EP7uIZw8gqZDkBMixrPTeZyFJy0LKFEvtEJJdrDhvinjyJr
         zJvEAodDYZQAYhIiKixmc4SWZsZWBPfoifp/hHY0vPzskrQGJle5iTG1bqPiL20yFXfV
         LL6/mMgOP2ECrw4yy4/L0P5Pf6zzmqrial4ibYnMPgG4J2FX7rUt0d9UvL39o2A9R4/+
         l7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=6hwygJ8MEwplr9UBDy/XNkiSwRsZUTBp1lRo0EUiPi0=;
        b=pDR18rT+yViEWuiCTE+DtJdhWkrlEITVXXyFemzKqDUc+LlRG4wd2gkCKVbQKF9HEb
         ZE6hsQMmmDivTlgax5A0bIxl9w0iLvBmb6INd2raIHCzmya7j7K8SoP0uCh9YkXRYzzl
         1l46gXg35Bs0IjONbnGO+i6rWT6368qxzqHY5xiKciUAyziIQsH36b3IpTB3HYROBIm4
         FvgNNQHCV78i67/e0O4XB3+NbmJdpun3fhVQ6jiYJSxpbeF5a4p+Z00Xe/yfYIad830Y
         Cf9RPxbpujEkH+MYDnssuu8/EpqwyuGV4eQnb57UznS5TqR2Hg8UeTcD3RkNdk6G0fGd
         RJpQ==
X-Gm-Message-State: AJaThX7AaUZlMj9ZBq184iQbIb/O8uL41CHN2sukjNkOhtwCyyklpDGe
        vkxWHYd1VxqN0kMFHQmJGaOld7RT
X-Google-Smtp-Source: ABhQp+SUaIddOuOus+6utMUPJFubu6wIMNscLdhFKkq8YSTfIqeaTH+8f2qV9MYtxqQv2Z7EGCffrQ==
X-Received: by 10.28.141.194 with SMTP id p185mr5282097wmd.149.1509969047877;
        Mon, 06 Nov 2017 03:50:47 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h3sm1852464wre.63.2017.11.06.03.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Nov 2017 03:50:46 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eBfvS-0006XP-18; Mon, 06 Nov 2017 12:50:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, git@vger.kernel.org
Subject: Re: git grep -P fatal: pcre_exec failed with error code -8
References: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org> <20171105021623.yi46w2awwy7p3q6e@sigill.intra.peff.net> <4e2bc579-429f-9927-4502-5929e5235740@aegee.org> <20171106103125.fwtrxv6zycrbihcv@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171106103125.fwtrxv6zycrbihcv@sigill.intra.peff.net>
Date:   Mon, 06 Nov 2017 12:50:45 +0100
Message-ID: <878tfj62y2.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 06 2017, Jeff King jotted:

> On Sun, Nov 05, 2017 at 10:41:17AM +0100, Дилян Палаузов wrote:
>
>> I understand that the PCRE's stack can get exhausted for some files, but in
>> such cases, git grep shall proceed with the other files, and print at the
>> end/stderr for which files the pattern was not applied.  Such behaviour
>> would be more usefull than the current one.
>
> Yes, I had a similar thought. It does feel a little funny for us to
> basically treat an error as "no match" for non-interactive use, but then
> the current behavior works out to be more or less the same (we return an
> error code which most shell scripts would interpret as failure).
>
> IOW, I think something like this is probably the right direction:
>
> diff --git a/grep.c b/grep.c
> index ce6a48e634..2c152e5908 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -427,7 +427,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
>  	}
>
>  	if (ret < 0 && ret != PCRE_ERROR_NOMATCH)
> -		die("pcre_exec failed with error code %d", ret);
> +		warning("pcre_exec failed with error code %d", ret);
>  	if (ret > 0) {
>  		ret = 0;
>  		match->rm_so = ovector[0];
>
> but possibly:
>
>   1. It would be nice to report the filename that we couldn't match on.
>      But we don't know it at this level of the code (and it might not be
>      a file at all that we are matching). So probably we'd want to pass
>      the error much further up the call stack. This is tricky as there
>      are multiple regex libraries we can use, and the return value gets
>      normalized to 1/0 for hit/not-hit long before we get as far as
>      something that knows the filename.
>
>      We might need to do something invasive like adding an extra
>      parameter to hold the error message, and passing it through the
>      whole stack.
>
>   2. We should still try to exit with an exit code other than "1" to
>      indicate we hit an error besides "no lines were found".
>
>   3. Other regex libraries might need similar treatment. Probably
>      pcre2match() needs it. It doesn't look like regexec() can ever
>      return an error besides REG_NOMATCH.
>
> -Peff

Some replies to the thread in general, didn't want to spread this out
into different replies.

 * Yes this sucks.

 * Just emitting a warning without an appropriate exit code would suck
   more, would break batch jobs & whatnot that expcept certain results
   from grep.

 * As you point out it would be nice to print out the file name we
   didn't match on, we'd need to pass the grep_source struct down
   further, it goes as far as grep_source_1 but stops there and isn't
   passed to e.g. look_ahead(), which calls patmatch() which calls the
   engine-specific matcher and would need to report the error. We could
   just do this, would slow down things a bit (probably trivally) but we
   could emit better error messages in genreal.

 * You can adjust these limts in PCRE in Git, although it doesn't help
   in this case, you just add (*LIMIT_MATCH=NUM) or
   (*LIMIT_RECURSION=NUM) (or both) to the start of the pattern. See
   pcresyntax(3) or pcre2syntax(3) man pages depending on what version
   you have installed.

 * While regexec() won't return an error its version of dealing with
   this is (at least under glibc) to balloon CPU/memory use until the
   OOMkiller kills git (although not on this particular pattern).
