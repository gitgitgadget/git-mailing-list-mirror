Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FC52023D
	for <e@80x24.org>; Mon, 22 May 2017 17:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759608AbdEVR5O (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 13:57:14 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34322 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758616AbdEVR5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 13:57:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so21516016pfk.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 10:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgSPH1jM+TMcDtFqpj78p3yibyYsBKMeRWvC/JB9ihk=;
        b=AI5eyv+s/QxMU728UYka/bvsNe64BAzl6R46aVL2ioGxXnuWKs0DOol0coNRPHFbht
         EAoVB28vO1R0J/6TE4i69vURkifs+MpQQjJuanM7r8Z2cEgLEZLLejNFu3s2usQHu37T
         PMsvYHFvUEFz6/++2FEDnIZwgp7BjHW7qmx7+MfjrqI/09WwGhFYVqnSH1W4TbXHNQiI
         r8pn/1I8htaE9K8NbqEHcIAeZX8Tfzt6Bplsezyqbyi3iji282QMYf/29l/I9DnsgBeH
         Y5xzo4RM/qP79g/V0V/8t4W6RxU9RqCvjjcTPK/k0FibZMJGPH1jVsi0fbu1BJpr7BnT
         50Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgSPH1jM+TMcDtFqpj78p3yibyYsBKMeRWvC/JB9ihk=;
        b=UkVZKk31mAbJdab3GWbrzR40esXAbdsR879XUFrrgu+OCJ9xsk4WBGeFiAvuNyJka7
         q5xCZlSedcnY/0+t/CVGkRdoFWPja9q7kzILmC+ULcfP+It0fU/IrbhYdjv+SSLVFEV9
         T70df5MPz+RoDqhMPq+1rlHeNiTKLNH+0Br2a2++bj7ZJB0X+zLrEqGlHzA10ox9YEau
         2Cd1P6e+nXHwBIsYroLf3F5bT2Y14s1DWvDptcB3U11PNwkeIb7JSIhf6d+W7a+n6R/A
         AG8sZYJIKCZDx8Y9fxsXKrQd+MpglE5FNrrIYGucvkWtg4O8IYFTkhVNvwCyzXu+LfSr
         V0Kg==
X-Gm-Message-State: AODbwcD79N9G1qWeodkb3MiiGewVaD0KTBMj1R1LvJdJCkqRoCNTkkPh
        5Bs8J/oC0Gl+Lg==
X-Received: by 10.84.175.129 with SMTP id t1mr30742535plb.190.1495475831856;
        Mon, 22 May 2017 10:57:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:557c:4659:8965:b134])
        by smtp.gmail.com with ESMTPSA id z14sm7058558pfg.109.2017.05.22.10.57.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 10:57:11 -0700 (PDT)
Date:   Mon, 22 May 2017 10:57:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v3 1/6] Fix build with core.autocrlf=true
Message-ID: <20170522175709.GC17710@aiede.svl.corp.google.com>
References: <cover.1493891336.git.johannes.schindelin@gmx.de>
 <cover.1494334366.git.johannes.schindelin@gmx.de>
 <6bc890b10de8a59f90005462f8767d6b022b0749.1494334366.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bc890b10de8a59f90005462f8767d6b022b0749.1494334366.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Pat Thoyts, git-gui maintainer)
Hi,

Johannes Schindelin wrote:

> On Windows, the default line endings are denoted by a Carriage Return
> byte followed by a Line Feed byte, while Linux and MacOSX use a single
> Line Feed byte to denote a line ending.
>
> To help with this situation, Git introduced several mechanisms over the
> last decade, most prominently the `core.autocrlf` setting.
>
> Sometimes, however, a single setting is incorrect, e.g. when certain
> files in the source code are to be consumed by software that can handle
> only LF line endings, while other files can use whatever is appropriate
> for the current platform.
>
> To allow for that, Git added the `eol` option to its .gitattributes
> handling, expecting every user of Git to mark their source code
> appropriately.
>
> Bash assumes that line-endings of scripts are denoted by a single Line
> Feed byte. Therefore, shell scripts in Git's source code are one example
> where that `eol=lf` option is *required*.
>
> When generating common-cmds.h, the Unix tools we use generally operate on
> the assumption that input and output deliminate their lines using LF-only
> line endings. Consequently, they would happily copy the CR byte verbatim
> into the strings in common-cmds.h, which in turn makes the C preprocessor
> barf (that interprets them as MacOS-style line endings). Therefore, we
> have to mark the input files as LF-only: command-list.txt and
> Documentation/git-*.txt.
>
> Quite a bit belatedly, this patch brings Git's own source code in line
> with those expectations by setting those attributes to allow for a
> correct build even when core.autocrlf=true.
>
> This patch can be validated even on Linux, by using this cadence:
>
> 	git config core.autocrlf true
> 	rm .git/index && git stash
> 	make -j15 DEVELOPER=1
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks again for writing this patch.  One bit of administrivia I
missed before:

Pat, would you mind picking up this .gitattributes change for git-gui?

Junio, how do you prefer to handle this in git.git?  Would you need to
amend the patch to remove the git-gui/.gitattributes change and wait
to get it from Pat, or is getting the same change twice okay?  If I
understand git-gui/GIT-VERSION-GEN correctly, then either way, once
you perform a subtree merge from git://repo.or.cz/git-gui the
"version" file will be okay.

Patch left unsnipped for reference.

Thanks,
Jonathan

>  .gitattributes         | 8 +++++++-
>  git-gui/.gitattributes | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitattributes b/.gitattributes
> index 320e33c327c..8ce9c6b8888 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,3 +1,9 @@
>  * whitespace=!indent,trail,space
>  *.[ch] whitespace=indent,trail,space diff=cpp
> -*.sh whitespace=indent,trail,space
> +*.sh whitespace=indent,trail,space eol=lf
> +*.perl eol=lf
> +*.pm eol=lf
> +/Documentation/git-*.txt eol=lf
> +/command-list.txt eol=lf
> +/GIT-VERSION-GEN eol=lf
> +/mergetools/* eol=lf
> diff --git a/git-gui/.gitattributes b/git-gui/.gitattributes
> index 33d07c06bd9..59cd41dbff7 100644
> --- a/git-gui/.gitattributes
> +++ b/git-gui/.gitattributes
> @@ -2,3 +2,4 @@
>  *           encoding=US-ASCII
>  git-gui.sh  encoding=UTF-8
>  /po/*.po    encoding=UTF-8
> +/GIT-VERSION-GEN eol=lf
