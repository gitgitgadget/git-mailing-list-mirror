Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6B7C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4226141B
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbhI3KI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:08:27 -0400
Received: from mout.web.de ([212.227.15.4]:33803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349774AbhI3KI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 06:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632996398;
        bh=dUQ/Z745Azv1/NfKFHCQoJnBFu+PteyrIDhHt0fpLBM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=L4JktYiRbg94D8gxVJBfnm4P2135gCHPzn3HxtboRrwMIcRqzPjh1WRsFkcnuO5M8
         ZsZLxVEiaqCJ7MSj6mA/YaXPuyXrzOv33dcDTTna53zYGqFUWFuBafFOPz1as39g+v
         Vs2ZkdR4VZuGBYO7Jiv7yfdWHmELBOeWdWu1KqkI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MGxQV-1macBR1HSl-00DufG; Thu, 30 Sep 2021 12:06:38 +0200
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
To:     Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de>
Date:   Thu, 30 Sep 2021 12:06:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJEWYXnkAiWnfu7EHQvMKVh1RJ2Jl4VPkB+KC/2Z6DRyNhmnt+P
 GufDNVlLeKp8fcLavPrLQ77RLk1tN6HS3q8+i+Uu3dXUndXnupg2h0fJxIETKAHphX8YhrY
 rqse0YVzA57Y7sJMw+rDT1EvvSC8QL1e+BanQWGCLh0Ev9hvnjTWaND6Q21O2pHXPsHhuSs
 Uc7pcwzTfpEHOyoi79IIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ETRwEQZIIM=:eB55lfcbRkztz3g1ezPxQM
 hFts/CDAlaqNWwVA+o2nYkqZ0s/vD+tYliC3AdvsktP7wNWcqGL0p1j/l6jHjQbr+nyhgh93d
 ppo8CHvoRNSakHaOUxxyrl4eY8tA85/1Yjo92HGJAU2xMj5OXXwql2xUxWeWs1jLxpGFkStyL
 3FG1/41qWomMhTuJdgZ3oQgMpLIag0wSKsyNHFltQx79d/a3pvoOR3ypddvpSvuuGr312WsOn
 9GUiM/1SH3rEyvnhvc0o/d6JSknRWDKNQ0OOi9Ck7kTyA1WhzYrTXwYSjyNvjdI6wc+C/fXCr
 ABc/cfi1ppB+vIf7Uuh0iQbYLUtxApAxOQsZL7TN/xzbTKDJKrDXrZBs/qqY5LZygeVKCecN8
 SyB9Bk3ZTl0j6XIQue3slCCzdLsiDUCCktceo+nx92n+vcLgE4Khk+w40O/utvU/P0We9Iwgu
 Kl/h8zEJTGJ0oxjqqu1a8EFPmnJE00v/nSOgeeHKaGMtv582UsiOo51/2JWtY7Ib2szpn2qku
 hhmHbRuJIXhA3U3fnXdLhqDJgckI5pZY4tLuXqJrIuSX+ezzCPCx6MLQyWJm+QEbnbvApWFLQ
 d2b/sUvDae4hM9shZZhi+DFHMnJbtPlBcKR3kT1h2dP58wJ+THnuN6tLm/sP06nPg/82aJuOp
 vEo/8nbrkDSqcIbvkhfo3k7Om8ZihSXohF5aus9GQStYPoHXx82q+z9jbyBA9rcyK8w04QtoO
 aCbK/692Vh1FQ61dyeUab+D3MzYPdR6/kAb39XU4bK87mYz+plWNA9TUTs0+h+s+kKHLngxoL
 ZCfmNWLvDFmbRuMkok9ynEucbq5ksOPmqM1N9WQWMxMJfxW/zzrSj9Cq7/+NusvzAF/Ylwxka
 h4Df3UONbjY3krv0WLFORSkcXhnSJ+YbrsHWObEYxevF5l4Od0WrUqgVkAZ3yX4BoHYGExiKf
 z8o6SrlJtT/kJeFeJkzjOVT3ySb0L81IUpLm61axRZHHfrxewHA1CbLy5VyFhkpmi2znjSt8g
 rw1bUYAGC2dqSmLwbEbJsmsyTWIxvujwN5wmAgA6TRZE0xBdHD1JS9JUP/jOyNTSAQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.21 um 02:49 schrieb Robert Leftwich:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>   Initialised a repo and added a file or cloned a repo inside an existin=
g
> repo (think dependencies).
>   See https://github.com/gitpod-io/gitpod/issues/5675 for background.
>
>   In an existing repo:
>     $ mkdir sub_test && cd sub_test/ && git init . && touch test.txt && =
git
> add test.txt
>     OR
>     $ git clone https://github.com/stencila/test.git sub_test
>     THEN
>     $ git stash push -u
>
> What did you expect to happen? (Expected behavior)
>   Command should complete without error but ignore the directory (this i=
s
> the existing behavior prior to v2.31)
>     $ git stash push -u
>     Ignoring path sub_test
>     Saved working directory and index state WIP on (no branch): 94f6e3e2=
83
> Git 2.30.2
>
> What happened instead? (Actual behavior)
>   Command failed
>     $ git stash push -u
>     error: sub_test/: is a directory - add files inside instead
>     fatal: Unable to process path sub_test/
>     Cannot save the untracked files
>
> What's different between what you expected and what actually happened?
>   Command failed
>
> Anything else you want to add:
>   It happens on all versions from v2.31 to current master.
>   It is specifically related to this change:
>
> https://github.com/git/git/commit/6e773527b6b03976cefbb0f9571bd40dd5995e=
6c#diff-70525b6b89c7cac91e520085d954a68671038d218b77d22855e938ab075a68d8L1=
006
>
>   If this is the new expected behavior perhaps it can result in a better
> error message and related documentation?
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.

Looping in Stolee as the author of 6e773527b6 (sparse-index: convert
from full to sparse, 2021-03-30).

>
>
> [System Info]
> git version:
> git version 2.33.0.610.gcefe983a32
> cpu: x86_64
> built from commit: cefe983a320c03d7843ac78e73bd513a27806845
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.4.0-1051-gke #54-Ubuntu SMP Thu Aug 5 18:52:13 UTC 2021
> x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
>
>
> [Enabled Hooks]
>

Here's a raw patch for that.  Versions before 6e773527b6 pass the
included test.

The magic return value of 2 is a bit ugly, but allows adding the
additional check only to the call-site relevant to the bug report.

I don't know if other callers of verify_path() might also need that
check, or if it is too narrow.

Ren=C3=A9


=2D--
 builtin/update-index.c             | 15 ++++++++++++++-
 read-cache.c                       |  2 +-
 t/t3905-stash-include-untracked.sh |  6 ++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb..3d32db7304 100644
=2D-- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -445,10 +445,22 @@ static void chmod_path(char flip, const char *path)
 	die("git update-index: cannot chmod %cx '%s'", flip, path);
 }

+static int is_nonbare_repo_dir(const char *path)
+{
+	int ret;
+	struct strbuf sb =3D STRBUF_INIT;
+
+	strbuf_addstr(&sb, path);
+	ret =3D is_nonbare_repository_dir(&sb);
+	strbuf_release(&sb);
+	return ret;
+}
+
 static void update_one(const char *path)
 {
 	int stat_errno =3D 0;
 	struct stat st;
+	int ret;

 	if (mark_valid_only || mark_skip_worktree_only || force_remove ||
 	    mark_fsmonitor_only)
@@ -458,7 +470,8 @@ static void update_one(const char *path)
 		stat_errno =3D errno;
 	} /* else stat is valid */

-	if (!verify_path(path, st.st_mode)) {
+	ret =3D verify_path(path, st.st_mode);
+	if (ret =3D=3D 0 || (ret =3D=3D 2 && is_nonbare_repo_dir(path))) {
 		fprintf(stderr, "Ignoring path %s\n", path);
 		return;
 	}
diff --git a/read-cache.c b/read-cache.c
index f5d4385c40..0188b5b798 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -1040,7 +1040,7 @@ int verify_path(const char *path, unsigned mode)
 			 * sparse directory entries.
 			 */
 			if (c =3D=3D '\0')
-				return S_ISDIR(mode);
+				return S_ISDIR(mode) ? 2 : 0;
 		} else if (c =3D=3D '\\' && protect_ntfs) {
 			if (is_ntfs_dotgit(path))
 				return 0;
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-un=
tracked.sh
index dd2cdcc114..5390eec4e3 100755
=2D-- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -422,4 +422,10 @@ test_expect_success 'stash show --{include,only}-untr=
acked on stashes without un
 	test_must_be_empty actual
 '

+test_expect_success 'stash -u ignores sub-repository' '
+	test_when_finished "rm -rf sub-repo" &&
+	git init sub-repo &&
+	git stash -u
+'
+
 test_done
=2D-
2.33.0
