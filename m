Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFF61FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 23:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbcLAX7B (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:59:01 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33002 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbcLAX7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:59:00 -0500
Received: by mail-pg0-f50.google.com with SMTP id 3so100352491pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 15:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zOi5MCQyODpiTSGEewNSqlWjGWBxp+8MsKS4FCpLdw=;
        b=D45S55VYcjZTjOcoE/wexanigoAIOLd7iwX7qSV24XZu7I8I1HHFkpMmDsMVBxRBD1
         GC53iLbmHIiRNz15yQc4ZENwnSuhP1Tid5QU9kkSXsjjpDlGlEGcCmrY2pYufpTwJBAv
         ilLc9U0H7DpKM6t4NRUgZBT5PQchmkI2GxTKx+Qfg6ptcu24Vxq+mtZ7Bap3o4jcai+J
         nMQI4N0uVybqfNPenNMFGiE+dQzd+J0mlWZ5koq3p5gh2VN14B1Xrk8uzKbH1bGSzxhc
         wyBC/WYty0mnuKar1oKZ60zyRe2u24s5u49EaicRLWZ7I4iV9AZUein7bqCF2WJxttWP
         7q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zOi5MCQyODpiTSGEewNSqlWjGWBxp+8MsKS4FCpLdw=;
        b=IPL58t1nMxKjUADGZjuDeOydvlhgHsZL3/ss7cRHkoWkslsd9yXm5VRWsyHlkm68tg
         tS8ladTu1pYxR/d3Q1NtsRO80OvPED/SjshmdKvnG4EDv09Ttyr4tKYD8+bwtICVewYb
         hESbx2EkVtBF1STJ4YRHZQBOOxtxHfUKoSVA+gSDwJZLuLy752Rp5StMAXpAfw5jRTyI
         TRd75yHqvcNaESWvWc6yb7x4JXYE7CP7df3/PxnxNOi45iQcr3pggh2Ok8rAP7VfWJCF
         0dWIqmWqYdcC0LmcVJEzu2Jh20kausbuePyt+DHhJWfkH0Vaono8FVdY/w1HO2AA6mHv
         xvtw==
X-Gm-Message-State: AKaTC0006gcoRHVtl38bOjtSss8BhcO/0TcwdTMrwl0Cj9bzHWPJaPNEsRUrxL+YsN4jEMw/
X-Received: by 10.84.178.7 with SMTP id y7mr90690095plb.147.1480636739137;
        Thu, 01 Dec 2016 15:58:59 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id t184sm2582812pgt.36.2016.12.01.15.58.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 15:58:58 -0800 (PST)
Date:   Thu, 1 Dec 2016 15:58:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        bburky@bburky.com, jrnieder@gmail.com
Subject: Re: [PATCH v7 4/4] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161201235856.GL54082@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
 <1480623959-126129-5-git-send-email-bmwill@google.com>
 <20161201214004.3qujo5sfdn3y6c5u@sigill.intra.peff.net>
 <20161201230738.GJ54082@google.com>
 <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh96n6x63.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > I started taking a look at your http redirect series (I really should
> > have taking a look at it sooner) and I see exactly what you're talking
> > about.  We can easily move this logic into a function to make it easier
> > to generate the two whitelists.
> 
> OK.  With both of them queued, t5812 seems to barf, just FYI; I'll
> expect that a future reroll would make things better.

Yeah I expected we would see an issue since both these series collide in
http.c

I'm sending out another reroll of this series so that in Jeff's he can
just call 'get_curl_allowed_protocols(-1)' for the non-redirection curl
option, which should make this test stop barfing.

-- 
Brandon Williams
