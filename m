Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBA71F42D
	for <e@80x24.org>; Wed, 30 May 2018 15:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeE3PhH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 11:37:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41014 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeE3PhG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 11:37:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so5002730lfa.8
        for <git@vger.kernel.org>; Wed, 30 May 2018 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yuJAq+CJjvHypCw7KMCKLIY8bDVLYIoLEG4MKJnIaFk=;
        b=ZrjZvEJWLORS/7y8ucP1esDpr9RpZzJxzdcZ0urypSOFK4s8z4fZIywNlZGcd8IrIY
         xKEg+t4PUewOUgyWIemAB0vr9cNcJhpx7rA8p2rqraondId8ibEAZrXiTlZ1nTQd5+Fx
         q1CyIDDAONaZqL398q5YClJ5lQIlPldnZ+e99yAcNiVrmqZEgVxYSyh1YWacU7AhACyS
         ZyNGHwjhqJAhMo4/v42+iBb1RQ52wxKvSgKfqWjNNG4vLJN4sfM8HOkTBPe8RBYgQeTR
         M5TzLkb7t9vnIW9HfvSe7lukBQ/8sqv/CgS0GM+9HNIwZ2HBWRZHTujoVvpjtIG0JDeJ
         t9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yuJAq+CJjvHypCw7KMCKLIY8bDVLYIoLEG4MKJnIaFk=;
        b=FMdUljyf7zaF+QXpE4+0SgCQtWhN98D2gEsiHPQ4tqMThlHoqCqNdq66rYC5J+oTRL
         DmHHJuqd7Rhk8GMVEQdPh/GadKFSJf2RTccFujH+u1J9maHkZxgaXCtiL866Rs2W5xvF
         YJHpqsPs8haATaxQLLIyhbCaGekH0v6VAUhpR0fXtyb7yeGCMWE3gla42Lr6PbF7x0w6
         qxZZoaqEXfNR6CM7bn59ulH1FPDmSFPwO42shW7pNs4QrEzIWPdDx5O6dUSTjhi8fOy1
         SEgp7NKmB+Kf0JoV9TV/O5JzeFGiDUJTg8CNwgaZDxUCppt2x/7sPH8erA0kg++oC5oe
         Oo6w==
X-Gm-Message-State: ALKqPwfuctSXJeD16VyWABwzgO+W2YzevW8G/VbhZvj+zrlwjfM80JD0
        qR77MBOpMwWmTxoLOMFJKjU=
X-Google-Smtp-Source: ADUXVKLwrJcrUcfFj74WJTqF12Ai7uC8S5FJ4McnBBNpBYWthnv2O6S/hDj4vpSvvDN1YZt/R4eS0g==
X-Received: by 2002:a19:ef11:: with SMTP id n17-v6mr2176712lfh.66.1527694625330;
        Wed, 30 May 2018 08:37:05 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u14-v6sm6482977lfk.55.2018.05.30.08.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 08:37:04 -0700 (PDT)
Date:   Wed, 30 May 2018 17:37:01 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: complete remote names too
Message-ID: <20180530153701.GA23809@duynguyen.home>
References: <CGME20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90@eucas1p2.samsung.com>
 <20180525104842.2930-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525104842.2930-1-l.stelmach@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 12:48:42PM +0200, Łukasz Stelmach wrote:
> "git remote update" accepts both groups and single remotes.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 961a0ed76..fb05bb2f9 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2632,7 +2632,7 @@ _git_remote ()
>  		__gitcomp_builtin remote_update
>  		;;
>  	update,*)
> -		__gitcomp "$(__git_get_config_variables "remotes")"
> +		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"

Reviewed-by: me.

The short commit description actually made me curious, which led to
more digging and finally this follow up patch.

-- 8< --
Subject: [PATCH] remote.txt: update documentation for 'update' command

Commit b344e1614b (git remote update: Fallback to remote if group does
not exist - 2009-04-06) lets "git remote update" accept individual
remotes as well. Previously this command only accepted remote
groups. The commit updates the command syntax but not the actual
document of this subcommand. Update it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-remote.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 595948da53..dd38587168 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -186,8 +186,8 @@ actually prune them.
 
 'update'::
 
-Fetch updates for a named set of remotes in the repository as defined by
-remotes.<group>.  If a named group is not specified on the command line,
+Fetch updates for remotes or remote groups in the repository as defined by
+remotes.<group>.  If no group or remote is not specified on the command line,
 the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true will
-- 
2.17.0.705.g3525833791

-- 8< --
