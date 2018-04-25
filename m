Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841431F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbeDYSNS (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:13:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44971 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeDYSNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:13:16 -0400
Received: by mail-ua0-f194.google.com with SMTP id h15so9053848uan.11
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AC+8es72VyLa2vOo3RohZnCe4/yvDjMuunCbmzoIpAM=;
        b=uwL1y8vZCP6nmLkKWGP/EILDWQXmIGWlmng2ykRc4zDtNNzCONuYk72GyJWebd+u8l
         0fjB32sRQhD5Z8RzHCxvkmGbTIpevIObsAJGDkdGkhz5/0JpwLLmJuX/AKSkeJ9Ep+fI
         Ab3bH/pSnDt4xZ4e0rXmanN0jUQcjT8O9EimwQVhy/+ojlZXUQilJd2rHkEulkYq//CP
         KVWpFJxye2pzVlsN5E40BOrGNfII9L88PPlJJPgca/jkQhQ5XsyqjyDRfvOLorCDdMVX
         6i/zDjwEGsArVI2rVOIwLwDazWS1EEgrjRpCjRCiy/E8QWpSx53CxT/Qzt6LXAw7uDpf
         vrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AC+8es72VyLa2vOo3RohZnCe4/yvDjMuunCbmzoIpAM=;
        b=ngO6mH6Ymo3/gTNr46rRllhanr4IklC2uGtkGJ4aXE14qP5B8Ir5b5Ppt72sBIlola
         iwIaxv7W2yP3AhIKb+yfXgqaa2S4ZAC2z7VBlKhy1aRR6uRz/omKjjwc93axW25syw4g
         LmdatCrVnTEZQAQ/RFz9eUrFq4XmEo4AopgwQ/6aYxbx/rObGcF7an1esstXKG41bgxC
         qEOe57tlaCHgjFRbyBS7g7V1bglxUq/t8M2NBxzUzuWNqfmPdcmeOPekeMVYHQQcSV1T
         uSgbLi5f1Y3zpjQV94Rn+lj7CAhID1C+WNyRUMpsO09pxl5WdA/jQlA0Nlw14INgY92O
         7IRA==
X-Gm-Message-State: ALQs6tBdhFSNmMMJcDol9h4HgerzmAPuPN7NmA7JAKruRXVeSBm8KfcL
        WbMZkDNEdFw9zLM4WU0Y4dvVBQJ8Xavv9fqzCuI=
X-Google-Smtp-Source: AIpwx492IKoz17fXUJ4TpMBdG60S2rBXi9+J3SZnBbfUIMC9vT+OMlmmeysChqAGCWHu2ksozr+nWE4A5vOv7jP2GZ0=
X-Received: by 10.176.80.182 with SMTP id c51mr22587835uaa.149.1524679995421;
 Wed, 25 Apr 2018 11:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180421165414.30051-1-pclouds@gmail.com> <20180425163107.10399-1-pclouds@gmail.com>
 <20180425163107.10399-2-pclouds@gmail.com> <CAPig+cTQrbHq9bgge5Ftj+Fi8kMkuL2VtQzs7McuqU-ueVK4vw@mail.gmail.com>
In-Reply-To: <CAPig+cTQrbHq9bgge5Ftj+Fi8kMkuL2VtQzs7McuqU-ueVK4vw@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 25 Apr 2018 18:13:04 +0000
Message-ID: <CAM0VKjkbqmWRhuBQEg6+7AKE4YWX3gONCsyf2wnJuLSho2D+ow@mail.gmail.com>
Subject: Re: [PATCH v4/wip 01/12] generate-cmds.sh: factor out synopsis
 extract code
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 7:59 PM Eric Sunshine <sunshine@sunshineco.com>
wrote:

> On Wed, Apr 25, 2018 at 12:30 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
> > This makes it easier to reuse the same code in another place (very
> > soon).
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> > ---
> > diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> > @@ -1,5 +1,17 @@
> > +get_synopsis () {
> > +       local cmd=3D"$1"

> 'local' is a Bash-ism, isn't it?

Well, strictly speaking it isn't, because many shells support it
besides Bash.

I don't remember seeing any complaints about 01d3a526ad (t0000: check
whether the shell supports the "local" keyword, 2017-10-26), but we
only have that commit for a couple or months / two releases, so it's
still too early to start using 'local' in build scripts.
