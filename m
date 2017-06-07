Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E89E1F8CF
	for <e@80x24.org>; Wed,  7 Jun 2017 02:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdFGCSL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 22:18:11 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36249 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdFGCSK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 22:18:10 -0400
Received: by mail-pg0-f48.google.com with SMTP id a70so87622pge.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 19:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jv/dwry2TH0tlep38cCuWDWCh3dxDGcGudnTNfA82Nw=;
        b=h6xKfugbFl6FRPJ1YUrhFWZfUyvvEqcZVT6gZHQSyupHClpbz31xpVA47PUnSqzMr8
         4L8RNraqHjnsOI8QVietUlqcnVk0lkoEUBfDAWesZ2zHYfUTTJOil+zlQd+1MpBsqy5X
         5OHzC56hk+HkGtrhbS4HyBCvLIjalw6JnwCFyhqk4Npp+3gjYT+Afl+gGKuW12P01laY
         mOwaTw6eFIf7IGLw3L2JROKKLkcOzKHdSsKokd4skRcxVBVpxcTSuNWFuNiUnpPgBbek
         UblooP/ZYR8+pl4DjXsxN++IcoRABBTskcYbWa4S8BJd22MHVkC0sVeVji8ifo67iXAl
         UWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jv/dwry2TH0tlep38cCuWDWCh3dxDGcGudnTNfA82Nw=;
        b=dUeuXcXRX9MLnc+je0t3Pn2xqXjnlEoyJcdN8h4TTdOhnpfyHaNd/TnCqkcLqD1z3P
         60nEOVFAAL+FXfMPmZ6locXrjIJh06znwOsM4rhnPp3ajldzgmbz+pa9+LH2FvJ8yXp+
         GvDoXk5Lqi1Wj6JxAqFJqzilJeLnueWejVvWb/MyrxhF+lMbjXJcsRNzV7CTL1doaodR
         7YQetAhKkzVzMlKlN6uRhHN8aqgrLevgS6iKE5VnntpwehLpPBQqTYmUgKRADq1iX0Cl
         2ORh1npppijwb0jiK7qPWygJN0jCPNjLQ0OW5L//SWo9V+UnqTEc1Ctm9KIVmML52PlO
         vE3Q==
X-Gm-Message-State: AODbwcAgvG0E5EG2jD/UFxZ7Yo0Jn6n1JtxSZdBtXgWMNvC2FDJgrNFw
        0wJ5GytFh/zvxK7M
X-Received: by 10.84.167.168 with SMTP id d37mr24734668plb.125.1496801889478;
        Tue, 06 Jun 2017 19:18:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:406c:4586:c4dd:a63c])
        by smtp.gmail.com with ESMTPSA id s17sm254102pfk.112.2017.06.06.19.18.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 19:18:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        jrnieder@gmail.com, phillip.wood@dunelm.org.uk, sbeller@google.com
Subject: [PATCH] t4005: modernize style and drop hard coded sha1
Date:   Tue,  6 Jun 2017 19:18:05 -0700
Message-Id: <20170607021805.11849-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.17.gf3d7728391
In-Reply-To: <xmqqwp8o7gdc.fsf@gitster.mtv.corp.google.com>
References: <xmqqwp8o7gdc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use modern style in the test t4005. Remove hard coded sha1 values.
Combine test prep work and the actual test. Rename the first
test to contain the word "setup".

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio wrote:
> If it helps, I _can_ make any set of declarations to make it sound
> more official, e.g. (the remainder of) June is the "make sure our
> tests are ready" 

If it helps, I can write code for that. :)

Do get a good grasp on which tests need to be fixed, I changed the seed
value for the sha1 computation and then run the test suite. There are a lot
of tests passing for this, but also quite a few failing. Then I picked t4005
randomly to start with. This patch works even with a crippled hash function
as we use hash-object to get the object id.

Thanks,
Stefan

 t/t4005-diff-rename-2.sh | 95 ++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 52 deletions(-)

diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 135addbfbd..f542d2929d 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -3,84 +3,75 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-test_description='Same rename detection as t4003 but testing diff-raw.
+test_description='Same rename detection as t4003 but testing diff-raw.'
 
-'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
-     echo frotz >rezrov &&
-    git update-index --add COPYING rezrov &&
-    tree=$(git write-tree) &&
-    echo $tree'
-
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
-    rm -f COPYING &&
-    git update-index --add --remove COPYING COPYING.?'
+test_expect_success 'setup reference tree' '
+	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+	echo frotz >rezrov &&
+	git update-index --add COPYING rezrov &&
+	tree=$(git write-tree) &&
+	echo $tree &&
+	sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
+	sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+	origoid=$(git hash-object COPYING) &&
+	oid1=$(git hash-object COPYING.1) &&
+	oid2=$(git hash-object COPYING.2)
+'
 
+################################################################
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
 # and COPYING.2 are based on COPYING, and do not say anything about
 # rezrov.
 
-git diff-index -C $tree >current
-
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 R1234	COPYING	COPYING.2
-EOF
+test_expect_success 'validate output from rename/copy detection (#1)' '
+	rm -f COPYING &&
+	git update-index --add --remove COPYING COPYING.? &&
 
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_raw current expected'
+	cat <<-EOF >expected &&
+	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
+	:100644 100644 $origoid $oid2 R1234	COPYING	COPYING.2
+	EOF
+	git diff-index -C $tree >current &&
+	compare_diff_raw expected current
+'
 
 ################################################################
-
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
-
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # both are slightly edited, and unchanged rezrov.  We say COPYING.1
 # is based on COPYING and COPYING is still there, and do not say anything
 # about rezrov.
 
-git diff-index -C $tree >current
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M	COPYING
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
-EOF
+test_expect_success 'validate output from rename/copy detection (#2)' '
+	mv COPYING.2 COPYING &&
+	git update-index --add --remove COPYING COPYING.1 COPYING.2 &&
 
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_raw current expected'
+	cat <<-EOF >expected &&
+	:100644 100644 $origoid $oid2 M	COPYING
+	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
+	EOF
+	git diff-index -C $tree >current &&
+	compare_diff_raw current expected
+'
 
 ################################################################
-
 # tree has COPYING and rezrov.  work tree has the same COPYING and
 # copy-edited COPYING.1, and unchanged rezrov.  We should not say
 # anything about rezrov or COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
-test_expect_success \
-    'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
-
-git diff-index -C --find-copies-harder $tree >current
-cat >expected <<\EOF
-:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
-EOF
+test_expect_success 'validate output from rename/copy detection (#3)' '
+	cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+	git update-index --add --remove COPYING COPYING.1 &&
 
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_raw current expected'
+	cat <<-EOF >expected &&
+	:100644 100644 $origoid $oid1 C1234	COPYING	COPYING.1
+	EOF
+	git diff-index -C --find-copies-harder $tree >current &&
+	compare_diff_raw current expected
+'
 
 test_done
-- 
2.13.0.17.gf3d7728391

