Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 551BE1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeBVAMN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:12:13 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:46408 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBVAMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:12:12 -0500
Received: by mail-pl0-f49.google.com with SMTP id x19so1885955plr.13
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aseQ6FtizYE3I/B4a/z8oKseaHx0vm4HCBMcR5pITNw=;
        b=GknmJSuJ/jIbB8kBfyVpLzc4yLhU2eaa/6NvjgrWQUJwpwy8Ak5xXkmNPrECEORpAp
         2tq1T51OzS6UFzuZFAN10gl/hw5Izv3+Muw5e/hWOMaxreaLZGSN0PU5NPYxvBEm0zF1
         b2VEYemVsq+4/Vi6G6w97jTtGE84pfso9aq0i/ZjJKvqXWu1HfO8WxCJ9lexYm8Bcfqu
         8ZGHStiPK0/9fY4CiTK6ORK8iTagJ7WgtZHO5MupuSngdTpQ+fHqogNL6e6HVTI1vtdY
         jtbr7CiDbalj5bVB2tF38oJttb/191QTyYv6EuALLNAPXmy/vxYGZCpMJwDoj2FnP174
         6Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aseQ6FtizYE3I/B4a/z8oKseaHx0vm4HCBMcR5pITNw=;
        b=W/PhyUvoEmM845E4GhEwHfUK4ANRjyU6lceWIYIVBIK2swCZW/oQTtI2DjU2ErfBhs
         rh4ptMB+FN6bViCSDwu78a2pgbcWe3YBsihq4o68oWug23IMEgVu4yskTGLsLtbClBE5
         I2bN7q/cjhZbdjSMKi0YOCrgQhIpFZiyDTEEHJkT6EtDs3xtK1H6rsYDy6AUaoeZebkQ
         Dbrc2uEy3+s7LJ3pnJ0VKNApmtjLWcRBi78+x4fxCWRNRXdvlUSrcakJhDin6UVA+xfq
         Ft/01P15Iv07ORxYbnUCn5jy1b8IBqmCuuZoD2feb5pVm/oUfx7wFBuP8fScnC23EXCX
         WOcA==
X-Gm-Message-State: APf1xPAsGBesWXm1wuG2uremoz1RlyqsHAybT8+yHBOWSDcwuiE9ijuI
        GG5PujQJt5/GFjXo2QbD0Fcd+g==
X-Google-Smtp-Source: AH8x225IIh1brWSGzQSaQ4PMs1TdAD8YrZcMudbBPdQijLiVudk7AdxqYO4xT9JPZceU+exj3Q+QFw==
X-Received: by 2002:a17:902:51e9:: with SMTP id y96-v6mr4742745plh.344.1519258331854;
        Wed, 21 Feb 2018 16:12:11 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id i14sm66151955pgv.40.2018.02.21.16.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:12:10 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:12:09 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 35/35] remote-curl: don't request v2 when pushing
Message-Id: <20180221161209.80f0a3b941a069ea78ccf43e@google.com>
In-Reply-To: <20180207011312.189834-36-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-36-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:13:12 -0800
Brandon Williams <bmwill@google.com> wrote:

> +test_expect_success 'push with http:// and a config of v2 does not request v2' '
> +	# Till v2 for push is designed, make sure that if a client has
> +	# protocol.version configured to use v2, that the client instead falls
> +	# back and uses v0.
> +
> +	test_commit -C http_child three &&
> +
> +	# Push to another branch, as the target repository has the
> +	# master branch checked out and we cannot push into it.
> +	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
> +		push origin HEAD:client_branch && 2>log &&

Should it be protocol.version=2? Also, two double ampersands?

Also, optionally, it might be better to do
GIT_TRACE_PACKET="$(pwd)/log", so that it does not get mixed with other
stderr output.
