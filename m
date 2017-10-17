Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A626F202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754670AbdJQEok (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:44:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753531AbdJQEoj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:44:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEDAAB891F;
        Tue, 17 Oct 2017 00:44:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HoiyZHjtp6Meb4UStx2DAr8+M8=; b=Y8w1BZ
        x2Wm5q2r0hHubd0bUmwmeSuH25LO059TxajpYRXwttuLo7pRqLkanlG2BHx1poRs
        Q8DA3n1BAVdhWYGGK9XeoyZGk5zZKOWUdYBcoYqlXDvWBkJI2elngrsq4A1gjvjK
        hmwqvAnd/qtPUMGnFrI2Sl4rvTAEyw0b8iqV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G8L0NuWqZHyb95bdwiNTQq5JG4Wwn8JN
        gKaeOrRS9mYTEHgBqpSeHmfL5RYaIYvPK9qeEiJOWdFhSxpLgSGysRp+LQmxGe9p
        MPNmc0/FwjMetKMcYw7TTC4FmRgvkumPhhzGG79f21Y7D20Yi7GNH/S64PvFpzM5
        FSOBLEMLON4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B607AB891E;
        Tue, 17 Oct 2017 00:44:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25537B891D;
        Tue, 17 Oct 2017 00:44:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Marko Kungla <marko.kungla@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
        <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
        <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
        <20170717172709.GL93855@aiede.mtv.corp.google.com>
        <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
        <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
        <xmqq1sm3s751.fsf@gitster.mtv.corp.google.com>
        <20171016224512.6fhtce5anmff577b@sigill.intra.peff.net>
        <xmqqbml6r2js.fsf@gitster.mtv.corp.google.com>
        <20171017024203.6hqzy2paed6fyvym@sigill.intra.peff.net>
        <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 17 Oct 2017 13:44:36 +0900
In-Reply-To: <xmqqo9p6phxg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 17 Oct 2017 12:33:15 +0900")
Message-ID: <xmqq7evupemj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1B6DBCC-B2F5-11E7-9BB6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I don't think there is any need to prepare it upon my 4d03f955,
>> though.  I'd think it could simply replace it.
>
> Yeah, it ended up that way, it seems.  Still it needs a bit of doc
> updates to balance the description.

So here is what I have now on 'pu'.  Clearly not a 2.15 material yet.

-- >8 --
Subject: [PATCH] check-ref-format: --branch cannot grok @{-1} outside a repository

"git check-ref-format --branch $name" feature was originally
introduced (and was advertised) as a way for scripts to take any
end-user supplied string (like "master", "@{-1}" etc.) and see if
that is usable when Git expects to see a branch name, and also
obtain the concrete branch name that the at-mark magic expands to.

When the user asks to interpret a branch name like "@{-1}", we have
to dig the answer out of the HEAD reflog.  We can obviously only do
that if we have a repository, and indeed, running it outside a
repository causes us to hit a BUG().

Let's disable the "expand @{-n}" half of the feature when it is run
outside a repository, but keep the feature to check the syntax of a
proposed branch name, as "git check-ref-format --branch $name" can
be stricter than "git check-ref-format refs/heads/$name", and
Porcelain scripts need to have a way to check a given name against
the stricter rule.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |  9 ++++++++-
 builtin/check-ref-format.c             | 15 ++++++++++++---
 cache.h                                | 14 ++++++++++++++
 sha1_name.c                            | 22 +++++++++++++++++++---
 strbuf.h                               |  6 ++++++
 t/t1402-check-ref-format.sh            | 12 ++++++++++++
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 92777cef25..cf0a0b7df2 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -77,7 +77,14 @@ reference name expressions (see linkgit:gitrevisions[7]):
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
-With the `--branch` option, it expands the ``previous branch syntax''
+With the `--branch` option, the command takes a name and checks if
+it can be used as a valid branch name (e.g. when creating a new
+branch).  The rule `git check-ref-format --branch $name` implements
+may be stricter than what `git check-ref-format refs/heads/$name`
+says (e.g. a dash may appear at the beginning of a ref component,
+but it is explicitly forbidden at the beginning of a branch name).
+When run with `--branch` option in a repository, the input is first
+expanded for the ``previous branch syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last branch you
 were on.  This option should be used by porcelains to accept this
 syntax anywhere a branch name is expected, so they can act as if you
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index eac499450f..4e62852089 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -38,13 +38,22 @@ static char *collapse_slashes(const char *refname)
 
 static int check_ref_format_branch(const char *arg)
 {
+	int nongit, malformed;
 	struct strbuf sb = STRBUF_INIT;
-	int nongit;
+	const char *name = arg;
 
 	setup_git_directory_gently(&nongit);
-	if (strbuf_check_branch_ref(&sb, arg))
+
+	if (!nongit)
+		malformed = (strbuf_check_branch_ref(&sb, arg) ||
+			     !skip_prefix(sb.buf, "refs/heads/", &name));
+	else
+		malformed = check_branch_ref_format(arg);
+
+	if (malformed)
 		die("'%s' is not a valid branch name", arg);
-	printf("%s\n", sb.buf + 11);
+	printf("%s\n", name);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 52b91f5b64..3815925122 100644
--- a/cache.h
+++ b/cache.h
@@ -1444,6 +1444,20 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
 #define INTERPRET_BRANCH_HEAD (1<<2)
 extern int interpret_branch_name(const char *str, int len, struct strbuf *,
 				 unsigned allowed);
+
+/*
+ * NEEDSWORK: declare strbuf_branchname() and strbuf_check_branch_ref()
+ * here, not in strbuf.h
+ */
+
+/*
+ * Check if a 'name' is suitable to be used as a branch name; this can
+ * be and is stricter than what check_refname_format() returns for a
+ * string that is a concatenation of "name" after "refs/heads/"; a
+ * name that begins with "-" is not allowed, for example.
+ */
+extern int check_branch_ref_format(const char *name);
+
 extern int get_oid_mb(const char *str, struct object_id *oid);
 
 extern int validate_headref(const char *ref);
diff --git a/sha1_name.c b/sha1_name.c
index 5e2ec37b65..c95080258f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1319,15 +1319,31 @@ void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 	strbuf_add(sb, name + used, len - used);
 }
 
-int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+static int strbuf_check_branch_ref_format(struct strbuf *sb)
 {
-	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
-	if (name[0] == '-')
+	if (*sb->buf == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
 	return check_refname_format(sb->buf, 0);
 }
 
+int check_branch_ref_format(const char *name)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int result;
+
+	strbuf_addstr(&sb, name);
+	result = strbuf_check_branch_ref_format(&sb);
+	strbuf_release(&sb);
+	return result;
+}
+
+int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
+{
+	strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
+	return strbuf_check_branch_ref_format(sb);
+}
+
 /*
  * This is like "get_sha1_basic()", except it allows "sha1 expressions",
  * notably "xyz^" for "parent of xyz"
diff --git a/strbuf.h b/strbuf.h
index d785258649..3da95685b2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -568,6 +568,12 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 	strbuf_complete(sb, '\n');
 }
 
+/*
+ * NEEDSWORK: the following two functions should not be in this file;
+ * these are about refnames, and should be declared next to
+ * interpret_branch_name() in cache.h
+ */
+
 /*
  * Copy "name" to "sb", expanding any special @-marks as handled by
  * interpret_branch_name(). The result is a non-qualified branch name
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 0790edf60d..2ddefb4bd1 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -161,6 +161,18 @@ test_expect_success 'check-ref-format --branch from subdir' '
 	test "$refname" = "$sha1"
 '
 
+test_expect_success 'check-ref-format --branch @{-1} from non-repo' '
+	test_must_fail nongit git check-ref-format --branch @{-1}
+'
+
+test_expect_success 'check-ref-format --branch master in non-repo' '
+	nongit git check-ref-format --branch master
+'
+
+test_expect_success 'check-ref-format --branch -naster in repo' '
+	test_must_fail git check-ref-format --branch -naster
+'
+
 valid_ref_normalized() {
 	prereq=
 	case $1 in
-- 
2.15.0-rc1-178-geb01ff2fe8

