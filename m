Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77822203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbcGYPQ4 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 11:16:56 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35815 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcGYPQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 11:16:54 -0400
Received: by mail-qk0-f169.google.com with SMTP id s63so166173731qkb.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 08:16:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lm4g7UQ+tCUD07Al5A55WsfW0SPkhqfjIafRjnZdp24=;
        b=JWhuQezr5BZ+uhtJ0drghyLZ4ak98AsOnVkvulVXYliY3GtfAeJ8Sf6Ijq1e3UKM7C
         BOuXiEz/yDP7rOdHhj6W8zlg3tXiPrSWmM6v1CW2Hkaj8gvMPsbTMXH/k8RNtehPzl8s
         VJ0XAi+008hdS+QoOzXkonq9GUXwpf+0YLcyRxgqyDhm5JnwZF4fbnP3u3IITZU6Pk6j
         PkLufsL0H02/fuOhB3pUL3HGTWMA+PiLiISfGjgWTjX4N6l4Tde6IDD1J9iwrhJTwrza
         cFyDZGi5VHb89gewPrxMCvQbUyQEmENW3tfo1I2Y8nrjOKSCEXS47XlSLbMWm8Eeq8DQ
         rbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lm4g7UQ+tCUD07Al5A55WsfW0SPkhqfjIafRjnZdp24=;
        b=GuC05FrDM9K6Jcbiflo8YaKgzpPjh1ofmegs5q+4P1MG7EI+7hfKv0riod09mP/uYm
         mBBOktGdmhFPNtOrWzq+VR9KAVvqWOZebRQ3Vp0b0qXMg9ShRmxOZn3oN+DId+LrESEs
         rCFsGdQXbqOfdi9mltaOd1NBR9Zq+sedmAsWY/UyCmR26tgoRH/ja2H+RtKA5R0rzowf
         1FGelTZaG1JeIDx/uruYSVSE4i9ixOs/FEWeqC4UUYrLaXeB5jx2YV+grYxBJG66ZpGP
         U7ksJClQ8O0RIgt3SNaM3ByfdpO4L5ni53MJgEVruAZhyAThnth9W8Z7LiyfwdyDSAVx
         x/1g==
X-Gm-Message-State: AEkoousOWxOULfQKqTAO3cqHEv7evJit1mie9QPxurwvTQ2haMMw6jV/kbOHPo7o+JuQb+0USgstfZWOcfuVIg==
X-Received: by 10.129.105.136 with SMTP id e130mr14388780ywc.176.1469459813744;
 Mon, 25 Jul 2016 08:16:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Mon, 25 Jul 2016 08:16:34 -0700 (PDT)
In-Reply-To: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
References: <1469439068-2724-1-git-send-email-vascomalmeida@sapo.pt>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 25 Jul 2016 08:16:34 -0700
X-Google-Sender-Auth: 3lbOMtVQdrvnJnSKyskP345ARRw
Message-ID: <CAPc5daVV8EkMXWeTiZN9bEXXAejmbDbT9L7SNCc4jNtXYVomLQ@mail.gmail.com>
Subject: Re: [PATCH] t5510: become resilient to GETTEXT_POISON
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 2:31 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Replace gettext poison text with appropriate values to be able to cut
> the right output of git fetch command for comparison.

Hmm, as these tests are _all_ about human-readable output, it probably is
sufficient to skip them using prerequiste, I would think. We do not want each
individual test to have too intimate knowledge on how POISON strings look
like.
