Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B182095B
	for <e@80x24.org>; Sun, 19 Mar 2017 09:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdCSJ3c (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 05:29:32 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34571 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSJ3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 05:29:30 -0400
Received: by mail-ot0-f178.google.com with SMTP id o24so117339794otb.1
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xfPXKTGKFjObo/kQGhkxbr025H9cB1JMEf5u9xXjNow=;
        b=hTHlsD58KVFNNNmDHBKwYYWd19d2YgMq8XTtXa2nRGeFKyY/NYzTUVNljhkRyk2UPS
         WBEIFmGfbMmE2ZovdC/zXwDB7tL71XbnMnqIWzsFzsmRIMpdKfDTz8nEeEexvzd/z3+V
         6IIri5oOhYnnCObvGDStE2L+S5/2L1fP5BukMW4uPPWIyGN7AZfw+y6uDK8+aLQwsLS/
         oaFpk274w04R5DTw6Py4RwLP+SVlWSvgdKePZtSVqNiY7N394x2bdalMKj10EW0lWOiU
         1WXprGvqORfCdDCPZ0XvcECeEb0UwRBk3RG+PMj/5nDITNjQiB8IYWz2nPIKxsjD4RKF
         1mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xfPXKTGKFjObo/kQGhkxbr025H9cB1JMEf5u9xXjNow=;
        b=o5DYBQ0vDSQY4L6awnmJZcGfqAHC3lHfFIBiuywzbNa9e0SenOOUsH7MF4TG9uE57b
         MbTtxnZep3SpBe5+ovwH0LJLycR/mpXJbgA2qHXe5IhM6uT/i3QEPg+e8Bae4X0QF6qz
         dbNbU18gCbz6feKIF3TFwek60qdqlWvK4qSIgp2Nro72K8IxPhNu8gZRaqvQw/o4amTH
         fVyEeWIaA0WIMvuvh1A9i6qKmMWFV2ZoGl1PhmBZ8QPowaAE+eafGGipOQvhJQ8kDBwz
         HXkbZFK30fYfZklgu0dAS7q/uO5Bb90g1A+FI0ZDpipEQ0RQ+CM0KA9KufuBjmG3KZt4
         oc8w==
X-Gm-Message-State: AFeK/H3ligE+ckHX24+22XegomviG3xRSjdZjEsY/NVppzXpZSxlAlcO3QW1tJA6J3Zi7Va7MQis/k46YeDdZg==
X-Received: by 10.157.36.202 with SMTP id z68mr5038848ota.271.1489915207963;
 Sun, 19 Mar 2017 02:20:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sun, 19 Mar 2017 02:19:37 -0700 (PDT)
In-Reply-To: <20170318223409.13441-1-avarab@gmail.com>
References: <20170318223409.13441-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 19 Mar 2017 16:19:37 +0700
Message-ID: <CACsJy8CV=9PoH6QHCeznJ4DFLJN5w1a74X3f4raqrh4zBzCe4Q@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 5:34 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index ba11b9c95e..55bde6ea65 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -96,7 +96,8 @@ some output processing may assume ref names in UTF-8.
>    refers to the branch that the branch specified by branchname is set to=
 build on
>    top of (configured with `branch.<name>.remote` and
>    `branch.<name>.merge`).  A missing branchname defaults to the
> -  current one.
> +  current one. Both '@\{upstream\}', '@\{u\}' are case-insensitive, so e=
.g.
> +  '@\{UPSTREAM\}', '@\{U\}' or '@\{Upstream\}' also work.

Since this change makes @{everything} case-insensitive and there's no
new one on the horizon, can we just say "everything in @{..} is
case-insensitive unless otherwise specified" and not updating every
@{case}? It sets a new common rule for these @{}, which I think is
good (easier to remember as a user).
--=20
Duy
