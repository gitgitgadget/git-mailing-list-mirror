Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCB120357
	for <e@80x24.org>; Mon, 17 Jul 2017 17:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbdGQR1O (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:27:14 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33505 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdGQR1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:27:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id e26so11742247pfd.0
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Xpm3SwiDw+5vBeWL7LFiE+GC5jgTffTPONE6bjXT/A=;
        b=H0PrZxiaT/Jhncmqm1Nva2NHftEBZsJ80vNgwG8591BWPtW6y4/e7vhGInYn0dEPiC
         Yt+N1Y49hfeh8DKf3ThCpa50SEyFRXj6zDwKgJh+s3mWUJeIMefUZUfD1PzpGpO8tGMX
         ipXvStd2i69xHaz8OKpV2kAxDezFgE2DOPUMHO7jJvoo7aJqrOzProWVXGj3Vn2NoInJ
         YpimSI1IwUsdfazjlal5UboOgpEz8JTgviKPiZRG7Qif63CPXq66LwNXu+tnbGrKHg/Q
         Z/Elur8zY3hzP+6QQiu3ExIVvt+NfjqMY2mX9c8eqt1vRytr09GXZG1BM7qHNzUsxCfM
         EPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Xpm3SwiDw+5vBeWL7LFiE+GC5jgTffTPONE6bjXT/A=;
        b=Pb2FvkG1Vc2AIl1iJ211SGA9msGhoa8wEKKS9H2+WyaCdV5a6RYYxCnHcPsijbKzAD
         xCc96+Chp6H4A4l9tXmNGNJ/Cnej0Sk+WQZQ67TWNMiCYphl7s51z5sWb4s9Tj0vEfXV
         714TzEsFLUnzkG3eeBRAu1zTj9vXkWsu6786GfdkXg4QSUU687HyHa7uCX5g3f5WbKsA
         KtHwHiDGCB3jLDpcH4qX2SvZcVk+Gn0vY6SSNk0/EeaI9a7R788o5gfuuoVDc4WaHmuD
         Og1/3XhGeX5frvzIyQt8gzS0h2txZRDV3+yU8Qd3RhEjm+JsncFYTh2rts28zqxM6gkA
         VrdQ==
X-Gm-Message-State: AIVw111KErTu8Nb6JoSiRFy7UxVBkAWEwW5ZEtazw1zvrTdHuHs3/xac
        vht8Q3+qCqV2bQ==
X-Received: by 10.99.45.193 with SMTP id t184mr30867553pgt.209.1500312432562;
        Mon, 17 Jul 2017 10:27:12 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8ce8:54ee:549a:2508])
        by smtp.gmail.com with ESMTPSA id n83sm6473758pfi.1.2017.07.17.10.27.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:27:11 -0700 (PDT)
Date:   Mon, 17 Jul 2017 10:27:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20170717172709.GL93855@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Jul 14, 2017 at 02:03:13PM -0400, Jeff King wrote:

>> So I think the patch below is probably the right direction.
>
> And here it is with a real commit message, if this is what we want to
> do.
[...]
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -161,6 +161,10 @@ test_expect_success 'check-ref-format --branch from subdir' '
>  	test "$refname" = "$sha1"
>  '
>  
> +test_expect_success 'check-ref-format --branch from non-repo' '
> +	test_must_fail nongit git check-ref-format --branch @{-1}
> +'
> +
>  valid_ref_normalized() {
>  	prereq=
>  	case $1 in

I don't think it's right.  Today I can do

	$ cd /tmp
	$ git check-ref-format --branch master
	master

You might wonder why I'd ever do such a thing.  But that's what "git
check-ref-format --branch" is for --- it is for taking a <branch>
argument and turning it into a branch name.  For example, if you have
a script with an $opt_branch variable that defaults to "master", it
may do

	resolved_branch=$(git check-ref-format --branch "$opt_branch")

even though it is in a mode that not going to have to use
$resolved_branch and it is not running from a repository.

Thanks and hope that helps,
Jonathan
