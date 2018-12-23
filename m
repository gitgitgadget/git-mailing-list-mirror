Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2061F405
	for <e@80x24.org>; Sun, 23 Dec 2018 14:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeLWOqX (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 09:46:23 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33732 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLWOqX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 09:46:23 -0500
Received: by mail-ot1-f45.google.com with SMTP id i20so9209340otl.0
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 06:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7zOH8tbriT3+BSQrKZ1Vdny8UHhwqEY2byD4UBU73fA=;
        b=YLXLIsTpSceHmNB9ACRPxbwu2Z8K1cv2mlk0NiokHPsU/hOqQuIYYCXdbPB+Sq4wz3
         Hia6dosGB7wHbYOwoiDGTmle0/V4EHRFcODl4084WMkZbuDukxVupLroRgyuD/S8Vts3
         L21A0AtPImBFY7XPO+/aocK+DxGUDn5rp7tox71DOCMTTDg6NgaH1uj98x9bTZbXuGXw
         hN/wA/KMoUdQzA1WkCTANlRUSXPcyV7/pEuoOz6v3GFvBbZJ7qGmq10GP+ltRshma9ro
         NDqWm43lNSixprHd06wcZ1rO8SgFKVeHNehMGs9rRXfnu0z7s83oRz2fZWXhdXyAvXGu
         mNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=7zOH8tbriT3+BSQrKZ1Vdny8UHhwqEY2byD4UBU73fA=;
        b=S/U2qnUD22EU5ivq7nv07iqVt580HoltZuvX5HwbJAaYHp4RnqL6pJkQnXAmauXVCa
         m0xTtwQQntHwTs61hpWNJ3s07lyL5WkBRSUlG4n5vnBEzMb2Disc60OZ2bLeiLKRCXk7
         HXtMFVq1Ik8RZvJSSoHuUDRsB8K14bvwfaWQ7zqCgAdmd2aCdyLs+HJiYw4Segat6Iey
         Bhn5c/xoPVKWVobEasXEaXqbNGRteIgOlmSq+r/QGbO/8dGraC423KYRdfPC0uKmwOvj
         yLo9DXP0/zhEu4+CojdNXmlyVh7ENAhs86Nz2E/Wu+hZVVYaaNN6wyfXSA7j3HDhMKMQ
         GgYA==
X-Gm-Message-State: AJcUukeUNXhNLo4aXlGpux2Pp0KX40jCisJaEr2rxS1pGyZwUPz1azCN
        dpARTJkvlOichX+jEvGvsHk=
X-Google-Smtp-Source: ALg8bN4LtkGwjliRcq1QoXPYrw2ErVEBhRBVckCzv5Gi9ulaB5o0r74xqEnfuI/CG8ispuKoieq8Rg==
X-Received: by 2002:a9d:128b:: with SMTP id g11mr6432961otg.130.1545576382501;
        Sun, 23 Dec 2018 06:46:22 -0800 (PST)
Received: from Daddy1 (ip68-5-136-133.oc.oc.cox.net. [68.5.136.133])
        by smtp.gmail.com with ESMTPSA id n185sm13728387oih.18.2018.12.23.06.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Dec 2018 06:46:21 -0800 (PST)
From:   "Alexandre Grigoriev" <alegrigoriev@gmail.com>
To:     =?UTF-8?Q?'Torsten_B=C3=B6gershausen'?= <tboegi@web.de>,
        =?UTF-8?Q?'Adri=C3=A1n_Gimeno_Balaguer'?= <adrigibal@gmail.com>
Cc:     <git@vger.kernel.org>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com> <20181104170729.GA21372@tor.lan>
In-Reply-To: <20181104170729.GA21372@tor.lan>
Subject: RE: git-rebase is ignoring working-tree-encoding
Date:   Sun, 23 Dec 2018 06:46:25 -0800
Message-ID: <009e01d49ace$4876c230$d9644690$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGzHBPypQu4TMaDIA8Y5jdFC6/IqAKw5WaKpbna0vA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>On Fri, Nov 02, 2018 at 03:30:17AM +0100, Adri=C3=A1n Gimeno Balaguer =
wrote:
>> I=E2=80=99m attempting to perform fixups via git-rebase of UTF-16 LE =
files
>> (the project I=E2=80=99m working on requires that exact encoding on =
certain
>> files). When the rebase is complete, Git changes that file=E2=80=99s =
encoding
>> to UTF-16 BE. I have been using the newer working-tree-encoding
>> attribute in .gitattributes. I=E2=80=99m using Git for Windows.
>>=20
>> $ git version
>> git version 2.19.1.windows.1
>>=20

>Thanks for the report.
>I have tried to follow the problem from your verbal descriptions
>(and the PR) but I need to admit that I don't fully understand the
>problem (yet).
>Could you try to create some instructions how to reproduce it?
>A numer of shell istructions would be great,
>in best case some kind of "test case", like the tests in
>the t/ directory in Git.
>It would be nice to be able to re-produce it.
>And if there is a bug, to get it fixed.

This is not as much Git issue (and not rebase issue at all), as libiconv =
issue.

Iconv program exhibits the same behavior. If you ask it to convert to =
UTF-16,
It will produce UTF-16BE with BOM.

That said, it appears that Centos (tested on 7.4) devs have seen the =
wrong in it and patched libiconv to produce UTF-16LE with BOM.
Git on Centos does check out files as UTF-16LE, and iconv produces these =
files, as well.
Just need to find out what patch they applied to libiconv.



