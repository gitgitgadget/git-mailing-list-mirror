Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98353ECF7
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087488; cv=none; b=sro9kE2JZpNBuFAbNraw5dgVXnraU9EFe8/FB/riskfeSfYSPrAQIUW8U1ZRfzYrojRdJbXnYB5Xbtf645c47/T47OHs5HR08kZBTy0F28V7px/ylwB6wOfbWN7xfMhoaCgF4rcN87lIyPnQ3lNO3hBcvcLIFZW1m6gEnR6puEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087488; c=relaxed/simple;
	bh=8ex8Ba0bx2gehdpEJBIrY9S7IhshU+JBTLU2FIPEF2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6OXZfw56qeXNcSsdNzhi7WJiyY3CT1vqtp52NTF6+UTExnjwZYi0ZYnea0FsLpwOdCnIgryV3zsIRy0d8/AjDlz0svGeTNhIDiJqQcUG25s3c09GgBpaFsoOPquHp1mkWf6xYZ+1DEl0IyQOMdz671nY+FenOpg9niK10N070Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nkqpzRuW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxip/ARD; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nkqpzRuW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxip/ARD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 182B113002B1;
	Tue, 22 Sep 2026 10:31:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 10:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790087485; x=
	1790091085; bh=sWNFtLG8e3n7dXIiIrigSB1f1BRT6zV5Z6CiuU9BADU=; b=n
	kqpzRuWhVS64uhZmsVB2Es3O5swiDpYLCWJjZ1sbtWz0KPsJh1vwfRIEeNsV2Cwk
	HCeow8O5H8aKSLixLtFlRoCNLByQiZQKClnc3QlkByFbCb3e/wOGLvsDF6atylXF
	4go2f+YF8GjmOXplJ43vaXi3hpilpfPxgM9j7yHSah40RjtKjmVaQE9cWJBhy1HI
	IKhYxH8T9zM1dvPfvg4kYtcREHH04RmAatV4tEEzRPOazpcffTBl/9070QnLTIpF
	957bzGp16GpmONC0xns7Bl43+whv1wvjt8hl+Pe7Uq0rlCaBH/cwCC37IKKlDvPg
	e3etC5OTbZMgbJBRCCLlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790087485; x=1790091085; bh=s
	WNFtLG8e3n7dXIiIrigSB1f1BRT6zV5Z6CiuU9BADU=; b=mxip/ARDzplqIRFNF
	rVv/snwVkBW8AYsWxlsCLwWL4kL8EBQ0V7KgQR3kOBBG0KItAiVyTrcaBSiHfifW
	5Ny2vePYK/CeZBlaoUZIPyTJmpQgNK3PtSbwGpVoYzFR5Y0yHurPy8zG2GCohEZw
	j4sS4MqdZ3PIn6qvFs8lyfl3QETpSLPQsF9bUu4heg2fOXUCdyHqm2ElO8fViOVw
	LM66oL3sA4UY5Aen+mNi1i/Hi7a18WOmh9Hzdv2LgVG4vDhlJjSx7hMlwbpWtHwI
	AS0qr8Uxo/iHJ1hBfN5vI2RQsHETH2UWnhNepsXwrbIdbtBxeilXl0bSoR1yOqRj
	RBcOw==
X-ME-Sender: <xms:PZGyaiAoODGrj7R0UHx0dczDGCkgQY-9x_JpOuY2Mc41VbvxkIGmxQ>
    <xme:PZGyaih1Cf_S_-kdewMWR7Lj7te8hPUXNZG6CKH0XzjB9hq-9Y0GL8HphA8pELQ1c
    JZ8WmBMpizpdq5W5Btk5UjnNir1HSGb5Y0PG7V3o-MLP3tYhylTPsrN>
X-ME-Received: <xmr:PZGyajPIcfsPcO_xP0XBAHNSJq4qQ1EhpY9hDNr5h6v1ExCqA6oFDng3iqneFMcJTUmIrT3VUTbI591Xdk49DwV7sRDDdL7V4W_yXoxzNT9x6w>
X-ME-Proxy-Cause: dmFkZTGP46YC6q8ZS3oonxOjMTC8HCqj8daYDtrYqYmUEi+Bj7yDT49A11ucpAmi6NOwbE
    bYPMC/PK7ijGEx3KCLyNJV4ENog/lKljYFCb7OmPy/6Ib0hckN1c0hOW408V2srDVEV37R
    Wt0YOEqKR33HGn05ImrYjn2QJMTRlOtLICsR3jUVxfmA8isF4S8XeLrFnAvx+VV+e20GAQ
    jLnaAe1yTYI09FIuCk2734LLj1Ad6e/2dKFMb/MjXw3+q8iVXlvQyU5vcXVWgdQKgLIHUO
    xRCZEyn025iW7UlArYlUbnLpmBhthU8vvgiTwjzZiBB5En9g0LphA/i07BhhLkbsPEIKT0
    ZyPxH45f5MUZPj1X9q3AZronCk5ANH7bZ9cAKCwvePsGuo6lsJeHoLhOoxUXggSKvDoxtn
    eYBE3vmB6fyBRtEJxM8OCUpKKzIRgDaYRufoOijyyUsUMXSMXKDTUJLJkAK2F/OtnNBUSy
    wsHr3OVSgCoaTX6WqfpcW+MO96vpb+m+NsB7QNib9rtK5QnlpImMXJsCVpZzcnam/ZVyxg
    ITmzSYRDy2evEFh1Uy3V682RLi6e+ry+AHg8RY6GCx8cbg++2CcBunjRULSvyHC7sbmCMW
    sEbyxC7bzKFhJZ+X0s5HxU9j3DrdxyU4MoekVtXP1cbCBnP15TmnmzjUYB1Q
X-ME-Proxy: <xmx:PZGyar5YLjplqyIjLq0S4TOcsVsPC_Dfll5QGvEbmSi1xVD7dfYNNQ>
    <xmx:PZGyap36ZOYp4DaHsWt78oEPvOBHfukYyc5kXqLu6r4PJNotwQELyg>
    <xmx:PZGyakaue57GvU8fgoN1aBp8zLLcXnfiI8QY-aBg9TGpeD6yJryUoQ>
    <xmx:PZGyapDKWNFEqNMV7l-i-NZmn31JTfZ4OYwriHh2ZoOlzyiqE9vGgg>
    <xmx:PZGyal-Ms4OpQ6WSybjygtYWH0vzAGJRFe2J2LIqe0ekwEdGNlrUSBwV>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 10:31:25 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 2/3] t4009: modernize
Date: Tue, 22 Sep 2026 10:31:18 -0400
Message-ID: <20260922143119.3313620-3-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922143119.3313620-1-markchucarroll@fastmail.com>
References: <20260922143119.3313620-1-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old tests were written in a different style than modern
ones; for better readability and test error messages,
update t4009 to the modern style.

* run everything inside of a test_expect_success block.
* write title line on the same line as test_expect_success,
  end that line with a single quote that opens the body of the test,
  and end the test with a single quote that closes the body.
* write expected output of a test to a file named "expect",
  and actual output to a file named "actual".
* write here-docs using "<<-" syntax, so that they're indented
  uniformly with the rest of the test.
* make test names more clearly reflect the functionality that
  they test.

Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
---
 t/t4009-diff-rename-4.sh | 126 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 66 deletions(-)

diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
index 198de5d039..e42891ee5a 100755
--- a/t/t4009-diff-rename-4.sh
+++ b/t/t4009-diff-rename-4.sh
@@ -10,67 +10,63 @@ test_description='Same rename detection as t4003 but testing diff-raw -z.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success  'prepare reference tree' '
-    COPYING_test_data >COPYING &&
-    echo frotz >rezrov &&
-    git update-index --add COPYING rezrov &&
-    orig=$(git hash-object COPYING) &&
-    tree=$(git write-tree) &&
-    echo $tree
+test_expect_success 'setup' '
+	# prepare reference tree
+	COPYING_test_data >COPYING &&
+	echo frotz >rezrov &&
+	git update-index --add COPYING rezrov &&
+	orig=$(git hash-object COPYING) &&
+	tree=$(git write-tree) &&
+	echo $tree &&
+	# prepare work tree
+	sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
+	sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
+	rm -f COPYING &&
+	c1=$(git hash-object COPYING.1) &&
+	c2=$(git hash-object COPYING.2) &&
+	git update-index --add --remove COPYING COPYING.?
 '
 
-test_expect_success 'prepare work tree' '
-    sed -e "s/HOWEVER/However/" <COPYING >COPYING.1 &&
-    sed -e "s/GPL/G.P.L/g" <COPYING >COPYING.2 &&
-    rm -f COPYING &&
-    c1=$(git hash-object COPYING.1) &&
-    c2=$(git hash-object COPYING.2) &&
-    git update-index --add --remove COPYING COPYING.?
-'
-
-# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# and COPYING.2 are based on COPYING, and do not say anything about
-# rezrov.
-
-git diff-index -z -C $tree >current
-
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-:100644 100644 $orig $c2 R1234
-COPYING
-COPYING.2
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#1)' '
-    compare_diff_raw_z current expected
+	# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# and COPYING.2 are based on COPYING, and do not say anything about
+	# rezrov.
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	:100644 100644 $orig $c2 R1234
+	COPYING
+	COPYING.2
+	EOF
+
+	git diff-index -z -C $tree >actual &&
+	compare_diff_raw_z actual expect
 '
 
 ################################################################
 
-test_expect_success 'prepare work tree again' '
-    mv COPYING.2 COPYING &&
-    git update-index --add --remove COPYING COPYING.1 COPYING.2
-'
-
-# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
-# both are slightly edited, and unchanged rezrov.  We say COPYING.1
-# is based on COPYING and COPYING is still there, and do not say anything
-# about rezrov.
-
-git diff-index -z -C $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c2 M
-COPYING
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#2)' '
-    compare_diff_raw_z current expected
+	# prepare work tree again
+	mv COPYING.2 COPYING &&
+	git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
+
+	# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+	# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+	# is based on COPYING and COPYING is still there, and do not say anything
+	# about rezrov.
+
+	git diff-index -z -C $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c2 M
+	COPYING
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
 '
 
 ################################################################
@@ -80,20 +76,18 @@ test_expect_success 'validate output from rename/copy detection (#2)' '
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success 'prepare work tree once again' '
-    COPYING_test_data >COPYING &&
-    git update-index --add --remove COPYING COPYING.1
-'
-
-git diff-index -z -C --find-copies-harder $tree >current
-cat >expected <<EOF
-:100644 100644 $orig $c1 C1234
-COPYING
-COPYING.1
-EOF
-
 test_expect_success 'validate output from rename/copy detection (#3)' '
-    compare_diff_raw_z current expected
+	# prepare work tree once again
+	COPYING_test_data >COPYING &&
+	git update-index --add --remove COPYING COPYING.1 &&
+	git diff-index -z -C --find-copies-harder $tree >actual &&
+	cat >expect <<-EOF &&
+	:100644 100644 $orig $c1 C1234
+	COPYING
+	COPYING.1
+	EOF
+
+	compare_diff_raw_z actual expect
 '
 
 test_done
-- 
2.53.0

