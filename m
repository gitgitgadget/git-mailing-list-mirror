Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A5420248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfCUNcN (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:32:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35109 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfCUNcN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:32:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id e1so3666631vsp.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Idaq41qX8c773ang/5ReM0F2Hhy5qG6jOYQZP25PiY=;
        b=OkjxOYinmh4k/yrY1iZ+is30ikJsUP4OBMYytwlU2LoGlje/vwCVh4Ac7WbfYlcyhc
         rg40+X4YuU1ztxE2SsAX0zPDAZSRSBzp04MBS/R5RypzghaPiZgIsRKUP5tlzIn/0fy0
         PbK3MXTxgthaB0JI8xTCYkRsuKE7jZeIQ2wawhpVmrp9V/JHG0SupqJeFhjLRZ0aq9Fo
         +6CZpKd7RQtRLQs7m+Dzyz8OY9o44ph+RIDOFmBylkMFpDSBrcytnBAAZ8rL9OSeoDxE
         qwG4oIfQmbtxC6qtaLkdcqx9FElpKB4NNRzAgZwz90Xbu21LwD7QyKfeS3onC4Ei2fRP
         SHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Idaq41qX8c773ang/5ReM0F2Hhy5qG6jOYQZP25PiY=;
        b=coyAPclxIg9B5EmkzwXl51eqp8Km8OhgpEJLjZEc4JOH/5pL8UOuBm8t4z7JnDiXvd
         BKAcVYzKNUjOqlIZ+bCXfs7Gb+y+mFALxCOsk/J2kbYre8JBcL0hhpb5MGs9NwHXwn/E
         3pf8+yCNZh2FILdK9Sc17LTj2z12lAyI342UeyhwQESXuVkigUkl1htv5E5Sg1xtAjRE
         je8e29FAZuMt8FjJfvbGYUjTVrvhsqIqPJbPSoBiEBjUaSBsIIRVkORGJv1OnP7G5zyn
         QoHfn5f6Zn269KrhHjsSMGwOL4r/Y4zp23i322by9KTd2eMRmqFCcvs1FUcbAXG0jhhm
         hivA==
X-Gm-Message-State: APjAAAXnJ4UqJw4k55e8zvteWycrGPMzUm3gRcRSp3DIZ+2VnGwdi14f
        wi7NZjDq6NePyRalVIGkgxlKhE9g7ZkOm1zBLX8=
X-Google-Smtp-Source: APXvYqx/foAkC2TgUw8mbPtCNAxgezFDCxO5aUzbeDldRKOY7HaqKiNM8TKjEdi869Rcs13JdNxnZL0MRtDhTIbhwRA=
X-Received: by 2002:a67:b145:: with SMTP id z5mr1955975vsl.53.1553175132437;
 Thu, 21 Mar 2019 06:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190317124926.17137-1-pclouds@gmail.com> <20190321131655.15249-1-pclouds@gmail.com>
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Mar 2019 06:32:00 -0700
Message-ID: <CABPp-BHRh9bfMMhaLsb3btOVo6mpUEJ85w8VKNyds3AAZV+qqg@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Add new command 'switch'
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 21, 2019 at 6:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This adds a new command 'git-switch' as the half-replacement for
> 'git-checkout'. Jump to 12/26 as the starting point. The other half is
> git-restore, which is dealt with separately.
>
> The diff delta is shrinking nicely. The two main changes are

I only looked over the range-diff this time, but this round looks good
to me.  Thanks for working on this.
