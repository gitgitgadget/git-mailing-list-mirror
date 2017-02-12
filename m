Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E32F11FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdBLWGv (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 17:06:51 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33186 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdBLWGu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 17:06:50 -0500
Received: by mail-wr0-f196.google.com with SMTP id i10so21713464wrb.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 14:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qv+LGwhuriEce0SlqI5PwGvOxFyV3Kd4heaODfRio3c=;
        b=bAKUQn1NWoQlSM64skZtLjQOPp2duojgO6i1znfNeDk0dtaRK0lrVPLbEfgfLJD6z1
         JaJsnwiE295fUXPNIwgYhZZHLQQvP1yR2nAHDPPSDJvP3n8pxGU362P1gXa9VMbRCyQL
         j0v787eWvRukDX6hz5kH+YNuxStv/RnManOhcZhvPxCljFIzh/VSYUDOyAjoLFUT7npV
         uJEZUUCvqx4BZrjzfJYcx61kzMCpO2Nc1MAMmHjp3cvCeb1kGErEqfkVS/fRcC8bO4ls
         lXdw6c6y4e2J32lBbbJEfBrQpmA74vcTafSG2o6IntU5b/kl6Y5cfzqKrKwcQQgUiqvI
         auSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qv+LGwhuriEce0SlqI5PwGvOxFyV3Kd4heaODfRio3c=;
        b=itlJ0TvzlY+YMZ+REGut4udrYhIYh/1ZbwRxgYcuwVgEzq9mYvpq6uIk15lOoWiPVf
         FbT3/vPFSWksAuASwbzg3vny2sDO2DGL/UvOBNgfdKE47Uok8jiI0ROdeVVWzBvZFxE2
         47N9fl6XkTY+9b6sKJ6JqXIKesirAHuiWKrvnifdlLmfMNfiSf6ByWCyZcLNumXM4rhX
         jL4Whu1Kb76rJnbKpJwfFIdbcrH0pYIUd0ALImuu69dmlkuLafD/powsI9wXfupOG/96
         6SXbNmk3EAsNfoU5KlRFXaVO0U2FUsxjvYSnt+gRF6Lv3AXHkt+ihwKgIf6/EM29Rocb
         BjHw==
X-Gm-Message-State: AMke39kZN7aK9OQkuEU2mIz2P93EbmyBj3JEp15AH+V3mBQhrpjJbbBb4kXR7RTuq8qk9Q==
X-Received: by 10.223.169.140 with SMTP id b12mr16995443wrd.138.1486937209373;
        Sun, 12 Feb 2017 14:06:49 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id i29sm11417743wrc.25.2017.02.12.14.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 14:06:48 -0800 (PST)
Date:   Sun, 12 Feb 2017 22:07:22 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 0/7] stash: support pathspec argument
Message-ID: <20170212220722.GB652@hank>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Thomas Gummerer wrote:
> Thanks Peff and Junio for the review of the last round.
>

Sorry it seems like I messed up the In-Reply-To header.  Previous rounds were at:
v1: http://public-inbox.org/git/20170121200804.19009-1-t.gummerer@gmail.com/
v2: http://public-inbox.org/git/20170129201604.30445-1-t.gummerer@gmail.com/
v3: http://public-inbox.org/git/20170205202642.14216-1-t.gummerer@gmail.com/
