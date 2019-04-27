Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8F91F453
	for <e@80x24.org>; Sat, 27 Apr 2019 13:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfD0NnV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 09:43:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41822 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfD0NnV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 09:43:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so8467701wrt.8
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1gBOOzlTaQyvhnTuZole+sCnJ3Sk0RtFuLrTqCPb4q8=;
        b=peS5RophjnBCuqtzQ1+ICwSv9an7Vlk0L6z9DxuS692tSFAYQ8CyX3xCXUiajJw4hO
         nPrWWVeXoyJpkU4Ny3NiQ73SmlTP8+2FIDuomTFnjEQYiv5c1KSP9N0LygxK49TE3FCE
         aX/3/JwzzlhxBScgCFMKzw2L0pY+QdURfVkjoNIWcAosOMVLk+2QOwBjY5oEAgnQHGL4
         9b3jA6ZietgNJRUDoiDD2Sr6eWTFnLSySxc29Vs0+SgLA+o9XU8xba4oqcJbwomzhETt
         VfoxQSm6ZSWL3hkygvORLOm0AmSR83xJue9GfhiM+8WVFVLUYz2TmEDIzUAt+0P9A20B
         87aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1gBOOzlTaQyvhnTuZole+sCnJ3Sk0RtFuLrTqCPb4q8=;
        b=AFpEN215a3YqLL4OJ34R6ma/cvNo1oG/OXwTZoOYHzW0Osoe63Dln66HZu6bZZ9tqK
         7M/Ondj3D9spuUg+Dlik9wnTp2341rbr6jYipKtAWYI00Iy9u/+7HMOyyEcPjAOmknWB
         /RWgFLTDweF03mkY+/vvEZVbTGOOJnGefU1978nY25Cy5x6JStmfpetlh7h6HVf3bH5Q
         63TLsgZujaMWNKsvPetu0A0NCc+7lz4V9kkSmtiiEdgoxOdOJ2fuWpcx+O7G5/TccbMC
         MR3WU1nbBUBAUzjL/q5TUlxAjV+JWFcU5ic11KHsa2fU3tkKth7H3MD39PpGD4ipMCTz
         1l+g==
X-Gm-Message-State: APjAAAWShnMWsuPVg736otRlnAXKhlAb4l6Y9HpnS/mIQ++PZt9okuuu
        JA1B0M/VuPDhmBfpdF9A5sA=
X-Google-Smtp-Source: APXvYqy5XRiRL5h2DOrD+8IK42uldrnCJE0nQ8SdGXrtRovTJsxwSpH/OJrVEqUJLUVTqAqvb2OrOQ==
X-Received: by 2002:adf:8068:: with SMTP id 95mr21408507wrk.174.1556372599807;
        Sat, 27 Apr 2019 06:43:19 -0700 (PDT)
Received: from szeder.dev (x4d0c5ca7.dyn.telefonica.de. [77.12.92.167])
        by smtp.gmail.com with ESMTPSA id z19sm23133249wml.44.2019.04.27.06.43.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 06:43:19 -0700 (PDT)
Date:   Sat, 27 Apr 2019 15:43:16 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, steadmon@google.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 06/10] trace2: use system/global config for default
 trace2 settings
Message-ID: <20190427134316.GE8695@szeder.dev>
References: <pull.169.v3.git.gitgitgadget@gmail.com>
 <pull.169.v4.git.gitgitgadget@gmail.com>
 <550cad618923c6e5aa1bd5f901f2968791d7566b.1555360780.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <550cad618923c6e5aa1bd5f901f2968791d7566b.1555360780.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 01:39:47PM -0700, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Teach git to read the system and global config files for
> default Trace2 settings.  This allows system-wide Trace2 settings to
> be installed and inherited to make it easier to manage a collection of
> systems.
> 
> The original GIT_TR2* environment variables are loaded afterwards and
> can be used to override the system settings.
> 
> Only the system and global config files are used.  Repo and worktree
> local config files are ignored.  Likewise, the "-c" command line
> arguments are also ignored.  These limits are for performance reasons.
> 
> (1) For users not using Trace2, there should be minimal overhead to
> detect that Trace2 is not enabled.  In particular, Trace2 should not
> allocate lots of otherwise unused data strucutres.
> 
> (2) For accurate performance measurements, Trace2 should be initialized
> as early in the git process as possible, and before most of the normal
> git process initialization (which involves discovering the .git directory
> and reading a hierarchy of config files).

Reading the configuration that early causes unexpected and undesired
behavior change:

  $ sudo chmod a-rwx /usr/local/etc/gitconfig
  $ ./BUILDS/v2.21.0/bin/git
  usage: git [--version] [--help] [-C <path>] [-c <name>=<value>]
  <... snip rest of usage ...>
  $ strace ./BUILDS/v2.21.0/bin/git 2>&1 |grep config -c
  0
  $ ./git
  fatal: unable to access '/usr/local/etc/gitconfig': Permission denied
  $ ./git --version
  fatal: unable to access '/usr/local/etc/gitconfig': Permission denied

I think at least 'git', 'git --help', and 'git --version' should Just
Work, no matter what.


This breaks the 32 bit Linux build job on Travis CI, because:

  - In the 32 bit Docker image we change UID from root to regular user
    while preserving the environment, including $HOME.
    
  - Since $HOME is the default build prefix, Git will look for the
    system-wide configuration under '/root/etc/gitconfig', which fails
    as a regular user.

  - Our test harness checks early (i.e. earlier than setting
    GIT_CONFIG_NOSYSTEM=1) whether Git has been built successfully by
    attempting to run '$GIT_BUILD_DIR}/git', which fails because of
    the inaccessible system-wide config file, and in turn the harness
    assumes that Git hasn't been built and aborts.

  https://travis-ci.org/git/git/jobs/524403682#L1258

