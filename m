Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5529A208B4
	for <e@80x24.org>; Wed,  9 Aug 2017 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbdHIJrX (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 05:47:23 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38822 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbdHIJrW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 05:47:22 -0400
Received: by mail-wm0-f54.google.com with SMTP id m85so26597635wma.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 02:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CCFYDuQ9lt0iTp6VNouAPQIuEjLABMZXtfGUGUOgvCo=;
        b=e9yQ3Kl5CK4IV9HGvWwvEGiwXvnUKGorH7LXj9rrx5HlWRPdhkwk9/+dBQCWsOmwGY
         Mbh6scEKoTsZHOVwD8oIQFvrsPglyiOLrGsrKRPI01ZPNowNspYA2raZI1ZO249KfTcl
         kGebhDF8A5AVpIRSPs7iJSkAhTeBRAuctt6lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCFYDuQ9lt0iTp6VNouAPQIuEjLABMZXtfGUGUOgvCo=;
        b=Shu5b5luIRT//V10QefmEsUmu5EbvaeHpCwZ1aGia8AYWMvM9pW4M+qErXH0QssmUu
         71J2G9KaRH592+LF2XvlcMFAZvGD6VCzqRvjipV+STuSIDXI92mfkRwVNmdWYerG7WlW
         yBZ9oCh/NfzMguzF1wxrd7df3H45kIYo19hGXwkaKlVC7qVAgH+Zg0kVb62XzFEKf1Jq
         N4sW54jr0k3M9B8Puz2Wquft2gj85QxDw8MTyoAEVJDFmvW46iWaz1aDop1ZDRnQ6pu8
         xXb6Kp+N+1GkkMK4yhhzhTy7u6cXm7GAhx8SAX/7cF+4nns0V87udvIsfLPdtSInl2Tt
         TxYw==
X-Gm-Message-State: AHYfb5jkqwmhAF+4flbJhf1vFGnH4a2thLdPbBuV1LnrMaWRo8VqysrF
        7ii1l9xYdKsLTu6/
X-Received: by 10.28.66.217 with SMTP id k86mr4980463wmi.52.1502272040980;
        Wed, 09 Aug 2017 02:47:20 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id b195sm4046288wmf.38.2017.08.09.02.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 02:47:19 -0700 (PDT)
Date:   Wed, 9 Aug 2017 10:47:17 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Xie <emilyxxie@gmail.com>
Subject: Re: t3700 broken on pu on Cygwin
Message-ID: <20170809094717.GD32640@dinwoodie.org>
References: <20170808151808.GA32640@dinwoodie.org>
 <25c23536-50a3-5a59-756f-e5c48ac1a342@web.de>
 <20170808172524.GC32640@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808172524.GC32640@dinwoodie.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2017 at 06:25:24PM +0100, Adam Dinwoodie wrote:
> I'm running a bisect overnight to try to isolate the commit on the left
> merge parent that seems to be interacting badly with the commit on the
> right, and will send in the results from that when I have them.

For the sake of interest, I've tracked down the problem to commit
v2.9.0-3-g9e4e8a64c.  That changed t3700 so it would no longer add all
extant paths to the index, meaning a later `git reset --hard` wouldn't
remove them.
