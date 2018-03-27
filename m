Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0221F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeC0PmM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:42:12 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54098 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbeC0PmL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:42:11 -0400
Received: by mail-wm0-f52.google.com with SMTP id p9so9987829wmc.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vOTucxFS48r4hw4/IT4lbZ5rY4brKJ0HJRqd6Hue4qk=;
        b=nk72DRnzBz9aAudGkxvbnsH1lEyGHF5Kb059NlHdTjQjBzZeCo1oBm5H+wLRLYPM5U
         bk7lmNPCz71JdjB2Km4e+FqCqUF60yA6IYqSeaRR296GI7Otq+2EdgaPrK0WmDWsUF+2
         PwYxeWgs5/Nw66gixTLOeOngmC74WvRebimKtKMqAM4JyUBCIC3VPH5NSJ6iBNC62zo8
         NFZiHAuakSeDtkLptGjMgrdRkeu/wFUMCpvBmNE8Zx4JzvT1+8zWxgVsNCBvtKiKi5d1
         qSf2phaCl5sL6IxHK1axKl67Q0oAfVKvKtjoTIVuO3yMAl8g24922HK8n1neOOBPmkwn
         Q+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vOTucxFS48r4hw4/IT4lbZ5rY4brKJ0HJRqd6Hue4qk=;
        b=Ts1hdFCuGgGpUZD68Ph91NAJvVxAmn3JaSmce3BBlYc5okyyv1IXxZPHvYwXOddUft
         BDBvGPVv3L9NofHVjTKpN5VTOrB6mcXCaQFKV33MRtOa0WcvI5qJNuOgecQ1qC9V9pDz
         WOC4oxkUpIQc7n7TPjW6mBTu75M42X02vSpAjTXAVH/lYa46+tiHWI0v1umCCzOrjDH5
         zjzlJyTpA9c43gqUEJ+9XmAC+2VyFJKvNKU+jiqitYVxhB+kwl0tx8CLlPaCpePBQOy2
         z8ktFoLM2Q0krSJRZjuhahP05elzmi4mO92HhQva6fgwFM/4WAC/kvP0uJzdzxIO7QsS
         NifA==
X-Gm-Message-State: AElRT7Ebhw/OBJiGAGfLGnd5GS+xZkkCo1pFAOGNcoKvZ11LKIfWw753
        7vRoUReUJjdrH6jjgKOehcArGByG
X-Google-Smtp-Source: AG47ELve3nGD2dY2n3zoytleOxIgkp4uwDHlJ5mfQhDYSwQVk2hoLEwj4JvWxhREfGsW4LLpCsiFag==
X-Received: by 10.28.192.8 with SMTP id q8mr16419529wmf.103.1522165329317;
        Tue, 27 Mar 2018 08:42:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g186sm2031768wmd.41.2018.03.27.08.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 08:42:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v2 00/36] Combine t/helper binaries into a single one
References: <20180317075421.22032-1-pclouds@gmail.com>
        <20180324074505.19100-1-pclouds@gmail.com>
        <nycvar.QRO.7.76.6.1803271558380.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:42:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803271558380.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Mar 2018 16:00:00 +0200
        (DST)")
Message-ID: <xmqqtvt1a5kg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This iteration, with the SQUASH??? I proposed (and that Junio will
> hopefully pick up soon), works well on Windows.

Thanks; is that the "call it fn, as main is macro-ed away by us?"
change?
