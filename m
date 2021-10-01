Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16988C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F094B61A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbhJAPvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353712AbhJAPuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:50:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48CFC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:48:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so36264765edv.12
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gr4N71cPulYMKNikpZRoa6S+0erF/tmDZDGwK7JHxtY=;
        b=ouae+NgGM7/iCWFrGCU54lf+IMxV0lEiUyvQDi30dvjpuH8fsZFJ0E15ZdCEd2vdfn
         MNHlRy+Sjkyg7fKHRsCnWtF4iyya07xAUTm/XVuuvT7onUGm94hB5ypV6Nha0QFnITnw
         UawPxk67hOxgi0cBpxDMszEBFrf1Uv+wGQS+QI5JwSYlX3SA7KMK/LVF0e3q17sYaJX7
         aAaHZ1noQjPpX/xjeLvsXUuzA8hbLW+vqgu2ceajWt8yfMnSTQh9NbQmsuXQvb/s6V+9
         nspQIWT/+Bxo41sBq9AhNh8NPjtfOh24qYLR/99PfL8PRk0VY2mFj2ISDcJ0Pw8rVI/8
         viGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gr4N71cPulYMKNikpZRoa6S+0erF/tmDZDGwK7JHxtY=;
        b=g2St5t41vPWNUFTFut3hR7/V0XXmWk/Kj+5SioPiK7VAdCDhguOm914VnVjvbaewcf
         ArAlFbnnmzQmjvfNHRi2p5/phSU8nuJJ7o64JUCINPrAfZERTIh17Gx+nAtjt0vCHOKF
         zxj0sPWo1BrVyAtqpbW/2Unv2NNOcEVLFytfleTlXkbbcQV5w4JdXbBmfrUbaZI2D+0F
         KGUohS+S324Gxzxig5ijg7MExKB7JM7kUg3pq8QgnipZlkPQYfVX37Fhey25dY5J5lNY
         Q9/C2oonU+kWlwAOJ2zgjZ8DQRx8Bb72LpX7fGCWDCNuaUR74JwD4DU5nINrtHbTAblV
         Qayg==
X-Gm-Message-State: AOAM530VWu8BPHcbmZOueMMamAd5weyMmHaGKcNUrYw/owsC15EaYfQ+
        WMSi6tCHhWsYsrU2GOEBjAc=
X-Google-Smtp-Source: ABdhPJzajDhYT1FLNo7kG5vHnjOWX75lLAKxCXPM+dLYUkqI7277x7dV1N1pKFrRrAP03Tid9dA9mw==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr15111427edb.102.1633103337308;
        Fri, 01 Oct 2021 08:48:57 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u6sm3392666edt.30.2021.10.01.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:48:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com, gitster@pobox.com
Subject: C++(C99)-style comments in git.git
Date:   Fri, 01 Oct 2021 17:37:40 +0200
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <20210930054032.16867-1-carenas@gmail.com>
 <20210930054032.16867-3-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210930054032.16867-3-carenas@gmail.com>
Message-ID: <87wnmwpwyf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 29 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Avoid C++ style comments, that are not allowed in C89.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  reftable/stack_test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 7a4641ab60..f907215d3c 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -46,8 +46,10 @@ static int count_dir_entries(const char *dirname)
>  	return len;
>  }
>=20=20
> -// Work linenumber into the tempdir, so we can see which tests forget to
> -// cleanup.
> +/*
> + * Work linenumber into the tempdir, so we can see which tests forget to
> + * cleanup.
> + */
>  static char *get_tmp_template(int linenumber)
>  {
>  	const char *tmp =3D getenv("TMPDIR");
> @@ -861,7 +863,7 @@ static void test_reftable_stack_compaction_concurrent=
(void)
>=20=20
>  static void unclean_stack_close(struct reftable_stack *st)
>  {
> -	// break abstraction boundary to simulate unclean shutdown.
> +	/* break abstraction boundary to simulate unclean shutdown */
>  	int i =3D 0;
>  	for (; i < st->readers_len; i++) {
>  		reftable_reader_free(st->readers[i]);

This change looks fine, but FYI we had a C++ comment in git.git from
v2.21.0 with d73019feb44 (http: add support selecting http version,
2018-11-08) until now.

It'll be removed in v2.34.0 with my 2a7f64616a3 (http: correct version
check for CURL_HTTP_VERSION_2, 2021-09-13) (not the purpose of that
change).

Now, granted it's "only" compiled if you don't have NO_CURL=3DY, and it's
on a "#" pre-processor line, not in the "main" code.

So it's possible (but I think not likely) that someone's cpp accepts it,
but not their cc. Or that some platform has nobody compiling with curl
(not very likely).

I'm not advocating for using "//" comments, but I think it's fair to say
given the above that they're purely an asthetic coding style preference
in the context of git.git, and not a matter of C89 portability that
anyone cares about when building or porting git.

We already have a hard dependency on a few C99-only features, I'd think
it's very unlikely that someone has say implemented designated
initializers, but not "//" comment support. So for our purposes support
for it should be universal.
