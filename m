Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474F720248
	for <e@80x24.org>; Sun, 31 Mar 2019 17:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfCaRkn (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 13:40:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43512 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731237AbfCaRkm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 13:40:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so8853073wrx.10
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+XrRLT8d4XCQ7youztRUDkII3w10BF2wipNk5SpMNzI=;
        b=bB/+G+raWs3NZh1PN2PClcba7A3RSe9OiLULalOvAZVa3ligVkuLCdRreW+PuoSZr8
         jsH2+3fxSOWXSqLnPuAfEdiqBz7QMR5FliK4k4htSphCtCSgddbHxtoJu4ha4P3qF1u0
         uNzpBzRgR3bGuNMEAGfQ+z54ocTPZ1GLVhqbM6rGHuQhS3KX0AlZ3u/VTrX3Ol7jmPox
         aWey2QPG34UCVnWRPo9hVYiWjoTXVqmF3tUdMT/72CNSr08bqT0nf6WK+FaJDFdsIlGT
         bATX390iRfIV9Nm053nDPQWBnLW9I8NpMvSmb1CRglRiZNfpwjusxr23hJ9omVynZR6I
         E2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+XrRLT8d4XCQ7youztRUDkII3w10BF2wipNk5SpMNzI=;
        b=r/I7MwWFfgRtNkPtSeTj0OlRld8SYKhAkLdQhnoy79XTj0tbtJ2CXoxTAHjVHqT2vy
         mBczg3gCpnDQFkDAyC4VBB8IqGCTROtkEwV6vN89vIPZSN55wE1frH0Xh+01szphcoKz
         JlgzyRDHq2tK/Isx/YZVLlCcxxeeN3ehi0Ty9Y0ANErVTjljjVjXK4lI37YgXIS8gv2w
         7S3cvdnjMJm8uUBGIPU+ksWGD8ecz+qHA2lD04rIYxQtD8NpQajOsfg4Qk31B1AYRqJH
         T0qV9fPK/UUh1h2F4AhgzWkz2Gp18uuyS993gJbvdvEBmeKccbHs075gl5bETaJ+R97V
         nrVw==
X-Gm-Message-State: APjAAAWSoYHEU+a87nwy62fYVRtDRZJOhW//QvsCjmG2DLTEbNXEOr3v
        DKQIOjvEH2dM6Y284y89s4s=
X-Google-Smtp-Source: APXvYqxV3VFjHOdvxoBAqATK4ZseSG1qrBK4SGfvMnWtvdefxbtukdZUn+LVfpWDOucbd7OEgo4Nhg==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr38897063wrr.145.1554054040848;
        Sun, 31 Mar 2019 10:40:40 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id z84sm11877556wmg.24.2019.03.31.10.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 10:40:39 -0700 (PDT)
Date:   Sun, 31 Mar 2019 18:40:38 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        kernel-usp@googlegroups.com
Subject: Re: [GSoC][PATCH v5 2/7] clone: better handle symlinked files at
 .git/objects/
Message-ID: <20190331174038.GS32487@hank.intra.tgummerer.com>
References: <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190330224907.3277-1-matheus.bernardino@usp.br>
 <20190330224907.3277-3-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190330224907.3277-3-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Matheus Tavares wrote:
> There is currently an odd behaviour when locally cloning a repository
> with symlinks at .git/objects: using --no-hardlinks all symlinks are
> dereferenced but without it, Git will try to hardlink the files with the
> link() function, which has an OS-specific behaviour on symlinks. On OSX
> and NetBSD, it creates a hardlink to the file pointed by the symlink
> whilst on GNU/Linux, it creates a hardlink to the symlink itself.
> 
> On Manjaro GNU/Linux:
>     $ touch a
>     $ ln -s a b
>     $ link b c
>     $ ls -li a b c
>     155 [...] a
>     156 [...] b -> a
>     156 [...] c -> a
> 
> But on NetBSD:
>     $ ls -li a b c
>     2609160 [...] a
>     2609164 [...] b -> a
>     2609160 [...] c
> 
> It's not good to have the result of a local clone to be OS-dependent and
> besides that, the current behaviour on GNU/Linux may result in broken
> symlinks. So let's standardize this by making the hardlinks always point
> to dereferenced paths, instead of the symlinks themselves. Also, add
> tests for symlinked files at .git/objects/.
> 
> Note: Git won't create symlinks at .git/objects itself, but it's better
> to handle this case and be friendly with users who manually create them.
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Co-authored-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c            |  5 ++++-
>  t/t5604-clone-reference.sh | 27 ++++++++++++++++++++-------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..f975b509f1 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -443,7 +443,10 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>  		if (unlink(dest->buf) && errno != ENOENT)
>  			die_errno(_("failed to unlink '%s'"), dest->buf);
>  		if (!option_no_hardlinks) {
> -			if (!link(src->buf, dest->buf))
> +			char *resolved_path = real_pathdup(src->buf, 1);
> +			int status = link(resolved_path, dest->buf);
> +			free(resolved_path);
> +			if (!status)

Is there any reason why we can't use 'real_path()' here?  As I
mentioned in [*1*], 'real_path()' doesn't require the callers to free
any memory, so the above could become much simpler, and could just be

+			if (!link(real_path(src->buf), dest->buf))

*1*: <20190330192738.GQ32487@hank.intra.tgummerer.com>

>  				continue;
>  			if (option_local > 0)
>  				die_errno(_("failed to create link '%s'"), dest->buf);
