Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C02201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdBXLsU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 06:48:20 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:32857 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBXLsT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 06:48:19 -0500
Received: by mail-qk0-f179.google.com with SMTP id n127so16221885qkf.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 03:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4fiH/AqHgiL5mF82HXsI0qBKXQ9fT7T10MOIunk3pwI=;
        b=BXM3DcRvhwA/HBdr3zLqBYO96BJjLW4hoJPzsAA3aXw91XgTpajjK7fXrzc5LhGk1O
         PrqL+7qksiyX2gtLB8DxMos3Q2AQsh+8DfoSvYWMnPZWuJIah7E3rkuAtzckoIkooQ25
         W+JbiYD2mMyV3RTFTTcGDdL1qadJ0aNjnN3Y/qroNru1R4Fm3AzUv2gcAE2U28zazYx3
         IgU+B50fTUbqgeVzdoIeI+kDdD8yVOCyKl3PsAANhXh0eHku4BDslXZ5yv6GgoxG42XP
         +iQkviyeUT9YBwKUuOh6FGEZqKDUFoD7nE5U7LixEJLu9oMKyGoppofwJuzk7ZessnEJ
         Vfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4fiH/AqHgiL5mF82HXsI0qBKXQ9fT7T10MOIunk3pwI=;
        b=TvAAx/XU00h2AIKj7zpT1v44MVyYFHt8Dz3rZZEHAKCuJgZJa3agRce7oGHxmHxisT
         Qy/UhsI/vxh+e7GIleqvmprt1MnTbC2Q9yi8WrHBA5vQdPdOchmBGRr2UCedBQMEuC8O
         34hr/rUrYXk+1WaWCIWrY8hR8G05fkNvb4+w2q4IZhyuHhyTdDvA4LSdLAxE9QkUzZ8y
         QHc0UC9tV9cQ0eb0gWowieOoaP8QyYqvT231JvSuqWHnvV3rcQj7/ZqR3S1nOp/MwKHa
         pCm4poIq1w7KqmppAFYh1B2jyxIOWJvT+WL4Vea1ODTGkv0kwlJsmBH3csyiDgXOryaU
         NC8w==
X-Gm-Message-State: AMke39l4s/qFQnwU6BmT9mVlC1MamLr1Vodok4ZSEPjOqEt599nH9CsIaB2qjPjpGTLl5yV/DuAPPlIJAvTfVQ==
X-Received: by 10.55.98.69 with SMTP id w66mr1971243qkb.85.1487936898459; Fri,
 24 Feb 2017 03:48:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.3 with HTTP; Fri, 24 Feb 2017 03:47:38 -0800 (PST)
From:   Christophe Macabiau <christophemacabiau@gmail.com>
Date:   Fri, 24 Feb 2017 12:47:38 +0100
Message-ID: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
Subject: fatal error when diffing changed symlinks
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

with the commands below, you will get :

> fatal: bad object 0000000000000000000000000000000000000000
> show 0000000000000000000000000000000000000000: command returned error: 128
>

I am using version 2.5.5 fedora 23

cd /tmp
mkdir a
cd a
git init
touch b
ln -s b c
git add .
git commit -m 'first'
touch d
rm c
ln -s d c
git difftool --dir-diff

Thanks for your feedback,

Christophe
