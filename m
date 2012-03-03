From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2-w 101/105] t7004 (tag): modernize style
Date: Fri,  2 Mar 2012 18:15:38 -0800
Message-ID: <1330740942-25130-7-git-send-email-tmgrennan@gmail.com>
References: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3eWe-0001tn-Ky
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199Ab2CCCQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:16:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37868 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852Ab2CCCQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:16:10 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so2055487vbb.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:16:10 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.76.7 as permitted sender) client-ip=10.52.76.7;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.76.7 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.76.7])
        by 10.52.76.7 with SMTP id g7mr20626674vdw.104.1330740970088 (num_hops = 1);
        Fri, 02 Mar 2012 18:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=QiwOc9z2pZ/gnHs3C0UWkVh1BYs+QYs46nYd3xJ5jcA=;
        b=oj0v0sEFLvw9kk1qugouLQQrxbgrvgXVCcSUygs7uzpD06eQT5mimeR4vCqptlLXdw
         aHrmXCDvvLMOoh2Urc4r4KSxWVVcWcUNu3UObzzB6o1xGrp8e9y5uNwA6A849kuB6s3B
         nBQpMftB15YXEJUWChAWsBGJnv6MBG8UUpTpfVDf2PnNTi+C58dKKSmHoJsTBqCI8y8c
         Z1rLwE4jIESg7HHe+GWjbBfSxUMplG6iQCfVReIXTxSLoqcFWoE5s3AFsja6FEYQ3UWb
         0v5K/CZSHs8Z8Tz0CgeAEnWyBCLAOKIo+1U4JF3Oanbc540YEq1Q2xgRnbVMuytgTisw
         wjxg==
Received: by 10.52.76.7 with SMTP id g7mr17632176vdw.104.1330740970017;
        Fri, 02 Mar 2012 18:16:10 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id e10sm11763981vdj.21.2012.03.02.18.16.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:16:09 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330740942-25130-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192083>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks
- Use >FILE instead of > FILE
- Use a "here" filter for generation of expect files with mixed tabs and
  spaces

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t7004-tag.sh |  590 +++++++++++++++++++++++++++++++-------------------------
 1 files changed, 328 insertions(+), 262 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index f8c247a..f819f41 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -27,8 +27,9 @@ test_expect_success 'listing all tags in an empty tree should output nothing' '
 	test `git tag | wc -l` -eq 0
 '
 
-test_expect_success 'looking for a tag in an empty tree should fail' \
-	'! (tag_exists mytag)'
+test_expect_success 'looking for a tag in an empty tree should fail' '
+	! tag_exists mytag
+'
 
 test_expect_success 'creating a tag in an empty tree should fail' '
 	test_must_fail git tag mynotag &&
@@ -66,27 +67,32 @@ test_expect_success 'listing all tags if one exists should output that tag' '
 
 # pattern matching:
 
-test_expect_success 'listing a tag using a matching pattern should succeed' \
-	'git tag -l mytag'
+test_expect_success 'listing a tag using a matching pattern should succeed' '
+	git tag -l mytag
+'
 
 test_expect_success \
-	'listing a tag using a matching pattern should output that tag' \
-	'test `git tag -l mytag` = mytag'
+	'listing a tag using a matching pattern should output that tag' '
+	test `git tag -l mytag` = mytag
+'
 
 # todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success \
-	'listing tags using a non-matching pattern should suceed' \
-	'git tag -l xxx'
+	'listing tags using a non-matching pattern should suceed' '
+	git tag -l xxx
+'
 
 test_expect_success \
-	'listing tags using a non-matching pattern should output nothing' \
-	'test `git tag -l xxx | wc -l` -eq 0'
+	'listing tags using a non-matching pattern should output nothing' '
+	test `git tag -l xxx | wc -l` -eq 0
+'
 
 # special cases for creating tags:
 
 test_expect_success \
-	'trying to create a tag with the name of one existing should fail' \
-	'test_must_fail git tag mytag'
+	'trying to create a tag with the name of one existing should fail' '
+	test_must_fail git tag mytag
+'
 
 test_expect_success \
 	'trying to create a tag with a non-valid name should fail' '
@@ -111,15 +117,17 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 	test_must_fail git tag -d unknown-tag
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'trying to delete tags without params should succeed and do nothing' '
+	cat >expect <<-EOF &&
 myhead
 mytag
 EOF
-test_expect_success \
-	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+	git tag -l >actual &&
+	test_cmp expect actual &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success \
@@ -147,12 +155,15 @@ test_expect_success \
 	! tag_exists myhead
 '
 
-test_expect_success 'trying to delete an already deleted tag should fail' \
-	'test_must_fail git tag -d mytag'
+test_expect_success \
+	'trying to delete an already deleted tag should fail' '
+	test_must_fail git tag -d mytag
+'
 
 # listing various tags with pattern matching:
 
-cat >expect <<EOF
+test_expect_success 'listing all tags should print them ordered' '
+	cat >expect <<-EOF &&
 a1
 aa1
 cba
@@ -163,7 +174,6 @@ v1.0
 v1.0.1
 v1.1.3
 EOF
-test_expect_success 'listing all tags should print them ordered' '
 	git tag v1.0.1 &&
 	git tag t211 &&
 	git tag aa1 &&
@@ -179,81 +189,81 @@ test_expect_success 'listing all tags should print them ordered' '
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'listing tags with substring as pattern must print those matching' '
+	cat >expect <<-EOF &&
 a1
 aa1
 cba
 EOF
-test_expect_success \
-	'listing tags with substring as pattern must print those matching' '
 	rm *a* &&
 	git tag -l "*a*" > current &&
 	test_cmp expect current
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'listing tags with a suffix as pattern must print those matching' '
+	cat >expect <<-EOF &&
 v0.2.1
 v1.0.1
 EOF
-test_expect_success \
-	'listing tags with a suffix as pattern must print those matching' '
 	git tag -l "*.1" > actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'listing tags with a prefix as pattern must print those matching' '
+	cat >expect <<-EOF &&
 t210
 t211
 EOF
-test_expect_success \
-	'listing tags with a prefix as pattern must print those matching' '
 	git tag -l "t21*" > actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-a1
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-EOF &&
+		a1
+	EOF
 	git tag -l a1 > actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-v1.0
-EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
+	cat >expect <<-EOF &&
+		v1.0
+	EOF
 	git tag -l v1.0 > actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'listing tags with ? in the pattern should print those matching' '
+	cat >expect <<-EOF &&
 v1.0.1
 v1.1.3
 EOF
-test_expect_success \
-	'listing tags with ? in the pattern should print those matching' '
 	git tag -l "v1.?.?" > actual &&
 	test_cmp expect actual
 '
 
->expect
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
+	>expect &&
 	git tag -l "v.*" > actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
+test_expect_success \
+	'listing tags using v* should print only those having v' '
+	cat >expect <<-EOF &&
 v0.2.1
 v1.0
 v1.0.1
 v1.1.3
 EOF
-test_expect_success \
-	'listing tags using v* should print only those having v' '
 	git tag -l "v*" > actual &&
 	test_cmp expect actual
 '
@@ -272,66 +282,73 @@ test_expect_success \
 	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
 '
 
-test_expect_success 'trying to verify an unknown tag should fail' \
-	'test_must_fail git tag -v unknown-tag'
+test_expect_success 'trying to verify an unknown tag should fail' '
+	test_must_fail git tag -v unknown-tag
+'
 
 test_expect_success \
-	'trying to verify a non-annotated and non-signed tag should fail' \
-	'test_must_fail git tag -v non-annotated-tag'
+	'trying to verify a non-annotated and non-signed tag should fail' '
+	test_must_fail git tag -v non-annotated-tag
+'
 
 test_expect_success \
-	'trying to verify many non-annotated or unknown tags, should fail' \
-	'test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2'
+	'trying to verify many non-annotated or unknown tags, should fail' '
+	test_must_fail git tag -v unknown-tag1 non-annotated-tag unknown-tag2
+'
 
 # creating annotated tags:
 
+here='s/\\s/ /g; s/\\t/\t/g; s/\\n/\n/g'
+
 get_tag_msg () {
 	git cat-file tag "$1" | sed -e "/BEGIN PGP/q"
 }
 
 # run test_tick before committing always gives the time in that timezone
 get_tag_header () {
-cat <<EOF
+	# name, object, type, time
+	cat <<-EOF &&
 object $2
 type $3
 tag $1
 tagger C O Mitter <committer@example.com> $4 -0700
 
 EOF
+	sed -e "$here"
 }
 
-commit=$(git rev-parse HEAD)
-time=$test_tick
-
-get_tag_header annotated-tag $commit commit $time >expect
-echo "A message" >>expect
 test_expect_success \
 	'creating an annotated tag with -m message should succeed' '
+	commit=$(git rev-parse HEAD) &&
+	time=$test_tick &&
+	get_tag_header annotated-tag $commit commit $time \
+		>expect <<-EOF &&
+		A message
+	EOF
 	git tag -m "A message" annotated-tag &&
 	get_tag_msg annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >msgfile <<EOF
-Another message
-in a file.
-EOF
-get_tag_header file-annotated-tag $commit commit $time >expect
-cat msgfile >>expect
 test_expect_success \
 	'creating an annotated tag with -F messagefile should succeed' '
+	cat >msgfile <<-EOF &&
+		A message from the
+		standard input
+	EOF
+	get_tag_header file-annotated-tag $commit commit $time >expect <msgfile
 	git tag -F msgfile file-annotated-tag &&
 	get_tag_msg file-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >inputmsg <<EOF
+test_expect_success 'creating an annotated tag with -F - should succeed' '
+	cat >inputmsg <<-EOF &&
 A message from the
 standard input
 EOF
-get_tag_header stdin-annotated-tag $commit commit $time >expect
-cat inputmsg >>expect
-test_expect_success 'creating an annotated tag with -F - should succeed' '
+	get_tag_header stdin-annotated-tag $commit commit $time \
+		>expect <inputmsg
 	git tag -F - stdin-annotated-tag <inputmsg &&
 	get_tag_msg stdin-annotated-tag >actual &&
 	test_cmp expect actual
@@ -361,29 +378,47 @@ test_expect_success \
 
 # blank and empty messages:
 
-get_tag_header empty-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with an empty -m message should succeed' '
+	>emptyfile &&
+	get_tag_header empty-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -m "" empty-annotated-tag &&
 	get_tag_msg empty-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
->emptyfile
-get_tag_header emptyfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with an empty -F messagefile should succeed' '
+	get_tag_header emptyfile-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -F emptyfile emptyfile-annotated-tag &&
 	get_tag_msg emptyfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' >blanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>blanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>blanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>blanksfile
-get_tag_header blanks-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
+test_expect_success \
+	'extra blanks in the message for an annotated tag should be removed' '
+	sed -e "$here" >blanksfile <<-\EOF &&
+
+		\s\s
+		\t
+		Leading blank lines
+
+		\t\s\t\s\s
+		Repeated blank lines
+
+
+
+		Trailing spaces\s\s\s\s\s\s\t\s\s
+
+		Trailing blank lines
+
+		\t\s
+
+	EOF
+	get_tag_header blanks-annotated-tag $commit commit $time \
+		>expect <<-EOF &&
 Leading blank lines
 
 Repeated blank lines
@@ -392,36 +427,38 @@ Trailing spaces
 
 Trailing blank lines
 EOF
-test_expect_success \
-	'extra blanks in the message for an annotated tag should be removed' '
 	git tag -F blanksfile blanks-annotated-tag &&
 	get_tag_msg blanks-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header blank-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with blank -m message with spaces should succeed' '
+	get_tag_header blank-annotated-tag $commit commit $time >expect <emptyfile &&
 	git tag -m "     " blank-annotated-tag &&
 	get_tag_msg blank-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-echo '     ' >blankfile
-echo ''      >>blankfile
-echo '  '    >>blankfile
-get_tag_header blankfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with blank -F messagefile with spaces should succeed' '
+	sed -e "$here" >blankfile <<-\EOF &&
+		\s\s\s\s\s
+
+		\s\s
+	EOF
+	get_tag_header blankfile-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -F blankfile blankfile-annotated-tag &&
 	get_tag_msg blankfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '      ' >blanknonlfile
-get_tag_header blanknonlfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with -F file of spaces and no newline should succeed' '
+	printf "      " >blanknonlfile &&
+	get_tag_header blanknonlfile-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -F blanknonlfile blanknonlfile-annotated-tag &&
 	get_tag_msg blanknonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -429,7 +466,9 @@ test_expect_success \
 
 # messages with commented lines:
 
-cat >commentsfile <<EOF
+test_expect_success \
+	'creating a tag using a -F messagefile with #comments should succeed' '
+	cat >commentsfile <<-EOF &&
 # A comment
 
 ############
@@ -446,8 +485,8 @@ Another line.
 
 Last line.
 EOF
-get_tag_header comments-annotated-tag $commit commit $time >expect
-cat >>expect <<EOF
+	get_tag_header comments-annotated-tag $commit commit $time \
+		>expect <<-EOF &&
 The message.
 One line.
 
@@ -455,36 +494,39 @@ Another line.
 
 Last line.
 EOF
-test_expect_success \
-	'creating a tag using a -F messagefile with #comments should succeed' '
 	git tag -F commentsfile comments-annotated-tag &&
 	get_tag_msg comments-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header comment-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with a #comment in the -m message should succeed' '
+	get_tag_header comment-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -m "#comment" comment-annotated-tag &&
 	get_tag_msg comment-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-echo '#comment' >commentfile
-echo ''         >>commentfile
-echo '####'     >>commentfile
-get_tag_header commentfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with #comments in the -F messagefile should succeed' '
+	cat >commentfile <<-EOF &&
+		#comment
+
+		####
+	EOF
+	get_tag_header commentfile-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -F commentfile commentfile-annotated-tag &&
 	get_tag_msg commentfile-annotated-tag >actual &&
 	test_cmp expect actual
 '
 
-printf '#comment' >commentnonlfile
-get_tag_header commentnonlfile-annotated-tag $commit commit $time >expect
 test_expect_success \
 	'creating a tag with a file of #comment and no newline should succeed' '
+	printf "#comment" >commentnonlfile &&
+	get_tag_header commentnonlfile-annotated-tag $commit commit $time \
+		>expect <emptyfile &&
 	git tag -F commentnonlfile commentnonlfile-annotated-tag &&
 	get_tag_msg commentnonlfile-annotated-tag >actual &&
 	test_cmp expect actual
@@ -542,11 +584,13 @@ test_expect_success \
 	test_cmp expect actual
 '
 
-echo 'tag line one' >annotagmsg
-echo 'tag line two' >>annotagmsg
-echo 'tag line three' >>annotagmsg
 test_expect_success \
 	'listing many message lines of a non-signed tag should succeed' '
+	cat >annotagmsg <<-EOF &&
+		tag line one
+		tag line two
+		tag line three
+	EOF
 	git tag -F annotagmsg tag-lines &&
 
 	echo "tag-lines" >expect &&
@@ -621,20 +665,22 @@ test_expect_success GPG \
 
 # creating and verifying signed tags:
 
-get_tag_header signed-tag $commit commit $time >expect
-echo 'A signed tag message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG 'creating a signed tag with -m message should succeed' '
+test_expect_success GPG \
+	'creating a signed tag with -m message should succeed' '
+	get_tag_header signed-tag $commit commit $time >expect <<-EOF &&
+		A signed tag message
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "A signed tag message" signed-tag &&
 	get_tag_msg signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header u-signed-tag $commit commit $time >expect
-echo 'Another message' >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG 'sign with a given key id' '
-
+	get_tag_header u-signed-tag $commit commit $time >expect <<-EOF &&
+		Another message
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -u committer@example.com -m "Another message" u-signed-tag &&
 	get_tag_msg u-signed-tag >actual &&
 	test_cmp expect actual
@@ -654,54 +700,54 @@ test_expect_success GPG 'sign with an unknown id (2)' '
 
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
+test_expect_success GPG '-u implies signed tag' '
+	write_script fakeeditor <<-\EOF &&
 test -n "$1" && exec >"$1"
 echo A signed tag message
 echo from a fake editor.
 EOF
-chmod +x fakeeditor
-
-get_tag_header implied-sign $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG '-u implies signed tag' '
+	get_tag_header implied-sign $commit commit $time >expect <<-EOF &&
+		A signed tag message
+		from a fake editor.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	GIT_EDITOR=./fakeeditor git tag -u CDDE430D implied-sign &&
 	get_tag_msg implied-sign >actual &&
 	test_cmp expect actual
 '
 
-cat >sigmsgfile <<EOF
+test_expect_success GPG \
+	'creating a signed tag with -F messagefile should succeed' '
+	cat >sigmsgfile <<-EOF
 Another signed tag
 message in a file.
 EOF
-get_tag_header file-signed-tag $commit commit $time >expect
-cat sigmsgfile >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with -F messagefile should succeed' '
+	get_tag_header file-signed-tag $commit commit $time >expect <sigmsgfile
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect
 	git tag -s -F sigmsgfile file-signed-tag &&
 	get_tag_msg file-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >siginputmsg <<EOF
+test_expect_success GPG 'creating a signed tag with -F - should succeed' '
+	cat >siginputmsg <<-EOF
 A signed tag message from
 the standard input
 EOF
-get_tag_header stdin-signed-tag $commit commit $time >expect
-cat siginputmsg >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG 'creating a signed tag with -F - should succeed' '
+	get_tag_header stdin-signed-tag $commit commit $time \
+		>expect <siginputmsg &&
+	echo "-----BEGIN PGP SIGNATURE-----" >>expect
 	git tag -s -F - stdin-signed-tag <siginputmsg &&
 	get_tag_msg stdin-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header implied-annotate $commit commit $time >expect
-./fakeeditor >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG '-s implies annotated tag' '
+	get_tag_header implied-annotate $commit commit $time >expect <<-EOF &&
+		A signed tag message
+		from a fake editor.
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	GIT_EDITOR=./fakeeditor git tag -s implied-annotate &&
 	get_tag_msg implied-annotate >actual &&
 	test_cmp expect actual
@@ -715,11 +761,14 @@ test_expect_success GPG \
 	! tag_exists nosigtag
 '
 
-test_expect_success GPG 'verifying a signed tag should succeed' \
-	'git tag -v signed-tag'
+test_expect_success GPG 'verifying a signed tag should succeed' '
+	git tag -v signed-tag
+'
 
-test_expect_success GPG 'verifying two signed tags in one command should succeed' \
-	'git tag -v signed-tag file-signed-tag'
+test_expect_success GPG \
+	'verifying two signed tags in one command should succeed' '
+	git tag -v signed-tag file-signed-tag
+'
 
 test_expect_success GPG \
 	'verifying many signed and non-signed tags should fail' '
@@ -740,33 +789,52 @@ test_expect_success GPG 'verifying a forged tag should fail' '
 
 # blank and empty messages for signed tags:
 
-get_tag_header empty-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with an empty -m message should succeed' '
+	get_tag_header empty-signed-tag $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "" empty-signed-tag &&
 	get_tag_msg empty-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v empty-signed-tag
 '
 
->sigemptyfile
-get_tag_header emptyfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with an empty -F messagefile should succeed' '
+	>sigemptyfile &&
+	get_tag_header emptyfile-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -F sigemptyfile emptyfile-signed-tag &&
 	get_tag_msg emptyfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
-printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
-printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
-printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
-get_tag_header blanks-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
+test_expect_success GPG \
+	'extra blanks in the message for a signed tag should be removed' '
+	sed -e "$here" >sigblanksfile <<-\EOF &&
+
+		\s\s
+		\t
+		Leading blank lines
+
+		\t\s\t\s\s
+		Repeated blank lines
+
+
+
+		Trailing spaces\s\s\s\s\s\s\t\s\s
+
+		Trailing blank lines
+
+		\t\s
+
+	EOF
+	get_tag_header blanks-signed-tag $commit commit $time \
+		>expect <<-EOF &&
 Leading blank lines
 
 Repeated blank lines
@@ -774,53 +842,61 @@ Repeated blank lines
 Trailing spaces
 
 Trailing blank lines
+		-----BEGIN PGP SIGNATURE-----
 EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'extra blanks in the message for a signed tag should be removed' '
 	git tag -s -F sigblanksfile blanks-signed-tag &&
 	get_tag_msg blanks-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blanks-signed-tag
 '
 
-get_tag_header blank-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with a blank -m message should succeed' '
+	get_tag_header blank-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "     " blank-signed-tag &&
 	get_tag_msg blank-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blank-signed-tag
 '
 
-echo '     ' >sigblankfile
-echo ''      >>sigblankfile
-echo '  '    >>sigblankfile
-get_tag_header blankfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with blank -F file with spaces should succeed' '
+	sed -e "$here" >sigblankfile <<-\EOF &&
+		\s\s\s\s\s
+
+		\s\s
+	EOF
+	get_tag_header blankfile-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -F sigblankfile blankfile-signed-tag &&
 	get_tag_msg blankfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v blankfile-signed-tag
 '
 
-printf '      ' >sigblanknonlfile
-get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with spaces and no newline should succeed' '
+	printf >sigblanknonlfile "      " &&
+	get_tag_header blanknonlfile-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
 	get_tag_msg blanknonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
-	git tag -v signed-tag
+	git tag -v blanknonlfile-signed-tag
 '
 
 # messages with commented lines for signed tags:
 
-cat >sigcommentsfile <<EOF
+test_expect_success GPG \
+	'creating a signed tag with a -F file with #comments should succeed' '
+	cat >sigcommentsfile <<-EOF &&
 # A comment
 
 ############
@@ -837,52 +913,57 @@ Another line.
 
 Last line.
 EOF
-get_tag_header comments-signed-tag $commit commit $time >expect
-cat >>expect <<EOF
+	get_tag_header comments-signed-tag $commit commit $time \
+		>expect <<-EOF &&
 The message.
 One line.
 
 Another line.
 
 Last line.
+		-----BEGIN PGP SIGNATURE-----
 EOF
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with a -F file with #comments should succeed' '
 	git tag -s -F sigcommentsfile comments-signed-tag &&
 	get_tag_msg comments-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v comments-signed-tag
 '
 
-get_tag_header comment-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with #commented -m message should succeed' '
+	get_tag_header comment-signed-tag $commit commit $time >expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "#comment" comment-signed-tag &&
 	get_tag_msg comment-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v comment-signed-tag
 '
 
-echo '#comment' >sigcommentfile
-echo ''         >>sigcommentfile
-echo '####'     >>sigcommentfile
-get_tag_header commentfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with #commented -F messagefile should succeed' '
+	cat >sigcommentfile <<-EOF &&
+		#comment
+
+		####
+	EOF
+	get_tag_header commentfile-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -F sigcommentfile commentfile-signed-tag &&
 	get_tag_msg commentfile-signed-tag >actual &&
 	test_cmp expect actual &&
 	git tag -v commentfile-signed-tag
 '
 
-printf '#comment' >sigcommentnonlfile
-get_tag_header commentnonlfile-signed-tag $commit commit $time >expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag with a #comment and no newline should succeed' '
+	printf "#comment" >sigcommentnonlfile &&
+	get_tag_header commentnonlfile-signed-tag $commit commit $time \
+		>expect <<-EOF &&
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -F sigcommentnonlfile commentnonlfile-signed-tag &&
 	get_tag_msg commentnonlfile-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -941,11 +1022,13 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-echo 'stag line one' >sigtagmsg
-echo 'stag line two' >>sigtagmsg
-echo 'stag line three' >>sigtagmsg
 test_expect_success GPG \
 	'listing many message lines of a signed tag should succeed' '
+	cat >sigtagmsg <<-EOF &&
+		stag line one
+		stag line two
+		stag line three
+	EOF
 	git tag -s -F sigtagmsg stag-lines &&
 
 	echo "stag-lines" >expect &&
@@ -987,72 +1070,68 @@ test_expect_success GPG \
 
 # tags pointing to objects different from commits:
 
-tree=$(git rev-parse HEAD^{tree})
-blob=$(git rev-parse HEAD:foo)
-tag=$(git rev-parse signed-tag 2>/dev/null)
-
-get_tag_header tree-signed-tag $tree tree $time >expect
-echo "A message for a tree" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to a tree should succeed' '
+	tree=$(git rev-parse HEAD^{tree}) &&
+	blob=$(git rev-parse HEAD:foo) &&
+	tag=$(git rev-parse signed-tag) &&
+	get_tag_header tree-signed-tag $tree tree $time >expect <<-EOF &&
+		A message for a tree
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "A message for a tree" tree-signed-tag HEAD^{tree} &&
 	get_tag_msg tree-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header blob-signed-tag $blob blob $time >expect
-echo "A message for a blob" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to a blob should succeed' '
+	get_tag_header blob-signed-tag $blob blob $time >expect <<-EOF &&
+		A message for a blob
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "A message for a blob" blob-signed-tag HEAD:foo &&
 	get_tag_msg blob-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-get_tag_header tag-signed-tag $tag tag $time >expect
-echo "A message for another tag" >>expect
-echo '-----BEGIN PGP SIGNATURE-----' >>expect
 test_expect_success GPG \
 	'creating a signed tag pointing to another tag should succeed' '
+	get_tag_header tag-signed-tag $tag tag $time >expect <<-EOF &&
+		A message for another tag
+		-----BEGIN PGP SIGNATURE-----
+	EOF
 	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
 	get_tag_msg tag-signed-tag >actual &&
 	test_cmp expect actual
 '
 
 # usage with rfc1991 signatures
-echo "rfc1991" > gpghome/gpg.conf
-get_tag_header rfc1991-signed-tag $commit commit $time >expect
-echo "RFC1991 signed tag" >>expect
-echo '-----BEGIN PGP MESSAGE-----' >>expect
-test_expect_success GPG \
-	'creating a signed tag with rfc1991' '
+test_expect_success GPG 'creating a signed tag with rfc1991' '
+	echo "rfc1991" >gpghome/gpg.conf &&
+	get_tag_header rfc1991-signed-tag $commit commit $time >expect <<-EOF &&
+		RFC1991 signed tag
+		-----BEGIN PGP MESSAGE-----
+	EOF
 	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
 	get_tag_msg rfc1991-signed-tag >actual &&
 	test_cmp expect actual
 '
 
-cat >fakeeditor <<'EOF'
-#!/bin/sh
+test_expect_success GPG 'reediting a signed tag body omits signature' '
+	write_script fakeeditor <<-\EOF &&
 cp "$1" actual
 EOF
-chmod +x fakeeditor
-
-test_expect_success GPG \
-	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'verifying rfc1991 signature' '
+test_expect_success GPG 'verifying rfc1991 signature' '
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
-	'list tag with rfc1991 signature' '
+test_expect_success GPG 'list tag with rfc1991 signature' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1062,15 +1141,12 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-rm -f gpghome/gpg.conf
-
-test_expect_success GPG \
-	'verifying rfc1991 signature without --rfc1991' '
+test_expect_success GPG 'verifying rfc1991 signature without --rfc1991' '
+	rm -f gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
-	'list tag with rfc1991 signature without --rfc1991' '
+test_expect_success GPG 'list tag with rfc1991 signature without --rfc1991' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
 	test_cmp expect actual &&
@@ -1080,26 +1156,26 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
-	'reediting a signed tag body omits signature' '
+test_expect_success GPG 'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'git tag -s fails if gpg is misconfigured' '
 # try to sign with bad user.signingkey
-git config user.signingkey BobTheMouse
-test_expect_success GPG \
-	'git tag -s fails if gpg is misconfigured' \
-	'test_must_fail git tag -s -m tail tag-gpg-failure'
+	git config user.signingkey BobTheMouse &&
+	test_must_fail git tag -s -m tail tag-gpg-failure &&
 git config --unset user.signingkey
+'
 
 # try to verify without gpg:
 
-rm -rf gpghome
 test_expect_success GPG \
-	'verify signed tag fails when public key is not present' \
-	'test_must_fail git tag -v signed-tag'
+	'verify signed tag fails when public key is not present' '
+	rm -rf gpghome &&
+	test_must_fail git tag -v signed-tag
+'
 
 test_expect_success \
 	'git tag -a fails if tag annotation is empty' '
@@ -1126,12 +1202,13 @@ test_expect_success \
 	test_cmp rest.expect rest.actual
 '
 
-get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
 test_expect_success \
 	'overwriting an annoted tag should use its previous body' '
+	get_tag_header reuse $commit commit $time >expect <<-EOF &&
+		reuse
+	EOF
 	git tag -a -m "An annotation to be reused" reuse &&
-	GIT_EDITOR=true git tag -f -a reuse &&
+	GIT_EDITOR=true git tag -f -a -m "reuse" reuse &&
 	get_tag_msg reuse >actual &&
 	test_cmp expect actual
 '
@@ -1158,68 +1235,61 @@ test_expect_success 'filename for the message is relative to cwd' '
 
 # create a few more commits to test --contains
 
-hash1=$(git rev-parse HEAD)
-
 test_expect_success 'creating second commit and tag' '
+	hash1=$(git rev-parse HEAD) &&
 	echo foo-2.0 >foo &&
 	git add foo &&
 	git commit -m second &&
+	hash2=$(git rev-parse HEAD) &&
 	git tag v2.0
 '
 
-hash2=$(git rev-parse HEAD)
-
 test_expect_success 'creating third commit without tag' '
 	echo foo-dev >foo &&
 	git add foo &&
-	git commit -m third
-'
-
+	git commit -m third &&
 hash3=$(git rev-parse HEAD)
+'
 
-# simple linear checks of --continue
+# simple linear checks of --contains
 
-cat > expected <<EOF
+test_expect_success 'checking that first commit is in all tags (hash)' '
+	cat >expected <<-EOF &&
 v0.2.1
 v1.0
 v1.0.1
 v1.1.3
 v2.0
 EOF
-
-test_expect_success 'checking that first commit is in all tags (hash)' "
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # other ways of specifying the commit
-test_expect_success 'checking that first commit is in all tags (tag)' "
+test_expect_success 'checking that first commit is in all tags (tag)' '
 	git tag -l --contains v1.0 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-test_expect_success 'checking that first commit is in all tags (relative)' "
+test_expect_success 'checking that first commit is in all tags (relative)' '
 	git tag -l --contains HEAD~2 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-cat > expected <<EOF
+test_expect_success 'checking that second commit only has one tag' '
+	cat >expected <<-EOF &&
 v2.0
 EOF
-
-test_expect_success 'checking that second commit only has one tag' "
 	git tag -l --contains $hash2 v* >actual &&
 	test_cmp expected actual
-"
-
+'
 
-cat > expected <<EOF
+test_expect_success 'checking that third commit has no tags' '
+	cat >expected <<-EOF &&
 EOF
-
-test_expect_success 'checking that third commit has no tags' "
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # how about a simple merge?
 
@@ -1228,35 +1298,33 @@ test_expect_success 'creating simple branch' '
         git checkout stable &&
 	echo foo-3.0 > foo &&
 	git commit foo -m fourth &&
+	hash4=$(git rev-parse HEAD) &&
 	git tag v3.0
 '
 
-hash4=$(git rev-parse HEAD)
-
-cat > expected <<EOF
+test_expect_success 'checking that branch head only has one tag' '
+	cat >expected <<-EOF &&
 v3.0
 EOF
-
-test_expect_success 'checking that branch head only has one tag' "
 	git tag -l --contains $hash4 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 test_expect_success 'merging original branch into this branch' '
 	git merge --strategy=ours master &&
         git tag v4.0
 '
 
-cat > expected <<EOF
+test_expect_success 'checking that original branch head has one tag now' '
+	cat >expected <<-EOF &&
 v4.0
 EOF
-
-test_expect_success 'checking that original branch head has one tag now' "
 	git tag -l --contains $hash3 v* >actual &&
 	test_cmp expected actual
-"
+'
 
-cat > expected <<EOF
+test_expect_success 'checking that initial commit is in all tags' '
+	cat >expected <<-EOF &&
 v0.2.1
 v1.0
 v1.0.1
@@ -1265,11 +1333,9 @@ v2.0
 v3.0
 v4.0
 EOF
-
-test_expect_success 'checking that initial commit is in all tags' "
 	git tag -l --contains $hash1 v* >actual &&
 	test_cmp expected actual
-"
+'
 
 # mixing modes and options:
 
-- 
1.7.8
