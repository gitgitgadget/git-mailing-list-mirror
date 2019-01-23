Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B2551F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAWXjO (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45408 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfAWXjM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so4463935wrr.12
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=IN+Hkz0RFGeVaHB/+0sH1Pr3LvHkOCS2GRiLQxYMgPg=;
        b=reAZxCy0BJNf62jA8RcVXgrnOa99AqWVM9VFGsXxeQCPtZXI45IZaxoslEUN1zfXQv
         +ODi9CL7hHWAuZfv3/gI/Em++GHuld5EeMzEC97tb/1NWBguoSin5jZbtVKpd/GA+beX
         422FXz+3io9SPHYy3WxEQ91we013n0VxppWxdJInZbgOHBzSD5V66ElmLfgq4zNu+30b
         KBZR0dJNUFHH8KklXitt9wz5NCglD9Rtb/IlYYLerRI1nbL1FjstriQCw+kezwtYs03K
         1Pl1PeLBwIScSl02mVQGGz7cWCpyklGAt+TI2TjIC6RLSA/EQJI0YhcgYcWI2k3/e2Yx
         a+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=IN+Hkz0RFGeVaHB/+0sH1Pr3LvHkOCS2GRiLQxYMgPg=;
        b=L0BYZNKok0jmUOGvlVgGNmBEgkCrg7lsaKSK59kwiynYi2syyErJ/ww4D0WS7XfwLu
         rcRn1pXcevOQYpUzRci6/R+VxNN2V1YT1ral3ShsQCe0fdW/qP1UaPNnlNTQTQHXL4ma
         yUusAR4KFKt+GdEW53jm+r7P4EC5WP8vHUH/CKMQpYvzPsi4v134CwyYgIQbLBICeA+3
         CH0xubxHAOCkBHzCLy7jaKq+u1T8gZVQDVrq7Z8qQNktY7TV+kpwkKqm6srXrjrQW9TD
         BbReCGQ8rQjNUWJiwqnKxbHgttVu9fahDGOuojzXq0PVZk3nqmX33jYTxt7fJK9sHAVe
         /MuA==
X-Gm-Message-State: AJcUukfkxVjrNocW6mERnfDuTPa5P3CgDeQ2q9DXBkzjBR5+35zTgp5K
        yHxWk8u9j3fhmXd0mPL0j1A=
X-Google-Smtp-Source: ALg8bN4c5AmBTmADsinvn/Ua4QaXly9600YBGoOsLVnhBeV8DxYQiWbPa++VDXI1rDG4+yLN96tFgA==
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr4486475wrh.317.1548286750145;
        Wed, 23 Jan 2019 15:39:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x10sm123510675wrn.29.2019.01.23.15.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 06/21] test-date: add a subcommand to measure times in shell scripts
Date:   Wed, 23 Jan 2019 14:29:02 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <aa053ed9936ebae0ca5e18d27de96f1d054d7f89.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqo98754gy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In the next commit, we want to teach Git's test suite to optionally
> output test results in JUnit-style .xml files. These files contain
> information about the time spent. So we need a way to measure time.
>
> While we could use `date +%s` for that, this will give us only seconds,
> i.e. very coarse-grained timings.
>
> GNU `date` supports `date +%s.%N` (i.e. nanosecond-precision output),
> but there is no equivalent in BSD `date` (read: on macOS, we would not
> be able to obtain precise timings).
>
> So let's introduce `test-tool date getnanos`, with an optional start
> time, that outputs preciser values.

I think the goal to have our own stopwatch so that we do not have to
worry about differences among system-provided ones makes sense.

The only thing that may become an issue is how widely available
getnanotime() is.  As "test-date" itself is built on any platform an
end-user/developer runs our tests, which is wider set of platforms
than what we run Travis and other CIs on, unconditionally relying on
its availability might pose an issue.  I dunno.

> diff --git a/t/helper/test-date.c b/t/helper/test-date.c
> index a0837371ab..792a805374 100644
> --- a/t/helper/test-date.c
> +++ b/t/helper/test-date.c
> @@ -7,6 +7,7 @@ static const char *usage_msg = "\n"
>  "  test-tool date parse [date]...\n"
>  "  test-tool date approxidate [date]...\n"
>  "  test-tool date timestamp [date]...\n"
> +"  test-tool date getnanos [start-nanos]\n"
>  "  test-tool date is64bit\n"
>  "  test-tool date time_t-is64bit\n";
>  
> @@ -82,6 +83,15 @@ static void parse_approx_timestamp(const char **argv, struct timeval *now)
>  	}
>  }
>  
> +static void getnanos(const char **argv, struct timeval *now)
> +{
> +	double seconds = getnanotime() / 1.0e9;
> +
> +	if (*argv)
> +		seconds -= strtod(*argv, NULL);
> +	printf("%lf\n", seconds);
> +}
> +
>  int cmd__date(int argc, const char **argv)
>  {
>  	struct timeval now;
> @@ -108,6 +118,8 @@ int cmd__date(int argc, const char **argv)
>  		parse_approxidate(argv+1, &now);
>  	else if (!strcmp(*argv, "timestamp"))
>  		parse_approx_timestamp(argv+1, &now);
> +	else if (!strcmp(*argv, "getnanos"))
> +		getnanos(argv+1, &now);
>  	else if (!strcmp(*argv, "is64bit"))
>  		return sizeof(timestamp_t) == 8 ? 0 : 1;
>  	else if (!strcmp(*argv, "time_t-is64bit"))
