Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763261F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeKBWV6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:21:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43596 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeKBWV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:21:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id h4-v6so1017328pfi.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6r0EPGDqTvCRP9J6t3ef7WHyv6KSy4B5vamESNSP5Uc=;
        b=FfVp1Aa9oUkC4nIM7hsP4igTQgGfCiWbhjYIcmjPmHj/PJRIBsRO7pyYqyQmS26DVl
         bgo1Ph1E+IOmsfRe2V315kOOWXRQui5hLGcKbYMBvESYM6xTWL71TSNVSGsocuxh85HM
         REm290F96RbejOv+HffidiivOkjuIyCqnaXUVWhXOYBy8w02bi107xp3Ywm7JYQio7k+
         PAAFjw4ZvL4vfV4SIVCbiMYWGL6//9x94gHtUruAuuPJqGFESRa8AundLEH7yC/azH3Q
         he0mQi3jeEfof5RMYHycywDi7C8ygGFNdhffMS4GSaVg199NdQdBHiFOqWQhJwDe4+Kb
         rkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6r0EPGDqTvCRP9J6t3ef7WHyv6KSy4B5vamESNSP5Uc=;
        b=Xs3FCY6YqjsEzyJpAF3vC70EQvgywpeQFXuqloWC8o4qwfPsMfdi55Osij+shFnMdZ
         MpXrY/KeNbFq40OexC+UVUIMAHNOdYEPz70f0LDgVFwBdejac5WOJCVFHRXgANrp62HU
         sYiF8LSi6JI6lCxzAOT4H7Nk3Qza30c303STbwK/RE2iu+epHtp2hYno6K1DLbUQKbLS
         ZnAUAwXjYoyfLTQyAalxOjupXJE3csbN0JmWLKaE0rZB8LuugOSW5TYlv2jvafP46YEf
         z1/LLzNFMIjg8QMA3sPTpbtb6HgPyousX4TmtgWNO4qqfVuxAFNovD2IKPRr/WDEr9F6
         yOzw==
X-Gm-Message-State: AGRZ1gL6Kugp295GTmjnkZpVg0/AEl7RAix6u/93HmzO47lakEwhNaRA
        MBSTtCaed8wZ3o9kDHorTRGpGxWY
X-Google-Smtp-Source: AJdET5dYgeB7d6o28PNSoGkhSSXvFzD9BLoKgxJKUmYI1ZismIuJzMpc3inl+p/aplxQXf8TOhY0rw==
X-Received: by 2002:a62:14d4:: with SMTP id 203-v6mr11682962pfu.221.1541164489801;
        Fri, 02 Nov 2018 06:14:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 72-v6sm44544157pfl.126.2018.11.02.06.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:14:49 -0700 (PDT)
Date:   Fri, 02 Nov 2018 06:14:49 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Nov 2018 13:14:42 GMT
Message-Id: <dfaceb162f2f1f40ff8f28f9e62a646e56bbd15a.1541164482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.v2.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
        <pull.60.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] remote: make add_missing_tags() linear
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The add_missing_tags() method currently has quadratic behavior.
This is due to a linear number (based on number of tags T) of
calls to in_merge_bases_many, which has linear performance (based
on number of commits C in the repository).

Replace this O(T * C) algorithm with an O(T + C) algorithm by
using get_reachable_subset(). We ignore the return list and focus
instead on the reachable_flag assigned to the commits we care
about, because we need to interact with the tag ref and not just
the commit object.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 remote.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 81f4f01b00..b850f2feb3 100644
--- a/remote.c
+++ b/remote.c
@@ -1205,9 +1205,36 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 	 * sent to the other side.
 	 */
 	if (sent_tips.nr) {
+		const int reachable_flag = 1;
+		struct commit_list *found_commits;
+		struct commit **src_commits;
+		int nr_src_commits = 0, alloc_src_commits = 16;
+		ALLOC_ARRAY(src_commits, alloc_src_commits);
+
 		for_each_string_list_item(item, &src_tag) {
 			struct ref *ref = item->util;
+			struct commit *commit;
+
+			if (is_null_oid(&ref->new_oid))
+				continue;
+			commit = lookup_commit_reference_gently(the_repository,
+								&ref->new_oid,
+								1);
+			if (!commit)
+				/* not pushing a commit, which is not an error */
+				continue;
+
+			ALLOC_GROW(src_commits, nr_src_commits + 1, alloc_src_commits);
+			src_commits[nr_src_commits++] = commit;
+		}
+
+		found_commits = get_reachable_subset(sent_tips.tip, sent_tips.nr,
+						     src_commits, nr_src_commits,
+						     reachable_flag);
+
+		for_each_string_list_item(item, &src_tag) {
 			struct ref *dst_ref;
+			struct ref *ref = item->util;
 			struct commit *commit;
 
 			if (is_null_oid(&ref->new_oid))
@@ -1223,7 +1250,7 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			 * Is this tag, which they do not have, reachable from
 			 * any of the commits we are sending?
 			 */
-			if (!in_merge_bases_many(commit, sent_tips.nr, sent_tips.tip))
+			if (!(commit->object.flags & reachable_flag))
 				continue;
 
 			/* Add it in */
@@ -1231,7 +1258,12 @@ static void add_missing_tags(struct ref *src, struct ref **dst, struct ref ***ds
 			oidcpy(&dst_ref->new_oid, &ref->new_oid);
 			dst_ref->peer_ref = copy_ref(ref);
 		}
+
+		clear_commit_marks_many(nr_src_commits, src_commits, reachable_flag);
+		free(src_commits);
+		free_commit_list(found_commits);
 	}
+
 	string_list_clear(&src_tag, 0);
 	free(sent_tips.tip);
 }
-- 
gitgitgadget
