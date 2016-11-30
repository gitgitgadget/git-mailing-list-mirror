Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9901FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 16:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757143AbcK3QCS (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 11:02:18 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:35506 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757115AbcK3QCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 11:02:16 -0500
Received: by mail-wj0-f196.google.com with SMTP id he10so8619034wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 08:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Lk1rfVHpbyMhXHIrazFmtqVHGCrVdjHl6BCs509FpqI=;
        b=O5K8sVFt6WH2MjDbhKTMmXgTiNVqhrYtvn+UHjcuZhblO8N62npWBrPPqg5CUoa72H
         l0AuBRvdWQy4iXSvGKEB11E293j0P3lgj4EnKIZQ2LJm5lazFmU+3x9b1xmGmSXpnelF
         u0iVnLJec94scFW/AjhUGqIZM1yDTvzQxknBV1p00C1fMsnxEAZuQCTqF35/VA9Vfv8R
         G833nthUKIc8pphxfB1oMzcRTMSHoh1cIuetJh2hoKV/XiQ0GwpzOZy/EYYM2xEe+daJ
         qEXcwCgwylb/4oBoRWIZX07HDQaoeqGvKE7gCuTr6bhRD+9J4P2/g5HD4IJJA8sOfnVj
         tc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Lk1rfVHpbyMhXHIrazFmtqVHGCrVdjHl6BCs509FpqI=;
        b=f2jCIrNlanxoHa0y5fP96tzakay+2CB0YrGv9y8CloyaeeXmwMTFUDOeQipgtbyXWn
         rE1qGu52WQPXVInAi75hAaMNeI2KGTlRLXnPdJgHvG5LQYHxbtVLQgtlxsFH+lLT11NE
         caxp9jswzu1lPe5Jy4ScFISQSNeAV/v1QS9qtKP/d09mT6hL/0QpckZ4ouSFd93jLWel
         A2Z1d6FuZ56oMlJASutuP9GdKN8MrWhEAqQOVoc8WsvCkNg/v07Nye+/0DjsjQi3Ox4y
         Wua4+nirEL5Fsr4pxQP6BX9rHziHTT176pC3S0tt8illJ5cFEqCcpdMfvgGzpPLehlq/
         UG2g==
X-Gm-Message-State: AKaTC01dANT+vp63g8ptPJsXGur2R3p6e1NFpQsM3BBFmIXleSRB6be83TJ0T8nzsFZbEw==
X-Received: by 10.194.145.70 with SMTP id ss6mr11809023wjb.158.1480521735228;
        Wed, 30 Nov 2016 08:02:15 -0800 (PST)
Received: from [192.168.1.26] (epg20.neoplus.adsl.tpnet.pl. [83.20.48.20])
        by smtp.googlemail.com with ESMTPSA id u18sm8670305wmd.1.2016.11.30.08.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2016 08:02:14 -0800 (PST)
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611242211450.117539@virtualbox>
 <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251201580.117539@virtualbox>
 <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611251841030.117539@virtualbox>
 <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261320050.117539@virtualbox>
 <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
 <alpine.DEB.2.20.1611261400300.117539@virtualbox>
 <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
 <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611281830040.117539@virtualbox>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <855b9172-7225-e09e-e46d-87940f9fda75@gmail.com>
Date:   Wed, 30 Nov 2016 17:02:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611281830040.117539@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

W dniu 28.11.2016 o 18:34, Johannes Schindelin pisze:

> My original "create a file in libexec/git-core/" was simple, did the job
> reliably, and worked also for testing.
> 
> It is a pity that you two gentlemen shot it down for being inelegant. And
> ever since, we try to find a solution that is as simple, works as
> reliably, also for testing, *and* appeases your tastes.

I just would like to note that existence of file is used for both
git-daemon and gitweb (the latter following the git-daemon example).

So there is a precedent for the use of this mechanism.

Best,
-- 
Jakub Narębski

