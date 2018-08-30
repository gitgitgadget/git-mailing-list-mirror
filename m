Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826BE1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 22:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbeHaCi3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 22:38:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46123 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaCi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 22:38:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id k14-v6so7655714edr.13
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7pic93PeMPJ9ywR6Hqq7SQFEQVTZ5O0S8dxrIT9lwa0=;
        b=NHK2azDnBdmgu/oMEwg0aMwgAryvN6zb0Nn67rqxjLXoOhvrVkPRbdE98fgPAsvulr
         ThUp5BDYtIAQpfYKenwtPVhcFBybE9F4aOIGbfguU0Ybx9PYTon+wnKOuGN4ksOEUS4E
         7xgU4AmEgvrfe4w9VNUso8D3rXgS4JVfviP0lf0aRwTbRIZarIDE1DOkCDJaquTGmTmU
         bP0RqPYyZx+iK98wo3toFPWkTVtzLKPm3hqELVpC+fMlUzP3QM4S70zhSaK4G7oui5I4
         5tziKW4Fu7J65cxJv2vN/u+OeheVCzaPbw6lMlq9oHzYYkG5ElSIlggscRezxkbSw2Hd
         xayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7pic93PeMPJ9ywR6Hqq7SQFEQVTZ5O0S8dxrIT9lwa0=;
        b=NfTyau5wrc2xmQ5bjbqy3m9zeKdUO4bn5BZG3lKgw5hZz3c7j34fTIZQo+41On0dF/
         tw1iU+F7EsMlXPgL2QsodNEYp+jxbL7OCn2Ik3Jy70pi0dbX0mVT7nbuhsKF1k+PGwJ+
         g/dYx1IZKFIkiZK4KQ+0CAb1wmEfnctpZC3DBTkMs/M+IVG7Z3m79xrzO4AC1lSkEw3O
         zs+zeWjQITt8zxeUzfEDBwVmwAtJ3Ef9XKWNNPjpNcUrroHiKksfFepGqYWw8OgZeg1H
         QLrzj99ct4KAhokemLqfGMu/hSoioSSGDjbQGI/iMKz14mrTnwkZRKmU6UdoGydL7oHf
         FqFg==
X-Gm-Message-State: APzg51Ak0yO7jdzUBllUQhu9RL8rFN+X6EsGYT2VcMqPljjYALx3KH4F
        jPFMf2QEqaSJWrb84m0clxruJFg3vGc=
X-Google-Smtp-Source: ANB0VdZc4jbBPTDkYsO5OS4pKy7CL/a//1Ag3oorxCoNzi1M+UXWTuDJayxEcDN7oQVXR3PKF1uPOQ==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr14467899edd.120.1535668443268;
        Thu, 30 Aug 2018 15:34:03 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id m52-v6sm3239999edd.46.2018.08.30.15.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 15:34:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH v4 4/6] push doc: correct lies about how push refspecs work
References: <20180813192249.27585-1-avarab@gmail.com> <20180830201244.25759-5-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180830201244.25759-5-avarab@gmail.com>
Date:   Fri, 31 Aug 2018 00:34:01 +0200
Message-ID: <87efefcwme.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Ævar Arnfjörð Bjarmason wrote:

[Notes to self]

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 55277a9781..0f03d36f1e 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -74,12 +74,41 @@ without any `<refspec>` on the command line.  Otherwise, missing
>  `:<dst>` means to update the same ref as the `<src>`.
>  +
>  The object referenced by <src> is used to update the <dst> reference
> -on the remote side.  By default this is only allowed if <dst> is not
> -a tag (annotated or lightweight), and then only if it can fast-forward
> -<dst>.  By having the optional leading `+`, you can tell Git to update
> -the <dst> ref even if it is not allowed by default (e.g., it is not a
> -fast-forward.)  This does *not* attempt to merge <src> into <dst>.  See
> -EXAMPLES below for details.
> +on the remote side. Whether this is allowed depends on where in
> +`refs/*` the <dst> reference lives as described in detail below. Any
> +such update does *not* attempt to merge <src> into <dst>. See EXAMPLES
> +below for details.
> ++
> +The `refs/heads/*` namespace will only accept commit objects, and only
> +if they can be fast-forwarded.
> ++
> +The `refs/tags/*` namespace will accept any kind of object (as
> +commits, trees and blobs can be tagged), and any changes to them will
> +be rejected.
> ++

Both of these should carve out some mention for the "deletion" aspect of
"updates". I.e. you don't need --force to delete.

> +It's possible to push any type of object to any namespace outside of
> +`refs/{tags,heads}/*`. In the case of tags and commits, these will be
> +treated as if they were the commits inside `refs/heads/*` for the
> +purposes of whether the update is allowed.
> ++
> +I.e. a fast-forward of commits and tags outside `refs/{tags,heads}/*`
> +is allowed, even in cases where what's being fast-forwarded is not a
> +commit, but a tag object which happens to point to a new commit which
> +is a fast-forward of the commit the last tag (or commit) it's
> +replacing. Replacing a tag with an entirely different tag is also
> +allowed, if it points to the same commit, as well as pushing a peeled
> +tag, i.e. pushing the commit that existing tag object points to, or a
> +new tag object which an existing commit points to.
> ++
> +Tree and blob objects outside of `refs/{tags,heads}/*` will be treated
> +the same way as if they were inside `refs/tags/*`, any modification of
> +them will be rejected.
> ++
> +All of the rules described above about what's not allowed as an update
> +can be overridden by adding an the optional leading `+` to a refspec
> +(or using `--force` command line option). The only exception to this
> +is that no amount of forcing will make the `refs/heads/*` namespace
> +accept a non-commit object.
>  +
>  `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
>  +

Later below this we say:

    Pushing an empty <src> allows you to delete the <dst> ref from the
    remote repository.

Which, perhaps given the discussion of deletions as updates, should be
mentioned earlier in some way, i.e. should we just say above all these
rules that by "update" we mean non-deletions?
