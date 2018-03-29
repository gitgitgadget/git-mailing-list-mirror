Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0C01F404
	for <e@80x24.org>; Thu, 29 Mar 2018 19:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeC2Tje (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 15:39:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51124 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeC2Tjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 15:39:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id l201so12585623wmg.0
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PNg8flDqXOtfwhv3QBwLyUVu7nuqTkVbDF2+bvUOMn0=;
        b=d9CAQ2EGjkwQa6QEuo4Kz1iAYMNxDi6oljc5sCu1LNOtqbYAZUKJFEUHxpHU9drV9s
         BURu57hWx/2dTKpLCxiUBiGzeBqiS56Tw/lm+G46ttjVsIMGU8rOC4LQWJoYFVKQuPaO
         /F2juKFsfgrtQUR24Tk54zlUdXdLjv1EYYOhrwAHPVSJ2jHsB+j2nYw1DPu2QN04CPvY
         Br247NWX4iBFRTMqx75GTsxg/vt8ihXJGTqrcQJQqlePVRx3R7DnN8O+vEfMarDUaymd
         l770rmmZYaxAKd3ycKYAerYvqX8zQLMzJhrLgUQ67LlU6xfsD/Or+1AvbOA7YXUcd6zz
         jiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PNg8flDqXOtfwhv3QBwLyUVu7nuqTkVbDF2+bvUOMn0=;
        b=dUWniHBwRE+ZMgqIuZM3YSroW24QSgyNtQzeqKZm9iEKHutRB3ZRxzP/fy/zzXfLCI
         EZoiub7+voTeq7QIVfX2xD2Q6Ft+TtVsyM+VHG21ATPhIEMlxvzSOEOK1cOMGPyotEZE
         mk1vWGRBzepHPsTM29i015GeByXWSdRnC79NYuvWeydCIlDWzcPyi+v+k+DplPcUMElf
         rRHH3iwqhL0xxOGDwUeZtohqesaOeDc21/I+BmqNRSbgYlfwqOV6jpM08Y8ClCx9JOsY
         TeRFsVrLAwrOP1lqk904jNqghA2kai5fZEKSyuKWZjud8oiKQ24RkIpeF/fey3Nori3r
         aoxA==
X-Gm-Message-State: ALQs6tDnRUTmGzpoTPiXvpovY4IVgEzcxcyyYLXGxw0kQFt2S6eSbMqB
        FV1Xe5KLGRdwDRp3zTwS9H4=
X-Google-Smtp-Source: AIpwx4+5lbcUAHJHSUw5wf6ZDWtOIkzXXHB+PdMk7k8+vo9t99YsMUJ3pF1NqaDX6ZzEDt70neNJIA==
X-Received: by 10.28.105.135 with SMTP id z7mr197411wmh.119.1522352371811;
        Thu, 29 Mar 2018 12:39:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12sm5715004wrg.20.2018.03.29.12.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 12:39:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/5] stash: improve option parsing test coverage
References: <20180328222129.22192-1-joel@teichroeb.net>
        <20180328222129.22192-2-joel@teichroeb.net>
Date:   Thu, 29 Mar 2018 12:39:30 -0700
In-Reply-To: <20180328222129.22192-2-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 28 Mar 2018 15:21:25 -0700")
Message-ID: <xmqqr2o2658t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> In preparation for converting the stash command incrementally to
> a builtin command, this patch improves test coverage of the option
> parsing. Both for having too many paramerters, or too few.
>
> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index aefde7b17..8a666c60c 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -84,6 +84,17 @@ test_expect_success 'apply stashed changes (including index)' '
>  	test 1 = $(git show HEAD:file)
>  '
>  
> +test_expect_success 'giving too many ref agruments does nothing' '
> +
> +	for type in apply drop pop show "branch stash-branch"
> +	do
> +		test-chmtime =123456789 file &&
> +		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
> +		test_i18ngrep "Too many" err &&
> +		test 123456789 = $(test-chmtime -v +0 file | sed 's/[^0-9].*$//') || return 1
> +	done
> +'

This is done with "file" whose contents are all different in HEAD,
the index and the working tree.  If the command tries to "push" by
mistake, it will touch the timestamp of "file" and fail the test.
That is a reasonable thing to check.

What do stash@{0} and stash{1} record at this point?  Would they
touch that "file" if the command tries to "apply" or "pop" by
mistake?  Perhaps it deserves a bit of in-code comment here.

As "drop" or "show" would not touch the working tree anyway, the
test for timestamp seems pointless, even though grepping for "Too
many" would be a reasonable test.
