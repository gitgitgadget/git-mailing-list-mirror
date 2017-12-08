Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7312020C3A
	for <e@80x24.org>; Fri,  8 Dec 2017 18:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbdLHSLv (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 13:11:51 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33511 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdLHSLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 13:11:47 -0500
Received: by mail-qt0-f171.google.com with SMTP id e2so27936206qti.0
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YM1eZylrR+H8OtBWqM1246Zc2x6TOMAYOWvBW0aPU2Y=;
        b=IwwCtQldv3T2aLVb7D63AnL5bdyh8tsRubJrqeyF3l+u3JsC4JH9gjzf1geLAoabGG
         1k7bINWKXaCRWGmxY9Dz77XQbUUU9Wv0zznjJMVgR6VmBPELNMteYtjfPXGutuXhO+Dl
         ccTZ/YCFIXgLxrrQNAM3IX3ybTjY5CUnOTwOKH2Lj+Z35sWA3rNh4C8rFlMeWF5/T1te
         KpwrYqQviBaEcUKIB0ubBoZlJhgZUepkZQ0x4CGvEukdR5Vrz7kFOmTzbQt93sEXjza+
         UmW3mUGXrd4mgpQDUsVh2x13mChvD+IMwl30bZ8UHDe9E18eIL5UkMRck+jkAMXWOgwz
         ExFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YM1eZylrR+H8OtBWqM1246Zc2x6TOMAYOWvBW0aPU2Y=;
        b=OXYvkrlKh50frJTC8VhXjXDBRRUHQzw3JhnZPiEWwvN8kZU+AO6Syz32YVish/gZhH
         Qo8RxsSKkt5aN2EXO16/Nkn/DXh7M//Fp39kXIEOTwEEffOe7FuuE2HzYLDNRV37iTe9
         A5AukQhwHF9TUes+eaW3mdroW78vi2dutQwQwY/y4dtJoS/8Wj1ixGgFexFf5E3ArEnU
         A5ASr3lu0BTCRNg/P+qHAicxXmvj9Mm0D8qXax8I7ZZLnRrp+ZS+NxsnptBG9rW2QF1M
         G9O/7sBW7xLxRWZ2bCGUhrubSIgfdCuHPEjF3+hIxf04qqdLna627CZVvDKbcq312sIg
         j7GA==
X-Gm-Message-State: AKGB3mI3Q2gRkaMvUuVHqj2jAQ6ANnwdNs/8p8tE3ojuHSZh53/hO0RO
        BpxcDhLnLvNdo14V0wNau5ChAuQXoKnpd5Iqr9A=
X-Google-Smtp-Source: AGs4zMZSzHcMKorz1MDfexxai22n/8+eWPfZuTsJt9pxuFsbc05IAixCaF+ZMQqcUGafYjatvLy6jfG6JOTd8fUidcs=
X-Received: by 10.200.39.104 with SMTP id h37mr16575443qth.114.1512756707132;
 Fri, 08 Dec 2017 10:11:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 10:11:46 -0800 (PST)
In-Reply-To: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 13:11:46 -0500
X-Google-Sender-Auth: bifucsVJCL93mzahaqbOwsg3vZU
Message-ID: <CAPig+cStPiUoqO1pRqJ7X679ALM+UhufJ5vhrRQ1j5fwoMtCJQ@mail.gmail.com>
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 8:21 AM, Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
> Create header for pretty.c to make formatting interface more structured.
> This is a middle point, this file would be merged futher with other

s/futher/further/

> files which contain formatting stuff.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
