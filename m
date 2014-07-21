From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Mon, 21 Jul 2014 15:29:25 -0700
Message-ID: <xmqq1tteibwa.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-5-git-send-email-kasal@ucw.cz>
	<CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
	<xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
	<xmqqoawiiigz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBTNIW2PAKGQECYXLDCQ@googlegroups.com Tue Jul 22 00:29:36 2014
Return-path: <msysgit+bncBCG77UMM3EJRBTNIW2PAKGQECYXLDCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f189.google.com ([209.85.223.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBTNIW2PAKGQECYXLDCQ@googlegroups.com>)
	id 1X9M5P-00012Q-Hp
	for gcvm-msysgit@m.gmane.org; Tue, 22 Jul 2014 00:29:36 +0200
Received: by mail-ie0-f189.google.com with SMTP id at20sf2324243iec.16
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 15:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=1aj01Y0xTx72IYpXeGkrQcdUpZv9K9LQY/USVsCuqbU=;
        b=qKTrSc0NHWiz3ZVnQr2+Qyuz1qfBH40Kea6relkghu42WkdfLhFIuEhfC5dwdJztdt
         ll+n6A/wuCUgik2yQAEwwhi9v5tzdYhoZl5wvYxpbvaheyoqnFJY+YbiXAH6fjtvSfw7
         MKHL/kRFtnvTAfRW17xOUsQw6BrOa/abwGg6Du9XGilqHSI5XKED+6UF2xK8qL1HiYTc
         NOma9Ju5wp7IoscxuadYCdAq6HMtKnCrKrKofSNAoKfTnCwK92XWyhhh1KjELecDaaLW
         USYzMuNW7upX/r3+ekKVviTi75mBfLOh2oXo1PIMYW/eMnQVFjZhEbQKOR4pWLxyBz22
         HdSQ==
X-Received: by 10.50.111.232 with SMTP id il8mr147461igb.6.1405981774676;
        Mon, 21 Jul 2014 15:29:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.47.69 with SMTP id b5ls1914176ign.15.gmail; Mon, 21 Jul
 2014 15:29:33 -0700 (PDT)
X-Received: by 10.68.195.9 with SMTP id ia9mr8838890pbc.7.1405981773517;
        Mon, 21 Jul 2014 15:29:33 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id hq8si3960qcb.2.2014.07.21.15.29.33
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 15:29:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F27F2BBFE;
	Mon, 21 Jul 2014 18:29:33 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2343F2BBFD;
	Mon, 21 Jul 2014 18:29:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C34CE2BBF8;
	Mon, 21 Jul 2014 18:29:26 -0400 (EDT)
In-Reply-To: <xmqqoawiiigz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 13:07:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7941F65E-1126-11E4-9590-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253998>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Oh by the way, can somebody remind me why we spell these as
>> NOT_MINGW,  instead of !MINGW?
>
> Simple answer seems to be that !ANYTHING appeared only at bdccd3c1
> (test-lib: allow negation of prerequisites, 2012-11-14) but at that
> version already 5 test files use NOT_MINGW (and a few MINGW) as
> prerequisites.  We can safely replace uses of NOT_MINGW prerequisite
> with !MINGW, it seems.
>
> Sorry for the noise.

So here is the first of the two small/trivial patch series. 

To prepare the first one, I did "git grep -e '\<NOT_' t/" to the
result of applying Stepan's series and edited the hits manually.
And then compared the result with running

 $ perl -p -i -e 'if (!/\btest_set_prereq\s/) {
       s/\bNOT_([A-Z]*)\b/!$1/g
   }' t/t*.sh

on Stepan's series to see if I missed anything.

The second one was discovered while doing the manual fix mentioned
above.

-- >8 --
Subject: [PATCH 1/2] test prerequisites: eradicate NOT_FOO

Support for Back when bdccd3c1 (test-lib: allow negation of
prerequisites, 2012-11-14) introduced negated predicates
(e.g. "!MINGW,!CYGWIN"), we already had 5 test files that use
NOT_MINGW (and a few MINGW) as prerequisites.

Let's not add NOT_FOO and rewrite existing ones as !FOO for both
MINGW and CYGWIN.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0008-ignores.sh            |  2 +-
 t/t0081-line-buffer.sh        |  2 +-
 t/t1020-subdirectory.sh       |  2 +-
 t/t1300-repo-config.sh        |  6 +++---
 t/t1402-check-ref-format.sh   | 32 ++++++++++++++++----------------
 t/t3901-i18n-patch.sh         | 10 +++++-----
 t/t4201-shortlog.sh           |  6 +++---
 t/t4210-log-i18n.sh           |  4 ++--
 t/t5601-clone.sh              |  4 ++--
 t/t8005-blame-i18n.sh         |  8 ++++----
 t/t9300-fast-import.sh        |  8 ++++----
 t/t9809-git-p4-client-view.sh |  4 ++--
 t/t9812-git-p4-wildcards.sh   | 14 +++++++-------
 t/t9815-git-p4-submit-fail.sh |  2 +-
 t/test-lib.sh                 |  4 ----
 15 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 39e55a1..8dc6939 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -806,7 +806,7 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	test_cmp err.expect err
 '
 
-test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
+test_expect_success !MINGW,!CYGWIN 'correct handling of backslashes' '
 	rm -rf whitespace &&
 	mkdir whitespace &&
 	>"whitespace/trailing 1  " &&
diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 25dba00..ce92e6a 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -29,7 +29,7 @@ test_expect_success '0-length read, send along greeting' '
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'read from file descriptor' '
+test_expect_success !MINGW 'read from file descriptor' '
 	rm -f input &&
 	echo hello >expect &&
 	echo hello >input &&
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 62c0d25..2edb4f2 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -118,7 +118,7 @@ test_expect_success 'alias expansion' '
 	)
 '
 
-test_expect_success NOT_MINGW '!alias expansion' '
+test_expect_success !MINGW '!alias expansion' '
 	pwd >expect &&
 	(
 		git config alias.test-alias-directory !pwd &&
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3f80ff0..fb871d0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -824,14 +824,14 @@ cat >expect <<\EOF
 	trailingtilde = foo~
 EOF
 
-test_expect_success NOT_MINGW 'set --path' '
+test_expect_success !MINGW 'set --path' '
 	rm -f .git/config &&
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
 	git config --path path.trailingtilde "foo~" &&
 	test_cmp expect .git/config'
 
-if test_have_prereq NOT_MINGW && test "${HOME+set}"
+if test_have_prereq !MINGW && test "${HOME+set}"
 then
 	test_set_prereq HOMEVAR
 fi
@@ -854,7 +854,7 @@ cat >expect <<\EOF
 foo~
 EOF
 
-test_expect_success NOT_MINGW 'get --path copes with unset $HOME' '
+test_expect_success !MINGW 'get --path copes with unset $HOME' '
 	(
 		unset HOME;
 		test_must_fail git config --get --path path.home \
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 9aeb352..72fd917 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -30,17 +30,17 @@ invalid_ref() {
 }
 
 invalid_ref ''
-invalid_ref NOT_MINGW '/'
-invalid_ref NOT_MINGW '/' --allow-onelevel
-invalid_ref NOT_MINGW '/' --normalize
-invalid_ref NOT_MINGW '/' '--allow-onelevel --normalize'
+invalid_ref !MINGW '/'
+invalid_ref !MINGW '/' --allow-onelevel
+invalid_ref !MINGW '/' --normalize
+invalid_ref !MINGW '/' '--allow-onelevel --normalize'
 valid_ref 'foo/bar/baz'
 valid_ref 'foo/bar/baz' --normalize
 invalid_ref 'refs///heads/foo'
 valid_ref 'refs///heads/foo' --normalize
 invalid_ref 'heads/foo/'
-invalid_ref NOT_MINGW '/heads/foo'
-valid_ref NOT_MINGW '/heads/foo' --normalize
+invalid_ref !MINGW '/heads/foo'
+valid_ref !MINGW '/heads/foo' --normalize
 invalid_ref '///heads/foo'
 valid_ref '///heads/foo' --normalize
 invalid_ref './foo'
@@ -120,14 +120,14 @@ invalid_ref "$ref" --refspec-pattern
 invalid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 ref='/foo'
-invalid_ref NOT_MINGW "$ref"
-invalid_ref NOT_MINGW "$ref" --allow-onelevel
-invalid_ref NOT_MINGW "$ref" --refspec-pattern
-invalid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel'
-invalid_ref NOT_MINGW "$ref" --normalize
-valid_ref NOT_MINGW "$ref" '--allow-onelevel --normalize'
-invalid_ref NOT_MINGW "$ref" '--refspec-pattern --normalize'
-valid_ref NOT_MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
+invalid_ref !MINGW "$ref"
+invalid_ref !MINGW "$ref" --allow-onelevel
+invalid_ref !MINGW "$ref" --refspec-pattern
+invalid_ref !MINGW "$ref" '--refspec-pattern --allow-onelevel'
+invalid_ref !MINGW "$ref" --normalize
+valid_ref !MINGW "$ref" '--allow-onelevel --normalize'
+invalid_ref !MINGW "$ref" '--refspec-pattern --normalize'
+valid_ref !MINGW "$ref" '--refspec-pattern --allow-onelevel --normalize'
 
 
 valid_ref 'refs/heads/a-very-long-refname'
@@ -199,10 +199,10 @@ invalid_ref_normalized() {
 
 valid_ref_normalized 'heads/foo' 'heads/foo'
 valid_ref_normalized 'refs///heads/foo' 'refs/heads/foo'
-valid_ref_normalized NOT_MINGW '/heads/foo' 'heads/foo'
+valid_ref_normalized !MINGW '/heads/foo' 'heads/foo'
 valid_ref_normalized '///heads/foo' 'heads/foo'
 invalid_ref_normalized 'foo'
-invalid_ref_normalized NOT_MINGW '/foo'
+invalid_ref_normalized !MINGW '/foo'
 invalid_ref_normalized 'heads/foo/../bar'
 invalid_ref_normalized 'heads/./foo'
 invalid_ref_normalized 'heads\foo'
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 55c8a2f..a392f3d 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -54,7 +54,7 @@ test_expect_success setup '
 	git add yours &&
 	git commit -s -m "Second on side" &&
 
-	if test_have_prereq NOT_MINGW
+	if test_have_prereq !MINGW
 	then
 		# the second one on the side branch is ISO-8859-1
 		git config i18n.commitencoding ISO8859-1 &&
@@ -122,7 +122,7 @@ test_expect_success 'rebase (U/L)' '
 	check_encoding 2
 '
 
-test_expect_success NOT_MINGW 'rebase (L/L)' '
+test_expect_success !MINGW 'rebase (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
@@ -134,7 +134,7 @@ test_expect_success NOT_MINGW 'rebase (L/L)' '
 	check_encoding 2 8859
 '
 
-test_expect_success NOT_MINGW 'rebase (L/U)' '
+test_expect_success !MINGW 'rebase (L/U)' '
 	# This is pathological -- use UTF-8 as intermediate form
 	# to get ISO-8859-1 results.
 	git config i18n.commitencoding ISO8859-1 &&
@@ -162,7 +162,7 @@ test_expect_success 'cherry-pick(U/U)' '
 	check_encoding 3
 '
 
-test_expect_success NOT_MINGW 'cherry-pick(L/L)' '
+test_expect_success !MINGW 'cherry-pick(L/L)' '
 	# Both the commitencoding and logoutputencoding is set to ISO-8859-1
 
 	git config i18n.commitencoding ISO8859-1 &&
@@ -192,7 +192,7 @@ test_expect_success 'cherry-pick(U/L)' '
 	check_encoding 3
 '
 
-test_expect_success NOT_MINGW 'cherry-pick(L/U)' '
+test_expect_success !MINGW 'cherry-pick(L/U)' '
 	# Again, the commitencoding is set to ISO-8859-1 but
 	# logoutputencoding is set to UTF-8.
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 565c020..7600a3e 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -93,7 +93,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 	test_cmp expect log.predictable
 '
 
-test_expect_success NOT_MINGW 'shortlog wrapping' '
+test_expect_success !MINGW 'shortlog wrapping' '
 	cat >expect <<\EOF &&
 A U Thor (5):
       Test
@@ -114,7 +114,7 @@ EOF
 	test_cmp expect out
 '
 
-test_expect_success NOT_MINGW 'shortlog from non-git directory' '
+test_expect_success !MINGW 'shortlog from non-git directory' '
 	git log HEAD >log &&
 	GIT_DIR=non-existing git shortlog -w <log >out &&
 	test_cmp expect out
@@ -159,7 +159,7 @@ $DSCHO (2):
 
 EOF
 
-test_expect_success NOT_MINGW 'shortlog encoding' '
+test_expect_success !MINGW 'shortlog encoding' '
 	git reset --hard "$commit" &&
 	git config --unset i18n.commitencoding &&
 	echo 2 > a1 &&
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 9110404..e585fe6 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -34,7 +34,7 @@ test_expect_success 'log --grep searches in log output encoding (utf8)' '
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'log --grep searches in log output encoding (latin1)' '
+test_expect_success !MINGW 'log --grep searches in log output encoding (latin1)' '
 	cat >expect <<-\EOF &&
 	latin1
 	utf8
@@ -43,7 +43,7 @@ test_expect_success NOT_MINGW 'log --grep searches in log output encoding (latin
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'log --grep does not find non-reencoded values (utf8)' '
+test_expect_success !MINGW 'log --grep does not find non-reencoded values (utf8)' '
 	>expect &&
 	git log --encoding=utf8 --format=%s --grep=$latin1_e >actual &&
 	test_cmp expect actual
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 5e67035..e4f10c0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -318,7 +318,7 @@ test_expect_success 'clone myhost:src uses ssh' '
 	expect_ssh myhost src
 '
 
-test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
+test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
 	cp -R src "foo:bar" &&
 	git clone "foo:bar" foobar &&
 	expect_ssh none
@@ -339,7 +339,7 @@ test_clone_url () {
 	expect_ssh "$2" "$3"
 }
 
-test_expect_success NOT_MINGW 'clone c:temp is ssl' '
+test_expect_success !MINGW 'clone c:temp is ssl' '
 	test_clone_url c:temp c temp
 '
 
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index a6e73d0..847d098 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -33,7 +33,7 @@ author $SJIS_NAME
 summary $SJIS_MSG
 EOF
 
-test_expect_success NOT_MINGW \
+test_expect_success !MINGW \
 	'blame respects i18n.commitencoding' '
 	git blame --incremental file | \
 		egrep "^(author|summary) " > actual &&
@@ -49,7 +49,7 @@ author $EUC_JAPAN_NAME
 summary $EUC_JAPAN_MSG
 EOF
 
-test_expect_success NOT_MINGW \
+test_expect_success !MINGW \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding eucJP &&
 	git blame --incremental file | \
@@ -66,7 +66,7 @@ author $UTF8_NAME
 summary $UTF8_MSG
 EOF
 
-test_expect_success NOT_MINGW \
+test_expect_success !MINGW \
 	'blame respects --encoding=UTF-8' '
 	git blame --incremental --encoding=UTF-8 file | \
 		egrep "^(author|summary) " > actual &&
@@ -82,7 +82,7 @@ author $UTF8_NAME
 summary $UTF8_MSG
 EOF
 
-test_expect_success NOT_MINGW \
+test_expect_success !MINGW \
 	'blame respects --encoding=none' '
 	git blame --incremental --encoding=none file | \
 		egrep "^(author|summary) " > actual &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5fc9ef2..99f5161 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2336,7 +2336,7 @@ test_expect_success 'R: cat-blob-fd must be a nonnegative integer' '
 	test_must_fail git fast-import --cat-blob-fd=-1 </dev/null
 '
 
-test_expect_success NOT_MINGW 'R: print old blob' '
+test_expect_success !MINGW 'R: print old blob' '
 	blob=$(echo "yes it can" | git hash-object -w --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 11
@@ -2348,7 +2348,7 @@ test_expect_success NOT_MINGW 'R: print old blob' '
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'R: in-stream cat-blob-fd not respected' '
+test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
 	echo hello >greeting &&
 	blob=$(git hash-object -w greeting) &&
 	cat >expect <<-EOF &&
@@ -2369,7 +2369,7 @@ test_expect_success NOT_MINGW 'R: in-stream cat-blob-fd not respected' '
 	test_cmp expect actual.1
 '
 
-test_expect_success NOT_MINGW 'R: print new blob' '
+test_expect_success !MINGW 'R: print new blob' '
 	blob=$(echo "yep yep yep" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 12
@@ -2387,7 +2387,7 @@ test_expect_success NOT_MINGW 'R: print new blob' '
 	test_cmp expect actual
 '
 
-test_expect_success NOT_MINGW 'R: print new blob by sha1' '
+test_expect_success !MINGW 'R: print new blob by sha1' '
 	blob=$(echo "a new blob named by sha1" | git hash-object --stdin) &&
 	cat >expect <<-EOF &&
 	${blob} blob 25
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 23a827f..e80db7a 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -365,7 +365,7 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >dir1/git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			echo git-wild-star >dir1/git-wild\*star
 		fi &&
@@ -379,7 +379,7 @@ test_expect_success 'wildcard files submit back to p4, client-spec case' '
 	(
 		cd "$cli" &&
 		test_path_is_file dir1/git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			test_path_is_file dir1/git-wild\*star
 		fi &&
diff --git a/t/t9812-git-p4-wildcards.sh b/t/t9812-git-p4-wildcards.sh
index c7472cb..ed4b488 100755
--- a/t/t9812-git-p4-wildcards.sh
+++ b/t/t9812-git-p4-wildcards.sh
@@ -14,7 +14,7 @@ test_expect_success 'add p4 files with wildcards in the names' '
 		printf "file2\nhas\nsome\nrandom\ntext\n" >file2 &&
 		p4 add file2 &&
 		echo file-wild-hash >file-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			echo file-wild-star >file-wild\*star
 		fi &&
@@ -31,7 +31,7 @@ test_expect_success 'wildcard files git p4 clone' '
 	(
 		cd "$git" &&
 		test -f file-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			test -f file-wild\*star
 		fi &&
@@ -46,7 +46,7 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$git" &&
 		echo git-wild-hash >git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			echo git-wild-star >git-wild\*star
 		fi &&
@@ -60,7 +60,7 @@ test_expect_success 'wildcard files submit back to p4, add' '
 	(
 		cd "$cli" &&
 		test_path_is_file git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			test_path_is_file git-wild\*star
 		fi &&
@@ -75,7 +75,7 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$git" &&
 		echo new-line >>git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			echo new-line >>git-wild\*star
 		fi &&
@@ -89,7 +89,7 @@ test_expect_success 'wildcard files submit back to p4, modify' '
 	(
 		cd "$cli" &&
 		test_line_count = 2 git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			test_line_count = 2 git-wild\*star
 		fi &&
@@ -152,7 +152,7 @@ test_expect_success 'wildcard files submit back to p4, delete' '
 	(
 		cd "$cli" &&
 		test_path_is_missing git-wild#hash &&
-		if test_have_prereq NOT_MINGW NOT_CYGWIN
+		if test_have_prereq !MINGW !CYGWIN
 		then
 			test_path_is_missing git-wild\*star
 		fi &&
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
index 1243d96..4cff6a7 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -417,7 +417,7 @@ test_expect_success 'cleanup chmod after submit cancel' '
 		! p4 fstat -T action text &&
 		test_path_is_file text+x &&
 		! p4 fstat -T action text+x &&
-		if test_have_prereq NOT_CYGWIN
+		if test_have_prereq !CYGWIN
 		then
 			stat --format=%A text | egrep ^-r-- &&
 			stat --format=%A text+x | egrep ^-r-x
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a479537..b72f6bd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -866,7 +866,6 @@ case $(uname -s) in
 	# backslashes in pathspec are converted to '/'
 	# exec does not inherit the PID
 	test_set_prereq MINGW
-	test_set_prereq NOT_CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
 	GIT_TEST_CMP=mingw_test_cmp
@@ -874,7 +873,6 @@ case $(uname -s) in
 *CYGWIN*)
 	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
-	test_set_prereq NOT_MINGW
 	test_set_prereq CYGWIN
 	test_set_prereq SED_STRIPS_CR
 	test_set_prereq GREP_STRIPS_CR
@@ -883,8 +881,6 @@ case $(uname -s) in
 	test_set_prereq POSIXPERM
 	test_set_prereq BSLASHPSPEC
 	test_set_prereq EXECKEEPSPID
-	test_set_prereq NOT_MINGW
-	test_set_prereq NOT_CYGWIN
 	;;
 esac
 
-- 
2.0.2-870-g9e2e527

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
