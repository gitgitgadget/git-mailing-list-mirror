Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82731F42D
	for <e@80x24.org>; Tue, 29 May 2018 17:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965536AbeE2Rlc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 13:41:32 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:41985 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965284AbeE2Rla (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 13:41:30 -0400
Received: by mail-yw0-f182.google.com with SMTP id q7-v6so5081118ywd.9
        for <git@vger.kernel.org>; Tue, 29 May 2018 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mYfJhSwXTeHZ+TOOE5Aijqr8y8abnFBJm7cOaQfdZWY=;
        b=JY12vQTAH/kNWMb0ur9uYRVQxOPI2kSvP3ubx8oYDwmAcf/ffkW1IqcJs42Id+qkA2
         gKV9UvTYPRAb8Yk6rx0m00KKD/dvf0GWFI+h7c/ZpXb23DFHqEPxIilBpWTKgcbn8Q1d
         z2nEqJ0Vec99vXOQD6/IrIx0FkXQpeLbAPq43WE6SScDaNj54A3NeR+4nB1nl+vQB1WA
         KrO5+OFP5fdWTIROU89vcMtsKT65075KF/faFyv6IWrbji0jPcQhgkYIzZ+c6JneYnRD
         UvKU2Bae/dl2jbFuZOLWT4XlQCoSOxuAn/6+9VQKBNyncmNRQD59/O9KW5oGGTYpJput
         ZgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mYfJhSwXTeHZ+TOOE5Aijqr8y8abnFBJm7cOaQfdZWY=;
        b=NpG+OXG2Dcyk3j7+1aP9vdEAHQ7iJjiwqyjl+lVMGtAxHpEXWojPkOmLh83N4niHq4
         r706ckgTES/s02LJGhc3qWq0uB1BXO1ZYlq8VzbInl+krDXV5NaTwYcbQd5p7RKEU1Uj
         ibDbnqPAlDmSAvp/WW34MDIPO0KnCvg3+rpdf6hk3lijPpOyE4qkce98lckKapeCIvTc
         S3TXO0y1+iA2VX0SvFercYCOpZwogBr+SZX4HUioHZCVPv3R/6zt06I+aHDbe+TVDlC0
         JjX0vuGX5WH82Fgvr20f/z2Bm7xVJ+6SBFyLPTYktRF+9xyHl4evFxmfEWusCqalsm3G
         XOQQ==
X-Gm-Message-State: ALKqPwdykKCSjR/QLc8m5mM62k6yokzYNcQWP73+Jb5EESOf30BDjxTj
        YWN9BBz3DAPTQVpECz/cLXXwVzYvhtqJvmEejHbNSA==
X-Google-Smtp-Source: AB8JxZpxsGVGQGIxEiN0E8vkrUegjoNcCFR7RL53PUJDCdE4yYA9vyyzTlB+ETE1n3cvQoJxJQesD6IUjCNMrTWpq0c=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr9883647ywe.500.1527615689561;
 Tue, 29 May 2018 10:41:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 29 May 2018 10:41:28 -0700 (PDT)
In-Reply-To: <20180526135531.4516-2-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com> <20180526135531.4516-1-pclouds@gmail.com>
 <20180526135531.4516-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 May 2018 10:41:28 -0700
Message-ID: <CAGZ79kb7K_uZfUdjsnm065h3EYn=GE3Rma5+yACERFhBBcOL+Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] Add and use generic name->id mapping code for
 color slot parsing
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 26, 2018 at 6:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> Instead of hard coding the name-to-id mapping in C code, keep it in an
> array and use a common function to do the parsing. This reduces code
> and also allows us to list all possible color slots later.
>
> This starts using C99 designated initializers more for convenience
> (the first designated initializers have been introduced in builtin/clean.=
c
> for some time without complaints)

s/for some time without complaints/
in 512f41cfac5 (clean.c: use designated initializer, 2017-07-14) which
is almost a year without complaint/ maybe?

(just in case a resend is needed; please be precise and mention that
other commit so it's easy to see the reasoning there)

> +
> +int lookup_config(const char **mapping, int nr_mapping, const char *var)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr_mapping; i++) {
> +               const char *name =3D mapping[i];
> +

    if (!name)
        break;

maybe? We do we need to check for 'name' in the next
condition? What input do we expect/allow?

> +               if (name && !strcasecmp(var, name))
> +                       return i;


> +#define LOOKUP_CONFIG(mapping, var) \
> +       lookup_config(mapping, ARRAY_SIZE(mapping), var)
> +int lookup_config(const char **mapping, int nr_mapping, const char *var)=
;

Can you add a comment here saying what mapping is or should look like?
