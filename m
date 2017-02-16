Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20961FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933558AbdBPWzQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:55:16 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:35413 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPWzP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:55:15 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so118797429ith.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XfJ23et3/9UYCyV+YnI8X4cw7AoifyWCRpYao4XZpAI=;
        b=MgCYCGgJzpJMyuF/CfZY6WytsrGwWubYobg6qXNcsyDOdy/EtEWa+OZVndjXzeRfzw
         U+ImLhV+29bIke4/4E6JRF16gVqRPt+69Lo9ljDBrQFaVRzSQIDuEZl+uqXrblGBHoco
         mMMXWXFN2bGtsZaYpqvHLIXYBOZ4qvOJnmPUdCaE3vKFqTKtbgTg8ukrbDanx6M5HQ5T
         JhzB9pxVlhdG6QPp0jP5xve/ZX8GsPMebQomHzp32mRaNT6CVX8z0eKL6oMAgxlEWKyA
         sKPivYuA96eVclqPm0QHDSLNUHRtJUnZ/qWJrnvn/Pau4cmTGOCJnKHQBQ7w/ZB2nvE3
         9JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XfJ23et3/9UYCyV+YnI8X4cw7AoifyWCRpYao4XZpAI=;
        b=hhw8ax2qaHcIF1gN/fmKjfErg7FVYB2gB7bbhCm6Dx8OVQ0XO1vDIBJ4ZIv/+k7iEy
         6bonVbf4E9Y5oPRkZr3g2wZvpO3+0aotEgYvRB/kPKxfGWnNisGnWNd0ugzLYvX5gZdf
         vn096gkSW9uEO95qsHqdL55e0+gsTfecV2y2hdbhzlsGcIv7bGmgxKK4gVVkpvdtOdkq
         29dCWyJIPm3/4V9Obbwh9qeXzOEhWihn/6TOvRnKevT7707InWcvBocfx5dEKjSzUXUw
         YayWLBXHqTk9XIeDBFCPHMzz0p9aE1Z+t7U/Z9PsCMKBQSmfHe2lqEGp1HXuUm6zNZnU
         fRrQ==
X-Gm-Message-State: AMke39km/V80jIGZPbNO/F6l40RgGoZN7Uc/Q/BV6nVAkXJU/ZzWCb312LkPGQ7CdQzKVlqZ/8Saj7XKfddgTaxK
X-Received: by 10.36.65.161 with SMTP id b33mr4551461itd.114.1487285714649;
 Thu, 16 Feb 2017 14:55:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 16 Feb 2017 14:55:14 -0800 (PST)
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170216114818.6080-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Feb 2017 14:55:14 -0800
Message-ID: <CAGZ79kYwCK=WRbMRoKNzecL8XtxLriJxVYzJBixopmOa=hqtcg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Remove submodule from files-backend.c
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series looks good to me.

Thanks,
Stefan
