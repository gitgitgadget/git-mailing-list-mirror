Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6219D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 09:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJPR3z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 13:29:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39494 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPR3z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 13:29:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so20640369edq.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VxZdLqMLPwbgsDXZzk6SFpgUA1U6LJ0bQ+8mmrolnZk=;
        b=EhNadtsKBpdbfl7Oggvs6T/tgT4ZziXqcVSE1Q0PPNhBRRr6QXvdEv9sSYQ/3ITnGf
         hkJsdLXKFQvnB1BzQojfa4MERh7vcSlpBH4PBDLCwrSSRRpd+bZj4bNxYMBSP6aga9EL
         hAh5ObP80YT+Oxjo3XzZgvBKMIgxB0zvon0uFN65YbHg9GnkxerM2+MY+f4k5gbsQrfp
         jHThoK5IZXLzo2Gluh+Oy5d+0oOV2oEcyiSjtKuuuf73IepACuFgTkrF+owS6/1ZnTqj
         PjgclHmHoWSnig63W+UyqxgL7laNKpJmO+VHd5jrGXKTMXpqs1oa2g/13VECvAtxbp8Z
         Pmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VxZdLqMLPwbgsDXZzk6SFpgUA1U6LJ0bQ+8mmrolnZk=;
        b=gFVMlOdMRYxOW8qpShrgQODs+w3P0ZEEd0TW8ijK+Soa+zrlIYMC2s4ggJRJO+QG7m
         Qfs/C6RmUBovytMAdrnHzxS0hkuGS53B8+4KC/FcURHlwuJ8JiS05W3+jfj+rc1HwfIO
         FTjAtVebpYs0iDM4YQjRvWPsiX6njmsXxaSWEJ1Dq+AO6EEsJDCK78/kA6O7yZPpmF/l
         daVn6gOGB2IQRwb7Cg2occY7bd8l8zKBfuAfNeLbG5cl49c01Z3LF0VKHJTxcdoIMYhY
         U232IWixh/u1SthUIXWSs3m70RaRPdfXY2jOsh/lk6x/psjjOs1DlASVh+U1LDAQLkJg
         76Qg==
X-Gm-Message-State: ABuFfogYTdNaooDCi5QZsWzPKR6CYHTook7Ms5QD3iN9LLifpBpNWKSb
        Njr483+VhxbVFGBTP3KevJI=
X-Google-Smtp-Source: ACcGV61cZyC+wrdvSR3Ap4IsYeB8URKpyRwFbcC9cr+xl7huMxImlC1Jy+vofRKJfpOnrzatygu1MQ==
X-Received: by 2002:a17:906:454b:: with SMTP id s11-v6mr22488372ejq.83.1539682819060;
        Tue, 16 Oct 2018 02:40:19 -0700 (PDT)
Received: from szeder.dev (x4d0caaf1.dyn.telefonica.de. [77.12.170.241])
        by smtp.gmail.com with ESMTPSA id n40-v6sm3628284edn.30.2018.10.16.02.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 02:40:18 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:40:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 13/13] travis: fix skipping tagged releases
Message-ID: <20181016094016.GI19800@szeder.dev>
References: <pull.31.git.gitgitgadget@gmail.com>
 <pull.31.v2.git.gitgitgadget@gmail.com>
 <0a53f371350146ecd01b44f0f42da447d7573689.1539598316.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a53f371350146ecd01b44f0f42da447d7573689.1539598316.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 03:12:17AM -0700, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When building a PR, TRAVIS_BRANCH refers to the *target branch*.
> Therefore, if a PR targets `master`, and `master` happened to be tagged,
> we skipped the build by mistake.
> 
> Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
> when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
> known as "push builds").

This all makes sense, but this patch is fixing a long-standing issue
in our Travis CI build scripts (present since 09f5e9746c (travis-ci:
skip a branch build if equal tag is present, 2017-09-10)), so it
should be the first in the series.  So it could be picked up and
perhaps even graduated faster than the rest of this patch series.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 584abcd529..e1858ae609 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -3,7 +3,7 @@
>  if test true = "$TRAVIS"
>  then
>  	# We are running within Travis CI
> -	CI_BRANCH="$TRAVIS_BRANCH"
> +	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
>  	CI_COMMIT="$TRAVIS_COMMIT"
>  	CI_JOB_ID="$TRAVIS_JOB_ID"
>  	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> -- 
> gitgitgadget
