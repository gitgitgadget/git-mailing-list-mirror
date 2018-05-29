Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7D11F42D
	for <e@80x24.org>; Tue, 29 May 2018 18:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965571AbeE2Ssx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:48:53 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36763 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964830AbeE2Ssw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:48:52 -0400
Received: by mail-yw0-f194.google.com with SMTP id v68-v6so5162569ywd.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DP1nB32wXEue7HqDfMwbXZqGjymHyCw0HIupvdMP9Xw=;
        b=a0dRIqlURTXmE6yga2OiLKrru6RGb3fH5boOnbQmafdmspuPO4TsNce+W6bMhJEUpT
         BqZ+IACGV9h7Ci//8NEqSkzyYek+zJl578nn4yBDJDSsmRNbNoWCk9DBdNQIfabFGW0g
         F6WYxtF3Jhqe84HC6+YXTzwI2DoohlvvOdyYdDNolHfrbSbHQLWg7b2QrAYXobc0IUW5
         rlAEJsPHSvS8QmbRK0nW9GpDQJI4CSvrZ+5l72syVmiXEUtn8lul+ptOwbBWS/Nqs0A+
         NSURJ2f/+tAvfbC5jdn/c3VFSx6xtyPDK/ffNdtYgbGfYHhFB477zrk3I5TJLeB0KwlJ
         y8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DP1nB32wXEue7HqDfMwbXZqGjymHyCw0HIupvdMP9Xw=;
        b=TUGRRND/etKGC67BKgWWK/DgQVPLzzcCn6UWWp9/WVt4SaOAIgmjLV8/DEimvNHB2g
         0Ig+Pku0Epiq3A1n91HGy59jHIbSdDy/YmGj6mh1oydLnW9NWBObYSJQ1BGxOhClsZmC
         Bj4TXRYa9dIeuskoWDxZM9T97GiYWWls8ynQj+rE9FVoZ8VdbLTiDBPTnc2Xlq/YjyUl
         +1Jl4Z7P7CjDnrZcMJ5GRHhZPgIVh0Ws3gU4ADnms4wojSphwtZZ3wy2Apba3K0OvOpV
         6nqW8kB54OhYVuIwk2eW55dmmXDor3WmkcRJCLZTizz0HBdtzeaQs71RLGTFWxnHninf
         yw+g==
X-Gm-Message-State: ALKqPwf/UFqITJ4Vvhke1zU5DlZqmJSnj/eWct2Q5G4PK8IOm1cVBFeU
        puYPHiBZNIh20mEkGwzyslnzH0yqIAOAiPxZ/svdUcj09rM=
X-Google-Smtp-Source: AB8JxZr/D7dcct36d3Nv44s/OOx1G4XFEa/TiPtNdxUt/uyyjjzSFsG6z58x3xFnTALJwpEDW5e0zVBL4b8+xNUtvKw=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr10014000ywf.238.1527619731956;
 Tue, 29 May 2018 11:48:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 29 May 2018 11:48:51 -0700 (PDT)
In-Reply-To: <20180527083828.6919-4-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <20180527083828.6919-1-pclouds@gmail.com>
 <20180527083828.6919-4-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 May 2018 11:48:51 -0700
Message-ID: <CAGZ79kZ+kDRHKJj917rZ-=mmusuTcB4_Su-BNupqdQqT6rWRaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] completion: collapse extra --no-.. options
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 27, 2018 at 1:38 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The commands that make use of --git-completion-helper feature could
> now produce a lot of --no-xxx options that a command can take. This in
> many case could nearly double the amount of completable options, using
> more screen estate and also harder to search for the wanted option.
>
> This patch attempts to mitigate that by collapsing extra --no-
> options, the ones that are added by --git-completion-helper and not in
> original struct option arrays. The "--no-..." option will be displayed
> in this case to hint about more options, e.g.
>
>     > ~/w/git $ git clone --
>     --bare                 --origin=3D
>     --branch=3D              --progress
>     --checkout             --quiet
>     --config=3D              --recurse-submodules
>     --depth=3D               --reference=3D
>     --dissociate           --reference-if-able=3D
>     --filter=3D              --separate-git-dir=3D
>     --hardlinks            --shallow-exclude=3D
>     --ipv4                 --shallow-since=3D
>     --ipv6                 --shallow-submodules
>     --jobs=3D                --shared
>     --local                --single-branch
>     --mirror               --tags
>     --no-...               --template=3D
>     --no-checkout          --upload-pack=3D
>     --no-hardlinks         --verbose
>     --no-tags

https://public-inbox.org/git/20180527083828.6919-1-pclouds@gmail.com/
" There's no magic numbers (previously we keep 3 --no- options)"

Here I see 3 no- options, is the number how many no's to show configurable =
now?
