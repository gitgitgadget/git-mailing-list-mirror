Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF283202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbdJTBoA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:44:00 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:56411 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdJTBn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:43:59 -0400
Received: by mail-qt0-f177.google.com with SMTP id z28so16780703qtz.13
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9nJLHB2Jglog/xSdW0mcKPmKOk5JE46JF6S9RHFjmIU=;
        b=jreMPkWWyNOjKgm63t0pjUZ3tjhk5mL4gTPslY5+tW3hCTnUDPwn/n+TbkYsRSafbv
         3dDtRZYsXd+oiU8D67JY4YXdAAftdJ6SanzpekkPVyI37Ph3TWOgMTXf35Lt1gWrn7RP
         B/TcD1drrH9ORK4G92V584IPAg0YPsQCkagoE35uKi2PHNndGytGUdGO4XAbKqp/fp5o
         AlqUxn0rM3ayrbYt4+49LIQi+b2VkzAv66hVzrLqwP75U9UtHka/JKubhhvigskZYCwT
         KqA33A/K2IHec/9Ta2wpT7AXXXOi5eoC+E+YfNkiHfUUvnP7MNK5dpk61T5k3Po8pCPr
         bWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9nJLHB2Jglog/xSdW0mcKPmKOk5JE46JF6S9RHFjmIU=;
        b=MvKdCTgZmAT3Ermbr3TZsVUU1DQ+v8q09hyhaeyKATFAuj5OWq0Q8mvEHS2OCnOkUK
         02CzNm2/3I96s4If8htnUh7OzpE5tOFwhzGgMJToWWiE3X6R7NSvGrG6xWQAIudcy/AG
         TFwLnhGQrNQHEmu1PcNDeDwWrAgipBCU6aKxk1AmItJ+nf61K2KVay6DW8hER2IL1Ujk
         9QvSzO8HmVfX8BEYeTvL755aTkNnsUP5t+vQH0bArrI5TlxrjJU2f0LvJ+NG55CFYHk9
         P7jKPtn0bGrRCaEGklCjswaLnjU8DHG4pIR8wdZvu9fUI+Z2Vt/ZKkH7xc86pKJzVW/B
         HkeQ==
X-Gm-Message-State: AMCzsaX/+alrFo9HpQq42X3Y0FTapTlhG3AJRYyQKjZq9C5/suu4Byur
        Con77CVa+CwoEefF+IWgukVRlfC9VeceT0WCFy/TMIF3B7I=
X-Google-Smtp-Source: ABhQp+T1V1rfhmXxSD096TA0zTwkDutwLJu/3niPH3VRt3yR7yS1Hm7dStncfKUTkN6L8rhTNpAHu210lUw7lwlU3WA=
X-Received: by 10.200.47.77 with SMTP id k13mr4562223qta.298.1508463838509;
 Thu, 19 Oct 2017 18:43:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 18:43:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 18:43:57 -0700
Message-ID: <CAGZ79kYP0z1G_H3nwfmSHraWHMBOcik5LepUXKj0nveeBrihiw@mail.gmail.com>
Subject: "Cannot fetch git.git" (worktrees at fault? or origin/HEAD) ?
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I ran "git fetch --all" inside git.git that you are all familiar with.
All fetches failed with a similar error as:
Fetching kernelorg
fatal: bad object HEAD
error: https://kernel.googlesource.com/pub/scm/git/git did not send
all necessary objects

error: Could not fetch kernelorg

Working with an older version of Git (2.13.0) gives me

$ GIT_TRACE=3D/u/trace GIT_TRACE_PACKET=3D/u/out git fetch git://github.com=
/git/git
From git://github.com/git/git
 * branch                  HEAD       -> FETCH_HEAD

After fiddling around and some printf debugging,
clean fsck(!)
I could not make sense of it, so bisecting

$ git bisect bad
d0c39a49ccb5dfe7feba4325c3374d99ab123c59 is the first bad commit
commit d0c39a49ccb5dfe7feba4325c3374d99ab123c59
Author: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date:   Wed Aug 23 19:36:59 2017 +0700

    revision.c: --all adds HEAD from all worktrees

    Unless single_worktree is set, --all now adds HEAD from all worktrees.

    Since reachable.c code does not use setup_revisions(), we need to call
    other_head_refs_submodule() explicitly there to have the same effect on
    "git prune", so that we won't accidentally delete objects needed by som=
e
    other HEADs.

    A new FIXME is added because we would need something like

        int refs_other_head_refs(struct ref_store *, each_ref_fn, cb_data);

    in addition to other_head_refs() to handle it, which might require

        int get_submodule_worktrees(const char *submodule, int flags);

    It could be a separate topic to reduce the scope of this one.

    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

And here we go, I do use worktrees nowadays!
$ git worktree list
/usr/local/google/home/sbeller/OSS/git                   117ddefdb4
(detached HEAD)
/u/git                                                   d0c39a49cc
(detached HEAD)
/usr/local/google/home/sbeller/OSS/git_origin_master     b14f27f917
(detached HEAD)
/usr/local/google/home/sbeller/OSS/submodule_remote_dot  3d9025bd69
(detached HEAD)

$ git show 3d9025bd69
fatal: ambiguous argument '3d9025bd69': unknown revision or path not
in the working tree.

ok, so I presume I just delete that working tree to "fix my copy of git"
sbeller@sbeller:/u/git$ rm -rf
/usr/local/google/home/sbeller/OSS/submodule_remote_dot
sbeller@sbeller:/u/git$ git worktree prune
sbeller@sbeller:/u/git$ git worktree list
/usr/local/google/home/sbeller/OSS/git                117ddefdb4 (detached =
HEAD)
/u/git                                                d0c39a49cc (detached =
HEAD)
/usr/local/google/home/sbeller/OSS/git_origin_master  b14f27f917 (detached =
HEAD)
$ git bisect reset
Previous HEAD position was d0c39a49cc... revision.c: --all adds HEAD
from all worktrees
HEAD is now at 660fb3dfa8... Sync with maint
$ make install
$ git fetch --all
# works fine!

Any idea which direction we need to heading for a real fix?
