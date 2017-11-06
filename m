Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1AA202A0
	for <e@80x24.org>; Mon,  6 Nov 2017 09:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbdKFJyA (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 04:54:00 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:48514 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbdKFJx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 04:53:58 -0500
Received: by mail-pf0-f180.google.com with SMTP id b79so7352821pfk.5
        for <git@vger.kernel.org>; Mon, 06 Nov 2017 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r4tHy3ccCKDL/12jXcTsUIsBsHtkq0Z+XLtIoAcvvGc=;
        b=BeZEzgF6f8DAiImmkENvigc7tDZ601/f63Qtim7diEjy6Zldic/Y30xjn73I8dVBB3
         3icJUoyewdxaN7tNvQRC7jkRRaYO9pv63ryt/ldoN7qdyfLhojgYWzMeZJA+y4gTLRWx
         dLvRhlShC3idbHY2k4RxUVBMbegj7KVWpPPKsw35AvKsIMSxB24s2d+w7SmNHAw9OSsF
         QU2de9F35D/sVBp6vXoDcKnj/rnduxGRjnj1I1vbQ5+ZYeLTpjVcORcpVyXLggomc3+Z
         Cqs44Grcflj9STsvOITVkFQfqQURhD1iy560rUY7B/bPiZAPuymHbqMkPdPGukkSJLJC
         QVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r4tHy3ccCKDL/12jXcTsUIsBsHtkq0Z+XLtIoAcvvGc=;
        b=oIQ8fpscCU4BDbPdJ6Y0F3S2zv8zZYw2c+99SOU9NXpMqlVKzkadzYNGk8Bqtmq8Z0
         nV/GzS1oLW0AKFHDLn1a9WJMBHXWEiSk06Bfnyhg1lyYKfHbD8wDSe1ZaZfpKWBeN5zm
         ElyMtXBAcPNYloEfmbmctyYt14djc9i24qetQenOErILD27XwmbRKiBPZLEtUoZUpm2l
         eegkvKQ8CNh5pPK27SKcP6nAUGYMa/rvKKa9wkkok5b/KPo506nv04hxc0eRSWxxeo3r
         xSijotMoChzkZEO6Mi5bqktwAOJ96GlyFgdJfhEu5nTkddaN1ZfyY/nRM8l0JPUz9H8X
         1sxA==
X-Gm-Message-State: AMCzsaUj7Eqj/ci+sRm6Y29gf2n5XWMPPCt0ELGVIsqcsxo52UZYzyMR
        2EQkntBfoIOZiamZoDtGO5jlelIkbOm8h8t8URY=
X-Google-Smtp-Source: ABhQp+SlYIADWOjCpz/tTIm94s/Lo/erDjS/J9H+dCpH0PEsAqnL/lUCTalDbGn4N22RbJXO3ZYsTtPn8Ydt2BQwQLk=
X-Received: by 10.99.165.25 with SMTP id n25mr14781964pgf.294.1509962037821;
 Mon, 06 Nov 2017 01:53:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.170.1 with HTTP; Mon, 6 Nov 2017 01:53:42 -0800 (PST)
In-Reply-To: <20171103204449.5268-1-dennis@kaarsemaker.net>
References: <CAOAxMp9H6M+t5RvYiem+kXrY920ZDYvyyYt4GZ7ZnkpXVA_c0g@mail.gmail.com>
 <20171103204449.5268-1-dennis@kaarsemaker.net>
From:   =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Date:   Mon, 6 Nov 2017 11:53:42 +0200
Message-ID: <CAPWNY8WUo8n903AcUPQ-EsfmtjoKRJDGXp0Wy4KoBSbrOhrR0A@mail.gmail.com>
Subject: Re: [PATCH] credential-libsecret: unlock locked secrets
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 3, 2017 at 10:44 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Credentials exposed by the secret service DBUS interface may be locked.
> Setting the SECRET_SEARCH_UNLOCK flag will make the secret service
> unlock these secrets, possibly prompting the user for credentials to do
> so. Without this flag, the secret is simply not loaded.
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  contrib/credential/libsecret/git-credential-libsecret.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/co=
ntrib/credential/libsecret/git-credential-libsecret.c
> index 4c56979d8a..b4750c9ee8 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -104,7 +104,7 @@ static int keyring_get(struct credential *c)
>         items =3D secret_service_search_sync(service,
>                                            SECRET_SCHEMA_COMPAT_NETWORK,
>                                            attributes,
> -                                          SECRET_SEARCH_LOAD_SECRETS,
> +                                          SECRET_SEARCH_LOAD_SECRETS | S=
ECRET_SEARCH_UNLOCK,
>                                            NULL,
>                                            &error);
>         g_hash_table_unref(attributes);
> --
> 2.15.0-rc2-464-gb5de734
>

Looks okay. (It seems that's what all other programs do, too...)

--=20
Mantas Mikul=C4=97nas <grawity@gmail.com>
