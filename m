Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE2D1FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 15:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166944AbdD2Ppv (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 11:45:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34504 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161076AbdD2Ppt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 11:45:49 -0400
Received: by mail-it0-f67.google.com with SMTP id c26so8706211itd.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2017 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NssIRn8KBshSOHriEKCR8uCSQenUpJKvEyWfH5Cwtkk=;
        b=LRu8VxIojwGmj7ohyocj7X+RY/4SChhmlAGnzY5eQ5JUw1eXL+TSf0XEffJGb1xiLF
         FBeftvKTfw5TeLo5zZWbV1RH2HkJr53t6BVCjEOx6T2WP8gkBhmekVOvSPZxeTCgj2/I
         Km0pEty/yYpoCVf9Q6M7zaXPVQcLD13/JjAL48UNDZuaI744BMb1kxrseK4bYybE/tDA
         XxEFGdOZncAXG7dl+zLdwskcUjGGGNHc5kO4PlAVWbORhQl0BT7M4MPNZg92a5HHZczM
         b2QCtJ8HEP4moEsTw7KaK5WjNC7McwEf5G5v3/Z/2RZnrlPiwb4rVKFfkfhk5McRYabr
         uNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NssIRn8KBshSOHriEKCR8uCSQenUpJKvEyWfH5Cwtkk=;
        b=eMVYxB2Q5xBjKYkL2rsHbFAEocuiIZzkO02ZH4mcMUNjZLVDRVc5ZrfDOmA8d+WTYf
         VkCH7paK/ORU+T5B6etZhFWHmDQYGfOvRTm8pJBDp/BerBNy6s8uU3VisCYESVfM1nDt
         DEQL06Mkh67I2/uxSnm4UTYQKydYwZ/8XuKANDqKhySLRfTDnODBjbVxUmseL+v9bwLK
         SFPhhIMBd39V0pK1C6FV23WOwxRBkwU7tAvlXPk3sSYhhm3KXqNNjZJPVCePkIVaDL1W
         bZjOp8XNRYqz/Nctx6hV51hexT/6118j0z+/PwuMobrF58Ed+gsI1W+D9EE07gbJl2Tb
         f6jQ==
X-Gm-Message-State: AN3rC/4MWNyj7R91k96Ypht5vEqBakbpIIwPy/EQMnsCCeyXCt34utSt
        JBc5VAGN8YxSscHmBDVmwU+lStavAg==
X-Received: by 10.36.98.21 with SMTP id d21mr14172908itc.94.1493480748632;
 Sat, 29 Apr 2017 08:45:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Sat, 29 Apr 2017 08:45:27 -0700 (PDT)
In-Reply-To: <20170429122829.lz56r7exh3ecynxb@ruderich.org>
References: <20170409130126.uqmjop25jidhblhd@ruderich.org> <CACBZZX4uBL99y=ZaKZ7dqyP9Ne-cx=kYkh8p51p3VYOr3PQGSw@mail.gmail.com>
 <20170429122829.lz56r7exh3ecynxb@ruderich.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 29 Apr 2017 17:45:27 +0200
Message-ID: <CACBZZX5EdWHWjnYG2YFj7P4Ec+qm80DurUmP4JAR+sSaBjWWtA@mail.gmail.com>
Subject: Re: [PATCH] githooks.txt: clarify push hooks are always executed in $GIT_DIR
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 2:28 PM, Simon Ruderich <simon@ruderich.org> wrote:
> Listing the specific hooks might feel verbose but without it the
> reader is left to wonder which hooks are triggered during the
> push. Something which is not immediately obvious when only trying
> to find out where the hook is executed.
>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  Documentation/githooks.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> On Mon, Apr 10, 2017 at 01:13:15PM +0200, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>> [snip]
>>
>> Can we say as we do now that:
>>
>> * All hooks regardless of type in bare repos execute in the bare repo
>> * If you have a working tree hooks use that
>>
>> But add:
>>
>> * Working trees are ignored by any hooks invoked on your behalf during a=
 push.
>
> Hello,
>
> Maybe like this? I reordered the cases as it felt more natural
> that the general case is first and followed by the one with the
> exception.
>
>> Some ad-hoc testing reveals that this rule also goes for the
>> push-to-checkout hook. Should it? Wouldn't it be more useful if it
>> broke the pattern, since it's dealing with the working tree on the
>> other side? Junio?
>
> I added push-to-checkout to the patch. Changing the behavior will
> break backwards compatibility so I think that's a no-go.
>
> Regards
> Simon
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 32343ae29..706091a56 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -22,8 +22,10 @@ changed via the `core.hooksPath` configuration variabl=
e (see
>  linkgit:git-config[1]).
>
>  Before Git invokes a hook, it changes its working directory to either
> -the root of the working tree in a non-bare repository, or to the
> -$GIT_DIR in a bare repository.
> +$GIT_DIR in a bare repository or the root of the working tree in a non-b=
are
> +repository. An exception are hooks triggered during a push ('pre-receive=
',
> +'update', 'post-receive', 'post-update', 'push-to-checkout') which are a=
lways
> +executed in $GIT_DIR.
>
>  Hooks can get their arguments via the environment, command-line
>  arguments, and stdin. See the documentation for each hook below for

This looks good to me. Thanks for working on this.
