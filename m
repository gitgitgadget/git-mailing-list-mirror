Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD98215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 14:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeD3O5w (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 10:57:52 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:40809 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754523AbeD3O5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 10:57:36 -0400
Received: by mail-ot0-f195.google.com with SMTP id n1-v6so9772041otf.7
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LwUlx7u5CG2TjsH2ACockb3xQ4xmXwz39FrNOLZGSg0=;
        b=fSVPSgvVDlZ9feZJGKS00WXf34jOrKtLlLYUNiuMS5XSHKoAkxMEWW3ClSeemNOPKo
         V5AuQoxhl+usVYshTeGRSrkdrBc8uShDel32E9SVo6oBu7bMpNZC1ZL8EA7zDfZPZFth
         RaaBEBlC4k/vaWz3nushH9ycgP/sRGRE96It/M9R76nAJ0hASOqs6TMcC47xK4d8MoCZ
         ADHjgTXuqeZx+ckTvG9bsbsne7t2lVLAquFy0wEhIcWoa5n6ThHHao7U8meiQDWtrIMe
         jyyd/YIGmG39OvCZFCseo9ikkjiJqGE0ygdmgPHIU6ghBhKE2tw2AGr7K0WM9fB3+nFW
         Ke9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LwUlx7u5CG2TjsH2ACockb3xQ4xmXwz39FrNOLZGSg0=;
        b=PUjnrxvLkt9sdk8Ajtyd2uj2ORG1Y56J8rqGaS8oR47IiRQKWRaClmYhm3nV5xDsd4
         juvGXuSRWC+ZaD/WK9RNGKEVp9Uven517CuhCLT5kPEj7qHlyP2tAgSMD6LS+DwEwRdS
         X31bssOBe41E9IxZNpr1M361/rot/bZuz3sv9UIBBPQDRKliFpmTIFaxIpPnsaaeAEVR
         JIrzZhGBvbURItCWPt9qpp6dFd/KDvWqJnyvS0FdtRt41dcehGd3HfUhuNGufcyNe+rr
         deVfYDSNkH10QrWIn8soJ3Splgn+6OOxTc4ZXZCVG6WxJHfTS7YgJOyaPjO/i25cCkDm
         MgnQ==
X-Gm-Message-State: ALQs6tDftVX+zJpo2G82N4cALs44ixI9eGrXOe4qiuM9nrjSmf/1kB0q
        Ypi+Bl0XipD9vEWdidaaqLFho77+PJV21UXN2B4=
X-Google-Smtp-Source: AB8JxZpYdJLOGweYud5L92fGZBJ1fJjmZ7v7Xc0JpkZeOHhwHrqqvHf+y9EunLMgKYBwfKgP4o5Uej4X45tMZHi9c1M=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr9222224otb.356.1525100255260;
 Mon, 30 Apr 2018 07:57:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 07:57:04 -0700 (PDT)
In-Reply-To: <20180430142555.23260-1-benpeart@microsoft.com>
References: <20180430142555.23260-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 16:57:04 +0200
Message-ID: <CACsJy8CY1fNY9OPq9nisDC3X93QXjntre-vFgQ0OeuO=B0YV=Q@mail.gmail.com>
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of NtSetSystemInformation
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 4:26 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Take advantage of the recent addition of support for lazy loading functions
> on Windows to simplfy the loading of NtSetSystemInformation.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>
> Notes:
>     Base Ref: master
>     Web-Diff: https://github.com/benpeart/git/commit/6e6ce4a788
>     Checkout: git fetch https://github.com/benpeart/git test-drop-caches-v1 && git checkout 6e6ce4a788
>
>  t/helper/test-drop-caches.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/t/helper/test-drop-caches.c b/t/helper/test-drop-caches.c
> index 838760898b..dd41da1a2c 100644
> --- a/t/helper/test-drop-caches.c
> +++ b/t/helper/test-drop-caches.c
> @@ -1,5 +1,6 @@
>  #include "test-tool.h"
>  #include "git-compat-util.h"
> +#include "lazyload.h"

This is in compat/win32, should it be inside the "if defined
(GIT_WINDOWS_NATIVE)" block instead of here?

>
>  #if defined(GIT_WINDOWS_NATIVE)
>
> @@ -82,8 +83,6 @@ static int cmd_dropcaches(void)
>  {
>         HANDLE hProcess = GetCurrentProcess();
>         HANDLE hToken;
> -       HMODULE ntdll;
> -       DWORD(WINAPI *NtSetSystemInformation)(INT, PVOID, ULONG);
>         SYSTEM_MEMORY_LIST_COMMAND command;
>         int status;
>
> @@ -95,14 +94,9 @@ static int cmd_dropcaches(void)
>
>         CloseHandle(hToken);
>
> -       ntdll = LoadLibrary("ntdll.dll");
> -       if (!ntdll)
> -               return error("Can't load ntdll.dll, wrong Windows version?");
> -
> -       NtSetSystemInformation =
> -               (DWORD(WINAPI *)(INT, PVOID, ULONG))GetProcAddress(ntdll, "NtSetSystemInformation");
> -       if (!NtSetSystemInformation)
> -               return error("Can't get function addresses, wrong Windows version?");
> +       DECLARE_PROC_ADDR(ntdll.dll, DWORD, NtSetSystemInformation, INT, PVOID, ULONG);
> +       if (!INIT_PROC_ADDR(NtSetSystemInformation))
> +               return error("Could not find NtSetSystemInformation() function");
>
>         command = MemoryPurgeStandbyList;
>         status = NtSetSystemInformation(
> @@ -115,8 +109,6 @@ static int cmd_dropcaches(void)
>         else if (status != STATUS_SUCCESS)
>                 error("Unable to execute the memory list command %d", status);
>
> -       FreeLibrary(ntdll);
> -
>         return status;
>  }
>
>
> base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
> --
> 2.17.0.windows.1
>



-- 
Duy
