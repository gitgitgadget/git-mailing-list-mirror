Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6B01F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJ0EGG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41935 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so2413220wrw.8
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVbnz0Oev/BCJSo2JozdSuJMl92t8hwHSpsWz1qmayQ=;
        b=GlIO2NTgxKUvyv2vl00roQ2s49/D9zKrofe453xLxKAoSnCJAYZ7himKsakUdWvPUl
         1WQPNsNSSe17LXxir2ZGZtd4US8rAKgdS5+Baol+FG0RAKZFR30hebnDVLZzlz4IE7LE
         GqphJw5+2hZBLd6xQXYVMBBdz//B1VLIakmxuhTnYzD/W/Nl9pHhr0DbqnvC1M7XSLDA
         zJvdMZ0babIvGDHTNajdjfjaHGd0S9AvUoqCyDj5mxynL1n9GbZuMm2gRFUF9tEXTPTn
         BRJMGf2rqPsl99LC0X+cro5l/AADc7vV9PKekinlY2BhfLuCuO+rw7S6dj8YmwHWRqsR
         Q9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVbnz0Oev/BCJSo2JozdSuJMl92t8hwHSpsWz1qmayQ=;
        b=gJ7EtEWg7j0Ll4jgDF0RuAyi89cghkNv9Cn6dk7vF2MZayaJzY7hF6lgYocm5guSu3
         FnOHWcB6mcOSjAK+P6vVcuyoGN7NoHpeyiA9F979Jjwu97Yyi7vxBy90tEoL9pk4KLJS
         CUECxmVMzPrG5GaMdcSQWkByYcvjcZsAR403mENCxttLKJfRlsvgcqNMgcXqTnSImLHp
         8RWCacjwOuowcul/B6R/GBDmce11QL3o1lL1t3oeYoSdfVAWdahJduF/PwXXkPfh8pQN
         kGg1Oh7dppAezaO/07KLTSVjlzqR0sVRgb0BV5Y6fGEWT59054qRVl54O3efYf2TetLL
         mt2A==
X-Gm-Message-State: AGRZ1gJ3tATo3yqFrAFk/wfQK8fwwIHhk1CNTPA0WWhmzylnjLIdy3nk
        5yL1Fa6EZLXB8y1kSdH6dKgauznx
X-Google-Smtp-Source: AJdET5eITjwJq5vrB3vzpXh2kai8l+5Vx2u1G0bkVAHoaJb0mMFeNBZBiCQU6/Hg5qFNo7e8CyhXbw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5-v6mr4420837wru.5.1540582067245;
        Fri, 26 Oct 2018 12:27:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] i18n: remote.c: mark error(...) messages for translation
Date:   Fri, 26 Oct 2018 19:27:29 +0000
Message-Id: <20181026192734.9609-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
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
 remote.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/remote.c b/remote.c
index 18cae48daa..5cb3d00bfb 100644
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
@@ -996,12 +996,12 @@ static int match_explicit_lhs(struct ref *src,
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
 
@@ -1041,32 +1041,33 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (starts_with(dst_value, "refs/")) {
 			matched_dst = make_linked_ref(dst_value, dst_tail);
+
 		} else if (is_null_oid(&matched_src->new_oid)) {
-			error("unable to delete '%s': remote ref does not exist",
+			error(_("unable to delete '%s': remote ref does not exist"),
 			      dst_value);
 		} else if ((dst_guess = guess_ref(dst_value, matched_src))) {
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
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
 		}
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
@@ -1765,7 +1766,7 @@ int get_fetch_map(const struct ref *remote_refs,
 			if (!starts_with((*rmp)->peer_ref->name, "refs/") ||
 			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
-				error("* Ignoring funny ref '%s' locally",
+				error(_("* Ignoring funny ref '%s' locally"),
 				      (*rmp)->peer_ref->name);
 				*rmp = (*rmp)->next;
 				free(ignore->peer_ref);
@@ -2133,7 +2134,7 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	else if (!colon[1])
 		oidclr(&entry->expect);
 	else if (get_oid(colon + 1, &entry->expect))
-		return error("cannot parse expected object name '%s'", colon + 1);
+		return error(_("cannot parse expected object name '%s'"), colon + 1);
 	return 0;
 }
 
-- 
2.19.1.759.g500967bb5e

