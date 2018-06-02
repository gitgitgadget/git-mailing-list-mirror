Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCE61F491
	for <e@80x24.org>; Sat,  2 Jun 2018 06:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbeFBGtS (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 02:49:18 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35791 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFBGtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 02:49:18 -0400
Received: by mail-oi0-f68.google.com with SMTP id e8-v6so6158221oii.2
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9DSWBMCVLAvkmX0ZxL3Hck1DoWAEYmJPdN8xjsaoDJI=;
        b=eF1esrNRlOUwY/x9pFpGB2YDq6sr32RNHl3duwnTaBhAvUrQPkuTNDRGFtdMF0dcaa
         rF+KpAglPTXFs/FUH7AihgzC4UqQQb4/VqMctJBB1Ke6PkUpvKNOUEJ4Auc8vB/QLvvk
         8/pciP5BeS/Z2LPA5h6ZnIEcE3sc7Sw0dj57ckJH1/bjAsVqUmHDBDmVGceFj48iWOjL
         VfqYQMAC9a6UfHv+mqYzjinADYeRxxNKNn2N5kJ0vcTWMhUhJfDWuE5hMN8ACZMVtdZF
         Yq77yT3VCnggz6PpWq/qYVkenOEsueXaJv5cBDyZbTbf3aOoZPZqvpsT5fnorlkif8T2
         x/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DSWBMCVLAvkmX0ZxL3Hck1DoWAEYmJPdN8xjsaoDJI=;
        b=PW+EJTuFAJmkAIKLxUBnL5R9cuDBe6mxpfhPQIcej81VKt+blA7CYedIVE6dRZ0Gug
         GHTboWzVR8v262WoFRu5KORFcN4G3yXMjrUzRZpMdmAL9SROY1O5w2lkh/S5Culd7gbU
         Ns7Bx+VO8CdCtSDtV5kbWJf34uARzYdNDpK0ByyHgx2xT36iZnttzjGi7ntuM97R24q9
         xbNkQ8xpy8D7tGV+AvQbefHd15rtH2YVPBsndi+FVFcGNb57Cs65VMOUzFKFfDQQxOl0
         1FRnCHubDAFiyzyxyTFTf68ecPnB+vS1hynnibEjvRjsjngsiLiSPV8nr685NsEGqSOU
         aNGA==
X-Gm-Message-State: ALKqPwcjMFBBOjmH48yRRcSQl3X9UFlcx2Iznis/8id+iz2oWKU1mP/c
        v2KGD09ovusbdysucyiNXh/WgqPPStmMjjEY4v0=
X-Google-Smtp-Source: ADUXVKIS5CcIOJ5c3ypl+lmGWDlTjOAbcMkTOhHPGlS/6VPZMfq6FFWErTlE9l3XSOWEmpBC9qDDTsHBXUaWJwquXec=
X-Received: by 2002:aca:52ce:: with SMTP id g197-v6mr5626276oib.228.1527922157727;
 Fri, 01 Jun 2018 23:49:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 23:48:46 -0700 (PDT)
In-Reply-To: <MW2PR18MB22845EE9631BB6586BA4E8E8E5620@MW2PR18MB2284.namprd18.prod.outlook.com>
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180420221231.4131611-1-martin.agren@gmail.com> <xmqqh8o5b4ww.fsf@gitster-ct.c.googlers.com>
 <CAN0heSqQckJT-4mHbwoP_XjbE2-UH8+k2nG6mnN76_t3nzO_xw@mail.gmail.com> <MW2PR18MB22845EE9631BB6586BA4E8E8E5620@MW2PR18MB2284.namprd18.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 08:48:46 +0200
Message-ID: <CACsJy8DCu116xp9buwm8ujdCF9jOzGgG0jO5zmKufa8uwaBcEQ@mail.gmail.com>
Subject: Re: [PATCH v3] fast-export: fix regression skipping some merge-commits
To:     Isaac Chou <Isaac.Chou@microfocus.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 1, 2018 at 9:41 PM, Isaac Chou <Isaac.Chou@microfocus.com> wrot=
e:
> Hello, I need help on this topic again.  I need to inform our customers w=
hat release this issue will be addressed in.  I checked the 2.17.1 binary r=
elease recently and found that the fix is not included.  Can someone help m=
e with that information or point me to a document that I can use to determi=
ne it myself?

It's in 2.18.0-rc0, so it should be in the next  2.18.0 release
(unless something horrible happens but very unlikely).
--=20
Duy
