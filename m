Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F3B20899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbdHWTph (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:45:37 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35095 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbdHWTph (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:45:37 -0400
Received: by mail-yw0-f181.google.com with SMTP id s187so6897785ywf.2
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+rnTYGi00OKfYH0ocvNDFt1h8O6i5solp3dkomyz0Y=;
        b=Wy/eC3kHWOQ14vXkn/XVAqOg60o5cLVzon0FJUc54yArVpzag5OJtd0kaflIkFoiBL
         8fTdWqWz2IfajBOdl6+efebhq96fuR5Xb7j4QgPgWoG6WFzXZIvvtlfcvvzBk4hDxzgQ
         8S87s61ZjTtg12gfR1dzSFps2JOhzoKD3r5AT8ngURR7vRIrcpoH5i+Ec+1GNRq+6yIf
         2aJZ/on2doWR0WStZ6jdKYgDvdZkR0EFlw+gO2Ka9uAd9igR25RSBeGdUqognqLD+rDa
         1cag2dpFlQRTEvC99TThLx+MIGOKC+pSRPxNHHZUbkrKgpweNHvps1FpBh5yvn9UGMJA
         EItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+rnTYGi00OKfYH0ocvNDFt1h8O6i5solp3dkomyz0Y=;
        b=Et/jsYEjDut7PaJmxFQ31QE2kY2scyDoXNiin4vkIst2T9X7xGDT91grsQrZMZ+z9G
         ISCUOF+HcHsNpLVQ80JqvJKdKhP2EgX8pzhpItafHphMBLeH98EMktXjmVEYW7tlhFjr
         Y6G9MFTOj/5MtEAwL6+vsT7S/YsNPoMwhhHQU6NCh42ojsKa0EDOCzYIW2rxevtlvLVN
         D7aIlMWCLjGqlV3Vn3dwLGgSmoIuzMSgkA6Uu+v+H3w7OswowtZcCIvcCRao1zpWPHPZ
         +HEO7LqlBpIOIgUpkQ/E5mvP+u0S0Sn6NnXT3ioxXdVBbE2KJfwmYbPXVWvid3j6zwDV
         1Q+w==
X-Gm-Message-State: AHYfb5g9kDaoSEv7tSC0yXHhDuTv2AWzKEzEnCuHEXNqJTBb/oM0UiyJ
        Xj1eC10nEI2Ly/fHW4vzp9htSXcAWUrp
X-Google-Smtp-Source: ADKCNb48fZMplnyMlrOjIppARRitB45Z0/qfErlm0B5L2eS9H5CAM+J6TzKTW2KZzYLNTvsQRXNpy6VWgmpgZi0QLYw=
X-Received: by 10.37.7.6 with SMTP id 6mr3150117ybh.215.1503517536481; Wed, 23
 Aug 2017 12:45:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:45:36 -0700 (PDT)
In-Reply-To: <20170823123704.16518-11-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-11-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:45:36 -0700
Message-ID: <CAGZ79kaGjE-A6e1rHAzVsg5gCL5e2Kgidt40p6VPj=hXSHc_eg@mail.gmail.com>
Subject: Re: [PATCH v4 10/16] refs: remove dead for_each_*_submodule()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> These are used in revision.c. After the last patch they are replaced
> with the refs_ version. Delete them.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

The refactoring up to this patch looks good to me.

Thanks,
Stefan
