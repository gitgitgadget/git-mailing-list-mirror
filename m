Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3641F453
	for <e@80x24.org>; Mon, 22 Oct 2018 04:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJVNLB (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:11:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46537 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJVNLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:11:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id i4-v6so4586408wrr.13
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 21:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lWYVns5vuCvCSDPNTGxOYm25AWzmGsNK+VhA5Bbf6lU=;
        b=Sk4ZJNLQ9sTmzRGtEfM1iuFPzQZkNwif4zg+xyGwZ08z1UB84CgPs8XtV61Av9QVnU
         aGb2r/9vq2Yce0geuAMeLlVHKImR+Ym7XMGNmMn4kmdUscttoe1qNAMYIiakrrp7QeZ5
         JDxGKPcoyQi8NJBw1sEB8WyTMtMJi2hrw1za7rXDDjjROynrnXplG3sB3C2LtOoNGg6S
         jWYcyjg7F4srGXhr92etJAigcwdSnlqK8DMZ2YYDqj5s5d8kIDTfNyvR+K+vuo6GDA3I
         DZ42X0q05jzcEhTaXtBfr8ySzESOnhGwWw+icZNED+kfwAYvWNeGDw/zeN7UHr/E++K/
         7bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lWYVns5vuCvCSDPNTGxOYm25AWzmGsNK+VhA5Bbf6lU=;
        b=NdvsytKOKeCUDv9+R1IsYnHm11O5vaof5InGY6L98xQlg38pZN/v9k3KZhscLvqALe
         UpZHJr4jcx1la5mtYqmx63Z+WhrSF4Lx04BJTQXqE/SWmG79QfTe6NQrBpjrV63b64Xc
         w4+2zuCxkohM/FBE+T4EMwzhw2B0tpA3sC5vU0NDJXawaJMTJVRdgNsQ+8f7GPLtkBSr
         8c5dZjpjMQUhw6CALxeNWwHpJPfnRsxE04hcdKglfl+SMRqYBRnhyh2IpLh1jCIKytpQ
         F9e6JTifrYbQOhriH3DbGO+FqXSCXdsJq+wFs1fg/SCXGApwMCosQ14TPkI+DnRF6ctu
         jzWg==
X-Gm-Message-State: AGRZ1gLmyF0l9HsxpYxshf7PVlyLqe5wnppoByBllx5RBtO5v+LiYiQI
        7SCCSkqQsHhzpqmSl2/DZWI=
X-Google-Smtp-Source: AJdET5eQM0E1QMxeJByqjHasgMHLyarPHqZs/b6aWQfeBgMHo2WUG3blgnxgL3KExrv537NL7FGTEA==
X-Received: by 2002:a5d:4a89:: with SMTP id o9-v6mr14011651wrq.132.1540184046798;
        Sun, 21 Oct 2018 21:54:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l140-v6sm14715203wmb.24.2018.10.21.21.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 21:54:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 2/2] worktree: add per-worktree config files
References: <20181002160658.15891-1-pclouds@gmail.com>
        <20181021140228.24941-1-pclouds@gmail.com>
        <20181021140228.24941-3-pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 13:54:04 +0900
In-Reply-To: <20181021140228.24941-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 21 Oct 2018 16:02:28 +0200")
Message-ID: <xmqqefciwphv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 552827935a..244560a35e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2,8 +2,9 @@ CONFIGURATION FILE
>  ------------------
>  
>  The Git configuration file contains a number of variables that affect
> -the Git commands' behavior. The `.git/config` file in each repository
> -is used to store the configuration for that repository, and
> +the Git commands' behavior. The files `.git/config` and optionally
> +`config.worktree` (see `extensions.worktreeConfig` below) in each
> +repository are used to store the configuration for that repository, and
>  `$HOME/.gitconfig` is used to store a per-user configuration as
>  fallback values for the `.git/config` file. The file `/etc/gitconfig`
>  can be used to store a system-wide default configuration.
> @@ -371,6 +372,13 @@ advice.*::
>  		editor input from the user.
>  --
>  
> +extensions.worktreeConfig::
> +	If set, by default "git config" reads from both "config" and
> +	"config.worktree" file from GIT_DIR in that order. In
> +	multiple working directory mode, "config" file is shared while
> +	"config.worktree" is per-working directory (i.e., it's in
> +	GIT_COMMON_DIR/worktrees/<id>/config.worktree)
> +

This obviously conflicts with your 59-patch series, but more
importantly

 - I notice that this is the only description of extensions.* key in
   the configuration files.  Don't we have any other extension
   defined, and if so shouldn't we be describing them already (not
   as a part of this series, obviously)?

 - If we are going to describe other extensions.* keys, do we want
   extensions-config.txt file to split this (and others) out and
   later rename it to config/extensions.txt?  Or do we want to
   collect related things together by logically not by name and have
   this extension described in config/worktree.txt instead, perhaps
   separate from other extensions.* keys?

