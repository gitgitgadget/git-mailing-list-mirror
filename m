Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95EE51F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407395AbfFKVG4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:06:56 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48716 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406793AbfFKVG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:06:56 -0400
Received: by mail-qk1-f201.google.com with SMTP id w184so12032934qka.15
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 14:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wMIHqNgZw/+xgDWg3XokOuUUijnq1w8QvoC542GMS0c=;
        b=c7AtoYVqTvEbZ/V6vuhGyt/V+MLvI76ezCth58nsLN8hAgYMFhtCuZ7J1gffQs+buf
         Px0DwvmAln9mICOsy3Dc1QOBGrxNi9Fj8eFohMjPPK4+GiV4oyjSh7nOoXolU0sxHtIp
         g0ZjO04hau/9496Vr8Arm6TX54gRVVO03NTvFNSiQuCvm21XrDVPU0JN5rNZDfu85yZW
         w5tCWHHzyv8CvCwywyYHGqCP/EJdYqDM0D4Kn+8h5SdLx3fwhSFUms0IyYhgdBBQrS/B
         C20jjxP5sRIKhBbZkKzlxeKvEVGgNt+yewl6ASKiGBgg958nyoXIVlwZidDqXZfsO8tP
         Y1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wMIHqNgZw/+xgDWg3XokOuUUijnq1w8QvoC542GMS0c=;
        b=FoRIgTC2q9qWD4iDUWm4n3ZGhy9ip5pAyrWth/EII88XNLzZno8SOnTFSN/I1L//aX
         bsriFibo2N151WzAlIuqFoLnsAadXmTJXKDcWYHYMG1Rsnb3nSDxuQKmH2vUOdP6zDCp
         hUUleVatE+BrfYwEfzYFoocnrjjvNjmFIj6nIxAqdQ8iI3wsjUjgPuMW2gKAGGqCcQtn
         DJxfbn2V5i6Pwhp8vBMj2UD7Ngrx2RrLDKTnMZIfvhP9SvjEfCUh8X+h0M4v3O66Ybpq
         KWwzNMBbLT3ygEkGTiPh3+x2rw9JghilDxkhdcKnkgvQhEIN1FTkz/in/mj06Wp7mj3z
         jFPQ==
X-Gm-Message-State: APjAAAVjCaSCtfI0pQRA8+9djVuKqRchYuOyE7n1eal/4lB5SkByzUpx
        kmGWdMn5RAlLhLWgd3gYAvJyldnOJJZMNAvKLNnR3A2P2CcsOLMzh+p2J9+zApUoj6iFrLfEmhu
        n4HM3Nw71M5Ofr+VxaOOrhAJ0ggV67V4QcahO/C3tviUvOmjBmjd6/xJimufOzUOir1o71+i62x
        Ln
X-Google-Smtp-Source: APXvYqwPo434EjOymxQ0oxfCseZI7nf+1Z25pGjEfuYBhCjqkisVI6MZsgxyTQ8HCvcKsktHW9qT/KVQfwJ2jEsWBl0f
X-Received: by 2002:a0c:afa4:: with SMTP id s33mr46251147qvc.194.1560287215016;
 Tue, 11 Jun 2019 14:06:55 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:06:47 -0700
In-Reply-To: <cover.1560286956.git.jonathantanmy@google.com>
Message-Id: <baa48722faf7ff748341fb07fe5ba46877684db0.1560286956.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1560286956.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH 2/2] t5616: cover case of client having delta base
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching into a partial clone, Git first prefetches missing
REF_DELTA bases from the promisor remote. (This feature was introduced
in [1].) But as can be seen in a recent test coverage report [2], the
case in which a REF_DELTA base is already present is not covered by
tests.

Extend the tests slightly to cover this case.

[1] 8a30a1efd1 ("index-pack: prefetch missing REF_DELTA bases",
2019-05-15).
[2] https://public-inbox.org/git/396091fc-5572-19a5-4f18-61c258590dd5@gmail.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5616-partial-clone.sh | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8b9b471a62..b91ef548f8 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -346,30 +346,37 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
 	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
-	# Create a commit with a blob to be used as a delta base.
+	# Create a commit with 2 blobs to be used as delta bases.
 	for i in $(test_seq 10)
 	do
-		echo "this is a line" >>"$SERVER/foo.txt"
+		echo "this is a line" >>"$SERVER/foo.txt" &&
+		echo "this is another line" >>"$SERVER/have.txt"
 	done &&
-	git -C "$SERVER" add foo.txt &&
+	git -C "$SERVER" add foo.txt have.txt &&
 	git -C "$SERVER" commit -m bar &&
-	git -C "$SERVER" rev-parse HEAD:foo.txt >deltabase &&
+	git -C "$SERVER" rev-parse HEAD:foo.txt >deltabase_missing &&
+	git -C "$SERVER" rev-parse HEAD:have.txt >deltabase_have &&
 
+	# Clone. The client has deltabase_have but not deltabase_missing.
 	git -c protocol.version=2 clone --no-checkout \
 		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
+	git -C repo hash-object -w -- "$SERVER/have.txt" &&
 
-	# Sanity check to ensure that the client does not have that blob.
+	# Sanity check to ensure that the client does not have
+	# deltabase_missing.
 	git -C repo rev-list --objects --ignore-missing \
-		-- $(cat deltabase) >objlist &&
+		-- $(cat deltabase_missing) >objlist &&
 	test_line_count = 0 objlist &&
 
 	# Another commit. This commit will be fetched by the client.
 	echo "abcdefghijklmnopqrstuvwxyz" >>"$SERVER/foo.txt" &&
-	git -C "$SERVER" add foo.txt &&
+	echo "abcdefghijklmnopqrstuvwxyz" >>"$SERVER/have.txt" &&
+	git -C "$SERVER" add foo.txt have.txt &&
 	git -C "$SERVER" commit -m baz &&
 
 	# Pack a thin pack containing, among other things, HEAD:foo.txt
-	# delta-ed against HEAD^:foo.txt.
+	# delta-ed against HEAD^:foo.txt and HEAD:have.txt delta-ed against
+	# HEAD^:have.txt.
 	printf "%s\n--not\n%s\n" \
 		$(git -C "$SERVER" rev-parse HEAD) \
 		$(git -C "$SERVER" rev-parse HEAD^) |
@@ -381,8 +388,13 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 	# most significant nybble of the first byte is 0b1111 (0b1 to indicate
 	# that the header continues, and 0b111 to indicate REF_DELTA), followed
 	# by any 3 nybbles, then the OID of the delta base.
-	git -C "$SERVER" rev-parse HEAD^:foo.txt >deltabase &&
-	printf "f.,..%s" $(intersperse "," <deltabase) >want &&
+	printf "f.,..%s" $(intersperse "," <deltabase_missing) >want &&
+	hex_unpack <thin.pack | intersperse "," >have &&
+	grep $(cat want) have &&
+
+	# Ensure that the pack contains one delta against HEAD^:have.txt,
+	# similar to the above.
+	printf "f.,..%s" $(intersperse "," <deltabase_have) >want &&
 	hex_unpack <thin.pack | intersperse "," >have &&
 	grep $(cat want) have &&
 
@@ -394,7 +406,12 @@ test_expect_success 'tolerate server sending REF_DELTA against missing promisor
 
 	# Fetch the thin pack and ensure that index-pack is able to handle the
 	# REF_DELTA object with a missing promisor delta base.
-	git -C repo -c protocol.version=2 fetch &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C repo -c protocol.version=2 fetch &&
+
+	# Ensure that the missing delta base was directly fetched, but not the
+	# one that the client has.
+	grep "want $(cat deltabase_missing)" trace &&
+	! grep "want $(cat deltabase_have)" trace &&
 
 	# Ensure that the one-time-sed script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

