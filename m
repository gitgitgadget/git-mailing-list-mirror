Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A7F1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeDWTYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:24:55 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:40353 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932122AbeDWTYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:24:54 -0400
Received: by mail-yw0-f180.google.com with SMTP id k5-v6so5070465ywm.7
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mlnv1y8qvqGjDjmcpDNJfMY2AzqKY6cud3ne1H7PFJc=;
        b=JmDw8Ykk4IwKd9Xamih5uAl0SbRBR1oqrgjJaAsRFsFEJxLsJfoKnbkFiXhOKFgdjO
         O5e2PRvaJM6cAeUE4Jp8YG+fN6pTRE893MoZsvNnGGmHgCnhOx5zMSf5G5n744ABE/IL
         9Gmbac0vBWFWTuSBixL9DGPKH1YPptBEKzRyJKGRH2arZOKTez6r20AqYTCUpX2VOuI1
         b45xyoY+aTxO1kfqLYzjXouQa4yQeD1Jb1i8/iFjO934Uvqr6BMyvYEatnbrVIZzrW8g
         h5za6BykVqetVL4Tsb5ToTZMYMWyKcK0SvwxlRMxmkXNqlNdsXJDC/pz/Xc5fIe3uf/8
         4EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mlnv1y8qvqGjDjmcpDNJfMY2AzqKY6cud3ne1H7PFJc=;
        b=mba4AUIGXw81M3tv4hMjkmNTH5GpOweTcuE4Xc2JSrB/NQKrVDizbL3Ac1ueTA2/XO
         6o+UutIQc1ZcPsmPBxty/QLbprc5c8zm90DsICYb+LUH1OqtyVbIIrbqDSPNbzb4ayrt
         WdpRInelov70JuHW+fcuwuphFvb1RR05ZO34eyiBKZQ/zX+Um+ThvuIysX11AQGgenHY
         cQkBOBhTuJpzDF8KwTPDQR5WXzwjuwsmANufP+6Dz3dlE3eDUc080mgnULPNbNUZYtnu
         g+xqZDwtM3Skbrk13xMNWeKrEYQqclJ/nfJPsgnqpb3NCYS0LUx4u0uXdbw4nwbxQSWd
         XeIw==
X-Gm-Message-State: ALQs6tBH2tVuea+QeLejnRCM4wwCwlaaptW0RMp0T74eKoNVfVMs7KtH
        ndN8ikNQbwquAVg8i/tBbwuOvc+xyUBeYXBjGINLqbIR2vU=
X-Google-Smtp-Source: AIpwx4/M7Bz4NDJ7cCLMnBN2KWjq1CvppUShK0GaONmm/0Lu1JucnqLXp8RLS7KwCiFgLGKkbfgK7g0yUYx4+z4SVoQ=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr11371190ywf.238.1524511493352;
 Mon, 23 Apr 2018 12:24:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 12:24:52
 -0700 (PDT)
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 12:24:52 -0700
Message-ID: <CAGZ79kaEdb0bd0C7GZXozq2n=CTuB2PZwM6qvgggkdHdNCg=_A@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Deprecate .git/info/grafts
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 2:43 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> It is fragile, as there is no way for the revision machinery to say "but
> now I want to traverse the graph ignoring the graft file" e.g. when
> pushing commits to a remote repository (which, as a consequence, can
> miss commits).
>
> And we already have a better solution with `git replace --graft <comit>
> [<parent>...]`.
>

Apart from some technical questions on patch 4 [1]
this series looks good to me,.

Thanks,
Stefan

[1] https://public-inbox.org/git/CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com/
