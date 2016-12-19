Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305BE1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 12:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763135AbcLSMCx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 07:02:53 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35654 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763111AbcLSMCw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 07:02:52 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so18314919pga.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 04:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDYh0klq6cXa50VkWd9hVt6X/gRZodfDqs1meHdPgL0=;
        b=ZvgvYvvvoDwXiQreAOyXLbMRsnRD42rtLbdGUE0FK2MoWy/1VdOfTsypRgpa9wN/jK
         Oo4kaFbCxz4iUn/2SUlmY0S6wK4rZtrF+o2CCOcrYct3Z0MOtr1fWO9/WxzSvXhaZtil
         DcOJgw7w/fpM1T6EaHIrB1cbGxqi/r6C4HcVs1Q+jcifgCG/jLXszsvlroAOFdE+Hl/u
         937jZf9EhcZFBYSlMRTbQoczdJ0p6cXu3GkzMX/W/LYXQaGBVZeOE8u/57+EWIoCK/zQ
         jceDr0CIkh1WsGacU68UNF1UOn0OpGbXRym4seDVH72bbVk3dSfmeGk4RFXIMg0x4WVd
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDYh0klq6cXa50VkWd9hVt6X/gRZodfDqs1meHdPgL0=;
        b=t1lLmF8YZYSBg6438/YvG70/y/iUon8h5uvf9pvjKM7QC10ckSwyafkI0AGp1GKEzX
         bN6Ju8o/ft7OjjivYXw3Entq6gMzU/KpPocgQWz0yVB6sMTqwnEVo20ZSKDih+90qP49
         DqvV77I9OEOWQ+ujEWCkzFOm1dfy607Q+Fvh0JqPM8+JmbDWPVGEHbW4DZ4gOvVMrSJn
         Qf9vlUTNlt6PImULrf35Zwclji7KZWHq6BfGKmJfDm25WGIQY4Mil/x0mkNkDzcnFAz+
         Q5Qv3xOV8AWjKgGGNZw2XNIUGYc3/GHDNpsDOovG9syyFNQwOWHNQJxgpxgHvR6Vzkol
         y6rA==
X-Gm-Message-State: AKaTC02ZfU5O+uTsAcI8e+bkq737s5TfEzbtyptpebTYhkgN+3t+KP2e+wsK5J8SZedRpQ==
X-Received: by 10.98.20.131 with SMTP id 125mr14644858pfu.51.1482148971822;
        Mon, 19 Dec 2016 04:02:51 -0800 (PST)
Received: from ash ([115.73.171.119])
        by smtp.gmail.com with ESMTPSA id a24sm31088758pfh.57.2016.12.19.04.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Dec 2016 04:02:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 19 Dec 2016 19:02:46 +0700
Date:   Mon, 19 Dec 2016 19:02:46 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/21] Add configuration options for split-index
Message-ID: <20161219120246.GE24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 03:55:26PM +0100, Christian Couder wrote:
> Goal
> ~~~~
> 
> We want to make it possible to use the split-index feature
> automatically by just setting a new "core.splitIndex" configuration
> variable to true.
> 
> This can be valuable as split-index can help significantly speed up
> `git rebase` especially along with the work to libify `git apply`
> that has been merged to master
> (see https://github.com/git/git/commit/81358dc238372793b1590efa149cc1581d1fbd98)
> and is now in v2.11.

I've read through the series (*) and I think it looks good, just a few
minor comments here and there.

(*) guiltily admit that I only skimmed through tests, not giving them
    as much attention as I should have
--
Duy
