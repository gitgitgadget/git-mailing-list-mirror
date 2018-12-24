Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B2B20A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 13:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbeLXNXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 08:23:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbeLXNXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 08:23:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id f81so11751785wmd.4
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 05:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YVruoibArC39fwVPn2XGttGIIiGHcgu5CoidopuP05o=;
        b=Au4iHeqcaSSMfUzkrCUO+dsM5yJqs+zGD/TNtNdaRaZbQOh9jk9VbQN1jkcv8xKSvN
         69SKg/MiN10FfDi3ZW7oGHDWHqCvUHXJeWmo5eaM3ToYPhFIGZ5io1nNyydx+HcizWxo
         cW1ORdddjI5dsGPOwTzc/WblCRiaTU0gFR74BsR8kEwKcIDhbMJ555n6B3aR/bM6c3wG
         1+HDZB27/SnGEMNeJDtdQHO30MIB6QQPuLw6M41Td2JqF6ZqACEDyf4KjH1XNqVLbAzC
         YHUv/0KND5F31kGU4SdSluvcI8S4Fu+ecM3fagELEcOtdG3ZtJ7WxP8H1WAmJdCQkaZj
         20Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=YVruoibArC39fwVPn2XGttGIIiGHcgu5CoidopuP05o=;
        b=NZ2jRZTiuML8FfFo1UjS75m3mCd+WlErOGFesnD1VSr0lr9Tmkc6OCdhzDuYQUk6X+
         QYFK89KM9mJUtKX9lsQxkeqUbfz4g+YPOrxLgtj/f6DjgYWRM9brDSu6nLvhMZkhGrNe
         1PCLgiFimNsa2k53rFVmD+X2AcXfLpoc/po5hjUtVAvI7N42ZlyvKVujUk27hJyPrEKe
         q9LvzLasktWbd5WTj7qd/9sbHxSdjAumjYSeKM0L2iTF+wfgox9V2UF19iI9Y0nM7awJ
         iU/U8tnyKNsgGFEY2EyARomZNhxhb4kN4fCwVcC1JfB+JKycEKhyt2bL8okvsYgcnEEh
         X+QQ==
X-Gm-Message-State: AA+aEWar8w4ivnKKeEkRvTOhtGjAVZA3nleB6qm40WnB31KPbnL2Qlfl
        xSz84a2aXJ1P2MVbGezLoko3OcCJACQLnIbBKsJOoQmr
X-Google-Smtp-Source: AFSGD/VhVODtmy48CEo2eMOtS1GPBszMVdS/YUOyeXRqpde3WCIhYZPDOd7WInB5X8sM8/OAR6vIHFmVIZwGJ9jl/kE=
X-Received: by 2002:a1c:410b:: with SMTP id o11mr12407187wma.109.1545657780239;
 Mon, 24 Dec 2018 05:23:00 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
In-Reply-To: <CAL21BmnoZuRih3Ky66_Tk0PweD36eZ6=fbY3jGumRcSJ=Bc_pQ@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 24 Dec 2018 16:16:55 +0300
Message-ID: <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
Subject: [PATCH v2 0/5] ref-filter: add new formatting options
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=BF=D1=82, 9 =D0=BD=D0=BE=D1=8F=D0=B1. 2018 =D0=B3. =D0=B2 10:37, =D0=9E=
=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhna=
ya@gmail.com>:
>
> Add formatting options %(objectsize:disk) and %(deltabase), as in
> cat-file command.
>
> I can not test %(deltabase) properly (I mean, I want to have test with
> meaningful deltabase in the result - now we have only with zeros). I
> tested it manually on my git repo, and I have not-null deltabases
> there. We have "t/t1006-cat-file.sh" with similar case, but it is
> about blobs. ref-filter does not work with blobs, I need to write test
> about refs, and I feel that I can't catch the idea (and it is hard for
> me to write in Shell).
>
> Finally, I want to remove formatting logic in cat-file and use
> functions from ref-filter (we are almost there, so many work was done
> for this). I had an idea to make this migration in this patch (and
> stop worrying about bad tests about deltabase: we already have such
> test for cat-file and hopefully that could be enough). But I have
> another question there. cat-file has one more formatting option:
> "rest" [1]. Do we want such formatting option in ref-filter? It's
> easier for me to support that in ref-filter than to leave it only
> specifically for cat-file.

Updates since previous version:
1. Fix type cast not to generate warnings/errors in other system
platforms (travis CI says that everything is OK now)
2. Add check for negative object size (BUG if it is negative)
3. Update documentation (thanks to Junio for better wording)

>
> Thank you!
>
> [1] https://git-scm.com/docs/git-cat-file#git-cat-file-coderestcode
