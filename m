Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 967061F404
	for <e@80x24.org>; Mon, 11 Dec 2017 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbdLKR0U (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 12:26:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34730 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdLKR0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 12:26:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id y82so14043103wmg.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6qRaWbU8srKJu563sONztDohHXP83aHDyEv8YrXO9vQ=;
        b=ijSvHPbPB/WEDRt5paTgqYKpUGLWkN7QX2rKAIAzHjj4heSQZbA+lPbXtfE4hwjTOn
         cZduxoisIy0aLc7unOP7M8ro0std6F8XH8Ivks/BljcdgFoiRvHtp5uyY1NPnyrSWrLK
         SGgx1d5QfQ+ElZk4pkjJOHY0vLJ7BgTHzio4ku7cj8RO7Az+CrmBfUXSk2ofUFxJe7It
         /aI6yiRllII2+vCYdqW6Zx4r1uoJjU+IHDGN09U+aefPsBE3d0fPtZGlKUs7ltJSa0E6
         TELCmM2RirIXBWYZvQ8c2fChvl5ts6I8ShTNxznefCc7BHLMPOrT24x2fhGG+PGG7+rW
         UTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6qRaWbU8srKJu563sONztDohHXP83aHDyEv8YrXO9vQ=;
        b=V0lFHbo6TWbwCGqeMDFI9wMNCt82LQ/kmqpgdcosj3sHmn/uIGp0euIMty0IlSrhVw
         OIVxPX4TZ2GypSyXF3qQexS9lp1sZziBlzW9soulikJR6ciGBtgeA4UrxvnJM1OQANnK
         a0D+7jr5xu1S2tfeh/XtwbhH8ArvwIyL/ugSOzodt4Cj0XOSLRlaMLM09eX0d4/TU9Ch
         X2HgyQc7ZxWUByFITTusW7xYdwvNoSRd2EMgjPoQo88uMlOfyKGu7INu8ijWHxFW1VCH
         jcRBLX3LXs6J69Z6PEeiVVCmvbU14MjPFORgiUfTbUUEU58VcboPQLoRZUiZK8Q5Sesk
         lpPg==
X-Gm-Message-State: AKGB3mLVjtAiqlpHjTPbj76lLpfB0P7FVKXguOCx/CmUcwKicTRoW76m
        ehbPh7F6ScEvB2LrW99n2/Y=
X-Google-Smtp-Source: ACJfBosJkWyO9SVOLqtgJFRT3ZK2B8xoMyIJ9Q3DxX/nxsxmBf4yRjxJ3p3umSDVjrESQDnmx8ImCQ==
X-Received: by 10.80.137.111 with SMTP id f44mr1986088edf.257.1513013178289;
        Mon, 11 Dec 2017 09:26:18 -0800 (PST)
Received: from laptop ([46.233.112.181])
        by smtp.gmail.com with ESMTPSA id l9sm6270168edi.58.2017.12.11.09.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 09:26:17 -0800 (PST)
Date:   Mon, 11 Dec 2017 17:26:16 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Adam <thomas@xteddy.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
Message-ID: <20171211172615.jfsjthkvs4itjpcn@laptop>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
 <87wp2jwe9o.fsf@linaro.org>
 <20171121205206.fvwjkkwhil4abmmk@laptop>
 <xmqq8tezyu3g.fsf@gitster.mtv.corp.google.com>
 <87mv2p89wu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mv2p89wu.fsf@linaro.org>
User-Agent: NeoMutt/20171013-21-a9a9c7-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 05:13:53PM +0000, Alex Bennée wrote:
> So have we come to a consensus about the best solution here?
> 
> I'm perfectly happy to send a reversion patch because to be honest
> hacking on a bunch of perl to handle special mail cases is not my idea
> of fun spare time hacking ;-)
> 
> I guess the full solution is to make Mail::Address a hard dependency?

This is what I was suggesting, and then as a follow-up, addressing the point
that there's a bunch of require() hacks to also get around needing
hard-dependencies.

-- Thomas Adam
