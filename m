Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2520C33
	for <e@80x24.org>; Fri,  8 Dec 2017 17:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdLHR1h (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:27:37 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:42506 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdLHR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:27:36 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so6400432itb.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 09:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eDJAuKTktMPoBLLGWi2jRy6rF9dXJEQ9JuXCCqyUbhc=;
        b=OqI0Dq+GgVKWoMADhFy43B1KXDjPUDQm0nu3zeHQRnYj+M1jwmXW7b9M0hAlQzYTud
         ibIcQRS00PTju/kHrr6olqi8MPy5bmOWWJUfQkLFFcDO16AXukRlmiuek4tsw4joFX6R
         e6Y6D12uz+nUQrIGiNVGtYCR2tfC9Ow9WE2CqN91mxSon1Q8DwRIdiQM1zc7PiKjpxxK
         LdF+qWdC6gwlLGO1WYs99ifbOimZ0vrGym2PirttFry0AGvUsPvYREB2CQld2VaL7chW
         q6ERWlctB/RKfe1/f+EC5n8igoi5SwIeUjED5SIy4WkJbel/ayuaFiWGvGut9226a8pr
         bH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eDJAuKTktMPoBLLGWi2jRy6rF9dXJEQ9JuXCCqyUbhc=;
        b=GPqDsOKitbwUV67fWJ8Pu7hWUDRf88Pdmj87jeS0gr1RJ+y1JuK6tGIrKhz2VS3ZiP
         8Gh/1cyq98GvxdddGmk1AM7cDFVQuC4Rnoz6j3LPNr+bzH2NlA+jGVG+lr5Gi4xQH1Ua
         cWt77kt+32R+3o5OqgzSP4GnJ93ri9uyT46RPHaI0nOKgkJQxdlVPkmpiMz5ZLPtuflF
         OaNBAK+RszAipxJXO7aX5p7Sgg4GJpx4G7Rb2ZHYHy3hyWSLiNFr9Q6AMB0+qzc5/jWD
         hNeu0ZXVUHdE+w1MYQdZFWDk9XYAamBCUJFRYqPxGtiBU+/Xdz5wxOAkAZ/4XMk8bIwk
         fLJQ==
X-Gm-Message-State: AJaThX44MK/auBymrKnPg/ccUGp0Sfkx/LUi6V1S/tE/2y2UFpJYoeht
        sGyJf6DQeoPqBE4iFAO4ETA=
X-Google-Smtp-Source: AGs4zMZtq+WI4CVjajWwRuruJOndOkr2huvnx7DPWMggOxFAMjsxyhFi+UdgVoL8KcM4BLMISnD9tw==
X-Received: by 10.107.169.132 with SMTP id f4mr41606338ioj.218.1512754055934;
        Fri, 08 Dec 2017 09:27:35 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g79sm967527itb.29.2017.12.08.09.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 09:27:35 -0800 (PST)
Date:   Fri, 8 Dec 2017 09:27:33 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] version --build-options: report commit, too, if
 possible
Message-ID: <20171208172733.GC14261@aiede.mtv.corp.google.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908989103a06291e38c8551c447bc73eb781fb26.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> In particular when local tags are used (or tags that are pushed to some
> fork) to build Git, it is very hard to figure out from which particular
> revision a particular Git executable was built.

Hm, can you say more about how this comes up in practice?  I wonder if
we should always augment the version string with the commit hash.
E.g. I am running

	git version 2.15.1.424.g9478a66081

now, which already includes the commit hash because it disambiguates
the .424 thing, but depending on the motivation, maybe we would also
want

	git version 2.15.1.0.g9b185bef0c15

for people running v2.15.1 (or at least when such a tag is not a well
known, published tag).

> We need to be careful, though, to report when the current commit cannot be
> determined, e.g. when building from a tarball without any associated Git
> repository.

This means that on Debian, it would always print

	built from commit: (unknown)

Maybe I shouldn't care, but I wonder if there's a way to improve on
that. E.g. should there be a makefile knob to allow Debian to specify
what to put there?

Thanks,
Jonathan
