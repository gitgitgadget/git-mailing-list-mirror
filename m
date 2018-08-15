Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8041F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeHOTZR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:25:17 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:40746 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbeHOTZR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:25:17 -0400
Received: by mail-qt0-f172.google.com with SMTP id h4-v6so1816869qtj.7
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rr6Kv5Y/iilqnovsZxAeCkjY9Pa48ijux1ILDMyFGcU=;
        b=BSE0JH9Muvkg13U/iHDdRSxW6Ar7X24CYOpPDtJk+idGoQnSLs/pQFO33pBQaF7/lR
         L7yBLalvU8vS5Nas+T9LvJ5CF6MwbMBf5vB+wkto15rS7TYIYwATlZcRkDX7mfT1QqWQ
         YprzVlje05ja/AC1PxpSsDWIEXt96+rEhaO3ulrEO4QR3n2ih1ncAz9M4BPv0fC7OWjh
         ALhoq/xKvzE+0ycAUeK2tZhXo+Ge5+NBlB73rxEXJ9XOLcvzW+9xNv1Uex49oFZgJw7z
         kpbEunJchwhXEQMlH6lGXoV0VIAJ2H/5/DZp163F7Ppb2wG7Ij2+bCp22SAeyhWSW3rX
         fCzA==
X-Gm-Message-State: AOUpUlGPK2GgpXxtHuywqH4sm1130DC4PXixghJwY+XC5TioolwT+V4e
        W857uYecdwRzYe6i9KJkJS/u9AHf0DsHQXGV1cg=
X-Google-Smtp-Source: AA+uWPxVQ0lnZpnJo/76g8ZNrW46wtIoZV7Ul+Aln3AwoWj6aobZu0YPkdF8lFaozh5W8i9kg2nThXgYc8AqRyndNVo=
X-Received: by 2002:a0c:94f1:: with SMTP id k46-v6mr23551655qvk.113.1534350746936;
 Wed, 15 Aug 2018 09:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.19.git.gitgitgadget@gmail.com> <d0d1d49d6f3e741e9c048041a2f467742bce4bdc.1534343621.git.gitgitgadget@gmail.com>
In-Reply-To: <d0d1d49d6f3e741e9c048041a2f467742bce4bdc.1534343621.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 15 Aug 2018 12:32:16 -0400
Message-ID: <CAPig+cQkHiKDUhMJEdOewnEHTiTvdULwhZGd_h_94W0+zzGb0Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] chainlint: fix for core.autocrlf=true
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 10:33 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The `chainlint` target compares actual output to expected output, where
> the actual output is generated from files that are specifically checked
> out with LF-only line endings. So the expected output needs to be
> checked out with LF-only line endings, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/.gitattributes b/t/.gitattributes
> @@ -1,4 +1,5 @@
> +/chainlint/*.expect eol=lf

Make sense. I did touch t/.gitignore for the chainlint series but
never thought to examine t/.gitattributes (and wasn't necessarily
aware of its existence). Had I looked inside .gitattributes, perhaps I
would have intuited the need for this change. Thanks for handling it.
