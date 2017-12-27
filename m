Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10731F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbdL0TVG (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:21:06 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34446 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdL0TVF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:21:05 -0500
Received: by mail-it0-f65.google.com with SMTP id m11so28492942iti.1
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 11:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DETdfexnzCYNVUp2O1fCuJi0fn9QifKGviDjBdCyXxg=;
        b=mxEgORVT5xM7cVdpLyN3BY/xN4NEIaV9erHuEEv/puoAwzeVJUUOqg/WPXrt8LsCBI
         RoT31nTw0bnFhTmQuiesWshKrY5bmA9R1MUt8EnrkBFH6n3EYCujYWMyhq4R2riFHcLr
         AJsVToJXwGlsLNGCy7fDXjVxxbbird6bygsdNxlc/gQptlUvHjUsjzYxa3lv1Aehev3D
         6y1o3LohvO+cmAs6hl8s2Iat3fW0cJfliSB81lSsgqRkHHW1nS28K6gnWWhGfeJTvaHP
         5SCl719SimRG9P5eQRefiLQJx9SiIpEaMpaHlzJ6npU/OrsnpfLQGvxJqfIqdrnCsDSw
         Td2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DETdfexnzCYNVUp2O1fCuJi0fn9QifKGviDjBdCyXxg=;
        b=J89qs9qdpfYBUZ20La+RMYkmaBQCdtIdKiBc3s443tyFmChXf2rtnmUWQLQCasewkH
         bVrcvqkdOJZUilhE2Cktd7diYe4lHMB1P+YO4CK3GAMCybMCht9Wh2sWk8pMzPK2aOf+
         O0BH/sk59rGsn+I7iQqzFS5JH3s6Wot3RazJdG5/58KiWUtE4w6P3fdwo0CmBImtRbGV
         b2gTkLcvo3fljy1vUxtMGfFHQYoAttTIQQ2nOn1ydTtFjJIpe4sb0Ax3g+pP/jXxnq7R
         5C5DdRsXVc6gDS5CyLXe5RCjtu7H08iELXgRyKyTg+29y7aDzxKhJUwRTYvgWOE+eNXY
         NYyA==
X-Gm-Message-State: AKGB3mLUVvSS/KyXei7XoUANEOb2CQqGh7TIjuj37H4xOdsp0gJZIktb
        Tb36kEzNI8Cx6G/epv6TVn4cP3wu
X-Google-Smtp-Source: ACJfBoviVX/WUmh+jM36SrcCKLQtPnbSu0A+Hf3fzM+/jPCa5Li4eCwYPtiIT6df4SDu2Sc7d5wDxg==
X-Received: by 10.36.249.134 with SMTP id l128mr38775801ith.12.1514402464852;
        Wed, 27 Dec 2017 11:21:04 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d1sm10939634iti.18.2017.12.27.11.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 11:21:04 -0800 (PST)
Date:   Wed, 27 Dec 2017 11:21:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>, Jakub Narebski <jnareb@gmail.com>,
        Petr Baudis <pasky@ucw.cz>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC/PATCH] perl: bump the required Perl version to 5.10.0 from
 5.8.0
Message-ID: <20171227192102.GG149622@aiede.mtv.corp.google.com>
References: <20171223174400.26668-1-avarab@gmail.com>
 <20171227191636.GF149622@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171227191636.GF149622@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Ævar Arnfjörð Bjarmason wrote:

>> This is similar to Jeff King's jk/drop-ancient-curl series in that
>> we're dropping perl releases that are rarely tested anymore, however
>> unlike those patches git still works on e.g. 5.8.8 (I couldn't build
>> anything older).
[...]
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

One caveat I forgot: please also update the INSTALL file:

 - Git is reasonably self-sufficient, but does depend on a few external
   programs and libraries.  Git can be used without most of them by adding
   the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
   config.mak file.
[...]
        - "Perl" version 5.8 or later is needed to use some of the

Thanks again,
Jonathan
