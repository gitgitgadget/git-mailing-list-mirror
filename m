Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8BF1FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 00:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdBNAui (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 19:50:38 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36215 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbdBNAuh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 19:50:37 -0500
Received: by mail-vk0-f50.google.com with SMTP id t8so71550270vke.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 16:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EKeNzNm4nhnG5kHogZqq3cIeEvEdchmI98ZfSR8l7vI=;
        b=iHI/8ZLTlTOHQQkIJwtlLPAKTKKRRJ7+9wTgVVk3Bxqp47clFSVp1clRYKrKShv4QK
         gM8nUAG4Ncs5WdfbRjUMg8PGoUQmr5GWZAFU8teWoxtKLJEaxjiWjv74d51CCzowi8oJ
         ODCkE/D6vTu3iwGRxjXFpmtDfrRbKxyf/zJYD1JeWd+Zj/LWp03KePfRetEvhLtgtzsI
         YEUNNvBo2Hc6/QPxJQrmfsKNwELM9dvlySGsE1+iPvNVZelUifb+9bqH6iuQK+IT1IXZ
         2CsqR8Ht4439CxzswM8ajLHCbt9uY4OacvEu5MBOlwobwAERWwOWAgEi3vxCk4UNhyXx
         bJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EKeNzNm4nhnG5kHogZqq3cIeEvEdchmI98ZfSR8l7vI=;
        b=bF5UJjN+OgzhzTkVo/PDYsS2i9SfiOvbCcNPHcf57XHmfWQu+6TgG/ZI4Flv1Im7Ta
         zgNFnQyzrrrrYmfhdowchCydZvZloLh1KMALGiSMvVihBPOu8TmZfuBu9bxyk9UroJRW
         thYf9dIZVGDbboDMhr78XqyDweVGboloNRHrfVVZyDci9HlDkpiqQgOAYGnLl2nn6kwX
         tQohE8Dd7878U+hQN1g9ItoHdhXu5ELTjMrZJ6+C8P3sUfK/BcVvh8f9ko1n34GYk9MY
         ZysDXR7GcJ2QFKxr4CNI/MXPt4QHK4VQK5w1vK0pGpRxO0/mozMkK+AQZf8OF3aGsHt6
         MLzw==
X-Gm-Message-State: AMke39kn50rTXp5FRltcbivjP2lBuEMYj7IBPNeALn80HII+QRRGYHFxKV5CS1jcHCqhERm8cS7GWWTgfvR1Xw==
X-Received: by 10.31.33.200 with SMTP id h191mr12756254vkh.0.1487033436662;
 Mon, 13 Feb 2017 16:50:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Mon, 13 Feb 2017 16:50:36 -0800 (PST)
In-Reply-To: <20170213233359.11149-1-cornelius.weig@tngtech.com>
References: <20170213233359.11149-1-cornelius.weig@tngtech.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Tue, 14 Feb 2017 01:50:36 +0100
Message-ID: <CAM0VKj=d+hAiF6_8TLuJfccNiPtHyg9F6zESA8SuTEeaLsrw4Q@mail.gmail.com>
Subject: Re: [PATCH] completion: complete modified files for checkout with '--'
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Git mailing list <git@vger.kernel.org>, j6t@kdbg.org,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 12:33 AM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> The command line completion for git-checkout bails out when seeing '--'
> as an isolated argument. For git-checkout this signifies the start of a
> list of files which are to be checked out. Checkout of files makes only
> sense for modified files,

No, there is e.g. 'git checkout that-branch this-path', too.


> therefore completion can be a bit smarter:
> Instead of bailing out, offer modified files for completion.
>
> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>  contrib/completion/git-completion.bash | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6c6e1c7..d6523fd 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1059,7 +1059,10 @@ _git_bundle ()
>
>  _git_checkout ()
>  {
> -       __git_has_doubledash && return
> +       __git_has_doubledash && {
> +               __git_complete_index_file "--modified"
> +               return
> +       }
>
>         case "$cur" in
>         --conflict=*)
> --
> 2.10.2
>
