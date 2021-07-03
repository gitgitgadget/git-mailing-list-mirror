Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90656C07E99
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 20:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7840161438
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhGCUGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 16:06:05 -0400
Received: from mout.web.de ([212.227.15.4]:41483 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhGCUGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 16:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625342606;
        bh=CRWfB+bmc0Z/o01bAccDh2GQYsuKXPYtAj/RaNhfxgk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UJqYdKn3OzatWDnSH83oLzJAfCfWhTqBy5Vls1Ab0h9UGDcs3x1gIk79ruEMZD3oX
         +ZIwhdaroM9odI3awLwYVjuPcFlbruC7/J38EMXlsbVBhaLy16vfhdVqrNeDPR8mIh
         ebcylt74ChuTXxNVAm4fb45Tpr47jgH+LpXGHGmQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M3m59-1m0awH2VZT-000eBO; Sat, 03 Jul 2021 22:03:26 +0200
Subject: Re: bug in "git fsck"?
To:     Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     git@vger.kernel.org
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 <xmqqczs0popg.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de>
Date:   Sat, 3 Jul 2021 22:03:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqczs0popg.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:29H3gYz7ujWM+EIBLiTmZ9N0g8hXnjdzF4PkSPFbAIwy0d+Qg5R
 WipjdFeEXVeWkt/ZVFfytmp4qKI3j3SPrAUf53BPbpFy0mbUmYN4iJkEIsW+R4DW0GfCb/J
 M4/4YrqL22AG55OXlWxokfezIuMoDeREZb5cnj7gCaxMTgEIokziXBNx6IBp+Zg2MLfi7Z7
 3rnlGsETod1KGpuWRVDbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaQJ/f4f/zQ=:mdpFy82tk3tHJ9+uGLzpnL
 doYD1pqtV2M2CiuZ8jHdUs/Zs1/2+jPBOn9nnWiklWQoDqgzrOyT13XNBLd399U3ynKzoB962
 /DgQXDudkKbuMpq0NhUS+tpRv0eY3Qgr2ityN6CUWTGfBg9oLhWvSPPnWa0Hmn+pXJ9gLQUPD
 84Y6kCalWNBaK/oHODwMdJltijLR9bqSb/s0yLhntuHjH4tQMtrlt+rX5dTcO9Auud76SAYLr
 Z8ISVLZIYtfozRSem9zmxIWPTnDpcr08Un1ktDRiIwKoVDl1ncnUlxX7y0uIZMtjh7t8JMKnm
 M6GNVKDYEAWOPhAsZmZ+EJysOtyy6Fg5HdiLLn8JTr6JpxE8B1uUc2zndjdV1IkN8TX//kPrW
 ey4J81PJ2zR1xXfVKDVRZI7J+LsQC76NNT0nHruHQd/FJx+/1QP1HhvbfLhy9cJly/+TQ9uIj
 WUbX6TrThBbnzcoK35o5Vit7hQjOeJ+yY+rFTeDbUnoTykxIYAvWH1vIAzsemrmhcGi5/PVIe
 ZTyFWvYMort0Xh2s/kPECQ4jyo4PoO2Nn1qSvvHc4fNcvyw9mpET/K0nZ8wUaQgnyYZZ9V1M/
 OoEVBQRh3uWaVR8/FxVIkd7Rz8hgeREb2o2ORNmZaMNYMsFZxZxyssAX/TBKW+pWAt2+a/tQi
 2UbmGO66Pe/9TH3N5mvlDLeTA0pqfkNbwDhBVZKCt3qGubQ4u3aIF6SS0vkrxmyZnu4ZC/1gP
 6B22FAzm7xeW5eeW/0n1F5Td0Gi7htURjTndaUdUC1D0c4ly4/APTOpOtQ5ORXWlYozVo2veU
 3kIdDHCp8YOcuHCIfv6WElbfrxNmM0Ytk0AiClAfcR4SK1uuFI3uSlsxPfOLGZXJHS9lX1xKk
 yBIX3dYOCm9AIPKskGa2micULNUokwcupsvuvYOn9cImNAuScKz5+I87d184yQTMoiauAesjG
 BhAM1wMLlCxbqLKV7skknQKCY1EqqAkrE6DZL7jcmfEf5OK/RN5CPpCPfCx6fVyfnK7qCinUd
 VGuD+9CHsQioOiUDW1Fjg010IVcJP8ceC/2BKsTAZsC9b8wkN98/mfFyLGeY+m8GY4H+wwXCi
 W1mWDwH5C+X2GBzW0rQrYXbLNXTZVsTOJDB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.07.21 um 20:15 schrieb Junio C Hamano:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>
>> I was wondering whether git fsck should be able to cleanup
>> orphaned branches ("HEAD points to an unborn branch") as described
>> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
>> it be editing files in the repository, but I feed that's not the
>> way it should be.
>
> HEAD pointing at an unborn branch is not even a corruption, isn't
> it?
>
>    $ rm -rf trash && git init trash
>
> would point HEAD at an unborn one, ready to be used.

True, but the scenario described on StackOverflow is a bit different.
Commits were filtered out, and branches still pointing to them cannot
be deleted with "git branch -d" or "git branch -D".  Git fsck only
reports them.

You *can* overwrite them using "git branch --force foo" and then
"git branch -d foo" works.

I think it makes sense to let "git branch -D foo" work directly in such
a case.  That would be a user-visible change that may cause data loss,
so we better be careful.  I can't imagine a practical data-loss
scenario, but that might be just me.  Under which circumstances do we
want to keep a branch that does not point to a commit?

Anyway, here's what the change would look like:

=2D-- >8 ---
Subject: [PATCH] branch: allow deleting dangling branches with --force

git branch only allows deleting branches that point to valid commits.
Skip that check if --force is given, as the caller is indicating with
it that they know what they are doing and accept the consequences.
This allows deleting dangling branches, which previously had to be
reset to a valid start-point using --force first.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-branch.txt | 3 ++-
 builtin/branch.c             | 2 +-
 t/t3200-branch.sh            | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..5449767121 100644
=2D-- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -118,7 +118,8 @@ OPTIONS
 	Reset <branchname> to <startpoint>, even if <branchname> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch=
.
 	In combination with `-d` (or `--delete`), allow deleting the
-	branch irrespective of its merged status. In combination with
+	branch irrespective of its merged status, or whether it even
+	points to a valid commit. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
 	branch name already exists, the same applies for `-c` (or `--copy`).

diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..03c7b7253a 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -168,7 +168,7 @@ static int check_branch_commit(const char *branchname,=
 const char *refname,
 			       int kinds, int force)
 {
 	struct commit *rev =3D lookup_commit_reference(the_repository, oid);
-	if (!rev) {
+	if (!force && !rev) {
 		error(_("Couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..ec61a10c29 100755
=2D-- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1272,6 +1272,13 @@ test_expect_success 'attempt to delete a branch mer=
ged to its base' '
 	test_must_fail git branch -d my10
 '

+test_expect_success 'branch --delete --force removes dangling branch' '
+	test_when_finished "rm -f .git/refs/heads/dangling" &&
+	echo $ZERO_OID >.git/refs/heads/dangling &&
+	git branch --delete --force dangling &&
+	test_path_is_missing .git/refs/heads/dangling
+'
+
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
=2D-
2.32.0
