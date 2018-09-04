Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083FB1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbeIEAmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:42:22 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:36974 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeIEAmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:42:21 -0400
Received: by mail-ed1-f52.google.com with SMTP id a20-v6so4283129edd.4
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 13:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TFwqHkQUnfYJqsxeyj1Kv6NAPv3nilrixWVNBwhQQbU=;
        b=qxUlvSDINcxD/iPYArRdE3Bh87zslAzZmOJkG4Fl8MUY1w3iCN7DcmXBrhCWv+APT7
         C8+igALMDYAhenfsEOuQYWWJO3li4S/BSPmmHGvqbWH/FtswZqc4iqWpeLEDcq68Irur
         ol6uyvjZaJaIsfoA74vSpL8+tALOVvBRyp1DN0yFPGizZlPNZvdmPB/2Y9qm3GzKUXdg
         qpcEyJMussOEDlddaG3gmJD+dxB9W62AQ60SGiUy92p13rYoXfdsHTx7r2AQMdWrC7oR
         qAJSe+5QRSTSeK9qo95CncLC0c75GtlQepmKwPSoK432VsUmd8Cb95rlNQj5OQ8P8Sye
         8S8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TFwqHkQUnfYJqsxeyj1Kv6NAPv3nilrixWVNBwhQQbU=;
        b=MoFoee+bt1yeXzTQdcCrhzb5e70sPQaqjPuZfHBW51qREMmHd9KttZFRGv7FcjoEB+
         dV17ALcnrx/lcV6CM/4AVT5ftrUzDHVUU5RWeZ+O+Q7Mms7pdspmsGA21XozCJDpIIWF
         Rb63G1StTUAYkijUeFPH2U2UGCeg4UJfVtfwbNEOOMDSMzYijaxe68TqxWkR0y18e1js
         f4zkLhJM9dy49+pPhMfUCb6D+CdAv+PhMf7/kyfFzxgEM1MFOkRxvELDyJrAvyeOJg+U
         o1h9qHUrCYBFXOfg06gRFkdqB1Hm16rD4Rm4i9k0QiX0P/uEFU4MXjBi/8IiyXcupDqf
         f5RQ==
X-Gm-Message-State: APzg51BDYBNnTqu37f5aW481S9srzEY0koEbm7UZw1YnqlS974kBXgMc
        Orn+7DuCPGSNRntiP4V6UhW78JsfL8J1R1Gh3txXdJM/
X-Google-Smtp-Source: ANB0VdbyFlkt5u/DOEQUPTzatHDeoy2kae1dx35EV8GJvCmvTyibWRLgp66WfSU99O1I83WHTqPR2wyujC1vhZ1EeMU=
X-Received: by 2002:a50:f0c2:: with SMTP id a2-v6mr39538567edm.90.1536092138579;
 Tue, 04 Sep 2018 13:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-25-pclouds@gmail.com>
In-Reply-To: <20180903180932.32260-25-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 13:15:27 -0700
Message-ID: <CAGZ79kZ+ZZNm8m7gPVjnbm1W5-HBFzJ7g2LraHJ68Mh_wRkQ-Q@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 11:10 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> The three functions init_revisions(), diff_setup() and rerere() are
> prefixed temporarily with repo_ to avoid breaking other topics which
> add new call sites for these functions. This is a temporary
> measure. Once everything is merged, it will be reverted and the new
> call sites fixed.

Thanks for writing the whole series; it was a pleasant read.

Stefan
