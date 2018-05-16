Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA291F406
	for <e@80x24.org>; Wed, 16 May 2018 01:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeEPBg7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:36:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35946 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEPBg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 21:36:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id n10-v6so4457810wmc.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KAMP04ey3/nUBYJSGLEnq6lwt5E5YOr/CH9/+OudGlo=;
        b=YE8xlO8kq9rA6Zitneg/K7ZeTyyKippYg5m1yQ6O0waxdIpsprZIx6FzBAImcnFPgJ
         7W5rusraqTxvdvWo5tbkiFnkvid0jjvT6oe+vG3RfVKelLlz3KNy1KY6InUxDISuWJTA
         PSzRgvJfFATxcEB+1iN67z+uGTrfM7Tlt1/4F6YUy9ZerzTvwhdQBluDLj1FmkRJEkB5
         kX3rfKMNZgCLwYFFUd228QYraRePP+dTzayS55hiQsUaQKWByvQ/b+Xb0YoNZVWU/pBY
         uBNFWWZ3Pamt8iUqW4f9GL6HrEAai+orXXFczOljE8FFkTahCyvhYVNDr0pAC4Q/M5kk
         3U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KAMP04ey3/nUBYJSGLEnq6lwt5E5YOr/CH9/+OudGlo=;
        b=uARqOMiI5LRGNpsixD+hwcu7JsEktrdKrtaK7RRr1gLvsgDXi1fLnKh4RL2vm2tog5
         bl6Q9Lkr6iLNkxjw/2e9sCHM6YURFTiHfrB2/kZrsXhWxY1V1R2ODIT4Q8an0Lrgw21+
         8tHcccuBsvrmTej/SrIFxFCM7OmNJp+NaU7lkniqLi76keawK60wcOXgUDW/7TfzwYAR
         4rTHUgmo9XLQqBvB0Soj1U3D/u7Kicf+GQhvndOP6GxenZsh9uu7ulrwgMmyvEY4Rtqn
         mjziIXUEHxCh325zbnQ3w9SB+zYoyZd9FVIjSDMgkfNnX6l7tKkxBk17KNF2izCjEgCZ
         qoVw==
X-Gm-Message-State: ALKqPweEJj2jZLMcMTLD1LKh3WpHr3Riy2+PM20nCLqPwP9a2yKqvu5/
        VKKcENnSsOKcH/16u2x+pNo=
X-Google-Smtp-Source: AB8JxZpi+TrGGhZ2VIIXGzIl/fgeAmQBJhlzQhavfQkrlicnKIqJwMv92apxS/9WlX1RnTzCnPpFMg==
X-Received: by 2002:a1c:6d47:: with SMTP id i68-v6mr171587wmc.154.1526434616678;
        Tue, 15 May 2018 18:36:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k30-v6sm2790790wrf.17.2018.05.15.18.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 18:36:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, leif.middelschulte@gmail.com, newren@gmail.com
Subject: Re: [PATCH 3/3] Inform about fast-forwarding of submodules during merge
References: <20180515200030.88731-1-sbeller@google.com>
        <20180515200030.88731-6-sbeller@google.com>
Date:   Wed, 16 May 2018 10:36:55 +0900
In-Reply-To: <20180515200030.88731-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 15 May 2018 13:00:30 -0700")
Message-ID: <xmqqo9hg7554.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>

Subject: merge-recursive: give notice when submodule commit gets fast-forwarded

perhaps?

>  	/* Case #1: a is contained in b or vice versa */
>  	if (in_merge_bases(commit_a, commit_b)) {
>  		oidcpy(result, b);
> +		if (show(o, 3)) {
> +			output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);
> +			output_commit_title(o, commit_b);
> +		} else if (show(o, 2))
> +			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
> +		else
> +			; /* no output */
> +

merge.verbosity::
	Controls the amount of output shown by the recursive merge
	strategy.  Level 0 outputs nothing except a final error
	message if conflicts were detected. Level 1 outputs only
	conflicts, 2 outputs conflicts and file changes.  Level 5 and
	above outputs debugging information.  The default is level 2.
	Can be overridden by the `GIT_MERGE_VERBOSITY` environment variable.

So, by default, we report the fact that we update submodule to a
particular commit, which is quite similar to how we report auto
merged paths using the content level 3-way merge; when you squint
your eyes, the "fast-forward" of submodules look somewhat like a
content-level 3-way merge anyway ;-)

And at level 3, which currently is used to report a non-event that
does not change the result of the merge from what was naturally
expected, we give a bit more detail by citing the commit the
submodule gets fast-forwarded to [*1*].

Sort of makes sense.


[Footnote]

*1* I wonder if that is really necessary, though---we do not give
"here is a diff" or "this is the new contents" after a path gets
merged for normal files.  And if it is needed perhaps because
submodules are so special, I wonder if we also need to give the
commit the submodule gets fast-forwarded from, i.e. the original
one, the same way.
