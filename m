Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0F91F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJJSDc (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:03:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44734 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:03:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so5141889wra.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 03:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/SogEvI+QR/SZ8InTpcT/2/7TKlSSCqIszUdmVMPRTc=;
        b=CzrGm0zXLKGJg7K+mPBU9WbR3F2OUpEej2FMszw8B0x5/1ByV25J8jKX80WTIamwiP
         qxM30zNPEyeyidtOh0Bb+MqdEGzRNbogCDsPTfE6pi5UxFjXwiKO5Ha6RR9ZXGnRAR/q
         +pnbaaZOy5oqfDxIca410jj2nPOTx5cCyUy9uSnfiJE0Kwl+Aixb8Kk+YOIttLSYNMEa
         Pdipl79JjTDskHH3P1U7QF0djxCkuUMnm6c6G+kuuYv1bpOn+52YDwXvN6AcG0nvjY23
         BKPZhVslRrfCRxJR5NPLH82JKYASrYUKXKzgSaaBHHOZjZPcn97dJH8lCDcO3E4XJRUn
         54xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/SogEvI+QR/SZ8InTpcT/2/7TKlSSCqIszUdmVMPRTc=;
        b=Sag+MW94D2iNdga75Z/73s5KtRLVtf4oxviEmDFoLPJShuuLfg+bs+lmy3yEoy88HM
         4jR4bhsnyEwRk56tRqbUiruwRvTay57tQPWguiyOALh6p77wSYyo/Li+b42BJ00Cn9hm
         T8hzJiwhJ+aTKEgJnQrbU6F7LlFvygeN0sA4qwa1L7R7AlMRH+igv/DZ6e3hP4cyrp4a
         0qQdXnKMAENNPkIuNc2I2Dzed8T2EDK5uMkA1RzUKN8t167gIPw+cuBVN3FkUJaH3JQf
         1XX+pWiW4oWzKVjhl5ngGozpnHwBfhbddUtDikKKpqO8Xs2VEuPYM9tW7+Vw3CUDcxqP
         2ALA==
X-Gm-Message-State: ABuFfoi68xXQexT6kF23rXnbTCtwAB46trT34BA2BIODUhNbSBCVp9Vs
        gBJR1JPQrKEuIlf2URXPxO/ldh9V
X-Google-Smtp-Source: ACcGV62TIrXaRfUB8xeGuWMjRG3VqdPu8Cvhlh/9m2435egprVLUo1xGAQNT8w2GwUq4AGqs1Un/xQ==
X-Received: by 2002:adf:f4c3:: with SMTP id h3-v6mr17426827wrp.259.1539168117581;
        Wed, 10 Oct 2018 03:41:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 204-v6sm16061644wmh.25.2018.10.10.03.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 03:41:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] i18n: remote.c: mark error(...) messages for translation
Date:   Wed, 10 Oct 2018 10:41:44 +0000
Message-Id: <20181010104145.25610-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
In-Reply-To: <20181010104145.25610-1-avarab@gmail.com>
References: <20181010104145.25610-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark up the error(...) messages in remote.c for translation. The likes
of "unable to push to unqualified destination" are relatively big
parts of the UI, i.e. error messages shown when "git push" fails.

I don't think any of these are plumbing, an the entire test suite
passes when running the tests with GIT_GETTEXT_POISON=1 (after
building with GETTEXT_POISON).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 682f2a01f9..cc5553acc2 100644
--- a/remote.c
+++ b/remote.c
@@ -406,7 +406,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!remote->receivepack)
 			remote->receivepack = v;
 		else
-			error("more than one receivepack given, using the first");
+			error(_("more than one receivepack given, using the first"));
 	} else if (!strcmp(subkey, "uploadpack")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
@@ -414,7 +414,7 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (!remote->uploadpack)
 			remote->uploadpack = v;
 		else
-			error("more than one uploadpack given, using the first");
+			error(_("more than one uploadpack given, using the first"));
 	} else if (!strcmp(subkey, "tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
@@ -707,7 +707,7 @@ static void query_refspecs_multiple(struct refspec *rs,
 	int find_src = !query->src;
 
 	if (find_src && !query->dst)
-		error("query_refspecs_multiple: need either src or dst");
+		error(_("query_refspecs_multiple: need either src or dst"));
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -735,7 +735,7 @@ int query_refspecs(struct refspec *rs, struct refspec_item *query)
 	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
-		return error("query_refspecs: need either src or dst");
+		return error(_("query_refspecs: need either src or dst"));
 
 	for (i = 0; i < rs->nr; i++) {
 		struct refspec_item *refspec = &rs->items[i];
@@ -995,12 +995,12 @@ static int match_explicit_lhs(struct ref *src,
 		 * way to delete 'other' ref at the remote end.
 		 */
 		if (try_explicit_object_name(rs->src, match) < 0)
-			return error("src refspec %s does not match any.", rs->src);
+			return error(_("src refspec %s does not match any."), rs->src);
 		if (allocated_match)
 			*allocated_match = 1;
 		return 0;
 	default:
-		return error("src refspec %s matches more than one.", rs->src);
+		return error(_("src refspec %s matches more than one."), rs->src);
 	}
 }
 
@@ -1041,30 +1041,30 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		if (starts_with(dst_value, "refs/"))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else if (is_null_oid(&matched_src->new_oid))
-			error("unable to delete '%s': remote ref does not exist",
+			error(_("unable to delete '%s': remote ref does not exist"),
 			      dst_value);
 		else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else
-			error("unable to push to unqualified destination: %s\n"
-			      "The destination refspec neither matches an "
-			      "existing ref on the remote nor\n"
-			      "begins with refs/, and we are unable to "
-			      "guess a prefix based on the source ref.",
+			error(_("unable to push to unqualified destination: %s\n"
+				"The destination refspec neither matches an "
+				"existing ref on the remote nor\n"
+				"begins with refs/, and we are unable to "
+				"guess a prefix based on the source ref."),
 			      dst_value);
 		break;
 	default:
 		matched_dst = NULL;
-		error("dst refspec %s matches more than one.",
+		error(_("dst refspec %s matches more than one."),
 		      dst_value);
 		break;
 	}
 	if (!matched_dst)
 		return -1;
 	if (matched_dst->peer_ref)
-		return error("dst ref %s receives from more than one src.",
-		      matched_dst->name);
+		return error(_("dst ref %s receives from more than one src."),
+			     matched_dst->name);
 	else {
 		matched_dst->peer_ref = allocated_src ?
 					matched_src :
@@ -1763,7 +1763,7 @@ int get_fetch_map(const struct ref *remote_refs,
 			if (!starts_with((*rmp)->peer_ref->name, "refs/") ||
 			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
-				error("* Ignoring funny ref '%s' locally",
+				error(_("* Ignoring funny ref '%s' locally"),
 				      (*rmp)->peer_ref->name);
 				*rmp = (*rmp)->next;
 				free(ignore->peer_ref);
@@ -2131,7 +2131,7 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	else if (!colon[1])
 		oidclr(&entry->expect);
 	else if (get_oid(colon + 1, &entry->expect))
-		return error("cannot parse expected object name '%s'", colon + 1);
+		return error(_("cannot parse expected object name '%s'"), colon + 1);
 	return 0;
 }
 
-- 
2.19.1.390.gf3a00b506f

