Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7151B1F454
	for <e@80x24.org>; Sun,  3 Nov 2019 13:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKCNOD (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 08:14:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44871 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfKCNOC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 08:14:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so8599695ljl.11
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 05:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=J6ZfmMm8TrC1ZjWsgz/WYLDpcuTeNpQkfJp28IvBSSY=;
        b=jfCGZU2canB+a+p1y/J0jzVNre13Sqsv/kpt5Vg1cSmr0PuZmqApuS5/BEpVqB64+X
         71VZ8g5cIEEJrbQzGKukSPSmO7Zf37bzk2JdU/kIBIv7uFG6ZkFo6Cg/tQu0VqGcChvn
         Dn+Uy1bH9FgaRTfjQGeMfLnxADvLElaXlAo+Q4gSYW3uwAinQVxdb67VNd6JRjRWEp/Y
         bYW+DNI1HalJo58Qt/I7H78uSUk3PaNY5qnzkgd8w8/q7BJmZgan9LXN3IzDfvOvRmpA
         Dkvw/qSnB7wUKI+ZFF5QV586too+ibsj1/A/qK1tCvaVA7ZmP5itrIubF4aX+pGELdk8
         79+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=J6ZfmMm8TrC1ZjWsgz/WYLDpcuTeNpQkfJp28IvBSSY=;
        b=NfMB/lk5lK/UPQgLkCnklYrgZ9eFrVleedF7AHdlJevHqNfFRRUwozSAMe25rlcRYv
         L/gveFjG4cfQyKVgFfuxAillynAVpDRTCOuENxSY12i9nxULtBKUEklp2ypvjmaIyz0v
         fv9mpG9GUcccCf7LQM6iuDe7ybNhbx3vZIQnlZbpP//mfko+YRhzYLIMoBAoZHWRZNH6
         uA54ORTDRePZdIySbhIG3YhTV+vKE8jdWmT33OI7eqISm/g7OpeppObRcGuz4+sTTLDN
         bCNBktWNEQFZmmYo0FuMZJuX42j4p3Bg80KjzBpkySSrHBwXztj8KH4DsC21arqzOJ30
         NbdA==
X-Gm-Message-State: APjAAAXlmUcXW5iaGelWti47UJJOOd977rnTPl38nYT1aGLTEvOV0jC2
        V4L332J8Vi681ikx3NswgZQ=
X-Google-Smtp-Source: APXvYqzZoPwuILVX1AeKjUPkGwdxrUM5lXWSg63nRQJi897eBjkyxYNcxKnQOgPZ042mVNISYQUBnw==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr4643036lji.213.1572786840544;
        Sun, 03 Nov 2019 05:14:00 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id n6sm3605434lji.61.2019.11.03.05.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 05:13:59 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] doc: provide guidance on user.name format
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-3-sandals@crustytoothpaste.net>
Date:   Sun, 03 Nov 2019 14:13:57 +0100
In-Reply-To: <20191102192615.10013-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 2 Nov 2019 19:26:13 +0000")
Message-ID: <86pni9hzl6.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It's a frequent misconception that the user.name variable controls
> authentication in some way, and as a result, beginning users frequently
> attempt to change it when they're having authentication troubles.
> Document that the convention is that this variable represents some form
> of a human's personal name, although that is not required.  In addition,
> address concerns about whether Unicode is supported.
>
> Use the term "personal name" as this is likely to draw the intended
> contrast, be applicable across cultures which may have different naming
> conventions, and be easily understandable to people who do not speak
> English as their first language.  Indicate that "some form" is
> conventionally used, as people may use a nickname or preferred name
> instead of a full legal name.

This reminds me of "Personal names around the world" by W3C
https://www.w3.org/International/questions/qa-personal-names

>
> Point users who may be confused about authentication to an appropriate
> configuration option instead.  Provide a shortened form of this
> information in the configuration option description.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I like this change!  Un-confusing users is always a win.

> ---
>  Documentation/config/user.txt | 7 ++++++-
>  Documentation/git-commit.txt  | 6 ++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index a1f80e823c..f0edb06329 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -13,7 +13,12 @@ committer.email::
>  	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
>  	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
>  	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
> -	See linkgit:git-commit[1] for more information.
> ++
> +Note that the `name` forms of these variables conventionally refer to
> +some form of a personal name.
> +See linkgit:git-commit[1] for more information on these settings and
> +the `credential.username` option if you're looking for authentication
> +credentials instead.

Minor nit: should this be one paragraph or two - the linebreak after "of
a personal name." looks a bit strange?

No need for a change: just idly wondering.

>=20=20
>  user.useConfigOnly::
>  	Instruct Git to avoid trying to guess defaults for `user.email`
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f684f7fdc2..3a69d82d52 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -467,6 +467,12 @@ if set:
>=20=20
>  (nb "<", ">" and "\n"s are stripped)
>=20=20
> +The author and committer names are by convention some form of a personal=
 name
> +(that is, the name by which other humans refer to you), although Git doe=
s not
> +enforce or require any particular form. Arbitrary Unicode may be used, s=
ubject
> +to the constraints listed above. This name has no effect on authenticati=
on; for
> +that, see the `credential.username` variable in linkgit::git-config[1].

Just ensuring that I understand it correctly: by "constraints" you mean
stripping of "<", ">" and "\n" (and by implication "\0")?

Should we say anything about encoding?

> +
>  In case (some of) these environment variables are not set, the informati=
on
>  is taken from the configuration items user.name and user.email, or, if n=
ot
>  present, the environment variable EMAIL, or, if that is not set,

Best,
--=20
Jakub Nar=C4=99bski
