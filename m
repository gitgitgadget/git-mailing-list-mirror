Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B4C1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 13:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfJFN0x (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 09:26:53 -0400
Received: from mout.web.de ([212.227.17.12]:39373 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFN0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 09:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570368403;
        bh=9NAtpYF2s1g7aLz7k4S28f9q3Y18rGUuwR0jtxGFpGw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=a0+YOvyvJs/9ci4A9hZhvCWD9VdOr8Qmrt+bxmliNsP9/0umtc+aC4RP8n/jglkw+
         KD0zHd4DwfZYek5m61rk4LX3WdNtCN893rHhwMazRE7eQ3Qz90DfY4OTrT97FyL9/6
         1EkxrsqaRweDqqPwBckuASjH1X3lgdCMdJ6zPxBk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLWc-1icSfV0wN4-00YjtN; Sun, 06
 Oct 2019 15:26:43 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] tests: remove "cat foo" before "test_i18ngrep bar foo"
Message-ID: <d178227d-7658-8c49-a147-e88d31c713e3@web.de>
Date:   Sun, 6 Oct 2019 15:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uFfLLDuYps99bE/y5XI2M5qs/1SJjafIGUVommXb3YHjx/wLpAV
 +8KoPgnUTaTKQ23whN6bOmO8InttwZRTvEF+RIv06CMkIyE+YxNzDPDdvFOvSpew0dN+Sfr
 PwA017V12E1IiM/9CHd2arVF9HZXgWz6Fl66GTkUG7VTUKwRsIwUBJ2P1+Kw6LRkki30sCG
 1v9p9/npP2vFF9cPcMU9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PKU95OtX55U=:B05jescywZ3bH42Ty4dLwf
 wkfZV3ZltpNbPpFNWw3M87b6wcY7zhEDdenS9ty1Ak8wfU8Py6oo7kwSRQZkCWXohI9F2OEj4
 H48sQo3TiHd5eW6Cduzj4V9WMAMZQXBjgFpoV7Mog0Xe+AKG4nxktS30Xar0SKtBoeiIKQ6Te
 S/9Lv2bqBo+Gzy/0J6ntLQVRVLpoodpeewKpBOzIOdanzggxYY/o0qeFoCJhsAUc8vm85njZT
 Ciiy2Y2jIdG5PEvNhzkCW5mDIcxdW0us/wagMRYhpC7WRG9e/K6A2rfsmV0HVa0+nFt/ydhl0
 xdrCB/W8WFLB/JQDE6ZmhDv3Otev3DaPzIjziW5ssD8ZK7mizdl0z40fY01fvgbV+JVS8qf6t
 jHSe/O9f9eX2W7aov7+aBvXzpzFz7ZzJ2H4vXKyhg6lUrz6QzWd/dSucsCcaf6DgOLdPlFnWJ
 6nqTL0z2BLwvZ7IVxCw5YvdF7dFhv7ScWIIZClEuHE103PT3FZ7uX8024QltXaIXPaxhvj/Uk
 lxidnTLLP/a/QH9irn5VHjOqc0dYLFBowphGxn5DWHvBrEtLNoLK8xvWH07du+kh/AdsDmT+i
 y00xycnh+dI2MQMw7UfFdvMgTcycgBeHAqznq5QflslPdn/7HxmY0mxxHdhTdJffQ/3dv59iD
 B3YKL7cbj2ObFKLDdDIbqsWoHct8k2MJtHHycp49LnbdpB57P0b9RlIQoy7G9xMDK9lWJOhr9
 Gqqwk+CyUOtS7c5Is4AsGasB6LD0GAwH/0uX1lFtNK9q8r33SKBpU2T8ERWnBOPamAujcv4p4
 H4CxNuIU7ovSOPSPo3CeB/tWle/HgI/qMxTc28OQqSFud7BUCqHfsGFNPr/QYVMm8lwZd6/cv
 hbcLY8Dde72CQaaJkc6gecdT5gWZoI03EDRHSQ1TsiF1bp/4quqXQhiz4BPnbYLm3+JMMZPVO
 tD4oZlYWN5B2h9cYvSjTqD7ZeyfqaaRY4l/COUck3PS6dLdm5HbYlVz+B1N4PmR+xZQJGf6+b
 BRPRh+f67N59SoY3tBqA7T9dCbGhWEUSL1mj+4KGxriRte8SotKf3YDSQrqjvb5vfnO2TmDz8
 tV0ROj0LjPRghcL2dw42gN7m3hoWskmXsqJvYMng1XYEXi1J+6GJ0vWPkFEi4h9bVWlc0P6fn
 xtmGZL30fexB3OiXLHgbJCJxWqtT58i3TJT17Loppza6Cbu4HDXtjU22gBPwsubRWTxnF+zVd
 1vR/F/aN3tJM1nY9s5NV0cggSGFmUtU/kUlwRvw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests print a file before searching for a pattern using
test_i18ngrep.  This is useful when debugging tests with --verbose when
the pattern is not found as expected.

Since 63b1a175ee (t: make 'test_i18ngrep' more informative on failure,
2018-02-08) test_i18ngrep already shows the contents of a file that
doesn't match the expected pattern, though.

So don't bother doing the same unconditionally up-front.  The contents
are not interesting if the expected pattern is found, and showing it
twice if it doesn't match is of no use.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Almost formatted it using -U1..

 t/t1450-fsck.sh            | 16 ----------------
 t/t5801-remote-helpers.sh  |  1 -
 t/t7400-submodule-basic.sh |  2 --
 t/t9300-fast-import.sh     | 13 -------------
 4 files changed, 32 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b36e0528d0..50d28e6fdb 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -70,7 +70,6 @@ test_expect_success 'object with bad sha1' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&

 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "$sha.*corrupt" out
 '

@@ -78,7 +77,6 @@ test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "not a commit" out
 '

@@ -88,7 +86,6 @@ test_expect_success 'HEAD link pointing at a funny objec=
t' '
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "detached HEAD points" out
 '

@@ -98,7 +95,6 @@ test_expect_success 'HEAD link pointing at a funny place=
' '
 	echo "ref: refs/funny/place" >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "HEAD points to something strange" out
 '

@@ -157,7 +153,6 @@ test_expect_success 'email with embedded > is not okay=
' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new" out
 '

@@ -169,7 +164,6 @@ test_expect_success 'missing < email delimiter is repo=
rted nicely' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new.* - bad name" out
 '

@@ -181,7 +175,6 @@ test_expect_success 'missing email is reported nicely'=
 '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new.* - missing email" out
 '

@@ -193,7 +186,6 @@ test_expect_success '> in name is reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new" out
 '

@@ -207,7 +199,6 @@ test_expect_success 'integer overflow in timestamps is=
 reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new.*integer overflow" out
 '

@@ -219,7 +210,6 @@ test_expect_success 'commit with NUL in header' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	cat out &&
 	test_i18ngrep "error in commit $new.*unterminated header: NUL at offset"=
 out
 '

@@ -297,7 +287,6 @@ test_expect_success 'tag pointing to nonexistent' '
 	echo $tag >.git/refs/tags/invalid &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
-	cat out &&
 	test_i18ngrep "broken link" out
 '

@@ -378,7 +367,6 @@ test_expect_success 'tag with NUL in header' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	cat out &&
 	test_i18ngrep "error in tag $tag.*unterminated header: NUL at offset" ou=
t
 '

@@ -409,7 +397,6 @@ test_expect_success 'rev-list --verify-objects with ba=
d sha1' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&

 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/nul=
l 2>out &&
-	cat out &&
 	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" =
out
 '

@@ -433,7 +420,6 @@ test_expect_success 'fsck notices blob entry pointing =
to null sha1' '
 	 sha=3D$(printf "100644 file$_bz$_bzoid" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  cat out &&
 	  test_i18ngrep "warning.*null sha1" out
 	)
 '
@@ -444,7 +430,6 @@ test_expect_success 'fsck notices submodule entry poin=
ting to null sha1' '
 	 sha=3D$(printf "160000 submodule$_bz$_bzoid" |
 	       git hash-object -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  cat out &&
 	  test_i18ngrep "warning.*null sha1" out
 	)
 '
@@ -465,7 +450,6 @@ while read name path pretty; do
 			printf "$mode $type %s\t%s" "$value" "$path" >bad &&
 			bad_tree=3D$(git mktree <bad) &&
 			git fsck 2>out &&
-			cat out &&
 			test_i18ngrep "warning.*tree $bad_tree" out
 		)'
 	done <<-\EOF
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 2d6c4a281e..121e5c6edb 100755
=2D-- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -247,7 +247,6 @@ clean_mark () {
 test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=3D1 git fetch 2>error &&
-	cat error &&
 	test_i18ngrep -q "error while running fast-import" error
 	)
 '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a208cb26e1..691b5fc3bf 100755
=2D-- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -527,7 +527,6 @@ test_expect_success 'update --init' '
 	test_must_fail git config submodule.example.url &&

 	git submodule update init 2> update.out &&
-	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&

@@ -545,7 +544,6 @@ test_expect_success 'update --init from subdirectory' =
'
 	(
 		cd sub &&
 		git submodule update ../init 2>update.out &&
-		cat update.out &&
 		test_i18ngrep "not initialized" update.out &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 141b7fa35e..0a44a06239 100755
=2D-- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2781,7 +2781,6 @@ test_expect_success 'S: filemodify with garbage afte=
r mark must fail' '
 	COMMIT
 	M 100644 :403x hello.c
 	EOF
-	cat err &&
 	test_i18ngrep "space after mark" err
 '

@@ -2798,7 +2797,6 @@ test_expect_success 'S: filemodify with garbage afte=
r inline must fail' '
 	inline
 	BLOB
 	EOF
-	cat err &&
 	test_i18ngrep "nvalid dataref" err
 '

@@ -2812,7 +2810,6 @@ test_expect_success 'S: filemodify with garbage afte=
r sha1 must fail' '
 	COMMIT
 	M 100644 ${sha1}x hello.c
 	EOF
-	cat err &&
 	test_i18ngrep "space after SHA1" err
 '

@@ -2828,7 +2825,6 @@ test_expect_success 'S: notemodify with garbage afte=
r mark dataref must fail' '
 	COMMIT
 	N :202x :302
 	EOF
-	cat err &&
 	test_i18ngrep "space after mark" err
 '

@@ -2844,7 +2840,6 @@ test_expect_success 'S: notemodify with garbage afte=
r inline dataref must fail'
 	note blob
 	BLOB
 	EOF
-	cat err &&
 	test_i18ngrep "nvalid dataref" err
 '

@@ -2858,7 +2853,6 @@ test_expect_success 'S: notemodify with garbage afte=
r sha1 dataref must fail' '
 	COMMIT
 	N ${sha1}x :302
 	EOF
-	cat err &&
 	test_i18ngrep "space after SHA1" err
 '

@@ -2874,7 +2868,6 @@ test_expect_success 'S: notemodify with garbage afte=
r mark commit-ish must fail'
 	COMMIT
 	N :202 :302x
 	EOF
-	cat err &&
 	test_i18ngrep "after mark" err
 '

@@ -2908,7 +2901,6 @@ test_expect_success 'S: from with garbage after mark=
 must fail' '
 	EOF

 	# now evaluate the error
-	cat err &&
 	test_i18ngrep "after mark" err
 '

@@ -2928,7 +2920,6 @@ test_expect_success 'S: merge with garbage after mar=
k must fail' '
 	merge :303x
 	M 100644 :403 hello.c
 	EOF
-	cat err &&
 	test_i18ngrep "after mark" err
 '

@@ -2944,7 +2935,6 @@ test_expect_success 'S: tag with garbage after mark =
must fail' '
 	tag S
 	TAG
 	EOF
-	cat err &&
 	test_i18ngrep "after mark" err
 '

@@ -2955,7 +2945,6 @@ test_expect_success 'S: cat-blob with garbage after =
mark must fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	cat-blob :403x
 	EOF
-	cat err &&
 	test_i18ngrep "after mark" err
 '

@@ -2966,7 +2955,6 @@ test_expect_success 'S: ls with garbage after mark m=
ust fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	ls :302x hello.c
 	EOF
-	cat err &&
 	test_i18ngrep "space after mark" err
 '

@@ -2975,7 +2963,6 @@ test_expect_success 'S: ls with garbage after sha1 m=
ust fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	ls ${sha1}x hello.c
 	EOF
-	cat err &&
 	test_i18ngrep "space after tree-ish" err
 '

=2D-
2.23.0
