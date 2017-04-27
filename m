Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCAB5207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 19:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164149AbdD0TgE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 15:36:04 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34453 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031818AbdD0TgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 15:36:02 -0400
Received: by mail-pf0-f182.google.com with SMTP id c198so36036118pfc.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nuktbscwk6QgCLqEYoBcj9Je8pRg7HR1PZeEJmMeP/c=;
        b=Xy3XSZ32Jkt6rXMJkfbC3eUnMkhNmWm87jU4B3j+330KNah9Hkad7Gd2zP4Rn0/dw7
         Idyh9gPZsby10vJ7DsdlFXdpBA4LvLJvS4x8ANQebbBSkYu7SLQv6F6GJssSKgIzc2rG
         K6kZYkq77NEC6UeJEK8lQhg41KPRVJuPhxEasok0p6qJUiyQxc9XLcIDjSBNAzf7K5pU
         nyQLpPprebXHXJP7Fk4BtS+M22tSfxKg4TPJq7FDlmGug/2PeH49Zljd05XeJupFEw/8
         oJY3MI0fbh7ULWOwkUVdGGz8rma2a4IOmYKUIkSOIolCenIwDX4WcOVG3+kxCBj7bM4G
         x+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nuktbscwk6QgCLqEYoBcj9Je8pRg7HR1PZeEJmMeP/c=;
        b=C0vKpFXJc2R52sQ6hj9IQnIxNyUxUzQXK4BgmYPOdU+ao0MCNE5na1UzdooYo6D802
         GChwbgpg2I46pWmZy8en70yQtgv7G+KybRHTGQ35cURjFR/NgOFFieE/U2IG3KbpYW9y
         j2oHcJv8Q8xyn1k6JV/v2/dq3D5tDCxLiQMi+kSCB9O+Zj93hzCyOR4fQ4HX97ZcKVrA
         SkuW9W/yVspc/q740f/EEiQDrmAVAN7J8Sh0ndo1CWQ3yfoSgxg3c7zl3DMNYNBZIoN4
         b2tv/yjBMUlgiC5TUIVS/pm9AUkepYdSlEPgawSYwHfM6Ou99NR8gvNKBddlV624crGq
         wvbg==
X-Gm-Message-State: AN3rC/4QYUGOIEPUurzLRT/2I+BcxKWUTTGQGfEUYimtpxU5zbTEdPs3
        7g9dtHp5D37dLXHwZY9jaBvTkqoUsHTJySIfaQ==
X-Received: by 10.84.232.133 with SMTP id i5mr9683531plk.172.1493321761984;
 Thu, 27 Apr 2017 12:36:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 27 Apr 2017 12:36:01 -0700 (PDT)
In-Reply-To: <20170426231236.27219-6-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <20170426231236.27219-6-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Apr 2017 12:36:01 -0700
Message-ID: <CAGZ79kadPPBxW01p8KFGrcj3XwT1VZCcNTG4O_vxpU5n-ZRPFA@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 5/5] WIP clone: add a --[no-]recommend-tags &
 submodule.NAME.tags config
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 4:12 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> @@ -855,7 +856,7 @@ static int prepare_to_clone_next_submodule(const stru=
ct cache_entry *ce,
>                 argv_array_pushl(&child->args, "--prefix", suc->prefix, N=
ULL);
>         if (suc->recommend_shallow && sub->recommend_shallow =3D=3D 1)
>                 argv_array_push(&child->args, "--depth=3D1");
> -       if (suc->no_tags)
> +       if (suc->no_tags || suc->recommend_tags =3D=3D 0)
>                 argv_array_push(&child->args, "--no-tags");

Here you would also need to pay attention to sub->recommend_tags?
