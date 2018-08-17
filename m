Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429231F954
	for <e@80x24.org>; Fri, 17 Aug 2018 14:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHQRkQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 13:40:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35329 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeHQRkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 13:40:16 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so12037133itf.0
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qDdUxDmsGpY/jDAy8+4BLZfEg+Yhibihd1wW6qKofKE=;
        b=cRIEJxJM6NKvt2+UjhismlL0A4+rQocRHd0dIywOV4TwxWfjy3qpbAlN1GRYD7u9Y3
         BCLrmeJ+yV4+TE61B4j/HsFyFS3vLyRcg5HkKTF/QdkV92e7eoiphHrAiWfhyr6VtNde
         PF2IaiDWbUSPYnW/9cpjnSiaPoSDsJzfE9rOg8DJ13IQSRkoukc3xfCdyJHVG41V3Idn
         dz2RChnxxk2Dj8nvBGzf/XGUwcQLdITvwWR0SENbY05BwiioUEZydF5qjQ6ZFUjZ9Nhu
         xQ3ZIYTJmJt6uGxHxs1OkicDiXfC8s+C/YF9SGd/NR4kMl+Yvx+L/yC5luNbLtVoJdZY
         hwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qDdUxDmsGpY/jDAy8+4BLZfEg+Yhibihd1wW6qKofKE=;
        b=MnO33cTFLMvErxvJzcNoGMwxVI0iMgJeRMe8VZpjXA0kKh+GsWLR/JdoeTd6rOjHFh
         epVJK7Hd6KUkLZDT6LvyKUqlAxgnFX/9s/Dcm/4gU5fmVhsKg+Sv3LCL2VVpJzPXPiAT
         lHJ3qf8SLdPGSce+BJVHoZy59BjcKpRdcf3VKPM4rI5plfEeYSiJHQUymjKEhTV39AjT
         1zlzY2RthVTinngC2Z6wKdfbpjNyZHvfqZUwxSt1IQUbmDbqK1JakWK4bcbG/ZVjlC/o
         DxE+DszFmgCjWb7kcYEmef21mYmX0GEiltFSZ/TSZm15Igpp61DvQnFM4UafMLlYj7LS
         Q7uw==
X-Gm-Message-State: AOUpUlFa2E8X2w6cdcq3qtDs+e1I/jY8Dlr56t9JFHE7PFZJzl6wZ6Kh
        2Qq47Aqtc49y3uZFY7WusZr7SD3cGAIsUjySFsQ=
X-Google-Smtp-Source: AA+uWPxE0G3loE1LMmTioju5HcUuKgCfv/+yoYDcaXd9xpr9Vwrm+WXNb/Zf/X0A6XZcKdFxaMZmMsimJEJeGfFrS2M=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr4214068itk.62.1534516600293;
 Fri, 17 Aug 2018 07:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <1534498806.1262.8.camel@gentoo.org> <20180817130250.20354-1-avarab@gmail.com>
In-Reply-To: <20180817130250.20354-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 17 Aug 2018 16:36:13 +0200
Message-ID: <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just FREE_AND_NULL(x)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 3:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Change the few conditional uses of FREE_AND_NULL(x) to be
> unconditional. As noted in the standard[1] free(NULL) is perfectly
> valid, so we might as well leave this check up to the C library.

I'm not trying to make you work more on this. But out of curiosity
would coccinelle help catch this pattern? Szeder's recent work on
running cocci automatically would help catch all future code like this
if we could write an spatch.
--=20
Duy
