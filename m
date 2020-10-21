Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC03C55178
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37651222C8
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 14:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Bga+GgHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443329AbgJUOqQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:46:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:35671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395254AbgJUOqP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 10:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603291570;
        bh=vC5QJGHTgboOs43JD2FI5vBBt1vuyDz9Xy1r+oaVHOA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Bga+GgHnRd3cXZEnXHXns2WS8lqOrzvCwzN8dCwYLIeCavfvKf9UntjhwGytXAnf7
         I4ciFKH7rNTKqWEpPZn3g2UupXEtA0dXGCR7iVP97OhsnVvKs/KpO/lsy5VVAlDs2+
         tFQAZfPMowO02Tz1zHsU7lag3nWCBuTwqSwTx5zk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.235]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1kbtCk1hyC-00FXFQ; Wed, 21
 Oct 2020 16:46:10 +0200
Date:   Wed, 21 Oct 2020 16:46:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: git-filter-repo v2.29.0, was Re: [ANNOUNCE] Git v2.29.0
In-Reply-To: <CABPp-BG+uP2-t62AfgBauvoRtXfF4pU-xXKq3+YEEhjDdiHR_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010211630010.56@tvgsbejvaqbjf.bet>
References: <xmqqy2k2t77l.fsf@gitster.c.googlers.com> <CABPp-BG+uP2-t62AfgBauvoRtXfF4pU-xXKq3+YEEhjDdiHR_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PWpwUjKInn5Ljc/iREJV1eElDEnTa36NIQxyn3YIVxeGUU1DtiP
 6+LXcAEnJYApYZfHpcA5ecIuzWek/Yu0geWfvlewLQG5+YGveSyvEbrW6671kBn/uLLjCmn
 EEyNW3tO1eRD0x8rIOn/L9wqkZ9xCCGXY1Q2fNan1Irpr3BMp6VlSR6FRA81ThGkxiGqpz1
 Sd6ijP5aiwINTAcOlcuJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GV8pHsHsWfk=:2q/c22uV3xmSfpA4sI0K0T
 WH8WMF607+fygpeev0MviXsBr/H0Jq9hYMYa+nFUy+TmDkiUebiPpP8VzzbpliTshtJ7CSOg8
 3my97ZS3WA/wPsIZlNGtRYiI/vilZwc6ypfI5liLR58RnLOL8NqZkQHqvKLewpBr04qJuZDxF
 tg8MIsG85ZP8gZIYef8ww7n1z/dPd56slt+sKE3yRtkIEqQ68mna20krQn57ihnsvg+hPJZFn
 nhFCSOZREAotlLSfgfav5K4T261zvEAW6prrGjMPRBbOhVAV1Gtsza+LFffLACZ5gp1ebVIMa
 3JZDPg03ahZzDP7FLPT1XAtBVT8sexRYHSDmWnIpXEMjclMSl6aUQ0RN5lazBdxCn0r/K6oW2
 cG7YXuyS+4T9/rPRxa9SmIIE+txQ/8WwZ9OIu4KWeK4TCuu0TuXH8p2MT6Q3qXO1+5+wCNOIc
 BKlTDCe4OCaSoaLzS2RqtWm711s71mmtH6rfIxxyJk4ZlcfXhPcow6S3JaNry7CPeU1e+I5w4
 giLTbXg2Bf8ZNE6SZVHwMpBMIatTINbU1qH0l0UfS4hVJ1KWOFwi9at/Ir1D9EbWKW7c7t7pW
 RpHhs5Sjvr3PxSjG33MDk/Nd5SS2bhxkkXfwqKTmEnmTvBGsJVKIHqwgvGbrk1ITtTfNOOZxL
 BI8XjLYD1x17TO/TeTmkl/GJcE8aV1vWjVRtsU3lejDtANRtWbRDBl2TyM3LdCs6AE0vmz+Rh
 Tg+kHbDHVKD82ms8Xx0hh+3d5C535m++bRjb2WXFGpgOMqM8C3nMTjIH+RCqTCg9u0Pjpd3cx
 oZK4s3wD/8UmXL3sgtjfQpb7Upd4EHOGjTEZ2O+BBtepeFqFkccDwkZBnkkS/bU+s2HH8tAjt
 S4RhIyQXwX34I3uPE+YgeesKsTydjH0vObVGo0vK0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 19 Oct 2020, Elijah Newren wrote:

> git-filter-repo can also be installed via a variety of package managers
> across Windows, Mac OS, or Linux (and maybe others)[1].

In the few attempts I ran to verify that this indeed works on Windows, I
always stumbled over the tests that require "funny" characters in the file
names. However, it seems that at least a couple later test cases rely on
side effects of those test cases that require those characters, so I never
managed to get this to work. Here is my work-that-is-not-even-in-progress:

=2D- snip --
diff --git a/git-filter-repo b/git-filter-repo
index ac039ec..7e2a534 100755
=2D-- a/git-filter-repo
+++ b/git-filter-repo
@@ -1,4 +1,4 @@
-#!/usr/bin/env python3
+#!/usr/bin/env python

 """
 git-filter-repo filters git repositories, similar to git filter-branch, B=
FG
diff --git a/t/t9390-filter-repo.sh b/t/t9390-filter-repo.sh
index 14bdeaa..d7f9f1f 100755
=2D-- a/t/t9390-filter-repo.sh
+++ b/t/t9390-filter-repo.sh
@@ -298,7 +298,7 @@ setup_metasyntactic_repo() {
 	)
 }

-test_expect_success '--tag-rename' '
+test_expect_success FUNNYNAMES '--tag-rename' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic tag_rename &&
@@ -317,7 +317,7 @@ test_expect_success '--tag-rename' '
 	)
 '

-test_expect_success '--subdirectory-filter' '
+test_expect_success FUNNYNAMES '--subdirectory-filter' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic subdir_filter &&
@@ -336,7 +336,7 @@ test_expect_success '--subdirectory-filter' '
 	)
 '

-test_expect_success '--subdirectory-filter with trailing slash' '
+test_expect_success FUNNYNAMES '--subdirectory-filter with trailing slash=
' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic subdir_filter_2 &&
@@ -355,7 +355,7 @@ test_expect_success '--subdirectory-filter with traili=
ng slash' '
 	)
 '

-test_expect_success '--to-subdirectory-filter' '
+test_expect_success FUNNYNAMES '--to-subdirectory-filter' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic to_subdir_filter &&
@@ -375,7 +375,7 @@ test_expect_success '--to-subdirectory-filter' '
 	)
 '

-test_expect_success '--use-base-name' '
+test_expect_success FUNNYNAMES '--use-base-name' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic use_base_name &&
@@ -394,7 +394,7 @@ test_expect_success '--use-base-name' '
 	)
 '

-test_expect_success 'refs/replace/ to skip a parent' '
+test_expect_success FUNNYNAMES 'refs/replace/ to skip a parent' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic replace_skip_ref &&
@@ -416,7 +416,7 @@ test_expect_success 'refs/replace/ to skip a parent' '
 	)
 '

-test_expect_success 'refs/replace/ to add more initial history' '
+test_expect_success FUNNYNAMES 'refs/replace/ to add more initial history=
' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic replace_add_refs &&
@@ -451,7 +451,7 @@ test_expect_success 'refs/replace/ to add more initial=
 history' '
 	)
 '

-test_expect_success 'creation/deletion/updating of replace refs' '
+test_expect_success FUNNYNAMES 'creation/deletion/updating of replace ref=
s' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic replace_handling &&
@@ -510,7 +510,7 @@ test_expect_success 'creation/deletion/updating of rep=
lace refs' '
 	)
 '

-test_expect_success '--debug' '
+test_expect_success FUNNYNAMES '--debug' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic debug &&
@@ -533,7 +533,7 @@ test_expect_success '--debug' '
 	)
 '

-test_expect_success '--dry-run' '
+test_expect_success FUNNYNAMES '--dry-run' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic dry_run &&
@@ -561,7 +561,7 @@ test_expect_success '--dry-run' '
 	)
 '

-test_expect_success '--dry-run --debug' '
+test_expect_success FUNNYNAMES '--dry-run --debug' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic dry_run_debug &&
@@ -589,7 +589,7 @@ test_expect_success '--dry-run --debug' '
 	)
 '

-test_expect_success '--dry-run --stdin' '
+test_expect_success FUNNYNAMES '--dry-run --stdin' '
 	setup_metasyntactic_repo &&
 	(
 		git clone file://"$(pwd)"/metasyntactic dry_run_stdin &&
@@ -892,7 +892,8 @@ test_expect_success '--strip-blobs-with-ids' '
 		grep fake_submodule ../filenames &&

 		# Strip "a certain file" files
-		git filter-repo --strip-blobs-with-ids <(echo deadbeefdeadbeefdeadbeefd=
eadbeefdeadbeef) &&
+		echo deadbeefdeadbeefdeadbeefdeadbeefdeadbeef >../input &&
+		git filter-repo --strip-blobs-with-ids ../input &&

 		git log --format=3D%n --name-only | sort | uniq >../filenames &&
 		test_line_count =3D 10 ../filenames &&
@@ -917,7 +918,7 @@ test_expect_success '--strip-blobs-with-ids' '
 		! grep words/to ../filenames &&
 		! grep capricious ../filenames &&
 		! grep fickle ../filenames &&
-		! grep mercurial ../filenames
+		! grep mercurial ../filenames &&

 		# Remove the temporary auxiliary files
 		rm ../bad-ids &&
=2D- snap --

(There are two unrelated fixes in there, to be sure.)

I wonder whether there would be a chance that you and I could combine
efforts so that git-filter-repo is MEAOW (Most Enjoyable Also On Windows)?
Maybe starting with the addition of a GitHub workflow that uses Git for
Windows' SDK via something along the lines of Git's `windows-build` steps:
https://github.com/git/git/blob/v2.29.0/.github/workflows/main.yml#L81-L95
(although it would need the full `git-sdk-64` artifact of
https://dev.azure.com/git-for-windows/git/_build?definitionId=3D29&_a=3Dsu=
mmary
because it requires Python, which git-sdk-64-minimal excludes)?

Ciao,
Dscho
