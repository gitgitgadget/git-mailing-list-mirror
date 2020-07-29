Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1271C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A560D207E8
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 22:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h6PhmlXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgG2WuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:50:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56548 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG2WuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 18:50:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 805FAE6896;
        Wed, 29 Jul 2020 18:50:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rNt/LX10//c8ue5Nz6wv8j2D0cY=; b=h6Phml
        XtqhraPA1Squ7MFc0hwy+VcOuFkluSNxP/o4KDQpuJ/WAd5mNJqnFuKt8zKmSjg5
        8BQhT6X57zLB0CzoXqiEfhFWYpXSXLT9nFcJrQeNwxRq2RGBESK8V4Gkd2nSw5KA
        mH21fR4sVrLzZPAOeoI063x9y49wA4LFJQUnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WCo4ek4mf8ZzRdduJsrS8DeV12k7Goeb
        MKwuHKVZ2vL6ru9OeIybYPpS1hMAPYw73OILTdl0A7q1Kc2QMgboeeZXChdudLIA
        eoJfixAnOWZNuTf+wMydSsmPcBgfx/RCmofscmhEyT9VpawN8qi4CPmAsiDQjael
        aqpedoyja0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78842E6895;
        Wed, 29 Jul 2020 18:50:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15D22E6892;
        Wed, 29 Jul 2020 18:50:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
        <20200729205846.GA2992025@coredump.intra.peff.net>
        <xmqqv9i6814y.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Jul 2020 15:50:01 -0700
In-Reply-To: <xmqqv9i6814y.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Jul 2020 14:25:17 -0700")
Message-ID: <xmqqlfj27x7q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E589AE-D1ED-11EA-8053-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The fast-export side lifted the "single branch is special"; we
> didn't do something similar for "fmt-merge-msg".
>
>> So I think a path forward is more like:
>>
>>   1. Add a new config option to shorten fmt-merge-msg's output when the
>>      destination branch matches it (and this should perhaps not even be
>>      a single name, but a set of globs, which supports more workflows).
>>      Call it merge.suppressDest or something.
>>
>>   2. Optionally a repository created with "git init" could copy its
>>      init.defaultBranch into merge.suppressDest. And likewise a clone
>>      might copy the remote HEAD into that variable. I'm not sure if that
>>      is worth doing or not, but it would restore the original behavior
>>      for the most part.
>
> Yeah, that sounds like a good plan.

A rough outline I did while waiting for today's integration builds
to finish looks like this, which does not look _too_ bad.  We can
replace the literal 'master' with the default branch name determined
at runtime, but I am not sure if that is needed.

 fmt-merge-msg.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index cfb8ff2f33..b99699eacc 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -10,6 +10,8 @@
 #include "commit-reach.h"
 
 static int use_branch_desc;
+static int suppress_dest_pattern_seen;
+static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
@@ -22,6 +24,12 @@ int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			merge_log_config = DEFAULT_MERGE_LOG_LEN;
 	} else if (!strcmp(key, "merge.branchdesc")) {
 		use_branch_desc = git_config_bool(key, value);
+	} else if (!strcmp(key, "merge.suppressdest")) {
+		if (!value)
+			string_list_clear(&suppress_dest_patterns, 0);
+		else
+			string_list_append(&suppress_dest_patterns, value);
+		suppress_dest_pattern_seen = 1;
 	} else {
 		return git_default_config(key, value, cb);
 	}
@@ -408,6 +416,8 @@ static void fmt_merge_msg_title(struct strbuf *out,
 {
 	int i = 0;
 	char *sep = "";
+	struct string_list_item *item;
+	int suppress_merge_dest = 0;
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
@@ -451,7 +461,15 @@ static void fmt_merge_msg_title(struct strbuf *out,
 			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
-	strbuf_addf(out, " into %s\n", current_branch);
+	for_each_string_list_item(item, &suppress_dest_patterns) {
+		if (!wildmatch(item->string, current_branch, WM_PATHNAME)) {
+			suppress_merge_dest = 1;
+			break;
+		}
+	}
+
+	if (!suppress_merge_dest)
+		strbuf_addf(out, " into %s\n", current_branch);
 }
 
 static void fmt_tag_signature(struct strbuf *tagbuf,
@@ -596,6 +614,9 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
 
+	if (!suppress_dest_pattern_seen)
+		string_list_append(&suppress_dest_patterns, "master");
+
 	memset(&merge_parents, 0, sizeof(merge_parents));
 
 	/* get current branch */
