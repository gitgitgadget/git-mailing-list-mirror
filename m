Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100871F406
	for <e@80x24.org>; Mon, 14 May 2018 03:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeENDF4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 23:05:56 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:38159 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751984AbeENDFz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 23:05:55 -0400
Received: by mail-qk0-f179.google.com with SMTP id b39-v6so8861086qkb.5
        for <git@vger.kernel.org>; Sun, 13 May 2018 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=EphNXghWcYZMrSCn88lGvhfM5PZPeK8II0unBfiSnWU=;
        b=Q6G+LH2wHPL18VbuBjSkeGTT0fCrsEabM23ifUhq/h6xdf3ZuGDho0K4JKePIQMOld
         bWCCkIzpuVKMPlalmJ5zxLM+c6FdDjYRVHyNVzrUgrs7aygny21PXbO4GNIWj00fl+iv
         mu0Tac2apyehi+DQU7hrmFP56aSUNNsxfRGgkoj1n2FDiFSdvsCeOaB7sTmO+36gtgcb
         sJhbSHhF8eGtcBqFlw4rxF2mihAXzUzLKjYWJs+nxm8dCIWeZcq1fC4Yrx62S4wBvJtE
         Pqe2KsPhv46MkbHwNwMs+y2vjwxnApZ5brc0qJp7nuF/8tZdhy6aL18h/7876Y0J6M+P
         oTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=EphNXghWcYZMrSCn88lGvhfM5PZPeK8II0unBfiSnWU=;
        b=XSxM+lAqj6YaFiPyA4IctU/Wg4oZlW4Jx/SVeVrksYtYOzG/LS6IJA5Vcq9x5QbUgs
         mx8rwqGOevtzULQtKvhtWxMc8rljoQzzPvAcZf5/7kI8VGUpysSxrUEi1VryEw/tl9GD
         Rjx24xFwmFRoPaksGKvGUcmAeb8VgUpyVQ6hHsq/QCkxYjNpX7OCur1dx0GUF1ojgozu
         xneJAZLraUY7u8T8xcx+BcqHK8isfStLmVOM5CWXykZJExgreLyIeytceoYvzZtMPt8z
         Ps2pSKYAXo2tbj06n/JmdrZlfLwiyh1OM5Ighybp5tI6HvbO7b49ztmERSZn21HQ6FDp
         8kEw==
X-Gm-Message-State: ALKqPwcFzTilPU/TFFQNtmHtdPO4scbYB92Em1cgbcil6q4AQqLTaUKL
        PNr3A+Zx8pmmJB++pZ+qBu4qnErwvL2MXFHYihU=
X-Google-Smtp-Source: AB8JxZocYw/+GHfgRzyrmJIYvmIk1KYu6yYCOfmtl/8nYx8AWd6fnzdQAFWU+ziDsp2zBbNBu9oQ6dUkytJqi2I4Yto=
X-Received: by 2002:a37:be86:: with SMTP id o128-v6mr6413396qkf.141.1526267154645;
 Sun, 13 May 2018 20:05:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 13 May 2018 20:05:54 -0700 (PDT)
In-Reply-To: <3f64a4e24a83a9041c79c8b302207af7687dbb21.1526204440.git.martin.agren@gmail.com>
References: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com>
 <cover.1526204440.git.martin.agren@gmail.com> <3f64a4e24a83a9041c79c8b302207af7687dbb21.1526204440.git.martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 May 2018 23:05:54 -0400
X-Google-Sender-Auth: Paid9FzDcC_OJQ0pJaXVG3h9hD4
Message-ID: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
Subject: Re: [PATCH 2/1] config: let `config_store_data_clear()` handle `value_regex`
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 13, 2018 at 5:58 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> Instead of carefully clearing up `value_regex` in each code path, let
> `config_store_data_clear()` handle that.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> I *think* that it should be ok to `regfree()` after `regcomp()` failed,
> but I'll need to look into that some more (and say something about it in
> the commit message).

My research (for instance [1,2]) seems to indicate that it would be
better to avoid regfree() upon failed regcomp(), even though such a
situation is handled sanely in some implementations.

[1]: https://www.redhat.com/archives/libvir-list/2013-September/msg00276.ht=
ml
[2]: https://www.redhat.com/archives/libvir-list/2013-September/msg00273.ht=
ml
