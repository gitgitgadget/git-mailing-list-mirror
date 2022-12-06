Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6734C47089
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiLFBOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFBOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:14:00 -0500
X-Greylist: delayed 634 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 17:13:59 PST
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73AB1CB0E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:13:59 -0800 (PST)
DKIM-Signature: a=rsa-sha256; b=V0LrbKFhoBQvmh8dZH4mSivRtAC53T3PQ/lW7l2oXcKoF66VUI3Opg5ZbxgVbC7IwCLsjh9KiiNdBTmE4fZtI8Rx0PhPacLJDwIGm7iXW3lrT6TqMSuaPBziKQKCZXsChV+rKPj6Uxela0n/jxXmsu/E1f9Ya4dunLHGI0VWL6zQL7fdfpNTC5QcmR5tlzyQLygIY6h855m4KRUXiOQZKVPF3W2whtGR4jeUJH8UIeCpnYmQ6nGzAkJSBQiXp3yaSPFEFzFy+ugISbnqyUrHGW/2yXedLEePYJCTOtDTwUCkXRICvLLQ7g2fq4eBmfhyaAaN7G+NznmhZWRJQg1/4w==; s=purelymail3; d=tionis.dev; v=1; bh=m9QPhO9+uI3Hv8GbbfbMn0ny1qRBslFjRc1y6E22Jpw=; h=Received:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=gKuLrLSGMmL5lo+ECcLSeEI7klvF3hHTesbtSpJAh7u5fDGZOSfkxtlHvv+Bxu6M8eRtIgEKpoaWViMDHhS3/u29afFDn0fs6wBpVZtJq6mT90ScZbW7t8Ucj08r8n5+5khG++ayo/8YxA1dQT8nmWvq6+yrhqHQDwsQfyJIxaYxXjkoDn3/hnbrKUDRjAc/YnxKysco6UZ7nMLiZtf6tMQoKzapheugoozmhzayVQ6CnHEgWo+YskX58n9kHwjgHc4KVS/muPeIf2HRvFZJxN7t9bQ0MnVSzmxn7zHISHJMqvwHLD2JVMfLP1+/gzc5mQTRhE0OD0sNO07Re/IfHg==; s=purelymail3; d=purelymail.com; v=1; bh=m9QPhO9+uI3Hv8GbbfbMn0ny1qRBslFjRc1y6E22Jpw=; h=Feedback-ID:Received:Subject:From:To;
Feedback-ID: 2034:545:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2051694802
          for <git@vger.kernel.org>
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Dec 2022 01:03:15 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Dec 2022 02:03:14 +0100
Message-Id: <COUBW3AG192J.1UCDLVUZ38VJA@tempest>
Subject: bug report: git push fails in worktree
From:   "tionis" <out@tionis.dev>
To:     <git@vger.kernel.org>
X-Mailer: aerc 0.13.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Setup two branches. =20
Check the main one out in a repo. =20
Checkout the second one using a worktree with
git worktree add ~/some/path branch-name
Add commits in ~/some/path
git status shows:
On branch dev
Your branch is ahead of 'dev/main' by 1 commit.
  (use "git push" to publish your local commits)
Execute git push

What did you expect to happen? (Expected behavior)
expected the one commit to be pushed

What happened instead? (Actual behavior)
the command only returns=20
Everything up-to-date
and nothing is pushed

What's different between what you expected and what actually happened?
git should detect the commits to push correctly

Anything else you want to add:
this was mentionend before on stack overflow:
https://stackoverflow.com/questions/41158057/why-does-git-allow-pushing-to-=
a-checked-out-branch-in-an-added-worktree-how-sha

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.38.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.15.80-1-MANJARO #1 SMP PREEMPT Sat Nov 26 13:41:30 UTC 2022 =
x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
post-checkout
post-commit
post-merge
pre-push
