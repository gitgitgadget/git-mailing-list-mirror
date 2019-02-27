Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEEDF20248
	for <e@80x24.org>; Wed, 27 Feb 2019 11:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfB0LuV (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 06:50:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35785 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfB0LuU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 06:50:20 -0500
Received: by mail-it1-f195.google.com with SMTP id 188so9410457itb.0
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lTt51UUXmzKAHA+T/LkGf42p7xrH3G+h+I526UEAroc=;
        b=CGymShqBAcrHNnkNjHHGUIvCAC3K8WOwK74QHcC+qdvmVWp7ekacNZDZV/OQjzWjcF
         DkFCJRPExMBkqz4aCUlLjdA5kKkHfo3OrklVJstZsbeLIQpR7G+DPc9KAXhY3y3wsNzq
         jAXYj48wiGnRgwUqYRei6bz2hVsB8afrx9FTEIdScP2/ldrEHPmzfPqYe+EGqsNUVQL+
         7BcXuIBRdr+eNM1Qx1D647RfqbBTX1bIGFrKnvEPxTueHKKC/PnwyJxBR9t/Y8out6Cd
         E2qFGh5uxWtenHfo1402lderPeJlHLVU3PmnkakdjaVrba49ge4yDsB+7Y4J8JhnXAXe
         DUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lTt51UUXmzKAHA+T/LkGf42p7xrH3G+h+I526UEAroc=;
        b=g0d0BJS5PMYrtgs35irT+9aoHas2h/85SPnuFAwden5Oq5BvR0R+PwUdLVmrwYPcYl
         dp62wfRbe80doUzibb87fKmLMCVDIUw/k2+OkWs8gRxv8nYXLJZah7mMZi8L+gwjZIQi
         zQk7tF7qzHJUVjGWRzERI8GHulWPYpf1jVKaN9/Ew7Ve9nimJCqGrUh6TNu5heIDN8Do
         /Tf52m5POKuTf2ngpc8o9sfCXA7ttrR8Ratq8dYoGMvBZmuUS9pLNo9wQEqrt/2G6U/Q
         cs70/lixMr1/DkUxF/hcg7KyM+3CE43zHTL7/ji2q/fGn7rNMWHv01t+HFeaXP36VQBJ
         Ih5A==
X-Gm-Message-State: AHQUAuZ91VhMfy8kQNKA1Q0pZWrmhJROmwlUAPkFIlA2DNY6CW6M7JYa
        yRf5dhFFUB62EPUUqE9fAolqepFkPGBTbDlhjVJeCw==
X-Google-Smtp-Source: AHgI3IbDkq8u4hLaTvA7+RRZ89IrkUlakbaaOYjiTdpcxXNnW5x5UuzQzxXsMaBKUf5LAVlKVcWcyUiOZZIWMxAuiWI=
X-Received: by 2002:a02:7e87:: with SMTP id g7mr954813jae.92.1551268219643;
 Wed, 27 Feb 2019 03:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20190226200952.33950-1-brandon1024.br@gmail.com>
 <CACsJy8Bgz6FiTqnq8pnebuyOr55Bqh67iRhr6J+WvzgxPSBLhw@mail.gmail.com> <20190227113711.GF19739@szeder.dev>
In-Reply-To: <20190227113711.GF19739@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Feb 2019 18:49:53 +0700
Message-ID: <CACsJy8AcrRBtEUFtFVDUbDZDodDDMAHxnwsf55zH+TzKCoyVMw@mail.gmail.com>
Subject: Re: [PATCH] commit-tree: utilize parse-options api
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Brandon <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 27, 2019 at 6:37 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Feb 27, 2019 at 06:07:42PM +0700, Duy Nguyen wrote:
> > > It was discovered that the --no-gpg-sign option was documented
> > > but not implemented in 55ca3f99, and the existing implementation
> >
> > Most people refer to a commit with this format
> >
> > 55ca3f99ae (commit-tree: add and document --no-gpg-sign - 2013-12-13)
>
> No, most often we use
>
>   55ca3f99ae (commit-tree: add and document --no-gpg-sign, 2013-12-13)
>
> i.e. with a comma instead of a dash between subject and short date;
> and without quotes around the subject.
>
> Truly sorry for nitpicking :)

Naah it's about time I update my ~/.gitconfig to be "conformant" :D I
think we both failed to mention where to find the command for Brandon
though: search commit-reference in SubmittingPatches.
--=20
Duy
