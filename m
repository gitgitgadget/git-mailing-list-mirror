Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054CA1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 00:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeCYA7c (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 20:59:32 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44120 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeCYA7b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 20:59:31 -0400
Received: by mail-qt0-f194.google.com with SMTP id j26so16283038qtl.11
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2Z5immI1sVGdmRxj7Dlhm7QEL+q30GGR6TfxsmfculU=;
        b=odQnNpQrUqfZ9SDOtawNL4pOdkJNtSi5ibigRFvxpOZ+GoygeFeWMMER9nzI+01tGZ
         hnvVEIToJU9M8KZOLAYS+/3GsgepRtXEJpNgIzDc06diBc6Th8qxhpV/Q1DdxDm96RPZ
         WsY+70maPnnhIJvHqf324pxjWQEkvPAj0rrzBGl8AC77M9w6VD8C/TH40PP0qJV+YVMD
         z0EvdfTWa0Bw14Xz7VE18Z3pVLMpSD+/vQXL9CrMdcyDH+fU/WMbm0RKX4zmg1pXD6d6
         SgBDUD32s9mqo+vQl59VOpnd1NENa6DDS6fvCjtggggyGSVY1WKPpw4CAPfEvP++yEVG
         x2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2Z5immI1sVGdmRxj7Dlhm7QEL+q30GGR6TfxsmfculU=;
        b=VD2LWPN/A97cRCrJnQLLs0LGCLkxLvxRn2P1cZfzsHERWOM6TLP0QUl3ZNGMi1UO6i
         8WKCmAA9/HbmXriA54KKzpCXUgMzof0+CLThh3kcoKLZbgu8lirflV+PGg5+yqa4HVgM
         l5dP3SQTC46gU+QVHF1S7xB3PXxxoALRVMabCGuyMCePSDVSQ+AblA3Rwx6oIcpdRs8+
         57XblO15oSbCvd28jRA5qQ/uCSrXdZMsFW6Qvee3lRce0rgQg1uwLdOK9O4CwDIy/ZJI
         hLt5N9n/XZQBzqrK4FsYQpZGqkbvBN71DgZK78R2nB5wnGB2JwQ3c5FlMZ01GmGb92hW
         rkoQ==
X-Gm-Message-State: AElRT7EqNbPdor4u62kEwHz/6yF/crKRfb0dVpKpQr+V/6N+t3QJFQ/V
        efhTikVFPa6EASTRmw2PulGMuEJmvOt40OLSBHc=
X-Google-Smtp-Source: AG47ELsyYfcU7sy7qrK/7QiOK4ECwwnehhJWYxzSTCvru5wNdcL3eFC4dprF2nFf2Cxilwjohen3ToroQOVpCCk23dc=
X-Received: by 10.200.50.174 with SMTP id z43mr47413350qta.250.1521939570945;
 Sat, 24 Mar 2018 17:59:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 17:59:30 -0700 (PDT)
In-Reply-To: <20180324203525.24159-6-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com> <20180324203525.24159-1-pclouds@gmail.com>
 <20180324203525.24159-6-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Mar 2018 20:59:30 -0400
X-Google-Sender-Auth: JFz-USESSbpCr3_YE7cpWR2ZoGQ
Message-ID: <CAPig+cThH3mNTn2nR9XEsmAVaQ0-NfA7r5JwyjBd9wZiRzedhw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] completion: add --option completion for most
 builtin commands
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 4:35 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Many builtin commands use parseopt which supports expose the option

s/expose/exposing/ maybe?

> list via --git-completion-helper but do not have explicit support in
> git-completion.bash. This patch detects those commands and uses
> __gitcomp_builtin for option completion.
>
> This does not pollute the command name completion though. "git <tab>"
> will show you the same set as before. This only kicks in when you type
> the correct command name.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
