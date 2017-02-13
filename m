Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,TVD_SUBJ_WIPE_DEBT shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704891FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdBMXoT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:44:19 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:35163 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdBMXoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:44:18 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so9452690ith.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k/+w7oIgfpDjBW3KeF0P3OqOEFCIKh++cCOBkdn/6XA=;
        b=dpdbFZweWN1wXkIZ/xnSdzUAcFCLrNyYydBKi1mqPrLtK+GR1mNJ/FlGC780P3FT8s
         Tfy7vJRAz+LJ1fN5gS+NVwgKUy4TbCvasKcvBDza8PhgImGRgfc8Kj/6uqz+5OYzVc1c
         9d6NZJ7KlLJO84SfTmnIfCPvIoisRaSJU8/mA2l/WAJOdxIfbe2OKBD5XaebkP7jOkmz
         1Ie0b87Ig5d9IbMvvrWx08OMbycLUd0lbv4ZO+Tj6RnqDRrI7VeMM6e6Fk28eimy3UND
         kGS9l3M/Am4MeWMHFTl/agLI+l2SHPxNWrBkgfjcjwLC41oTkcZFld1TUPQD1+F0DnA9
         3wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k/+w7oIgfpDjBW3KeF0P3OqOEFCIKh++cCOBkdn/6XA=;
        b=cPQwwTRV1ZYkGrOd5C4rUd+IRkTNk9uJ4VLAKhmgJlbeC+/K/xfzBKvFNUqIoa0DBb
         u/NDCdHii2n3u+H2cbyTsabpOa8GKVcmCKkXiGqvyvGnL2Cw0J23PIIBa+tBBwB/Amwz
         gf5HrUSVom7N/h4TFhQwmoVR2XNuTpYNbpKDLfuWkFJYtqcg2McQBLX5OFYw94vFWmHx
         5fbIkF5mkf8W5LT7hEaRsJIO3JcqJ4guo6kqwkbobTP+rvBdRL3tVAftlHIMSvZ/WQVi
         YGhxjrHVoUGKzR7DYiBSpXv8ooc/i3VDWTaHsdj9z69o7p8dP/P5ldzIr+g9uYfy+ZYk
         9WVw==
X-Gm-Message-State: AMke39lWD7lDFSFQUSP9ExLrgQbxh13X/Rpa6jMYw3yHASS/sHTAXK7S6fSuHdxHKyzvpANEZIyYnZVN9G/HDs67
X-Received: by 10.107.16.14 with SMTP id y14mr22767133ioi.164.1487029457341;
 Mon, 13 Feb 2017 15:44:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Mon, 13 Feb 2017 15:44:16 -0800 (PST)
In-Reply-To: <20170213152011.12050-11-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-11-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Feb 2017 15:44:16 -0800
Message-ID: <CAGZ79kaYfdNgZ-AxQq3Tf+CF095O+GQ0ecqq1Oe2LcAGYjZP3A@mail.gmail.com>
Subject: Re: [PATCH 10/11] files-backend: remove submodule_allowed from files_downcast()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 7:20 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Since submodule or not is irrelevant to files-backend after the last
> patch, remove the parameter from files_downcast() and kill
> files_assert_main_repository().
>
> PS. This implies that all ref operations are allowed for submodules. But
> we may need to look more closely to see if that's really true...
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---

Looks good,
Stefan
