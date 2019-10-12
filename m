Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77DD51F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 22:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJLWQR (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 18:16:17 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42534 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLWQR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 18:16:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id m22so8519346vsl.9
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//08/ahcJJYGY+GhgkyT+TZj34SpiX4MSz/bOztYt28=;
        b=MwdqZ2WrnRueQc7+R+5hROZGzNbCU7V33BD8IEagVl+UVcm91/Q4ScKwJqfjke2ikg
         DL7JmRh4IErdnahkWMp2+OQI2W5c6P495lPe6ZpCpVjDcj2u9cu/64fCSlr+IAqstwWk
         Lbdg1o7mb/9F1bKaidTM6WpB6+LNJ3dBM9WIN+4ZGrt5njzaZ0yaILwezjaztZZioZMP
         idY5fjmEf9ppFmkss3w2DVQC2MsJk6ZSm6tc+HMTXuzqSGytCflSBna4fgf0sGdedjE0
         knUSdsOTM8b63iS6rHOao0Iqz/wKKBz+EBxokt4IQDq3QXNFGGqO7R9CWAX5FcNq+iNS
         iokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//08/ahcJJYGY+GhgkyT+TZj34SpiX4MSz/bOztYt28=;
        b=AqHtsFpCrKXWcawk2fD51K7wurgHVd8xR7f3PNK6kmx5dZTu/KflNj/onzfBEUBzuS
         b7UyiTpXcHNStokLuegl/utrlYoyqHEVob6KsjwzvUnSNfwmEDo02t5jj02T++EA3Q/u
         lGDhyPW7a6Jq2HCAi5Bhypj3s9n9UBKulnHvU2HsvNXyVRhUvcX60LPCqomKN1EeX0nI
         KsqbJTt2C8pjQ+4EWByhCg8i1xtoe4QIhJvYyWHdTwI9z+sWV++dlrim72ju4XGukIPx
         yxD0jX8R7L+fxGsJtARkxfmCOI9fg4x4gmU36RyAVYW7KsKjtNGXSeXawE2WvL3I5VHx
         THHA==
X-Gm-Message-State: APjAAAXbfMuV1dIFgvJu+WLOOKoil/CFG0wgG49zAg5c1vpvO4Hi+e5l
        ieelW4sxe/HEtQHMfA7BQ4w3H5787X0sCnW7c38=
X-Google-Smtp-Source: APXvYqwa/VL+X6NZQx6wEMaVqF2+A0nNpOj3U4FlKlNON1luM666A6O5Hq6ZDEbX/4QvpGGvDyv5PRGwZbQN5wWbnOw=
X-Received: by 2002:a05:6102:2130:: with SMTP id f16mr12977708vsg.117.1570918576315;
 Sat, 12 Oct 2019 15:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <3a677f32b6b914fcc800b619fd082da25c275422.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <3a677f32b6b914fcc800b619fd082da25c275422.1570478905.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 15:16:05 -0700
Message-ID: <CABPp-BH0pN5noDpFH286YFHC22+SNr9ZuyJxuy=WzNPQ=cyxfg@mail.gmail.com>
Subject: Re: [PATCH v3 13/17] read-tree: show progress by default
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The read-tree builtin has a --verbose option that signals to show
> progress and other data while updating the index. Update this to
> be on by default when stderr is a terminal window.
>
> This will help tools like 'git sparse-checkout' to automatically
> benefit from progress indicators when a user runs these commands.

This change seems fine, but in patch 2 you said:

> The use of running another process for 'git read-tree' is sub-
> optimal. This will be removed in a later change.

leaving me slightly confused about the goal/plan.
