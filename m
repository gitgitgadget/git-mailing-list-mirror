Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E1920248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfDQKEy (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:04:54 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35831 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfDQKEx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:04:53 -0400
Received: by mail-it1-f194.google.com with SMTP id w15so3441829itc.0
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KhKUqFMzHr+qScD8FRaIVRGC+B1RxWEfngxJP8JLbVs=;
        b=GheWkZ8GyjAHygYFEb5VYUC2pzxxKAHUBE2QxgS6xKKa/bJ3bA5VfKc5xG2j7b2IRG
         QEmM6kHMVh3dlGhZgFpKMZgRMtUtye7GEkmkJPz/7Obj8GIhtZ0UTltpIycDEA+IzGfl
         FrGvhCahA2xe6WXRzKp62brjHZZH0ihVPwflw18V2L1qAyWY9cTtrNOIDEA5sL03AykL
         fNARliGA5Qhtm75Wzq485PFZYypIqFEJFyFBVDpRK9SA7mpjoykXqZY8BedqELAIxgTR
         YOahonuVsmjcWF9HeXHP4LQM18TV2D2sRDP/NgmPui2ozPV9PtzhWDW2Tq0toG9UZsWR
         murg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KhKUqFMzHr+qScD8FRaIVRGC+B1RxWEfngxJP8JLbVs=;
        b=DAsrqkLkYyPy27fi/9lM/qFQg8FEtKB4SLuELZe81v0zD5FVK0BEvM9/Tc8JdKuu7R
         acX1v8oU95RT0IY5/X4Ch2A6sG2DDohHQN8X5TPvUFIuRsPB/DHRoMRt+dHeOeaVAvAZ
         0t54sMzpnvasNfBXEbchoRPBLO0RX9C3f5/Vd492Eyq7kqUyHq+XrjNzXFv9RkWmaJoi
         vMrV3LcZdeigmLf3rU2kqLzW8+Zcy3T9wxKzgFJachDPz0+ZmJVkuNKoRNkZcDL5K1Qt
         Smn2JVi4fzbE3KvoFZHImmHuZB9oaN1J9gbIgRHts+TxYtCJCRZNNaU/8/lTYi5+C7Eo
         ChOw==
X-Gm-Message-State: APjAAAU8w3atXwN4BtAALvm7dhj2Q1fX2+2RSWposed+txTm/iqYUb2/
        HYqrjO/0mDzbzYLUDp0/zjCTMNvrg2gE+wnipf4=
X-Google-Smtp-Source: APXvYqx5Bh5oXxOlhcqzddAuSXLdxxVeZ95pgahq8/CLVX/41Ikrw9NExau34DFF/uX1B+UTB8OmEYYwH9KFnw4OT3I=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr30786594itb.107.1555495492918;
 Wed, 17 Apr 2019 03:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190411131218.19195-1-pclouds@gmail.com>
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Apr 2019 17:04:26 +0700
Message-ID: <CACsJy8A9xfR7FheOHUoywNz_D7W1X1fv=mUBz-uu82CGZqYfVA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Add new command 'restore'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 8:12 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This is the companion of "git switch" and is based on that topic.
> This command peforms the "checkout paths" from git-checkout, git-reset
> and also has a third mode to reset only worktree, leaving the index
> alone.

It does not have to be done now. But I'm just wondering, does anyone
think adding --dry-run is a good idea? This command is destructive by
default, so careful people might want it, I dunno.
--=20
Duy
