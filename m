Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C39211B3
	for <e@80x24.org>; Sat,  1 Dec 2018 04:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeLAPdn (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Dec 2018 10:33:43 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37040 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbeLAPdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Dec 2018 10:33:43 -0500
Received: by mail-ua1-f68.google.com with SMTP id u19so2642857uae.4
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 20:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I3tQJgOfBauDrcsnmQTz+ZkRQlu3UWqff0zg/64+MSQ=;
        b=U0hNWhJuO9gaurq3rYiRdaQ8ddxicX6/2/tZO+c8tMKdm8S1PU81dMjXmqQpXnqwL+
         gtEa9yzuLl6wRcQLgUptnvOJWlwpW/bsYNiAZDqnzn49B2/1maHAUpoWD0xo7N8JFGfl
         yFUGW3q21ujhzKx1k+a3mrK8UNxQtX1WZtu/AII/8b0ZnQHgl/got32teTfY22KBMmle
         RBpKoSWtH9SCeVhOdDaXBP75xnaX4cEHXHHAmxrVqfj5SzK6vCa4EN/apxG78vmyPxHW
         iZ3KFwF1Klxr+xKvuW5QlbanZLTzvEOeLNRIo3ptJOW69aNRRDTcpD1pLEL4GXeoBTNu
         cUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I3tQJgOfBauDrcsnmQTz+ZkRQlu3UWqff0zg/64+MSQ=;
        b=lXWcYlGPtMDvXiIMZSWZCyzZun5t5W0WjcjBIVWaOH5SrbXiFkxHeixSCRrhukDoE1
         rf9yLIV3G1Gk1o1I8WKboOY+Pl5gS2f7vRlVO8iuR+PqDsi9mc8SPaW/0gl3yNTu2jqZ
         tvHvtPbZXbPgb8N/uf2zLGbI9HqPWSR1gQWQKqqaeglj/+AxzZCBP9apNwWoNFi9hToj
         vcitokPEKmWowPf1way29IYP23EFCRfviDYbmXNSiJuc6GyFBP+hC7UpTusUFAm9xVps
         6lrVUrFIDTFpTZyaq3UUU4wD9UZsQjYBhSNM5rBfNoCk/yO+J+1irc3L53V4krpd9IiM
         UcUg==
X-Gm-Message-State: AA+aEWYya5sjtDh7y30knfw5OF4cCwUXfvXRAyn8SvIasV33QNQzIHDD
        9y0cfDL2r8xFjHv7L0uMLXJr9TkiNEVueXKj/bc=
X-Google-Smtp-Source: AFSGD/X+rpPuKlB7YOdoiHVkgUFjY/H7C6++YXZyp7xlmdZX6+I6uapfv/kD/JAU7ChscxzxpqTAxPwCymzZZTQZaLo=
X-Received: by 2002:ab0:2314:: with SMTP id a20mr3619025uao.130.1543638127305;
 Fri, 30 Nov 2018 20:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20181201025212.54244-1-carenas@gmail.com>
In-Reply-To: <20181201025212.54244-1-carenas@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Nov 2018 20:21:56 -0800
Message-ID: <CABPp-BG0=bGW54eMHCiVMbU3dwccZM06qy2gzqm1CE-TUFZ2zg@mail.gmail.com>
Subject: Re: [PATCH] t6036: avoid "cp -a"
To:     carenas@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks for the patch!

On Fri, Nov 30, 2018 at 6:52 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> b8cd1bb713 ("t6036, t6043: increase code coverage for file collision hand=
ling", 2018-11-07) uses this GNU extension that is not available in a POSIX=
 complaint

This is an extraordinarily long line; can you rewrap at around 72 character=
s?

> cp; use cp -R instead
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> to be applied on top of en/merge-path-collision for next
>
>  t/t6036-recursive-corner-cases.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner=
-cases.sh
> index b7488b00c0..fdb120d0dc 100755
> --- a/t/t6036-recursive-corner-cases.sh
> +++ b/t/t6036-recursive-corner-cases.sh
> @@ -1631,7 +1631,7 @@ test_expect_success 'check nested conflicts' '
>
>                 # Compare m to expected contents
>                 >empty &&
> -               cp -a m_stage_2 expected_final_m &&
> +               cp -R m_stage_2 expected_final_m &&
>                 test_must_fail git merge-file --diff3 \
>                         -L "HEAD"                     \
>                         -L "merged common ancestors"  \
> --
> 2.20.0.rc1.6.ga1598010f

Oops.  Thanks for catching.  To be honest, we don't even need -a, -R,
etc. -- it was just a habit for me to add -a after cp.  A simple cp
would do, though what you have here is fine too.
