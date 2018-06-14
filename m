Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D9C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965092AbeFNWyo (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:44 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:50949 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWym (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:42 -0400
Received: by mail-oi0-f73.google.com with SMTP id r125-v6so4686025oif.17
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ioOH8gn4WMQrVS+R17RUGveAYiDavXpgSb70hHMf0P0=;
        b=cqmppWDHQ+a22SDMWcE1bP1MxfkWWzHXkYS898fRd7U732eqZ7O9Z9q9nzpcfDkjUJ
         oIG2ky/WkT7Ycesk2d5OVjqRUsGZA1096AZM5jinMTMurCu/kFGFwV46hJ5VPCV1x7kZ
         nMzKpzSXYVBJV8yIGJAuX3HbeVHgujqzTUWCQfc7paVLZwPmvrVrhfLHvKptMU5wsPuX
         ztOPJ03rcWZPWpnHkMw/2JzSDXR3qe69VcaQisZ6Rlgt0OPvoS8TOPpLr+XhE/2H6lrS
         2NJp1Cl3shD7xkNNKmLSHofnU3ndjJGgDjnnUmm2zhcCqCNjFOwy5/gQWbpzwSMaqU1E
         eTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ioOH8gn4WMQrVS+R17RUGveAYiDavXpgSb70hHMf0P0=;
        b=SCsen5LYYv2cYbdGoyFOoAG9QcVPEAjIWFjXB9yCDCfSZ8s97zG1BDqTSZZPR7I0Of
         iN8hr1Xg8Kk0KwV9g0mUf9hXDQPIFI8cYwOZj+wE647dVHU/ldIK4sO++oL6T1CwSC2a
         xPIMpymfTc4CXOODg6sBvCDLCT29jfuIBjZFena14mmDUIXCA7DUbFdXZN/EvLQvt20G
         OGJN+JGqrp14hFXC3LAJoepWSqtjy6ZY4dEz/XswlraM434iIE/DVXs45g+gEUPrVrtS
         Yh1g1UVdr1EJr3ICk3vgGwkq3SB6BMzQOJJYJeMTJeJIDrrqHjsxspBq1U4gG2q2eP98
         55PQ==
X-Gm-Message-State: APt69E3FaPBb+YuffgjNqV5IWMgMbW7QGzVwzKRYZ+asrBliH3iPaZjA
        r7LcIyMmm122TsZzfH06cdqvPbYyorY+PEYoVslryQaK2GLNEhiUe96joJ6W8lM9fLZooVKmBma
        +q1ii+M+f33JJ+IwU5DXpGWbCyY0wOWb9IGEXJR3pXkJCHKKdCghZ4z3JMHIgpK1xIi4p/5YbWb
        ut
X-Google-Smtp-Source: ADUXVKJ8SwKcXnJ8HqWgNSZALNdkiV5/1KzDvQExgoY99bW1+/Mc/u3Idt716RB4foVqvbnicxB5cJTjjlMhpemvN8SR
MIME-Version: 1.0
X-Received: by 2002:a9d:2370:: with SMTP id k45-v6mr1915507otd.98.1529016881707;
 Thu, 14 Jun 2018 15:54:41 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:25 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <be3774cd799b7ff538fefc2171bc46c164f2eae6.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 4/7] fetch-pack: use ref adv. to prune "have" sent
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In negotiation using protocol v2, fetch-pack sometimes does not make
full use of the information obtained in the ref advertisement:
specifically, that if the server advertises a commit that the client
also has, the client never needs to inform the server that it has the
commit's parents, since it can just tell the server that it has the
advertised commit and it knows that the server can and will infer the
rest.

This is because, in do_fetch_pack_v2(), rev_list_insert_ref_oid() is
invoked before mark_complete_and_common_ref(). This means that if we
have a commit that is both our ref and their ref, it would be enqueued
by rev_list_insert_ref_oid() as SEEN, and since it is thus already SEEN,
mark_complete_and_common_ref() would not enqueue it.

If mark_complete_and_common_ref() were invoked first, as it is in
do_fetch_pack() for protocol v0, then mark_complete_and_common_ref()
would enqueue it with COMMON_REF | SEEN. The addition of COMMON_REF
ensures that its parents are not sent as "have" lines.

Change the order in do_fetch_pack_v2() to be consistent with
do_fetch_pack(), and to avoid sending unnecessary "have" lines.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c          |  6 +++---
 t/t5500-fetch-pack.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 60adfc073..806c40021 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1392,9 +1392,6 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				for_each_ref(clear_marks, NULL);
 			marked = 1;
 
-			for_each_ref(rev_list_insert_ref_oid, NULL);
-			for_each_cached_alternate(insert_one_alternate_object);
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
@@ -1402,6 +1399,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
+
+			for_each_ref(rev_list_insert_ref_oid, NULL);
+			for_each_cached_alternate(insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
 			if (send_fetch_request(fd[1], args, ref, &common,
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d4f435155..e0cdc295d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -755,6 +755,39 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'use ref advertisement to prune "have" lines sent' '
+	rm -rf server client &&
+	git init server &&
+	test_commit -C server both_have_1 &&
+	git -C server tag -d both_have_1 &&
+	test_commit -C server both_have_2 &&
+
+	git clone server client &&
+	test_commit -C server server_has &&
+	test_commit -C client client_has &&
+
+	# In both protocol v0 and v2, ensure that the parent of both_have_2 is
+	# not sent as a "have" line. The client should know that the server has
+	# both_have_2, so it only needs to inform the server that it has
+	# both_have_2, and the server can infer the rest.
+
+	rm -f trace &&
+	cp -r client clientv0 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv0 \
+		fetch origin server_has both_have_2 &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace &&
+
+	rm -f trace &&
+	cp -r client clientv2 &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C clientv2 -c protocol.version=2 \
+		fetch origin server_has both_have_2 &&
+	grep "have $(git -C client rev-parse client_has)" trace &&
+	grep "have $(git -C client rev-parse both_have_2)" trace &&
+	! grep "have $(git -C client rev-parse both_have_2^)" trace
+'
+
 test_expect_success 'filtering by size' '
 	rm -rf server client &&
 	test_create_repo server &&
-- 
2.17.0.582.gccdcbd54c4

