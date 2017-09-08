Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAA62082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdIHNxN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:53:13 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60516 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751139AbdIHNwT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:19 -0400
X-AuditID: 1207440e-bf9ff70000007085-3b-59b2a092f46f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 17.B1.28805.290A2B95; Fri,  8 Sep 2017 09:52:18 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvk1002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:16 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/11] t1404: demonstrate two problems with reference transactions
Date:   Fri,  8 Sep 2017 15:51:50 +0200
Message-Id: <76d473f62a8c1d6328eb15003c4d0d4dbc8f277d.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqDtpwaZIgyNrhCzWPrvDZPF8/Ql2
        i64r3UwWDb1XmC1ur5jPbNE95S2jxY+WHmaLzZvbWRw4PP6+/8DksXPWXXaPBZtKPZ717mH0
        uHhJ2ePzJrkAtigum5TUnMyy1CJ9uwSujFN7TjIVPJWvuH95J3MD40nJLkZODgkBE4n/W58y
        dzFycQgJ7GCSOP1wIhOEc5JJ4uyUu4wgVWwCuhKLepqZQGwRATWJiW2HWECKmAWeMknsPHmX
        FSQhLBAqcffmS7AiFgFVidUtM1lAbF6BKIlT178xQ6yTlzj34DaYzSlgIfHq3xo2EFtIwFzi
        6u5JrBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXWy80s0UtNKd3ECAkxvh2M7etl
        DjEKcDAq8fBaBG+MFGJNLCuuzD3EKMnBpCTKK9OzKVKILyk/pTIjsTgjvqg0J7X4EKMEB7OS
        CK/5LKAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCN2A+UKNgUWp6
        akVaZk4JQpqJgxNkOA/Q8I0gNbzFBYm5xZnpEPlTjLocHTfv/mESYsnLz0uVEudtmwdUJABS
        lFGaBzcHlhpeMYoDvSXMawAyigeYVuAmvQJawgS0pOT5BpAlJYkIKakGxjCT7rW2R2wifMUe
        mTupT5/rce2NvefJ3R9fLQpSF28pnXt95s3YSMuUDo0/W93LTZdd1PzMdzJNOv2185IcNTX2
        pTHBMhXxNTeVuZVK2E82rXBTSPQ/ndkygVt84ao7jqkWJld91s2M7prk+aD0WUGv2MN/U1M/
        FkxNXmyZ3P1Jxm7vTvf7SizFGYmGWsxFxYkAnzfB2+gCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a loose reference is deleted even before locking the
`packed-refs` file, let alone deleting any packed version of the
reference. This leads to two problems, demonstrated by two new tests:

* While a reference is being deleted, other processes might see the
  old, packed value of the reference for a moment before the packed
  version is deleted. Normally this would be hard to observe, but we
  can prolong the window by locking the `packed-refs` file externally
  before running `update-ref`, then unlocking it before `update-ref`'s
  attempt to acquire the lock times out.

* If the `packed-refs` file is locked so long that `update-ref` fails
  to lock it, then the reference can be left permanently in the
  incorrect state described in the previous point.

In a moment, both problems will be fixed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index c34ece48f5..64a81345a8 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -404,4 +404,77 @@ test_expect_success 'broken reference blocks indirect create' '
 	test_cmp expected output.err
 '
 
+test_expect_failure 'no bogus intermediate values during delete' '
+	prefix=refs/slow-transaction &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to update the reference, but hold the `packed-refs` lock
+	# for a while to see what happens while the process is blocked:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	{
+		# Note: the following command is intentionally run in the
+		# background. We increase the timeout so that `update-ref`
+		# attempts to acquire the `packed-refs` lock for longer than
+		# it takes for us to do the check then delete it:
+		git -c core.packedrefstimeout=3000 update-ref -d $prefix/foo &
+	} &&
+	pid2=$! &&
+	# Give update-ref plenty of time to get to the point where it tries
+	# to lock packed-refs:
+	sleep 1 &&
+	# Make sure that update-ref did not complete despite the lock:
+	kill -0 $pid2 &&
+	# Verify that the reference still has its old value:
+	sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
+	case "$sha1" in
+	$D)
+		# This is what we hope for; it means that nothing
+		# user-visible has changed yet.
+		: ;;
+	undefined)
+		# This is not correct; it means the deletion has happened
+		# already even though update-ref should not have been
+		# able to acquire the lock yet.
+		echo "$prefix/foo deleted prematurely" &&
+		break
+		;;
+	$C)
+		# This value should never be seen. Probably the loose
+		# reference has been deleted but the packed reference
+		# is still there:
+		echo "$prefix/foo incorrectly observed to be C" &&
+		break
+		;;
+	*)
+		# WTF?
+		echo "unexpected value observed for $prefix/foo: $sha1" &&
+		break
+		;;
+	esac >out &&
+	rm -f .git/packed-refs.lock &&
+	wait $pid2 &&
+	test_must_be_empty out &&
+	test_must_fail git rev-parse --verify --quiet $prefix/foo
+'
+
+test_expect_failure 'delete fails cleanly if packed-refs file is locked' '
+	prefix=refs/locked-packed-refs &&
+	# Set up a reference with differing loose and packed versions:
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	git update-ref $prefix/foo $D &&
+	git for-each-ref $prefix >unchanged &&
+	# Now try to delete it while the `packed-refs` lock is held:
+	: >.git/packed-refs.lock &&
+	test_when_finished "rm -f .git/packed-refs.lock" &&
+	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
+	git for-each-ref $prefix >actual &&
+	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
+	test_cmp unchanged actual
+'
+
 test_done
-- 
2.14.1

