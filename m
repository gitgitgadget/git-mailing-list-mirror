Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7DB1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeDWRrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:47:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38187 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932202AbeDWRrf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:47:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id b5so8883130pgv.5
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/jrDvMOmTY8sXeo+MeuAyoLCqXs9JJXy+AkuuSLQlU=;
        b=i8gNHjWVd9iIA+i6T8x8XLSjzkwLg7UJvVaKdDduYZ4XBbTIwcaKs6sTKsRE0gaOdI
         NVFdKwVyuInbmfaHSBo4E4lpSIlsaJi76dl5scafECeC2SHIrnK71v4l9wb0rxZ4A+8z
         9sGGHHZaD3qBSpZa7g/rBixAALkV3BERPmzS10wvC1eGO3ALh6TCM62gPxsJNkn05iu6
         oks7SccuVmtEjSCkZh9uZ4SEDdzT9jKnl4cILXyW2G4UcthMmnYONTM8o4a+qRiE4/8H
         F8xy9+cTi4cvLTQRNcSp/xjN/tkiErarO6IeFOg3IVIEdfjg/kIsKDM0xKVWvdLp4F1b
         RH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/jrDvMOmTY8sXeo+MeuAyoLCqXs9JJXy+AkuuSLQlU=;
        b=ZptL1fBN5I3X9+v2f6TSgFRBvNtOLpjay5hTVAuI19SMVTgje5rs5LKiSuid0c7dxC
         fl0GTKKcEICPMwIKQDN2CUjYTqnzqP+YqL94D+itYXvNSXt0FFZB8UrE//L58KU2XB4V
         8bxdRi3fK1FIVAITolmK3Khd5B90dKFqdaTBEiWoS6D1GZtZDETOspPVcgnOxhDzAo+3
         96OrYuwq6IHWbg2B4g24/Uyz4+t4kSZq4ByJJU6/v2dqiBy7+6Jz8H5x8efRXfCNolb2
         u1HuYxkD69h56jWU5cVmA53rKB6DR0GBHGNXHBNcK29vcXMaoWXMiFc/HnJjoBTJ21wk
         YubA==
X-Gm-Message-State: ALQs6tDoRZmHKG0KV9ykqPFCCKmhTFspcq0NzHnAH/dlEnuWnPeQEqBR
        77S4xRgPL7/kESDiSxS8w+Q=
X-Google-Smtp-Source: AIpwx48oiIbX6kC+tUtvlsQqcGl5NiywlzHztiboJqNx1GrMbCpbG4aL2LxpqpVlVKmJr4dZOHBZnQ==
X-Received: by 2002:a17:902:b691:: with SMTP id c17-v6mr22078987pls.192.1524505654508;
        Mon, 23 Apr 2018 10:47:34 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w134sm26571761pfd.132.2018.04.23.10.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 10:47:33 -0700 (PDT)
Date:   Mon, 23 Apr 2018 10:47:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
Message-ID: <20180423174709.GA25128@aiede.svl.corp.google.com>
References: <20180412222047.5716-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Antonio Ospite wrote:

> vcsh[1] uses bare git repositories and detached work-trees to manage
> *distinct* sets of configuration files directly into $HOME.

Cool!  I like the tooling you're creating for this, though keep in mind
that Git has some weaknesses as a tool for deployment.

In particular, keep in mind that when git updates a file, there is a
period of time while it is missing from the filesystem, which can be
problematic for dotfiles.

[...]
> However when multiple repositories take turns using the same directory
> as their work-tree, and more than one of them want to use submodules,
> there could still be conflicts about the '.gitmodules' file because git
> hardcodes this path.
>
> For comparison, in case of '.gitignore' a similar conflict might arise,
> but git has alternative ways to specify exclude files, so vcsh solves
> this by setting core.excludesFile for each repository and track ignored
> files somewhere else (in ~/.gitignore.d/$VCSH_REPO_NAME).

For reference:

	core.excludesFile
		Specifies the pathname to the file that contains
		patterns to describe paths that are not meant to be
		tracked, in addition to .gitignore (per-directory) and
		.git/info/exclude. Defaults to
		$XDG_CONFIG_HOME/git/ignore. If $XDG_CONFIG_HOME is
		either not set or empty, $HOME/.config/git/ignore is
		used instead. See gitignore(5).

Using this as a substitute for <worktree>/.gitignore is a bit of a
hack.  It happens to work, though, so reading on. :)

[...]
> So this series proposes a mechanism to set an alternative path for the
> submodules configuration file (from now on "gitmodules file").

I am nervous about this.  I wonder if there is another way to
accomplish the goal.

One possibility would be to handle the case where .gitmodules is
excluded by a sparse checkout specification and use .gitmodules from
the index in that case.  Would that work for you?

Thanks,
Jonathan
