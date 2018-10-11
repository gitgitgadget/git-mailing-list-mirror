Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4991F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 07:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJKPIV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 11:08:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37530 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJKPIU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 11:08:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id y11-v6so8459910wrd.4
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=7dZTN/SxKVctHI40TRCeIIt9my8nvY6DBUHYuF4x0XM=;
        b=Fo21Ni5/4QvumeQAdNjXX1HsnurpL4uZJbnIkVrL8yBdeV3tYSKNNgpaMbOejmVlYk
         aLLxwbC4gu1l57+34iHHyoNG7q+ihuQcoHizamJznhLWJBn3oQjJJfAvI7P2VRYvnHyH
         PeUlvzfusXZaAwjhQ9RhOJ6SrYLUoK66PHCxjIS4UmDEF/Cnarkmjmsf+e+lSjWpxFmm
         ZwtQ+lQGMG7zUiBZ/xbEgNX1c7Fbj1QcFyPwtWGpdx4UXZO0pe6Guc1x8jQWR/a7Vjz1
         A5a8qC+VupK4mFBVrpF43TPh2WjpvXmYieS6CtU6daV8StgENGEIxd50vVYZL9/vKvjj
         fyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=7dZTN/SxKVctHI40TRCeIIt9my8nvY6DBUHYuF4x0XM=;
        b=ZPxkrcHmVbywWZnjU/8ITv0Mvk1WHd9c+UcABhOY4J6V08jTVaIptmB6uBXu8fjLwi
         rUFsrDZpY56CFWL2ZtDlfuN3hNJJ+Bb8hQ5Urm96gLu2nU78zR4hzT2MlaUdZl+vNT6N
         rQW8hLgsW6PQk/Gr5/ROjGfYeHe4chZFp+XsbC2Cu5XPR449rCKEjxVM1YCpqbibaGGg
         IcZwShbgeymYlax4EyR//J4LePKvE+a1DEzQFZrl4wwB/CsGyf0XgKMHn0tjR6PcvCMY
         eUkjs/n+mNwq9ASRyzhqpJd28hGLzMAxTASynpPdvSL0Y+ZuW922pNTDaT3dMZwd9163
         aEnQ==
X-Gm-Message-State: ABuFfojCTZGaXJ6UmYxjOzy45rhbxlrTS4qqtyhPzkVhl1hmICL8q9tA
        YOjFqRlT7KMuEUj3hSY+QpI=
X-Google-Smtp-Source: ACcGV63TvMWq7fhZW/oDD4ZQTLsdZxYjJECiTcYrK8S9TbSTwiGvq2CKIk/F9pfky7y8ks1BMbZNQQ==
X-Received: by 2002:adf:e842:: with SMTP id d2-v6mr428718wrn.175.1539243736725;
        Thu, 11 Oct 2018 00:42:16 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b81-v6sm17338267wmh.47.2018.10.11.00.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 00:42:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010150916.4295-1-lucas.demarchi@intel.com>
Date:   Thu, 11 Oct 2018 09:42:14 +0200
Message-ID: <87in29dj55.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Lucas De Marchi wrote:

> Do like it's done in grep so mode doesn't end up as
> 0160000, which means range-diff doesn't work if one has
> "submodule.diff = log" in the configuration. Without this
> while using range-diff I only get a
>
>     Submodule a 0000000...0000000 (new submodule)

I'm not familiar enough with this to tell what the real problem is
that's being solved from the commit message, but if it means that now
range-diff works in some configuration, presumably that can be reduced
to a simple set of commands that didn't work before but now does, and
therefore a test in t/t3206-range-diff.sh.

> instead of the diff between the revisions.
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  range-diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 60edb2f518..bd8083f2d1 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
>  {
>  	struct diff_filespec *spec = alloc_filespec(name);
>
> -	fill_filespec(spec, &null_oid, 0, 0644);
> +	fill_filespec(spec, &null_oid, 0, 0100644);
>  	spec->data = (char *)p;
>  	spec->size = strlen(p);
>  	spec->should_munmap = 0;
