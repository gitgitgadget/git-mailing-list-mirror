Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22FD51F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfFXRj5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:39:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:50793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfFXRj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561397986;
        bh=q/Tp3DmNv1/e2nno7FPuyryAq2g6H6Ec/NZCqJRmLDU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IUGWzWMjjQuD83hHTxe0QUJyIz2C8TM0l8T7LwweErTtiWYvIlyJ5K9/JgpwTV5Sb
         Dn22ff+Eh2yODGGIiIRIoj14a0dBsvQMvr2/r5YLgf4NPeCXVJjZXr0tkYzmcKYRm8
         cl5C+o1srdw4F9uh28tmwaIUuk6dBSvfXUAPrqiE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1iV6hI3OAf-00z036; Mon, 24
 Jun 2019 19:39:45 +0200
Date:   Mon, 24 Jun 2019 19:40:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <1f0ceee8687e9032a7777f764b34b1c9ccc68f38.1561379363.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906241938450.44@tvgsbejvaqbjf.bet>
References: <pull.151.v2.git.gitgitgadget@gmail.com> <pull.151.v3.git.gitgitgadget@gmail.com> <1f0ceee8687e9032a7777f764b34b1c9ccc68f38.1561379363.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XV0WvFFLXrW+MSWNXQYq/2rw0RAI6nbU9g2s/Xt6LbUyla7LQvy
 skrAM4I/0nU0krSdrIbWEPpqsONbq+xbS5AHBbSNevijZdZ4cqD2S2R9EAqbP7kcFXTr6Va
 +L2sHc6dHk8AcY4R/h+ZwJU09gVr64uMsCNYfVWXjVZYGJWne2HOs3TQJ+5QJpvWuYYv2hg
 FDE1pbUwTg79NsDjMoMqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZK1Ol2jnqcU=:nVky01+GukwQTBdxroAE2B
 lL0e/Ujbi1hk2WVfKv+CvzydiCDy+j9+f8kEW1tDJXZJJzcI2Gct+JgQQBomX4wjxSnabDlyu
 wiYCwDJiBiaA25wUS2zTK98XgUwQSL4S46su5x/1yCN4AfpbdwQMfYup7NaUHvXKkzHpqlwxa
 3cSywz2vVmnBI6b0ORtEeeTFUAdVrkfUvcqW2ZHiySsWI8tM10fbJaAkciiIV/pbxVcmbgNWg
 QIEyHtaMnMK/jqedu+gNRp0Rbd0QbKyKXOjGoXIkNQmXOjCxAvm1YCja1x7KQBbgberfB/21t
 oJehlSc+Tdah58M4PW5SLbkl8b9W0qUdInxrfvVMvcWDTF+1PGqPW8hwnMiqzbmAUWHYmCfrW
 68UUsMcBJa86JkqeO8i8U/iFKN918nRLjKty16dMWZZgBr0mlecI2BbhK2SW8sIohHS+HI4/8
 VxrPK7WAz/Fn6aovtU9faDlSPjP3PpwDzBxEJFl0O9QYbq2lOmHI32KR+3dYWahEsWqx7DLE9
 sMVXrTXVJOkwIbbuIkDUfyq9gdZefHaNKbCuA5JAltHaTxBvEiclbrg7rIfdAB38toon2dU1B
 omPiDnxCMnfwpyT5pCUqbk2rIym7ch+NEIMDIYh8Pa+Dm5u+PLKPmLSJqqi0GXlNIAen2dKPB
 30Snw8nu+wv8zli3FDiKkqKlGMjumFnF40jUyGWWhkijvX9riRCbbHjBBk3BKVBNHOwEpBu2I
 l+kTIcuZKVExPhIADnhiNsEgRd/q2gmrSF+Fw7Zbd2mE0LsZz+ZDxiiybGXU9ZNsJUV6+5Lct
 CNxAw30i2xjzfVr63Nfms3LCf1E9ba8dTxa6rulj7c0mwm9HHnVcmFYuR3yTShnzU8JkgRdA/
 mqc2lRGkY6OpFrbdih5Km7Hdu2h5P3DcsZwnDEQHen9X4lpw1qL1wpMmaqQzwAzTF4YVlWSga
 zk5bARYmhnndSOBekTN9sLoaeKlHk6lIsb1Y6Z9Q2E8yiGPDC4igB
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
that the idea Bash has of the current directory differs in case from
what Git thinks it is. That's totally okay, though, and we should not
expect otherwise.

On Windows, for example, when you call

	cd C:\GIT-SDK-64

in a PowerShell and there exists a directory called `C:\git-sdk-64`, the
current directory will be reported in all upper-case. Even in a Bash
that you might call from that PowerShell. Git, however, will have
normalized this via `GetFinalPathByHandle()`, and the expectation in
t0001 that the recorded gitdir will match what `pwd` says will be
violated.

Let's address this by comparing these paths in a case-insensitive
manner when `core.ignoreCase` is `true`.

Reported by Jameson Miller.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--

	Again, re-sending, as something in the mail (my guess is the
	non-ASCII character in Martin's surname) seems to upset vger so
	much that it drops the mail unceremoniously.

 t/t0001-init.sh         | 22 ++++++++--------------
 t/test-lib-functions.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 42a263cada..b796fa25ac 100755
=2D-- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -310,8 +310,8 @@ test_expect_success 'init prefers command line to GIT_=
DIR' '
 test_expect_success 'init with separate gitdir' '
 	rm -rf newdir &&
 	git init --separate-git-dir realgitdir newdir &&
-	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	newdir_git=3D"$(cat newdir/.git)" &&
+	test_cmp_fspath "$(pwd)/realgitdir" "${newdir_git#gitdir: }" &&
 	test_path_is_dir realgitdir/refs
 '

@@ -360,12 +360,9 @@ test_expect_success 're-init on .git file' '
 '

 test_expect_success 're-init to update git link' '
-	(
-	cd newdir &&
-	git init --separate-git-dir ../surrealgitdir
-	) &&
-	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	git -C newdir init --separate-git-dir ../surrealgitdir &&
+	newdir_git=3D"$(cat newdir/.git)" &&
+	test_cmp_fspath "$(pwd)/surrealgitdir" "${newdir_git#gitdir: }" &&
 	test_path_is_dir surrealgitdir/refs &&
 	test_path_is_missing realgitdir/refs
 '
@@ -373,12 +370,9 @@ test_expect_success 're-init to update git link' '
 test_expect_success 're-init to move gitdir' '
 	rm -rf newdir realgitdir surrealgitdir &&
 	git init newdir &&
-	(
-	cd newdir &&
-	git init --separate-git-dir ../realgitdir
-	) &&
-	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	git -C newdir init --separate-git-dir ../realgitdir &&
+	newdir_git=3D"$(cat newdir/.git)" &&
+	test_cmp_fspath "$(pwd)/realgitdir" "${newdir_git#gitdir: }" &&
 	test_path_is_dir realgitdir/refs
 '

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 80402a428f..26218a6c53 100644
=2D-- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -879,6 +879,21 @@ test_cmp_rev () {
 	fi
 }

+# Compare paths respecting core.ignoreCase
+test_cmp_fspath () {
+	if test "x$1" =3D "x$2"
+	then
+		return 0
+	fi
+
+	if test true !=3D "$(git config --get --type=3Dbool core.ignorecase)"
+	then
+		return 1
+	fi
+
+	test "x$(echo "$1" | tr A-Z a-z)" =3D  "x$(echo "$2" | tr A-Z a-z)"
+}
+
 # Print a sequence of integers in increasing order, either with
 # two arguments (start and end):
 #
=2D-
gitgitgadget

