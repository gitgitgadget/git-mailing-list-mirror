Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5FD1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeKNFwj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:39 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43498 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNFwj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:39 -0500
Received: by mail-wr1-f51.google.com with SMTP id y3-v6so14672568wrh.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=emF1LzMUUWNGYE5jYyo3UzQniKyjS+tbDWZD9SzKNBQ=;
        b=F/YQ1jF4mETCktT5plrs86ccnwyLX7RgCmG1BVmSkLUUkcbyoiVNIudeOp2vQM4oHn
         7HCQGasOZa7e+aRvlsGTwN6RufT528zaACW4FqaX1Fayw7L5V0r7NIvXJB36IV0OODEb
         +LmGnax0LHFIzjp1jPawcz1EQigHk6K7wt+XdF5A6bka8l4ph3mOCDiKL7cMjmzwi0RE
         fj1XDB7C7d+5f9Xhz4JfPC21GHE3X/IC2CBurZodBqbwBGcL6rzxGGayuLZRqwzs3XLr
         CMGs8cP6yIGY1BWT9HLftwDX2hsnTB0SzlEFFRyzwXYFMmyLB1JqS7kBh+SC+GrVapx5
         iBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=emF1LzMUUWNGYE5jYyo3UzQniKyjS+tbDWZD9SzKNBQ=;
        b=pgOGxipSrphNLHR6bNH5E2jkvc0nso9CDXtYFWAMmMqMaSZKBJAmJjx/lq3Enh7vbg
         +VHE4gJgyU4HxKZ9uMNXrfeeARzGHOJA+eAIRNdAnBo+OT6pUUoZMieGYWixADlQbUAW
         SN7RHf2/vNQAA1oFeVitDPi/i0B3Nz9EYb2mHHaqrmlxVNz8eN9kad4Fn8OcnI6X9gBL
         axpmZ/RSz/gm8Qx+vXOOjEow2umnUVgo3yXbrsKD7qPOC1oZ60ptEvBn/nuyGdFIeKRl
         frEwgsyYi5/Th/aeChGBx8DMlSLwQTCQvtw+02BljWpqzDM8cureUGH0BKcQ4WECM58+
         QPAA==
X-Gm-Message-State: AGRZ1gKQCN9O7eto62f26ftDWaUvNBvCr9eHKfuD6HDPqVMRalPm/n8Y
        Any1u0ExKra4BbSNRBQv3Bg0y9siBU0=
X-Google-Smtp-Source: AJdET5cLRQi+O+ImDhvig4scJcd264mH7bGwJIwaQerEAA9+J4rW45c1NTALiTBEFLT3fZhvF9Mt8w==
X-Received: by 2002:adf:b253:: with SMTP id y19-v6mr6039236wra.213.1542138778308;
        Tue, 13 Nov 2018 11:52:58 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:52:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/7] i18n: remote.c: mark error(...) messages for translation
Date:   Tue, 13 Nov 2018 19:52:40 +0000
Message-Id: <20181113195245.14296-3-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
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
index 695b379a44..35fe8a178f 100644
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
@@ -1797,7 +1798,7 @@ int get_fetch_map(const struct ref *remote_refs,
 			if (!starts_with((*rmp)->peer_ref->name, "refs/") ||
 			    check_refname_format((*rmp)->peer_ref->name, 0)) {
 				struct ref *ignore = *rmp;
-				error("* Ignoring funny ref '%s' locally",
+				error(_("* Ignoring funny ref '%s' locally"),
 				      (*rmp)->peer_ref->name);
 				*rmp = (*rmp)->next;
 				free(ignore->peer_ref);
@@ -2165,7 +2166,7 @@ static int parse_push_cas_option(struct push_cas_option *cas, const char *arg, i
 	else if (!colon[1])
 		oidclr(&entry->expect);
 	else if (get_oid(colon + 1, &entry->expect))
-		return error("cannot parse expected object name '%s'", colon + 1);
+		return error(_("cannot parse expected object name '%s'"), colon + 1);
 	return 0;
 }
 
-- 
2.19.1.1182.g4ecb1133ce

