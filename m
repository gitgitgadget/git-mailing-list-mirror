Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB432055E
	for <e@80x24.org>; Wed, 25 Oct 2017 20:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbdJYUkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 16:40:53 -0400
Received: from mout.gmx.net ([212.227.15.19]:58678 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdJYUkv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 16:40:51 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkv0-1dtdsy1UWU-00LUOW; Wed, 25
 Oct 2017 22:40:42 +0200
Date:   Wed, 25 Oct 2017 22:40:40 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 1/1] status: do not get confused by submodules in excluded
 directories
In-Reply-To: <cover.1508964005.git.johannes.schindelin@gmx.de>
Message-ID: <33355d901d5f1c4d040b33bfd5b94e01803c03cd.1508964005.git.johannes.schindelin@gmx.de>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de> <cover.1508964005.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h4jRL+YKB9UBy2dVs2Noa4pe6sN/Vl0D1ec4sAiGAm9TYfPxa1c
 fSl5iTfH5EokFZIH0FEFyGstBnebo8bLC18VRZJya0IpzcaMLMJxMQCnrz915Y+MOwCFyw3
 VY8/OkizsMdhwcP1/9c/L3irGanV+3E9962kNlkn7C4XTWrEdLXWwC2TBsKRDH/hOfejij6
 5IwDa6iq+g1RmBNFgCFKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5sdqDHiLFuQ=:ReTEXN09Vs6F/+nTQHtJWU
 iM3tdK28/rRaTCp6aXZweLyWc5cWqV/4OSU4r0iY3dsaoypDnixMO/qC7+ikdvUZcgiTetTvg
 a2rI73lP6FLHVqoZZguhzpiz8zyiDKU7DxMbcTtfep4OOnPqSVQF1wu4sKm6XWcz7jRLw9rF2
 zFVudYdMD9AdHuNAydvHR2PUrd8LMOABN4YMszvN7EIP0A4Qp5FMQeZXg6/4AVP3z8awhP1ly
 dypkhJBSMUQQZWQrAAiBRZYBP6NRCEoZr4TrzzbYgVwS28jW1kRDleBReLghZO0h8tSxvVIZa
 OanbA5mAkmnPwYkxSxEKNLZYnDYNNNrlvxWdgPPVIM9vsT8LZHzVS679FgMnVpMAZM0+Yn1lM
 h5H6sic8TIK4ka7rR7ysT8ekWoKCeXSHJ2pFNqJ9djRhAbnqA55MTYOZ8wYKRdnxuujEKkTHM
 ghnYbExJeI2DGhJHYqo3FTk08COEn6TGiB6ijn1YJo0PhSTz80XNfD7oyqlyuYt8O24NDK0wP
 Ijg/giIePGzjFggogFFbqRIjKfDTGvGSS8MuaoHfSxSSCHwm23JUuHJ+VgQMgV2hdmpE/elFX
 H6ex5EUsWyLp5GnKYHVzpossEnJUtA+rpF1Xnh5AH2rNus23QBHgqmRwW58YMmP/IiGYSJUdI
 CVBIbjdAVhLvcccWnnunooJn0wniY/bIqUuK/Qd2b8rfj2RPJvEDEnyVJPBYG6/VK2xU2ukGv
 63uji5i0dmsoG6hbP8wWDAmbtPnuUJCljnP1kJemqZ9g3EGjvPEWpM1OBGidM5no9llmfaGQ0
 6yF2PcufydHcxsCI0d4HAciTUhMa7I9xGpHrnQsIxbfbUTq9BULrpw1+4OfKPdXo3anmLAx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We meticulously pass the `exclude` flag to the `treat_directory()`
function so that we can indicate that files in it are excluded rather
than untracked when recursing.

But we did not yet treat submodules the same way.

Because of that, `git status --ignored --untracked` with a submodule
`submodule` in a gitignored `tracked/` would show the submodule in the
"Untracked files" section, e.g.

	On branch master
	Untracked files:
	  (use "git add <file>..." to include in what will be committed)

		tracked/submodule/

	Ignored files:
	  (use "git add -f <file>..." to include in what will be committed)

		tracked/submodule/initial.t

Instead, we would want it to show the submodule in the "Ignored files"
section:

	On branch master
	Ignored files:
	  (use "git add -f <file>..." to include in what will be committed)

		tracked/submodule/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c                      |  2 +-
 t/t7061-wtstatus-ignore.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 1d17b800cf3..9987011da57 100644
--- a/dir.c
+++ b/dir.c
@@ -1392,7 +1392,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
-				return path_untracked;
+				return exclude ? path_excluded : path_untracked;
 		}
 		return path_recurse;
 	}
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index fc6013ba3c8..0c394cf995c 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -272,4 +272,15 @@ test_expect_success 'status ignored tracked directory with uncommitted file in t
 	test_cmp expected actual
 '
 
+cat >expected <<\EOF
+!! tracked/submodule/
+EOF
+
+test_expect_success 'status ignores submodule in excluded directory' '
+	git init tracked/submodule &&
+	test_commit -C tracked/submodule initial &&
+	git status --porcelain --ignored -u tracked/submodule >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.14.3.windows.1
