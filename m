From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/24] t9300 (fast-import), series A: re-indent
Date: Fri, 24 Sep 2010 02:16:31 -0500
Message-ID: <20100924071631.GI4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2Z8-0008N8-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab0IXHTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:19:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33744 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab0IXHTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:19:24 -0400
Received: by gxk9 with SMTP id 9so859723gxk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q1zgzXjrVTUxN+4v058spT4ubH1P6Mlm9jAZzd7lvIY=;
        b=QTP3m1Rce4Rrz9CIzPtCy0rMdRdLLVrj+kbU6VjrtwCTVTtmMn5g5Ie4h3cNkj5zsz
         W/DQn2uXFaPhIHcL4xojwojOIzRpYknD7aRoUVN2ZqZm55vgctqzdSsWJNc5chYNFCWW
         Ps5E0Qq2o5FM893vCvXQu7VA2bmE6kYvW4WeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O+LZF7jnvMLyvPowHYUw0fpxPPRspfhzPvYddFYutO8QVDPNLW1uqu9wM92u2Gii7R
         LDslaRs4oxuQPSJhHRIIu4CpEcDiWESndXHyrGp6xJyq6ZsjKj+KHcxqBwwv9PDOW64I
         QIUUOMtkFEx2I95SLMxZQDYR+s6B/MBualZLk=
Received: by 10.101.193.5 with SMTP id v5mr3285626anp.201.1285312763631;
        Fri, 24 Sep 2010 00:19:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm1956003ibh.4.2010.09.24.00.19.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:19:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156942>

This was originally an old-fashioned test script, with formatting
that might now look unfamiliar:

	test_expect_success \
		'series A: foo bar baz' \
		'test commands &&
		 more test commands'

The apostrophes after tab make indenting more trouble than it ought to
be and the alignment cannot be preserved with the <<- operator
working.  The initial and final apostrophes on command lines makes
patches that add new lines to a test harder to read.  The title
aligned with the test code makes the test description harder to
take in at a glance.

So switch to the usual modern style:

	test_expect_success 'series A: foo bar baz' '
		test commands &&
		more test commands
	'

No other change intended.

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   99 ++++++++++++++++++++++++-----------------------
 1 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 0059298..10dc720 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -81,13 +81,12 @@ An annotated tag without a tagger
 EOF
 
 INPUT_END
-test_expect_success \
-	'A: create pack from stdin' \
-	'git fast-import --export-marks=marks.out <input &&
-	 git whatchanged master'
-test_expect_success \
-	'A: verify pack' \
-	'verify_packs'
+test_expect_success 'A: create pack from stdin' '
+	git fast-import --export-marks=marks.out <input &&
+	git whatchanged master'
+test_expect_success 'A: verify pack' '
+	verify_packs
+'
 
 cat >expect <<EOF
 author $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
@@ -95,37 +94,40 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 initial
 EOF
-test_expect_success \
-	'A: verify commit' \
-	'git cat-file commit master >commit &&
+test_expect_success 'A: verify commit' '
+	git cat-file commit master >commit &&
 	sed 1d <commit >actual &&
-	test_cmp expect actual'
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 100644 blob file2
 100644 blob file3
 100755 blob file4
 EOF
-test_expect_success \
-	'A: verify tree' \
-	'git cat-file -p master^{tree} >tree &&
-	 sed "s/ [0-9a-f]*	/ /" <tree >actual &&
-	 test_cmp expect actual'
+test_expect_success 'A: verify tree' '
+	git cat-file -p master^{tree} >tree &&
+	sed "s/ [0-9a-f]*	/ /" <tree >actual &&
+	test_cmp expect actual
+'
 
 echo "$file2_data" >expect
-test_expect_success \
-	'A: verify file2' \
-	'git cat-file blob master:file2 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file2' '
+	git cat-file blob master:file2 >actual &&
+	test_cmp expect actual
+'
 
 echo "$file3_data" >expect
-test_expect_success \
-	'A: verify file3' \
-	'git cat-file blob master:file3 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file3' '
+	git cat-file blob master:file3 >actual &&
+	test_cmp expect actual
+'
 
 printf "$file4_data" >expect
-test_expect_success \
-	'A: verify file4' \
-	'git cat-file blob master:file4 >actual && test_cmp expect actual'
+test_expect_success 'A: verify file4' '
+	git cat-file blob master:file4 >actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'A: verify tag/series-A' '
 	master=$(git rev-parse --verify refs/heads/master) &&
@@ -153,17 +155,17 @@ test_expect_success 'setup: compute expected marks' '
 	} >expect
 '
 
-test_expect_success \
-	'A: verify marks output' \
-	'test_cmp expect marks.out'
+test_expect_success 'A: verify marks output' '
+	test_cmp expect marks.out
+'
 
-test_expect_success \
-	'A: verify marks import' \
-	'git fast-import \
+test_expect_success 'A: verify marks import' '
+	git fast-import \
 		--import-marks=marks.out \
 		--export-marks=marks.new \
 		</dev/null &&
-	test_cmp expect marks.new'
+	test_cmp expect marks.new
+'
 
 test_tick
 cat >input <<INPUT_END
@@ -177,21 +179,21 @@ from :5
 M 755 :2 copy-of-file2
 
 INPUT_END
-test_expect_success \
-	'A: verify marks import does not crash' \
-	'git fast-import --import-marks=marks.out <input &&
-	 git whatchanged verify--import-marks'
-test_expect_success \
-	'A: verify pack' \
-	'verify_packs'
-test_expect_success \
-	'A: verify diff' \
-	'echo ":000000 100755 $zeroes $file2_id A	copy-of-file2" >expect &&
-	 echo $file2_id >expect.copy &&
-	 git diff-tree -M -r master verify--import-marks >actual &&
-	 git rev-parse --verify verify--import-marks:copy-of-file2 >actual.copy &&
-	 compare_diff_raw expect actual &&
-	 test_cmp expect.copy actual.copy'
+test_expect_success 'A: verify marks import does not crash' '
+	git fast-import --import-marks=marks.out <input &&
+	git whatchanged verify--import-marks
+'
+test_expect_success 'A: verify pack' '
+	verify_packs
+'
+test_expect_success 'A: verify diff' '
+	echo ":000000 100755 $zeroes $file2_id A	copy-of-file2" >expect &&
+	echo $file2_id >expect.copy &&
+	git diff-tree -M -r master verify--import-marks >actual &&
+	git rev-parse --verify verify--import-marks:copy-of-file2 >actual.copy &&
+	compare_diff_raw expect actual &&
+	test_cmp expect.copy actual.copy
+'
 
 test_expect_success 'A: export marks with large values' '
 	test_tick &&
@@ -252,7 +254,8 @@ test_expect_success 'A: export marks with large values' '
 	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
 	git ls-tree refs/heads/verify--dump-marks >tree.out &&
 	test_cmp tree.exp_s tree.out &&
-	test_cmp marks.exp marks.large'
+	test_cmp marks.exp marks.large
+'
 
 ###
 ### series B
-- 
1.7.2.3
