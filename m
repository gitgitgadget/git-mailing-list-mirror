Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278912034E
	for <e@80x24.org>; Wed, 20 Jul 2016 16:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbcGTQjX (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:39:23 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36554 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbcGTQjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:39:21 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so63435758wma.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 09:39:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XCT9QCzbk/FJ87LFycI4OQNyuP6ucLwGgVu/pKwZszE=;
        b=GbAQINb8O8rrJaIli/GzlUkpUVtKPLtXm3na+8ntE5r+ioU3iRWYADyzL94P18ohFD
         4iiIWVkk2ac1y4kEwo91/ZcyyK/Q/UCKZWr9LzdhYxkpLTp64lKDAbtIauYK4isuz7AE
         19K2ygjJxyXGwalCcmB9LONlzlFxKxssYwjLUBxKT+so4hMGkKDLDOVZFEkj6kGtwyAL
         ou6lSeRJ07jy8KjYocSGrkyB4WcZY6ImNfp0HS6COGPmAr4zrHgGz+FHq3YNRKYf3Qs6
         wcRqMI5fIzk+IXIwnRJWcKAOUqykmTEohAOwdvJj70sKhSH5Fnsd6T2yyuFfDHU97vpR
         vi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=XCT9QCzbk/FJ87LFycI4OQNyuP6ucLwGgVu/pKwZszE=;
        b=hZJYzjJdGRo2hc3V8Bt8+77/xZb3NSM3RmLfgUaqByIcNyvK3s0+HoG9Io82++xmmL
         3gOHPbU85jrHYai+h5ZQ4kYD3XYg2C+99+E29rNPFdjSAaSQYwBY5Ri4lVnkzQImqg/t
         mU+zL2QTHNAJIMwL8IoT8yda+knDhzZjNN7w8OkNEEEtlwHxlzppJvg18JxefKoBpzcS
         ZLL1i9ALsR3i5WE/pXjHjMcDMZSIcP8PaVcUMCro47JsSNO7DqZfQBUzGU1Fphz6AKDp
         sNGD6E0jBko91Vq5/+EJU+7ZuWrDMOvjeolmk/e0ch0cVf27llW1mX5bzkXXr4eC1S4A
         ntQw==
X-Gm-Message-State: ALyK8tLgypVMQKfR91sH5dGqQYX0mTBqV3FphSssBwf0hg3heljrhO8t3b6Gd2LRmvjUWA==
X-Received: by 10.28.127.138 with SMTP id a132mr11846373wmd.72.1469032758980;
        Wed, 20 Jul 2016 09:39:18 -0700 (PDT)
Received: from [192.168.1.26] (daf247.neoplus.adsl.tpnet.pl. [83.23.5.247])
        by smtp.googlemail.com with ESMTPSA id d5sm2080788wjf.39.2016.07.20.09.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 09:39:18 -0700 (PDT)
Subject: Re: [PATCH v4] config: add conditional include
To:	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <alpine.DEB.2.20.1607141750190.6426@virtualbox>
 <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com>
 <alpine.DEB.2.20.1607161507250.28832@virtualbox>
 <20160716150835.GA24374@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607161834420.28832@virtualbox>
 <20160716164747.GA24933@sigill.intra.peff.net>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578FA931.4050708@gmail.com>
Date:	Wed, 20 Jul 2016 18:39:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160716164747.GA24933@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-16 o 18:47, Jeff King pisze:

> Heh. Don't get me wrong, I do think there's room for digging ourselves a
> deep hole with conditional includes, because anything dynamic opens up a
> question of _when_ it is evaluated, and in what context. So any
> condition should be something that we would consider static through the
> whole run of the program. Looking at the "gitdir" is right on the
> borderline of that, but I think it's OK, because we already have to
> invalidate any cached config when we setup the gitdir, because
> "$GIT_DIR/config" will have become a new source.
> 
> So I agree it's something we need to be thoughtful about, but I think
> this particular instance is useful and probably not going to bite us.

A question: we have a way to track where the value came from (tracking
includes). Do we have a way to check where the value didn't came from,
because for example error in the include condition?

-- 
Jakub Narębski

