Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D402D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 11:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbeFFLLn (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 07:11:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37670 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeFFLLm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 07:11:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id r125-v6so11047852wmg.2
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Bmj366S0KXC9QXY8/J+Wae/ip35FxspS4wT3fKCr+Lg=;
        b=HOnmA02WyJd22RSP49xt8gaqZoAJb2Y3xTLq58H47tGQKlFDCljbeKyYS/Zwx+3Vfh
         TFWAc3znGN4keNUX3DgDXpXOjgy2SNq88fUxkHtI7yv5xk7mbl/9a8cPJ/JRRYCpqM2s
         ILRLS30mKj/4Un23Ha6Z7uJ2vzwPwaqZCRHahhKNdpyqiqNb5L501hJHttR9rbz1D7dL
         iCES5K7Y13oboq6PQceuyGk4zdTkJ2Sch+Pk0gVNPEoK7hWVJ22zffo1D6i570uHhgg/
         Fib4oldos6MmwUsGGeMcoVxI4+3x1WMcg/ypMwV/AULVjCwInTg522FOthxIyKLafj2n
         8Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Bmj366S0KXC9QXY8/J+Wae/ip35FxspS4wT3fKCr+Lg=;
        b=DIRy9/3jPYWTOwyCM3KrnvMmgWfn4PyIN2Kx+eqoVuqnZszSTvW9s/KRkhaBkJfmR5
         NrrSm08dM4CLBC29K9ysHTyvsX3bw51xOoC431X7U4nZxQRVAeQbjpAhDSjg7NS6M7Lo
         qB0rYZpiGVN0g5vAJGDWSKuDtahBwpowlmqr6gwv5/2XbRfkmPsj+A8veJ2AOlUD+cuS
         dCAeH1FIwuKXUHOnopPvXexVrURLwYI3iWxCIAfutpvIZ2njknQODyZ8V5EGzxVTN7Nb
         gtHp246bpSCgH8iGwdpil92VUxqiLByqM5gFhT2K5rEh2H6zcGcQrlT5Fn1stKeYISRk
         jUvQ==
X-Gm-Message-State: APt69E39te4lBXxa4uf5NmgwYeKEmNO/gModx5VtPzYRlxirwfmMT+WS
        VpeKoGACeUcdESqRYi2gblM=
X-Google-Smtp-Source: ADUXVKKSH2B/SMV6y7hcfylkcuBtpTHN1dE684Y3HybqX/YQels2ZOLunddu1h1o1W1n8A7GjhE2Mw==
X-Received: by 2002:a50:d751:: with SMTP id i17-v6mr2426475edj.260.1528283501781;
        Wed, 06 Jun 2018 04:11:41 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id p57-v6sm28602647edc.21.2018.06.06.04.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 04:11:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "jnareb\@gmail.com" <jnareb@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "gitster\@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v4 20/21] gc: automatically write commit-graph files
References: <20180604165200.29261-1-dstolee@microsoft.com> <20180604165200.29261-21-dstolee@microsoft.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180604165200.29261-21-dstolee@microsoft.com>
Date:   Wed, 06 Jun 2018 13:11:40 +0200
Message-ID: <87in6wyxsj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 04 2018, Derrick Stolee wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 11f027194e..d2eb3c8e9b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -900,7 +900,8 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
>
>  core.commitGraph::
>  	Enable git commit graph feature. Allows reading from the
> -	commit-graph file.
> +	commit-graph file. See `gc.commitGraph` for automatically
> +	maintaining the file.
>
>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
> @@ -1553,6 +1554,13 @@ gc.autoDetach::
>  	Make `git gc --auto` return immediately and run in background
>  	if the system supports it. Default is true.
>
> +gc.commitGraph::
> +	If true, then gc will rewrite the commit-graph file when
> +	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
> +	'--auto' the commit-graph will be updated if housekeeping is
> +	required. Default is false. See linkgit:git-commit-graph[1]
> +	for details.
> +
>  gc.logExpiry::
>  	If the file gc.log exists, then `git gc --auto` won't run
>  	unless that file is more than 'gc.logExpiry' old.  Default is

Re my last E-Mail in
https://public-inbox.org/git/87k1rcyxxj.fsf@evledraar.gmail.com/
88258f58-c28f-0f74-a378-003704c41117@gmail.com and your reply in
https://public-inbox.org/git/88258f58-c28f-0f74-a378-003704c41117@gmail.com/
it seems what you've submitted here is the old version. E.g. this hunk
fails to apply to master because of the conflict with
gc.bigPackThreshold, which was merged in 30b015bffe ("Merge branch
'nd/repack-keep-pack'", 2018-05-23) .
