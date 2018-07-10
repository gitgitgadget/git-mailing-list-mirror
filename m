Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08BC41F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934326AbeGJPu0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:50:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37566 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeGJPuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:50:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so24902731wmh.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c5Ilo9HhxXkDs8IrqmzeVVRGpoeo7zMWjp2heEJx80A=;
        b=m5yMKocIljIN+DzMa8c7TTmDT91dWrn3LaN4jTzD2T8evU91vJiZqFPdmxPQMJDLS2
         MYKjK3aEnVEeJr2jLHvalww+ZowZVzIEwTAtrG7ibUU/LhNBTD+BgmbNupCidr0B/iCA
         StVFJcP6+g4hUV183ebnX8q32fnzee4Vxo8OHsIEytb99kmLpcqaTKFo0NuE22sS10sw
         GcRIeEYtdrIOciVwdorYW/XQuddSPtvAMBGOeyHwOT6LZIxEUcE6twqxnA0ijznmqSf1
         awZQS/UmqhvRXzFe7zXPPPOwGSDWV55b0oabJnN3Q5nacsMvsHA5+/SnzWKBfMQK+6g9
         imWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c5Ilo9HhxXkDs8IrqmzeVVRGpoeo7zMWjp2heEJx80A=;
        b=cOZ8uo0a53091aG8mxlYr8QlRGHo/f/+Ic6O0TlXqd10j574cHA6s1v+iwhd48uvJ/
         KjhWo/0d3g5lRubXSOhH9c5I7hCd2svTeWFj59vEzVy1ZcyaloIxiYotsN3s5zekMtpa
         CXth7MpOpG8TWd/aS9+UNHbJ9UiBzyz7HrolVPtJllGlH2SZFFAGLWTDlSj1Itvk+mTL
         lEnUov9+6MmltavuYwi8Siyr0f9CboPTFSStpMfgA5kyVoAabCpdDLMzHn1fUTJfSiPI
         VXa6VCW5syJGrfGd5jMnJfrKnGuQlINpvZCn2uZhCjnHKBCcznYYpg3jQLljCBZJounA
         ZjVA==
X-Gm-Message-State: APt69E01DGqh8dFoXl0+IJpqoaSbsXZKxyllAKiShPl4MJs4FOijR4UI
        Jf3ZUbKeD7+Y0k29lffLGzM=
X-Google-Smtp-Source: AAOMgpci/SgdN+1NDdgdloaT4vAMaLUQZtCx+qsF0/z8ReZKOcI+z9P3UYQUjRkEZdY8QlzevsM23g==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr16555927wmf.8.1531237822650;
        Tue, 10 Jul 2018 08:50:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 56-v6sm18612969wry.52.2018.07.10.08.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 08:50:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus white-space warning
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
        <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
        <xmqq601ocecs.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet>
Date:   Tue, 10 Jul 2018 08:50:21 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807101149130.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 10 Jul 2018 12:08:36 +0200 (DST)")
Message-ID: <xmqqr2kb9jk2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 9 Jul 2018, Junio C Hamano wrote:
>
>> I also wonder if we should be feeding the context lines to ws.c
>> machinery in the first place though.
>
> It *is* confusing, I know. The entire "diff of diffs" concept *is*
> confusing. I just don't know about a better alternative.
>
> So hear me out, because there is a big misconception here: there are *two*
> levels of diffs. The outer one and the inner one.
>
> Context lines of the outer diffs have no problem [*1*].
>
> The problem arises when the outer diff shows a - or + line (i.e. the line
> is present *either* in the old patch set or in the new patch set, but not
> both), *and* that line is *not* a context line of the inner diff.
>
> Let's illustrate this via an example. Let's assume that both the old patch
> set and the new patch set add a comment to a statement, and that the
> context of that statement changed between old and new patch set. Something
> like this would be in the old patch set:
>
> ```diff
>  	int quiet = 0;
> +	/* This is only needed for the reflog message */
>  	const char *branch = "HEAD";
> ```
>
> And this would be in the new patch set:
>
> ```diff
>  	int quiet = 0, try_harder = 0;
> +	/* This is only needed for the reflog message */
>  	const char *branch = "HEAD";
> ```
>
> So as you see, both old and new revision of the same patch add that
> comment, and it is just a context line that changed, which a regular
> reviewer would want to *not* consider a "real" change between the patch
> set iterations.
>
> Now, let's look at the "diff of diffs":
>
> ```diff
> - 	int quiet = 0;
> + 	int quiet = 0, try_harder = 0;
>  +	/* This is only needed for the reflog message */
>   	const char *branch = "HEAD";
> ```
>
> Please understand that in the dual color mode:
>
> - The first line's `-` would have a red background color, the rest of that
>   line would be uncolored (because it is a context line of the inner
>   diff),
>
> - the second line's `+` would have a green background color, the rest
>   would be just as uncolored as the rest of the first line,
>
> - the third line would be a context line of the outer diff, but a `+` line
>   of the inner diff, therefore that rest of the line would be green, and
>
> - the fourth line is completely uncolored; It is a context line both of
>   the inner and the outer diff.

All of the above about colouring I find sensible.

> That's it for the diff colors. Now for the white space: The first two
> lines start with a `-` and a `+` respectively (outer diff marker), and
> then most crucially continue with a space to indicate the inner diff's
> context line, *and then continue with a horizontal tab*.
>
> As far as the inner diff is concerned, this *is* a context line.
>
> As far as the outer diff is concerned, this is *not* a context line.

What I meant was that there is no point checking ws errors in the
outer diff.  The fact that the older and the newer revisions have an
unchanged context line (i.e. begins with two SPs in the outer diff)
or different one (i.e. begins with "- " and "+ ") are worth knowing
(and you have red and green leading "-/+" for that), but the fact
that the outer diff's new context line begins with "+ <HT>" has
nothing to do with the goodness of the new patch, as such a line
shows that the new patch touches a line near an unchanged [*1*] line
that happens to begin with a <HT>, which has no whitespace breakage
to begin with, and even if such a line had a trailing whitespace, it
is not something the new patch introduces.

	side note *1*; the fact that it has leading "+" means that
	there are differences in the previous steps between old and
	new patch series and that is why the context in this step is
	different between old and new series.  But in the context of
	applying the new series, the patch does *not* change that
	line.

> And that is the conundrum: the whitespace checker is called because the
> outer diff claims that the second line is a `+` line and the whitespace
> checker has no idea that it should treat it as a context line instead.

I think you are saying the same thing as I said in the previous
message.  Trying to reuse ws.c without first giving it a way to be
told that the caller does not care about the early columns (in the
"+ <HT>" example, you want to tell ws.c machinery that it is *not*
an added line that begins with SP + HT; you want it to know that it
is a context line whose contents begins with a HT) will of course
cause headaches.
