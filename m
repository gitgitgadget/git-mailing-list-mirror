Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B344C64E7C
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C794206FA
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 09:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dh4e0sig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgKXJ7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 04:59:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:34581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731804AbgKXJ7i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 04:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606211973;
        bh=CgxSAm2trgoZ3gfgFWtTJ1/r3UK8QgzQOpRbC+nvs4s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dh4e0sigvhzSYWC/7TQkqIiDI55f8moRfcP551ePLbzw69ZiveFH/xrfakKq1+gxh
         a18USkLJZTQEnOiWAIIgKZ85AaiwgrHpgfUxIcNjcLTgYcoNEp75teo7yxky/eKxVB
         YVQN3wp3LUUW8m/aqErfgMUqpeyF4mEL1lRiczFc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1ks8Ve1U3r-00QEBn; Tue, 24
 Nov 2020 10:59:33 +0100
Date:   Tue, 24 Nov 2020 06:47:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] branch -m: allow renaming a yet-unborn branch
In-Reply-To: <xmqqd003ljru.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011240551050.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>        <8de0c0eb228c8d9608d3a78c992cbd6829cb9329.1606173607.git.gitgitgadget@gmail.com>
 <xmqqd003ljru.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ns7z0W3kwEFtUl0zo8UC00mxdiS+3+whUmYoDQK1pfwA6QNC6aW
 dZBoJRchc7YCp24D+czXM29GVUMRYPeS/ubpwu0sxZlQQoz9+ZZz0GLIhybhipD0EQmxmLa
 tse7MAjdO6oxzSZWv+g9D9z9Bihemrvk/s0IoX4dQCzRpgQVmEvpLfBoNs5J5fqHvNm7KYz
 feEnUXAjOpmOLGYaU8M/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0wQ7SS7529w=:1SHH/FLMfndcJ/EenDDs0s
 0PYHxYueibA1zOTbJLYKOgX/0TsRK3D41ZkOoeA2ZK5WiimJi8F/5BqFYOZ3JRPMsW+KUukFu
 fQ77cth72LSwk73q75URdO711ibxdrjBQS53W3xKSjFJ3oR91tPGHs8DapwnuoKG1RGI8IcEv
 B9Cq4iTyOt6lvXNF7xPTFrDmA1TMdsAWKvO3+X50ErHRp/fNgo2RtKINaTLlDP9F12uNTtTsq
 Y/YLhfmCYpgVIV1AysbKH4OOMD5UrpPQaRhbhsSsqQ+G4/5Uu2ZLrGzaBm420a/4UXArImQi+
 +o+Lcy+N4MO7KN5q7BUXnUQzc1iYkuSq+oh3KPNg0JTBCF3q+qX0PUyFYVk7+XMZR9Jfkkpk4
 ANgS2LkQN74RQ00+OUdTQWq6P90UVlOJ3jxz+QaKcBPy8oiqyBQvJv5a0u1Hn0g+PxZ+CpQ09
 8gL8JhUy3zkzTTMWKMJdCWmLPWYvNV4wjvMvrRnIdlz8TgU3S/NEp0COSClXB/ZlQ00Ti3+C4
 iatVjfmakQhUuKUFLKYNv1UwuAFR9e+TqdOtOq/SpJKbAOwH86RXSZuXFSIyKSwM2fMpUaLSM
 vkuaL/ciR61CTnvaNVVm3+PVNb5J1BL7DFkZLQ1+FYHvQ/+3QClJTc91A+Z9xo5XoS9HBG/YC
 GVmtlkguqTn/pK8wKKRGNMUqVE9QKbvmKzQtgtJdRIu8qMRlrOLmxhNBHcIqpBNFxChoWmcWr
 7O5s6Vr1Fcr+T3NdQTDEvatoCFBcMK9id1OUOOBP/6QfPhIiJe/GZi44VUB1KvhJbH4ImMk45
 Bw/osh0Zk0IaE6YSMIvoUHfVAN2T8+H5t0Rha38vxAeuJqsLHc9R00eODlapAGDV+q+NlTuu2
 ZZTGRJRz027/X5Hj5VCWqPcF7abMzxgFO422Czehc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Mon, 23 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > @@ -538,7 +538,8 @@ static void copy_or_rename_branch(const char *oldn=
ame, const char *newname, int
> >  		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
> >  			    oldref.buf, newref.buf);
> >
> > -	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
> > +	if (!copy && (oldname !=3D head || !is_null_oid(&head_oid)) &&
>
> It always makes readers uneasy to see pointer comparison of two
> strings.

Even if it was on purpose ;-)

> Does this mean, after "git -c init.defaultbranch=3Dmaster init",
>
> 	git branch -m master main
>
> would not work while
>
> 	git branch -m main
>
> would?  It would be easy to see with the attached patch to the test,
> I guess.

At first, I thought that it would be inappropriate to do that because it
would not work with unborn branches in a worktree other than the current
one. Like,

	git worktree add --no-checkout --detach other
	git -C other switch --orphan start-over-again
	git branch -m start-over-again fresh-new-start

On second thought, that's a really obscure use case, anyway. It is not
even possible to create a secondary worktree! I started down that rabbit
hole, but think I'd better let it be. This is where I stopped:

=2D- snip --
diff --git a/builtin/branch.c b/builtin/branch.c
index 200da319f1d..c84bffe9632 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -489,6 +489,16 @@ static void reject_rebase_or_bisect_branch(const char=
 *target)
 	free_worktrees(worktrees);
 }

+static int is_unborn_branch(const char *branch_name, const char *full_ref=
_name)
+{
+	int flags;
+
+	return (head && !strcmp(branch_name, head) && is_null_oid(&head_oid)) ||
+		(!resolve_ref_unsafe(full_ref_name, RESOLVE_REF_READING, NULL,
+				     &flags) &&
+		 find_shared_symref("HEAD", full_ref));
+}
+
 static void copy_or_rename_branch(const char *oldname, const char *newnam=
e, int copy, int force)
 {
 	struct strbuf oldref =3D STRBUF_INIT, newref =3D STRBUF_INIT, logmsg =3D=
 STRBUF_INIT;
@@ -538,8 +548,7 @@ static void copy_or_rename_branch(const char *oldname,=
 const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);

-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !is_unborn_branch(oldname, oldref.buf) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 84047ac64e6..124abeedf19 100755
=2D-- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -586,4 +586,12 @@ test_expect_success 'branch -m with the initial branc=
h' '
 	test again =3D $(git -C rename-initial symbolic-ref --short HEAD)
 '

+test_expect_success 'branch -m with the initial branch in another worktre=
e' '
+	git -c init.defaultBranch=3Dinitial init rename-two &&
+	test_commit -C rename-two initial &&
+	git -C rename-two worktree add --no-checkout ../rename-worktree &&
+	git -C rename-worktree switch --orphan brand-new-day &&
+	git -C rename-two branch -m brand-new-day renamed
+'
+
 test_done
=2D- snap --

Having said that, I fixed the `git branch -m <current-unborn> <new-name>`
use case; the fix will be part of v3.

Ciao,
Dscho
