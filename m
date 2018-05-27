Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DADE1F51C
	for <e@80x24.org>; Sun, 27 May 2018 07:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934160AbeE0Hdu (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 03:33:50 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44668 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932993AbeE0Hdu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 03:33:50 -0400
Received: by mail-qk0-f194.google.com with SMTP id 185-v6so7120983qkk.11
        for <git@vger.kernel.org>; Sun, 27 May 2018 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=efbgLJQt0qU5Bdt8GQf2spx0yiauTNePYJt7Dl/MqjA=;
        b=esXsyrN4X/vs4QQjUuTvb60mR/XLeqzVJBP9hZoDHvCqiWVjYH8EjP+k43i6hgkJu8
         cVmwgpyBd2D7dM4S7O0NEnafpX6V3iizCryDL+zxXDJfXwLUdogoqACYHOGMdLJooPWl
         BDeCOAFnA3m8DrqYcf/JQ6JX1SZbt9dYOPshxxUjeZ8ROmWAarGBbT59AUlIgVgPbz8t
         +9bEIBmaX4oMAMXgoszt8JJE1hy1ae+6r9I42E/U92IlJWsScY6BPGoSD9hsfqVHcWQ+
         hSK2Oom3LZ/ITpJ3AIwAn56IWI77F4uRzJ2BDYp9K4Q7Sjguu6ot3RysiXHzQ2UMHM6B
         2xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=efbgLJQt0qU5Bdt8GQf2spx0yiauTNePYJt7Dl/MqjA=;
        b=bW741lYxM/fDO3vpFKGgZixuIXcFpX5dOujPtWbkCTgCq+X6PzzxvOtGFVflXGKZRW
         9+RzjAHHvO24wUwbLfzKmpxz/sTv56V9Mb4+1ku4oUcCgxUIZ7HDRgsh/57R+ZSGIq0T
         3o8SnZBs+QYTMIUl6BeA1IIQM5VKrw5yUrjmJTDUsrg7de8zsz/a1jvun9Bps2aE9IDI
         m/EnUVDGQ0AIWhoY1sa+pqXUIKKbKfw7CaMZLAcuyy+Jp0pqSsFMD6adq5pOCMUlnB+U
         UqoPV8LLlwI12q6F1tPsKdIn0LygvjQ/PBzaLdKE1IaoMq5X1ezBSNL3M4RAZa42a5sN
         PLcw==
X-Gm-Message-State: ALKqPwdibhO4ng3RLlYYM1TN8CzV8f/p/WFU43QAg+jFSxtRGx3Sp+pc
        2tAzUl7exSGy5UjOX8j4CnNMsKxJumc8MW6VYw4=
X-Google-Smtp-Source: ADUXVKIcGO4aBml+80RL25mwVE5XCmiBEymRMHFqr29t4os7Pm7Y93FbxgfFuk0zbkodgcPrrfVNBX8wz07X2MnL6ug=
X-Received: by 2002:a37:6cc6:: with SMTP id h189-v6mr7608104qkc.2.1527406429209;
 Sun, 27 May 2018 00:33:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Sun, 27 May 2018 00:33:48
 -0700 (PDT)
In-Reply-To: <20180526135531.4516-5-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com> <20180526135531.4516-1-pclouds@gmail.com>
 <20180526135531.4516-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 27 May 2018 03:33:48 -0400
X-Google-Sender-Auth: DOGvnUBL-QiS_Ch-rXMW3PdCKcw
Message-ID: <CAPig+cRbp1Kb2Nu-JihsxTaiWy5t=tNfVjTxGWVunyDuLu-71Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] help: add --config to list all available config
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 9:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Sometimes it helps to list all available config vars so the user can
> search for something they want. The config man page can also be used
> but it's harder to search if you want to focus on the variable name,
> for example.
>
> This is not the best way to collect the available config since it's
> not precise. Ideally we should have a centralized list of config in C
> code (pretty much like 'struct option'), but that's a lot more work.
> This will do for now.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/help.c b/help.c
> @@ -409,6 +409,62 @@ void list_common_guides_help(void)
> +void list_config_help(void)
> +{
> +       for (p =3D config_name_list; *p; p++) {
> +               const char *var =3D *p;
> +               struct strbuf sb =3D STRBUF_INIT;
> +
> +               for (e =3D slot_expansions; e->prefix; e++) {
> +
> +                       strbuf_reset(&sb);

Style nit: unwanted blank line

> +                       strbuf_addf(&sb, "%s.%s", e->prefix, e->placehold=
er);
> +                       if (!strcasecmp(var, sb.buf)) {
> +                               e->fn(&keys, e->prefix);
> +                               e->found++;
> +                               break;
> +                       }
> +               }
> +               strbuf_release(&sb);
> +               if (!e->prefix)
> +                       string_list_append(&keys, var);
> +       }
