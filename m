Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AE01F453
	for <e@80x24.org>; Tue,  6 Nov 2018 18:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeKGDv5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 22:51:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:55584 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387480AbeKGDv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 22:51:57 -0500
Received: by mail-it1-f196.google.com with SMTP id b7-v6so19242425itd.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCl6cfStIdINwB8oXId4W+VRdY/p9clE9rm7HrifWj4=;
        b=bmz18yYHjuJ0jw/X/95xmu2uIlltcb0Zxhkf9oRmok13PIJf05Ihe4xR2XGSLu84FZ
         B8jk5wNu/ol8a4l89ghq3cCDcFURbFAq2eg3wgQyyC824QFQC+B1warhpN2zX/m+vCzr
         wdQ2kXqkPPzxJRd/k6O67xO+Vif2Lv4vGH1EAc5ss4E1rUysZ+ScO4G+D1/lvlbikZZJ
         sEu9QrlgF9MepTvnqG/VvYjJjkkL4Kz0CpLqKjucQMipKDJxQ6VH8eIJKrGLFUwt/h+r
         D7SqdRJcLZCuutZRgcnlpMwxD4cP3Joq51mH+zewJk/CMc1BLd3v86XWAASAoBTYI0Tb
         tSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCl6cfStIdINwB8oXId4W+VRdY/p9clE9rm7HrifWj4=;
        b=uiOE2xZp3XlafI13OfeOwpbVet18rp3+4yn2Bz+JDQ3cBDZ/aD4h5GQhR+KDI6bg5c
         Go86vl58lqzKTVMfotieHVFNxdW6eaqcKLhb/1dhCkGV7imfo011KbDvd78G8pvQcIgS
         BTV65d0feFHmSKmfY2MvDVmev1mGI62b2+s2kSaHoPS09vSpbyuamsGXo5kyytZKGs4t
         GnGVXIoO1MTjT88HdkwHelemP2KtBQETxCF/Ds23WyHgjkcJzCMcy5EIgnZVZxviOYxY
         Wat2PDYof1It1WGG0eaaTYXq3w5TfJnigithK+KF937oQCw+LXm0XMAjkV6W1pUSIgOy
         /b4g==
X-Gm-Message-State: AGRZ1gIUiW6Dm16nPvu4JntoSgm5wfEiIe0+8Y2PVmFpLxMd5oJXyOTM
        2OFu5ZqmMLPTyRpTkVZ5ykdfy7OZJPF6mqf/Rh0=
X-Google-Smtp-Source: AJdET5dcn8KVNfdMg93MLJmRxHNqC1ePXbUSGIa7UXnpGT+gZnFbRuHTAar6TSHJTLj7wZUPC4V49I6sQrQsk/fbQ5g=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr24546234jaa.30.1541528725986;
 Tue, 06 Nov 2018 10:25:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
In-Reply-To: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 19:24:59 +0100
Message-ID: <CACsJy8D47sDgdpmPSqVbBu7Omc1=4yAn895-PE91-PLs9+83bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 3:55 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, an absolute POSIX path needs to be turned into a Windows
> one.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  path.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/path.c b/path.c
> index 34f0f98349..a72abf0e1f 100644
> --- a/path.c
> +++ b/path.c
> @@ -11,6 +11,7 @@
>  #include "path.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "exec-cmd.h"
>
>  static int get_st_mode_bits(const char *path, int *mode)
>  {
> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
>
>         if (path == NULL)
>                 goto return_null;
> +#ifdef __MINGW32__
> +       if (path[0] == '/')
> +               return system_path(path + 1);
> +#endif

Should this behavior be documented somewhere, maybe in config.txt?

>         if (path[0] == '~') {
>                 const char *first_slash = strchrnul(path, '/');
>                 const char *username = path + 1;
> --
> gitgitgadget
-- 
Duy
