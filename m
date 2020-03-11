Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 9AA727D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgCKPlt (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 11:41:49 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:36167 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgCKPlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 11:41:49 -0400
Received: by mail-lj1-f174.google.com with SMTP id g12so2881323ljj.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=eskAK7XVS541xklNtIRqCgirnp0QCz5xunObG0pzI90=;
        b=jLFgD/NQT48Glgn2FOVjddI+SAWOhIwru081RNeJ/apvdT/OcXhjAdoTQND0wQUBgw
         KBFqnORVJjTPv3uuUtXRlrd+XKRzxDJO2LTVd0E76iVSuvYoKc8L5GGaaUsN6QshEWuw
         tO+XEaR+8zUjTuVvv5AwCLhC3RWzVBeq9+t37i1VpUHIfmYKsSVfqGSqJ4moGCNq6CwK
         uAOCZkAR/UiUZ4PiNchclyX3CNQNwozNnH4FCWT0pQIVoEUZMtG18OLdwuRBm0CMUB55
         rrLwvlvAFsxJ1z2Y4qWy0qNnTfPPkzHhg8n6R92xhiYlGS0Sdbzh64pBVTuI6Z0irvjl
         EJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=eskAK7XVS541xklNtIRqCgirnp0QCz5xunObG0pzI90=;
        b=KMxJGdG5VaLawUf8np8IfoFg0nwF2KdKBJnjABG2SeGaBrHaOVGsP2qR/ZTV621ivJ
         3vtaOOFE47WpiIhFejpDczFq1JapI1VBA7kmkljt2VFcWNAHzqrJkiAR8BBa5A0ZQ3r0
         +RV+NFKeqN9vYe8qFPylSxd4n0KFTxWBf5j/4jppj9FBTaxPyND2V/0MPITtWCUvGDYa
         NJYv/8Zq4sL8qhraUVkIvsFmvQrNm0aPQOUAK4ReJvCdF0jahTP8gvojs+m8qNJqLAJF
         bbABs3BBK7peImiTC9uM5vuTLbwozBXWVJgrt1pwoCfRwup8b/fmHUxYZOSYOsOngisp
         40IQ==
X-Gm-Message-State: ANhLgQ0e/oKR7P/CmY+9DUy2kuPH8dhtkn69uHrDU7Ub5KjiXCF/Wfyc
        8wTP1EWG6snd8AnVMXjHgY3hSw83SSOqCPgh0V6qe4lv
X-Google-Smtp-Source: ADFU+vvPD6NIwBZE7dyLY1X6QYwqwgjwB3D9p0FEMCxJtXipwAlRqy+iHvbWV9E/V0ZpY/sDSxp/zSQw9z86kPS8YLg=
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr2502475ljp.272.1583941307114;
 Wed, 11 Mar 2020 08:41:47 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 11 Mar 2020 10:41:36 -0500
X-Google-Sender-Auth: v-lwToJ3eKjuVtHwF7L1sqj_r-k
Message-ID: <CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com>
Subject: Using push.default with push.remote.push
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/CAHd499BhLe0xF_k2ASV=ZuM7LVvxui_cxzB9UrJ2MDCyyNUmtw@mail.gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

With the specified configuration:

```
[push]
    default = current
[remote "origin"]
    url = git@mydomain:myrepo
    fetch = +refs/heads/dev/john/*:refs/remotes/origin/*
    fetch = +refs/heads/*:refs/remotes/origin/*
    push = refs/heads/master:refs/heads/master
    push = refs/heads/*:refs/heads/dev/john/*
```

Given a currently checked out local branch named `my-feature`, how can
I make this command:

    git push -n origin

Behave semantically identical to this command?

    git push -n origin my-feature

The current behavior seems to be working as designed, but not as
desired. The first push command pushes *all* branches under
`refs/heads/*`, instead of just the current branch as it normally
would via `push.default` setting. It sort of feels like if a resolved,
explicitly defined `push.<remote>.push` config is found *and* it
includes wildcards, the `push.default` setting should still be
respected.

Are there any workarounds to getting the behavior I'm looking for?

Note my ultimate goal here is to transparently map local branches to a
branch with a prefix on the remote. But I do not want to explicitly
work with or see those prefixes locally. Basically
`dev/john/my-feature` on the remote should be `refs/heads/my-feature`
locally, and `refs/remotes/origin/my-feature` for fetches. The
push-without-explicit-refspec case is the only one I haven't gotten to
work as desired yet.
