Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72605C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 16:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbiEJQQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 12:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347193AbiEJQP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 12:15:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3653A8CCC2
        for <git@vger.kernel.org>; Tue, 10 May 2022 09:12:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v11so3134295qkf.1
        for <git@vger.kernel.org>; Tue, 10 May 2022 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baller-tv.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lThnsPuhjoo4WpXI9p++ZUXzuLJfZhihaNSLdCTReCI=;
        b=mUq2vIFs5njV0RcW9GSfYban/PrFVpu/q0pH7Z753VcXBzEvp7+ZqY3Uyhqde7eEaA
         DySDPNFzQ3yu+mtLBAc1sF0hiAMHVswISZ+ifpTP6YgMJyo3weW7g5c1AIEroCEM2uSN
         pfOLruDQ5n8Rdhy+VmEOCdrOoJ4iC+kJ740rlyH1vIEBRc7NxSKPxJCfZMuCWw3TlhPl
         fpm9oFASSDyjrl+GLqQ7rvSXlH4kX9VqtfFS+URT6cP0qq5QoVug6CDe1/rY2gRFBJLi
         eJg2zw8CnOuiS8vYfG0KQw2tIAb3dFadu1ZDqiWyaelJGB+o8Ij2DeaK7jYyUB2cFFFT
         aW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lThnsPuhjoo4WpXI9p++ZUXzuLJfZhihaNSLdCTReCI=;
        b=72Ci3dDzQE8faGtllR3A5FUjUVTgU+Pkm990ZQivgkhKHFij8NQzpxygFBJ2LbS7DN
         UbmLWLyeiAAqg/dRnbX+IwEyMB+81T39gGVZBFmPhosv7B9E2yOJ7eySzxjq1ufxWJ9J
         K+SIOfgCALScDEAeaQZvSg1EcfRVjzO2MlKwR5NWbQtkFL+QxAkyBJoRqARAIEOuelxj
         lbWG1JQYRQmpvRU54XK4olR5r3pluDYPvjDd01w1vujKZRrtZjLgrllD8uthVp2fbBUu
         rgKuJ+o48cIhkYbe7uE5P4dYlmkoKPJu7Ll4T7KBmoo2rJs5j1XPxIRdSaIa0orlwc6F
         vckA==
X-Gm-Message-State: AOAM533GRuPmKltKsO5uEqu1kcR8A5gcKRZknoK+ZSKQ44gXO/Pr1QSH
        6w12ih2H8o3PuRjIEzJ9ymgXYUZlJLcJiX6bFptWM9DgizHh5Q==
X-Google-Smtp-Source: ABdhPJwlsMg4GQX93SKnPY/XLuPmyji5CLuT9+MhDEBJuR8E4c+L7cu/zr+AWXDfn0E6oS5W8RjVtJ5B0a1MR4gFqjI=
X-Received: by 2002:a05:620a:2949:b0:6a0:395f:c4b0 with SMTP id
 n9-20020a05620a294900b006a0395fc4b0mr15558176qkp.3.1652199119177; Tue, 10 May
 2022 09:11:59 -0700 (PDT)
MIME-Version: 1.0
From:   Addison Klinke <addison@baller.tv>
Date:   Tue, 10 May 2022 10:11:48 -0600
Message-ID: <CAE9CXuhvqfhARrqz2=oS1=9BF=iNhGbJv7y3HmYs1tddn8ndiQ@mail.gmail.com>
Subject: [FR] supporting submodules with alternate version control systems
 (new contributor)
To:     git@vger.kernel.org
Cc:     Addison Klinke <agk38@case.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm familiar with opensource software development through Github, but
have not contributed to git before so apologies if I'm using the wrong
avenues. Please point me in the right direction if that is the case. I
saw this mailing list mentioned on the
[mirror](https://github.com/git/git) repository, so it seemed like the
right place to start.

I have a feature request I'd like some feedback on. The core idea is
to support submodules with alternate (i.e. non-git based) version
control systems.

* **Why:** Git is excellent for versioning code and I don't need
another VCS for that purpose. However, in machine learning (ML)
workflows it has become more
[standard](https://opendatascience.com/how-data-versioning-can-be-used-in-machine-learning/)
to version your datasets, and for this purpose many git-like tools
have been developed. See [Dolt](https://www.dolthub.com/),
[LakeFS](https://lakefs.io/), and [DVC](https://dvc.org/) for a few
examples. Currently, ML practitioners have to bifurcate their
development process - code is committed/managed with git and datasets
are committed/managed with a 3rd party VCS (and often cloned in a
different folder outside the git repository). My proposal is to unify
the data versioning tools with git submodules so that they can act as
any other 3rd party library inside a parent repository

* **How:** Most data versioning tools already define a git-like CLI.
For instance, you have "dolt commit", "dvc push", "lakectl diff", etc.
The set of commands and options is usually a subset of the full list
available in git, but the important ones are there. My approach would
require a few steps

1. Git defines an API for configuring 3rd party VCS tools. It's
essentially a mapping from git command to the equivalent in the 3rd
party library. This should also account for which options/flags are
supported
2. Developers from the 3rd party library integrate with this git API
by maintaining a config file for the mapping that gets installed
alongside their binaries
3. The .gitmodules syntax is extended to include a "type" field which
defaults to git but can be set to other supported values
4. Then end-users can add submodules with an alternate VCS. Once
added, the CLI interaction would appear like normal git but under the
hood it would be using a different engine (and remote storage)

Is something along these lines feasible? If so, could someone who is
more familiar with the code base give me a rough idea how one might go
about this? I would like to author the PR to implement this - just
looking for some help getting started.

Thank you for the help,

Addison
