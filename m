Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B073369234
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781419059; cv=none; b=Ip7rh4fCfQxqJAH9eVEauCf9tp51Zm676sbbCDxQH/cMM42CApdIgQkZMflNGQVvAngnglp6IG52xm2gE5l78mdf7/F164I1qS66wKCc8Cl8DnPw23cpLdmpMBR7yapy3hKXWg0CiD2xyXP17lCO+bb5ef61XtvbCUbIwI8UalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781419059; c=relaxed/simple;
	bh=QSofk/86tfiUO+u8LH87vJiGaCflJP6ajgeBxuwGlGc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kUcJSSWVaWWBAyykSNaev8qYlW39RAOCT91j1ixkqPrUbZpJLbAJpJrRzdV6P09AASkl2vjlO9e4NGBWCRjNBUnlIfdO/2Sc9Te1UqpAZrpWyVv66BGSbeq/gV1b3LavEECLLBAQ6wwjfj2liZb/XmoOCzqBwwgOW7E2NgjYRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5rFPCCU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5rFPCCU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91578122305so377080985a.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781419057; x=1782023857; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZqX/SJg9g2wRNSKfKG1P8ISt8XIfoAVh/Jn4G9RGcc=;
        b=g5rFPCCU8v6BxhlEdFY5Djph4QmB9QCY6QjQ0qE7vJxqSlTIKN6bBRluUoB5dJNx5Q
         2kGZTsD1mbp3Be/nLDJpa4Td5fnGAkxMI/31gZOTcGNHJlybLaIgog6MhOfxg6oGh1Ud
         dSKiR+nzO/mITRa6MKXJokxCqY4HrGB7w1gbVDahC1ISH4v5wGA7pvu2E0cLcvZyYJdV
         8nCws0o5lh+K/wFqEfVvAj8ehZRb+3N2RVySG/vu4Uzx0mH4AbOTpSNlmT7Og0iWLjfh
         /gAe77tRsg1mTpCu+nHwXJWbmFpTl5aWUE15y26DoGNkxHZ2taxSj14w9Wzetx4R3o83
         /aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781419057; x=1782023857;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xZqX/SJg9g2wRNSKfKG1P8ISt8XIfoAVh/Jn4G9RGcc=;
        b=nMvTeElLnsTkqOk+id1E7AdMmt4wKESkGD7ID58bmHPr47EdfDXEqYGt8tu1PBBscS
         2zdo/0pvM+oG0OZUbykPE5ZVJxkQZuQt4QuMSrMQ0cZPGOK/dbC2WwhLpV9EUAl+WvBg
         4P7veeYCdlEIeNou2ehSSGgreWdYx6UCAXlRLjHycafFcna7mhN7QppQ/1JK9Y8ddLTz
         PjHi0MLcdJGx3aw7iEDL0BYQ9KncnVbEb7Ho2K7I16nF66/RJ84bJki1VJUUafNOt6tn
         9VrN4pfstI4WqnS8rNoOH1+y98ZlzEflWoV674+GGX6ypFZBLpmw+hzYmD9GTOb9Rj1K
         zTJg==
X-Gm-Message-State: AOJu0YzhFFykW2+7eJq3FOCz1/wJGtESz8Qx+nb8HOohOzNaJEzrMdhW
	f7vneYU5vSOIOOHfGasnbWfywQvemnUUuMP6O2uO5RehG2nD66QqItWtd1z27Q==
X-Gm-Gg: Acq92OFDqBZ/JEzCJeRHDwRp6lwozt4Tl5TI4hkPbUzOzYLnnbK032GnY5rxRGfBU+5
	bhyRDodYobFIhk81N2kVVnhTC0cNRvITp+2tuOL0ObbPJlV8cqdVlVwbNS5bLS1tJ0KY0WYv1Xx
	hgeQ9nhM02fap7tGWs6E+CzitDNKhHx4DC5CmvvqaHrSjw/mfn384amO3VB0oQB+SPHdYec2SSv
	BvFqztDNOYJkH9H7YQUsgFdn9rSo1DDQiZ+QNhmFeIHUuJ7JL+fE/qw9UCQafpbUuSLPdxJ4igg
	m+GpnWLOvOn8tJEgBxf+oJQ1frK/QoF/o47ULZFjM/HffhxKNOzIa1Ui2ccRGmPgS4rsYTlw4W8
	PrYHy+QweYIqmZC0UgVWfoZ5QtLvbiL81Wf4o7xk5ccdvgZ2ZxOhTDiFpM/pYCoWHUMMKd9ye7i
	JJh/efN+ZuJXGl0N0sQ0GmuA==
X-Received: by 2002:a05:620a:1709:b0:915:a217:a96b with SMTP id af79cd13be357-917eb7027f6mr950553485a.0.1781419057083;
        Sat, 13 Jun 2026 23:37:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.15.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a035855sm674607885a.32.2026.06.13.23.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 23:37:36 -0700 (PDT)
Message-Id: <cf50f1aabcf84aa755808318756c233305cc008d.1781419047.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<pull.2096.v2.git.1781419047.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 06:37:26 +0000
Subject: [PATCH v2 5/5] cache-tree: fix verify_cache() to catch non-adjacent
 D/F conflicts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Christian Couder <christian.couder@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

verify_cache() checks that the index does not contain both "path" and
"path/file" before writing a tree.  It does this by comparing only
adjacent entries, relying on the assumption that "path/file" would
immediately follow "path" in sorted order.  Unfortunately, this
assumption does not always hold.  For example:

    docs                     <-- submodule entry
    docs-internal/README.md  <-- intervening entry
    docs/requirements.txt    <-- D/F conflict, NOT adjacent to "docs"

When this happens, verify_cache() silently misses the D/F conflict and
write-tree produces a corrupt tree object containing duplicate entries
(one for the submodule "docs" and one for the tree "docs").

I could not find any caller in current git that both allows the index to
get into this state and then tries to write it out without doing other
checks beyond the verify_cache() call in cache_tree_update(), but
verify_cache() is documented as a safety net for preventing corrupt
trees and should actually provide that guarantee.  A downstream consumer
that relied solely on cache_tree_update()'s internal checking via
verify_cache() to prevent duplicate tree entries was bitten by the gap.

Add a test that constructs a corrupt index directly (bypassing the D/F
checks in add_index_entry) and verifies that write-tree now rejects it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache-tree.c                   | 64 ++++++++++++++++++++++++++++------
 t/meson.build                  |  1 +
 t/t0093-direct-index-write.pl  | 38 ++++++++++++++++++++
 t/t0093-verify-cache-df-gap.sh | 59 +++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 11 deletions(-)
 create mode 100644 t/t0093-direct-index-write.pl
 create mode 100755 t/t0093-verify-cache-df-gap.sh

diff --git a/cache-tree.c b/cache-tree.c
index 7881b42aa2..4d2669b312 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -161,6 +161,54 @@ void cache_tree_invalidate_path(struct index_state *istate, const char *path)
 		istate->cache_changed |= CACHE_TREE_CHANGED;
 }
 
+/*
+ * Check whether this_ce and the next entry in the index form a D/F
+ * conflict ("path" vs "path/file").  Returns the conflicting "path/..."
+ * name when one is found, or NULL otherwise.
+ *
+ * The cache is sorted, so "path/file" sorts after "path" and the
+ * conflict is usually visible as adjacent entries.  But other entries
+ * can sort between them -- e.g. "path-internal" sits between "path"
+ * and "path/file" because '-' (0x2D) precedes '/' (0x2F) -- so when
+ * the immediately following entry shares our prefix but starts with a
+ * character that sorts before '/', binary search for "path/" instead.
+ */
+static const char *find_df_conflict(struct index_state *istate,
+				    const struct cache_entry *this_ce,
+				    const struct cache_entry *next_ce)
+{
+	const char *this_name = this_ce->name;
+	const char *next_name = next_ce->name;
+	int this_len = ce_namelen(this_ce);
+	const struct cache_entry *other;
+	struct strbuf probe = STRBUF_INIT;
+	int pos;
+
+	if (this_len >= ce_namelen(next_ce) ||
+	    next_name[this_len] > '/' ||
+	    strncmp(this_name, next_name, this_len))
+		return NULL;
+
+	if (next_name[this_len] == '/')
+		return next_name;
+
+	strbuf_add(&probe, this_name, this_len);
+	strbuf_addch(&probe, '/');
+	pos = index_name_pos_sparse(istate, probe.buf, probe.len);
+	strbuf_release(&probe);
+
+	if (pos < 0)
+		pos = -pos - 1;
+	if (pos >= (int)istate->cache_nr)
+		return NULL;
+	other = istate->cache[pos];
+	if (ce_namelen(other) > this_len &&
+	    other->name[this_len] == '/' &&
+	    !strncmp(this_name, other->name, this_len))
+		return other->name;
+	return NULL;
+}
+
 static int verify_cache(struct index_state *istate, int flags)
 {
 	unsigned i, funny;
@@ -190,24 +238,18 @@ static int verify_cache(struct index_state *istate, int flags)
 	 */
 	funny = 0;
 	for (i = 0; i + 1 < istate->cache_nr; i++) {
-		/* path/file always comes after path because of the way
-		 * the cache is sorted.  Also path can appear only once,
-		 * which means conflicting one would immediately follow.
-		 */
 		const struct cache_entry *this_ce = istate->cache[i];
 		const struct cache_entry *next_ce = istate->cache[i + 1];
-		const char *this_name = this_ce->name;
-		const char *next_name = next_ce->name;
-		int this_len = ce_namelen(this_ce);
-		if (this_len < ce_namelen(next_ce) &&
-		    next_name[this_len] == '/' &&
-		    strncmp(this_name, next_name, this_len) == 0) {
+		const char *conflict_name;
+
+		conflict_name = find_df_conflict(istate, this_ce, next_ce);
+		if (conflict_name) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
 			fprintf(stderr, "You have both %s and %s\n",
-				this_name, next_name);
+				this_ce->name, conflict_name);
 		}
 	}
 	if (funny)
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..362177999b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -124,6 +124,7 @@ integration_tests = [
   't0090-cache-tree.sh',
   't0091-bugreport.sh',
   't0092-diagnose.sh',
+  't0093-verify-cache-df-gap.sh',
   't0095-bloom.sh',
   't0100-previous.sh',
   't0101-at-syntax.sh',
diff --git a/t/t0093-direct-index-write.pl b/t/t0093-direct-index-write.pl
new file mode 100644
index 0000000000..2881a3ebb2
--- /dev/null
+++ b/t/t0093-direct-index-write.pl
@@ -0,0 +1,38 @@
+#!/usr/bin/perl
+#
+# Build a v2 index file from entries listed on stdin.
+# Each line: "octalmode hex-oid name"
+# Output: binary index written to stdout.
+#
+# This bypasses all D/F safety checks in add_index_entry(), simulating
+# what happens when code uses ADD_CACHE_JUST_APPEND to bulk-load entries.
+use strict;
+use warnings;
+use Digest::SHA qw(sha1 sha256);
+
+my $hash_algo = $ENV{'GIT_DEFAULT_HASH'} || 'sha1';
+my $hash_func = $hash_algo eq 'sha256' ? \&sha256 : \&sha1;
+
+my @entries;
+while (my $line = <STDIN>) {
+	chomp $line;
+	my ($mode, $oid_hex, $name) = split(/ /, $line, 3);
+	push @entries, [$mode, $oid_hex, $name];
+}
+
+my $body = "DIRC" . pack("NN", 2, scalar @entries);
+
+for my $ent (@entries) {
+	my ($mode, $oid_hex, $name) = @{$ent};
+	# 10 x 32-bit stat fields (zeroed), with mode in position 7
+	my $stat = pack("N10", 0, 0, 0, 0, 0, 0, oct($mode), 0, 0, 0);
+	my $oid = pack("H*", $oid_hex);
+	my $flags = pack("n", length($name) & 0xFFF);
+	my $entry = $stat . $oid . $flags . $name . "\0";
+	# Pad to 8-byte boundary
+	while (length($entry) % 8) { $entry .= "\0"; }
+	$body .= $entry;
+}
+
+binmode STDOUT;
+print $body . $hash_func->($body);
diff --git a/t/t0093-verify-cache-df-gap.sh b/t/t0093-verify-cache-df-gap.sh
new file mode 100755
index 0000000000..0b6829d805
--- /dev/null
+++ b/t/t0093-verify-cache-df-gap.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='verify_cache() must catch non-adjacent D/F conflicts
+
+Ensure that verify_cache() can complain about bad entries like:
+
+  docs               <-- submodule
+  docs-internal/...  <-- sorts here because "-" < "/"
+  docs/...           <-- D/F conflict with "docs" above, not adjacent
+
+In order to test verify_cache, we directly construct a corrupt index
+(bypassing the D/F safety checks in add_index_entry) and verify that
+write-tree rejects it.
+'
+
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping verify_cache D/F tests; Perl not available'
+	test_done
+fi
+
+# Build a v2 index from entries on stdin, bypassing D/F checks.
+# Each line: "octalmode hex-oid name" (entries must be pre-sorted).
+build_corrupt_index () {
+	perl "$TEST_DIRECTORY/t0093-direct-index-write.pl" >"$1"
+}
+
+test_expect_success 'setup objects' '
+	test_commit base &&
+	BLOB=$(git rev-parse HEAD:base.t) &&
+	SUB_COMMIT=$(git rev-parse HEAD)
+'
+
+test_expect_success 'adjacent D/F conflict is caught by verify_cache' '
+	cat >index-entries <<-EOF &&
+	0160000 $SUB_COMMIT docs
+	0100644 $BLOB docs/requirements.txt
+	EOF
+	build_corrupt_index .git/index <index-entries &&
+
+	test_must_fail git write-tree 2>err &&
+	test_grep "You have both docs and docs/requirements.txt" err
+'
+
+test_expect_success 'non-adjacent D/F conflict is caught by verify_cache' '
+	cat >index-entries <<-EOF &&
+	0160000 $SUB_COMMIT docs
+	0100644 $BLOB docs-internal/README.md
+	0100644 $BLOB docs/requirements.txt
+	EOF
+	build_corrupt_index .git/index <index-entries &&
+
+	test_must_fail git write-tree 2>err &&
+	test_grep "You have both docs and docs/requirements.txt" err
+'
+
+test_done
-- 
gitgitgadget
