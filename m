Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BAB1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 18:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeFASe3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 14:34:29 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46797 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbeFASeW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 14:34:22 -0400
Received: by mail-vk0-f65.google.com with SMTP id b134-v6so1394379vke.13
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N8euPY4p9tCKfzQgfv4po+13+M79QtGzIvlcMsdsdbM=;
        b=Y+vxfDVQ0RPbmTI8669yfnHVvJYtMcGKKQHe7HLEpYXdQb02qw11DYS61mTxJBlk9V
         +9ih52JFChC+8LF+8PsbAUO3JId9enQPLlw1+B/lKaVeRJeI6UNutmUVHEXBBpN8CeI8
         x30+4Wg68rZFqn/jl2shVM2tTJ9TzuaBvTK/evQTKEQ21R9a4WWjXxYev+q6DlkiFbVe
         p1HkjPoDOST9I78NeIeeoycWP6yb34hcWtrTt3N07eG9SgUtfigPNZi49BhGbmb4etyk
         u8lxW88N4Rb03bbPbuiD7YeK85447HMMq1Ibf242saP1buDTvDn3NyDKOFoewRiSDHKo
         BVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N8euPY4p9tCKfzQgfv4po+13+M79QtGzIvlcMsdsdbM=;
        b=k2puCPs8dba8qteJl2YTtGVDT+twq1hKjlEvjz5k4inXpUB2j6xoThQ7aotk038BNy
         IqeM6X6JXAEnroCdm2IP/anE5Qgikl6yQCP2xoJ8hFpSdT8pLsSbwsGPPZ79W0KXrB62
         b84FSHb7NFV6U3csE2GY6T41kfX/87er2WbcohyIw/t1PMeukLrY7AK2Mbl9m66vhhfi
         JiXzOk3Lp39Rwv2kOMENjxTqQQ3d8RvUr/K28qoAb39aKx+lI/hd66iiQ1Rv3yiM8xFx
         pqh4CufsAo3jEdc4WqjPxDAupvVlBSYmQ6k2K6aTMtK1aGKt2XkCEGc8DRMghxKnfOvM
         AAsA==
X-Gm-Message-State: ALKqPwcYR+k4Qdve18y0l5o50eLTZMKGApv0afLfTHt5cY4mzAoCm91G
        1DdX5GbLG5gMBqXJcbEkrekJS3hSFBNX0gNMWac=
X-Google-Smtp-Source: ADUXVKKpoQ/t7Stoo6YaBOW+4Lf+YsPck6TxjBKok+PgEpSHJjZJPfUoQjmjVySHWhiovoXrTQl0OrI8jDKwfdeEb3w=
X-Received: by 2002:a1f:824a:: with SMTP id e71-v6mr7246157vkd.7.1527878061607;
 Fri, 01 Jun 2018 11:34:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 11:34:20 -0700 (PDT)
In-Reply-To: <20180601161153.15192-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jun 2018 11:34:20 -0700
Message-ID: <CABPp-BFaFR-ZTg2Wj4gcBPLyb4sejw+guNhWRFXfRRR0UZq4nw@mail.gmail.com>
Subject: Re: [PATCH/RFC/BUG] unpack-trees.c: do not use "the_index"
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 1, 2018 at 9:11 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
> unpack-trees code works on multiple indexes specified in
> unpack_trees_options. Although they normally all refer to the_index at
> the call site, that is the caller's business. unpack-trees.c should
> not make any assumption about that and should use the correct index
> field in unpack_trees_options.
>
> This patch is actually confusing because sometimes the function
> parameter is also named "the_index" while some other times "the_index"
> is the global variable because the function just does not have a
> parameter of the same name! The only subtle difference is that the
> function parameter is a pointer while the global one is not.
>
> This is more of a bug report than an actual fix because I'm not sure
> if "o->src_index" is always the correct answer instead of "the_index"
> here. But this is very similar to 7db118303a (unpack_trees: fix
> breakage when o->src_index !=3D o->dst_index - 2018-04-23) and could
> potentially break things again...

Actually, I don't think the patch will break anything in the current
code.  Currently, all callers of unpack_trees() (even merge recursive
which uses different src_index and dst_index now) set src_index =3D
&the_index.  So, these changes should continue to work as before (with
a minor possible exception of merge-recursive calling into other
functions from unpack-trees.c after unpack_trees() has finished..).
That's not to say that your patch is bug free, just that I think any
bugs shouldn't be triggerable from the current codebase.

Also, if any of the changes you made are wrong, what was there before
was also clearly wrong.  So I think we're at least no worse off.

But, I agree, it's not easy to verify what the correct thing should be
in all cases.  I'll try to take a closer look in the next couple days.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  unpack-trees.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 3a85a02a77..114496cfc2 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -18,6 +18,9 @@
>  #include "fsmonitor.h"
>  #include "fetch-object.h"
>
> +/* Do not use the_index here, you probably want o->src_index */
> +#define the_index the_index_should_not_be_used here

Good call.
