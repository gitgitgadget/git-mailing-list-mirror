Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B649208E9
	for <e@80x24.org>; Mon, 16 Jul 2018 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeGPScj (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:32:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbeGPSci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:32:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so32806609wrd.4
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PtqZeIAy2QvRH8X88wPJNUUVHkUO7kxnnv72iJ2Af0I=;
        b=hqkfT7bCdvOcgFKMl9ZqHR0X+mcuLoqguykoOAXSbd6Eij0cqDJKE6tP5HBQhZLMc8
         Fr1efh68+v5pYRmpQzpgnFuDlN5emqJeZz7Jj/3aphXJFVqAp0O+1X0A3TAGjWwpWAmy
         NBROmxxbtH8Le85YMhvR4EADgfZmycl/3FWAPtw8rHNDAU9RMHMPAnjV4xpVFshpDe5e
         yrY9q0t2A+cFMkYgcrLH0kHdAkrKmed187FRnMDIdwZM9PzstmcJXwsyyoqSVbfYw91L
         VQOl/qmVFkbfQvkjWv3dTjPxCz6r2+ME8DyY8Ku7sdzgGeo6QRE1zp1f5BrjLun+u2in
         30ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PtqZeIAy2QvRH8X88wPJNUUVHkUO7kxnnv72iJ2Af0I=;
        b=KGgCi++djuyC49bgE66Sdunp9rTI4tRFsJSjjL2HSNSBzZTqcGCHuiOvPQP+X7X0Ow
         FFoJqzFeKeVu68/36mP0h0f8veGrs/91shvERU8TQlkcvuTkAXd9TAzB9e6wOkMI/hcD
         GRd7DywxS3OnlIweRR/7F0xbdKn3x/J1WFatcByQN2hzG+AfHqMp8S9MWZi6Ojr2tQu1
         8MxTExwIC9GYh1DKpcB/tbRR/NNfQREntmE313QlLr+V+oN2qelTf/S9GN6flDr4Q6Vw
         Qi5+d1KqtHiWUvbfy78n/LsRPuPBEDQIjZ5Li5U4tBM+rrDwNXp9zd9cU07++MQJl4Qi
         iu1g==
X-Gm-Message-State: AOUpUlHG/zCA5DrCLHqqcayvLDyDN8T9c0fnTB/ZxQlvMc0/8BsRCF17
        HgJwx99HWR9fyHHD4YY4dg4=
X-Google-Smtp-Source: AAOMgpeYk64SvkSNuqmw2f6ze9vV4x0VB5phRi5xs/IQF2wzZrJL62CYzaMeZDXaxQ5o9vHj3I+jCA==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr13640555wrn.174.1531764245912;
        Mon, 16 Jul 2018 11:04:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w24-v6sm14810083wmc.15.2018.07.16.11.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 11:04:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsck: downgrade gitmodulesParse default to "info"
References: <20180713193759.GB10354@sigill.intra.peff.net>
        <20180713193958.GB12162@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 11:04:04 -0700
In-Reply-To: <20180713193958.GB12162@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 13 Jul 2018 15:39:58 -0400")
Message-ID: <xmqqwotvt5uz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>    site's support). And the broken .gitmodules may be too
>    far back in history for rewriting to be feasible (again,
>    this is an issue for cgit).

"again" but this is the first mention that hints cgit has some
problem (but not exactly what problem).  Is that the "cgit has a
file called .gitmodules that predates the submodule support on our
side?" thing?

> So we're being unnecessarily restrictive without actually
> improving the security in a meaningful way. It would be more
> convenient to downgrade this check to "info", which means
> we'd still comment on it, but not reject a push. Site admins
> can already do this via config, but we should ship sensible
> defaults.
> ...
> Considering both sets of arguments, it makes sense to loosen
> this check for now.
>
> Note that we have to tweak the test in t7415 since fsck will
> no longer consider this a fatal error. But we still check
> that it reports the warning, and that we don't get the
> spurious error from the config code.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.

>  fsck.c                     | 2 +-
>  t/t7415-submodule-names.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 4129935d86..69ea8d5321 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -62,7 +62,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>  	FUNC(ZERO_PADDED_DATE, ERROR) \
>  	FUNC(GITMODULES_MISSING, ERROR) \
>  	FUNC(GITMODULES_BLOB, ERROR) \
> -	FUNC(GITMODULES_PARSE, ERROR) \
>  	FUNC(GITMODULES_LARGE, ERROR) \
>  	FUNC(GITMODULES_NAME, ERROR) \
>  	FUNC(GITMODULES_SYMLINK, ERROR) \
> @@ -77,6 +76,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>  	FUNC(ZERO_PADDED_FILEMODE, WARN) \
>  	FUNC(NUL_IN_COMMIT, WARN) \
>  	/* infos (reported as warnings, but ignored by default) */ \
> +	FUNC(GITMODULES_PARSE, INFO) \
>  	FUNC(BAD_TAG_NAME, INFO) \
>  	FUNC(MISSING_TAGGER_ENTRY, INFO)
>  
> diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
> index ba8af785a5..293e2e1963 100755
> --- a/t/t7415-submodule-names.sh
> +++ b/t/t7415-submodule-names.sh
> @@ -185,7 +185,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
>  		git add .gitmodules &&
>  		git commit -m "broken gitmodules" &&
>  
> -		test_must_fail git fsck 2>output &&
> +		git fsck 2>output &&
>  		grep gitmodulesParse output &&
>  		test_i18ngrep ! "bad config" output
>  	)
