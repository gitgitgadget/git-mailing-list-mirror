Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6B8420A40
	for <e@80x24.org>; Thu, 30 Nov 2017 02:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbdK3CLm (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 21:11:42 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34963 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdK3CLl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 21:11:41 -0500
Received: by mail-io0-f194.google.com with SMTP id q15so5894019ioh.2
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 18:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IM+EMg5ZaYuebtATT/qR3uaiMkEp9Okmvcc2fceuYC8=;
        b=GhQ7LL2hMUPCcovFeNfZI+1eADDXaZqWhFLulYDEw0N2PxCQ2aiwX/hauVxE1vH1u/
         Ch2N/DEVRqIbeQJu/XLUfBUXuVy0Vh+d/tWANDnU1fx1GkEGeetTRVMKDicX4cODyZBv
         7OzABFs5yaM5EwRbBmTtbCty8IXFsPfdB65LTGGoY5Vsp6kNQYwK+m2T5plkkLlV6zvy
         C/Xu50721s7+hT0bitxP+Llwq6O//dy9OueJTcruEW5NmFzff8+4B2S1xy+WQ8e1wlu+
         0YG6IGyH+Zj4ufCcdT+Kt6CjRnTI+5Rh9GVobKlMOgYWetdtLkzOcrE56pL7Ak3CDnIS
         ca0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IM+EMg5ZaYuebtATT/qR3uaiMkEp9Okmvcc2fceuYC8=;
        b=A+F9PtbBvmJmPa48TfaiK4pHdb9yc7eCEEqyvGUjzSJfA+ejRdcFdGowJ+3lYBPq67
         4EJTjl6k7cc5aIdBwEMP3fNsSSJDeyGhjavIYalO6MuwRlwTGSbjD8Q7r8bIDMgwgEGs
         g36Q5KnqoFb31OLd6VYLZ4t4EH9iyGX6JYmX5RkNxlUHaKasKF8iLLCW6lC3kumJlOdO
         xCxKqRjSqrkzwNfdGjFBHqoql4e8mUPcjWftmYE3I0t7uE34jQbSnah0PzIxWYsdPR/g
         vtWwXGU1dR/0d5dsqRl5RYxJEak3SsonlPVsATnofei/ubijvVKs5JMtXgCy5S1ZL9VV
         SJOA==
X-Gm-Message-State: AJaThX4TrGVjHlpnvgreLmugHSdoLIkCaUIBqQ9JbOwQAQbSPVBJ/TX7
        VbAU+fvL95IkqLAzR4Ey6Ac=
X-Google-Smtp-Source: AGs4zMYxHiPV+Y70A8Ig1+N8dqFeqt8ktTTMkQ1cJ71wJ+fmHCZ1GGQV+WB4KeXytx82gc7pY+UqUA==
X-Received: by 10.107.169.6 with SMTP id s6mr6270982ioe.103.1512007900591;
        Wed, 29 Nov 2017 18:11:40 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j204sm1697513itj.16.2017.11.29.18.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 18:11:39 -0800 (PST)
Date:   Wed, 29 Nov 2017 18:11:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Makefile: replace perl/Makefile.PL with simple make rules
Message-ID: <20171130021137.GG15098@aiede.mtv.corp.google.com>
References: <20171129153436.24471-1-avarab@gmail.com>
 <20171129195430.10069-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171129195430.10069-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> Replace the perl/Makefile.PL and the fallback perl/Makefile used under
> NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
> inspired by how the i18n infrastructure's build process works[1].

Yay!  This looks exciting.

One quick comment:

[...]
>  * We don't build the Git(3) Git::I18N(3) etc. man pages from the
>    embedded perldoc. I suspect nobody really cares, these are mostly
>    internal APIs, and if someone's developing against them they likely
>    know enough to issue a "perldoc" against the installed file to get
>    the same result.
>
>    But this is a change in how Git is installed now on e.g. CentOS &
>    Debian which carry these manpages. They could be added (via
>    pod2man) if anyone really cares.
>
>    I doubt they will. The reason these were built in the first place
>    was as a side-effect of how ExtUtils::MakeMaker works.

Debian cares (see
https://www.debian.org/doc/packaging-manuals/perl-policy/ch-module_packages.html
for details).

I'll try applying this patch and seeing what happens some time this
week.

Thanks,
Jonathan
