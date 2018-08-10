Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA41F1F405
	for <e@80x24.org>; Fri, 10 Aug 2018 03:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeHJFeR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 01:34:17 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:42569 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeHJFeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 01:34:17 -0400
Received: by mail-pl0-f47.google.com with SMTP id g6-v6so3405851plq.9
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 20:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZfA+gl/3g+anwCsl0mz6jajBX7wl/mdRPRvFtyuWKd8=;
        b=ANUKHDfAqqTtBIWbHebOgVXgE4ynGQmc2K6lO6SkmQ150fRaGH2HI6gHmCKFo+GD8S
         kn0vpeDIEj8tdCCJKCo9P8RQmUVIp/ByvpuJDai/lsrY1D6o/nAWsMwwnwc88VTewxPn
         BcY48TGVtnR5f6XNeTUI+3KlJXXms3jIypE0otiNsLGl4wxVRKEg7JZL0WgDTPgG0FoY
         bK1XKZ0Xgmaa5wkuXyej3lDiD21O7BpifRRvg40udu4iOwWJE0+jmXim3WaLzQWr5trA
         2ku6uBIjFOi23cPZV/vgHqj2VvCL71H/CgPn8fjMGAcmGFPS7Lyy64JBQd8q19L7rFk0
         qAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZfA+gl/3g+anwCsl0mz6jajBX7wl/mdRPRvFtyuWKd8=;
        b=GBO0XT3m8q8eORTA41zvGBImy21s0K+bU92HiXxB3wHKkuo8ejvCkMX82pug96zBc2
         KCqqt+637ixwUDMzAfDVSMNkrxR6eR7GHgJ+PuZKdPaEbSX+cHGcMpHUE/Ih+ZEdXK7c
         I+xQUVnKRrHlKHlBu+asPdKoFYngYcb/tMiHsY25JI5vV5UNqjecI+YZ31M07gzPY/Ib
         TQN3Yjo+YGScl/lmpvR7WqmSrPZL6qagshRe+DrN45AqlfAD/gDsi+Eqnah7NVgeq8SJ
         kBr+hF0vqUtV6vT2lzDDtjCDzU/QLPOgsE/9oKRweuO8m0k82V7+415sKd2Q0WE5tdeq
         oPUQ==
X-Gm-Message-State: AOUpUlGhv4AJdLw7zJQzChQqXQipyw1jzni4MN7sSd68/LsBd3lwImy0
        QVh4yrrm2kOIPhex4n+dk+M=
X-Google-Smtp-Source: AA+uWPyZF+DLuo+g+qu24AI78P2uUf+QO1zfKmnatuHZ1mIxzjDc+3Xq0Jo8c5mHt2jWPW+cRz6AaA==
X-Received: by 2002:a17:902:8494:: with SMTP id c20-v6mr4345173plo.336.1533870386951;
        Thu, 09 Aug 2018 20:06:26 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 14-v6sm18861773pft.93.2018.08.09.20.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 20:06:25 -0700 (PDT)
Date:   Thu, 9 Aug 2018 20:06:24 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathon Reinhart <jonathon.reinhart@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: 'git submodule update' ignores [http] config
Message-ID: <20180810030624.GA101965@aiede.svl.corp.google.com>
References: <CAPFHKzepqebXX7mrbeoc=+SHzWZ5N+6eOaLiC26tVGKogZoLGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPFHKzepqebXX7mrbeoc=+SHzWZ5N+6eOaLiC26tVGKogZoLGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc: Stefan, who has been looking at fetch --recurse-submodules recently
Hi,

Jonathon Reinhart wrote:

> I've narrowed it down to an observation that the [http] config seems
> to be ignored by 'git submodule update'. Shouldn't those options be
> respected by submodules?
>
> Given a .git/config file like this:
>
> ------------------------------------------------------------------------
> [fetch]
>     recurseSubmodules = false
> [http "https://gitlab.exmaple.com"]
>     sslCAInfo = C:\\Users\\gitlab-runner\\builds\\deadbeef\\0\\somegroup\\someproj.git\\CA_SERVER_TLS_CA_FILE
[...]
> C:\Users\jreinhart\testrepo>set GIT_CURL_VERBOSE=1
> C:\Users\jreinhart\testrepo>git fetch
[...]
> *   CAfile: C:\Users\gitlab-runner\builds\deadbeef\0\somegroup\someproj.git\CA_SERVER_TLS_CA_FILE
[...]
> C:\Users\jreinhart\testrepo>git checkout master
> C:\Users\jreinhart\testrepo>git submodule update --init
[...]
> *   CAfile: C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
[...]
> Note that the CAfile reverted to its default instead of using the same
> one from the `git fetch`.

Interesting.

The context is that "git submodule update" is simply running commands
like "git fetch" inside the submodules, and the repository-local
config of the superproject does not apply there.

In the long run, commands like "git fetch --recurse-submodules" may
chaange to use a single process.  It's possible that some of the
repository-local configuration of the superproject would apply at that
point, though the inconsistency would be confusing, so probably not
these particular settings.  Anyway, that's a faraway future; today,
"git fetch --recurse-submodules" is also running "git fetch" commands
inside the submodules, and the repository-local config of the
superproject does not apply there.

Would it work for you to put this configuration in the global config
file ("git config --global --edit")?  That way, it would be used by
all repositories.  If you want it only to apply within the testrepo
directory, you can use conditional includes --- something like:

  in $HOME/.git/config/testrepo-ca:

  [http "https://gitlab.example.com"]
  	sslCAInfo = ...

  in $HOME/.git/config/git:

  [includeIf "gitdir/i:~/testrepo/**"]
  	path = testrepo-ca

Thanks and hope that helps,
Jonathan
