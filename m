Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E95520248
	for <e@80x24.org>; Wed, 20 Mar 2019 20:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCTU0q (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 16:26:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38823 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTU0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 16:26:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id v1so2607375pgi.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 13:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9y6BXqsNpMdCgT0h+eH8bqf4gXmy54MRSEETuThz1DU=;
        b=jz1paS2GZOTm5MN9Pgp+DxoIKGrcfPeABv3yy4z3VOQgjg0nzwuzXpdpI3rb4sZnXZ
         r+ELv43fETQ9RQTfDuQ3Kz5GRzBKdz6e4gBETlM1oWtUwHcgTvHpcQGzr+R3V3kJp/lt
         r1nREmLfkI2oytR6dY2siJAE2XnkXbp7lb3RPIkK8OB4RLVNRPVkGpVCVW9zyJlL8kQS
         wfQV2fi/qD4jGQKByAj6VB9+lM2HAKnDPWVJ0rrhGkAkxRJn+uf9RwsMzFTBHRaEayVK
         bA56DF8FFXoDoiJVcFFVTSqDTXq7a5EaeEOkBHbui4kkfu2u4UqRoi/FdH24qcL6p7mL
         6wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9y6BXqsNpMdCgT0h+eH8bqf4gXmy54MRSEETuThz1DU=;
        b=J7F9xekPs+P6wXDDdz3a4MOX1S2OZ8FYC52lbQ7bYykK3AFX4Xui9WSm7u8ty6d0mk
         E2/Zip2Jg43inzv0t4n6uP6/86LcbCHyqdMmMPKyigQ1ZrZyaWTxNO5hEGAmwGg2WfUN
         itNs1CY4brcyYlPCZIcDwDGzP0/JDFGyivd+L47eMuaqnZuSBj27aysVqaxdKkbPzjIC
         FHHB63wFkhDl2XE5/CQihVmWNApYOKF1f9RTvaGu1Fa8kd/roDLtcBcc0nK8PL15W6FG
         9zWHsSnRtsJYFLEXsjjHEwtuqf8hKAbMiTHtUY73cezKAJaZtJqBlwBaTQSqfYP04x4K
         j5DA==
X-Gm-Message-State: APjAAAUA8T/NpBibUiG4Zy8zEk6dCRpZupNjx5dchitFhe3/hRM9VN8r
        Ei+qK5NnqgAmfo5ouQfvRLpvOTV+0LB8aDZRMqb+Yg==
X-Google-Smtp-Source: APXvYqwGViDP7j8BTVM2lCfK8aPoinyaKSOuKBEDmmhTEC5pDKsF4UN47zVWebipRJL8+g8vQnMRG6JxRWrU8t5nGko=
X-Received: by 2002:aa7:914f:: with SMTP id 15mr9530477pfi.49.1553113605307;
 Wed, 20 Mar 2019 13:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190320114703.18659-1-pclouds@gmail.com> <20190320114703.18659-8-pclouds@gmail.com>
In-Reply-To: <20190320114703.18659-8-pclouds@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Mar 2019 21:26:33 +0100
Message-ID: <CAN0heSoyOqMeJeBJ7HWRzOW3WABCSGfqV8CoEVMM37h+T10g5w@mail.gmail.com>
Subject: Re: [PATCH 07/20] diff-parseopt: convert -O
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Mar 2019 at 12:48, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
> +               OPT_FILENAME('O', NULL, &options->orderfile,
> +                            N_("override diff.orderFile configuration va=
riable")),

This doesn't really tell me *why* I would want to provide -O. Or put
another way, there are lots of --foo-bar for overriding some baz.fooBar
config item, but they're not described like this. The primary purpose of
--foo-bar, at least to me, would be to solve some actual problem, like
"fooing the bar", whatever that means.

Gleaning at the manpage, an alternative would be "control the order in
which files appear in the output", but maybe you avoided that
deliberately? "provide an orderfile"?


Martin
