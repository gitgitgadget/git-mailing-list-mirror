Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B11CDFCA
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731191; cv=none; b=ktLTboIpirjeVO4zzfbovSKe6HW/8+B+L68wTBznl4l9z7zJ9wtv8XAkfGFTG1e7hOacjv66P2iyQGhsAm+txjCp3AWyeo51wA2bfrhy1H786Ha2J7Pg2itLhZMRqbQ8tEDeMuAyFV2uiqIbDn7glas6HFr4ylHmgPNfM82dkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731191; c=relaxed/simple;
	bh=2VbULdotY6zmMNQR6TdKzEOQ9lzmcbcoKe84RM2d7Ww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eOwDPPHoTXgMkJH6uJ1oEhBi5ExvLVG+iVZeTkPvmh7PRdItJOsy9GN2USE+NfWfu/U8lRFmZPAYVQgIqqTMfgMFsLIMw9861p4OankLX3HqX9XCN/fKJK1DXylUHU+ZBUZ4mYY9HB0jHOuFA7hUqQdYHbNcIEA/HkZQG8KOkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gekDCAYz; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gekDCAYz"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a6cf8242so27192421cf.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731187; x=1777335987; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4PIbhTNQGvSv04/iNEoI3TUVMk/UjcbqonjSpebyV8=;
        b=gekDCAYzHqdwP2Aqd6Efj0GLy5MnFON6u3N+PlgtVrj86sGTsV320fsaLgjSExd3bs
         K2lG+fQ8IoezwA2sW3kjGbJJnDZ9XhVzoxYCqVYeitJ/aICOAAUByCewDsarBEnDU7PL
         Aruku9gN5Zp/0btaaTy7EbB9qYVYUo0/5J5lKG0TwlRsW3OVABdmseuhN5aZNGzXyM7Z
         JzaQ4krXjv6YctUpR6wGoJPNEQVr6GIszg08+sLbo7XKYnMEpz1VhM6nUZwN/3kbmZRi
         3e8mWtlKBt7o6tvLLd6+icatPxvp0tWkfUfxitH8VycFBoSeaKupJOCrB2V7gaIHia75
         1wUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731187; x=1777335987;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4PIbhTNQGvSv04/iNEoI3TUVMk/UjcbqonjSpebyV8=;
        b=M7Vfx7X3+wWHSySLFLRJMtVTLXN0bpF097udFcSd5k9alIdy2MmYVEvmF3o10a5/qW
         4ifn/OaiLkyTheEKVmk6YPceCYVSRz1RS4rlvL9XaJ8lSmdwfIrXSGhAotEz2AqoW0d7
         /AtXXqJrUX5QUOXTNwAiZQTCZMTmxODKxpFAA6V+qEK27ylDq55Vmkp+9J8VZG96LsyY
         hhZ3PKqy3FZyDeYbumDXajw3/DdTBY3hjsPx5ZFJd5rTCirwikd1Skm5WlIzZd0lQ7lV
         +t5lsKoB66z0VnwF2EXdrL3ozD0ItpeUF4vpXbAVn3gtDXM1m74yMKd8bq38C/+h7UPi
         azzg==
X-Gm-Message-State: AOJu0YxbRkmnRgXPuVBVPeTQRgg2Cxk8p6acuTOn1XslygphhtppWWZl
	JzAS/at8JOYYEg5CIAnFgynwdUfiZbrE7q4vkd9Rdol982Af6Zml0ZWHSZLESQ==
X-Gm-Gg: AeBDievpQ0ydVp8H3KsfUlIHaqd8Vy8fqv2pJUSSdV4iqGZLkGmGaGRMTnlw6DaYSGq
	+eJ2Frsdy6EhUHQ6+9fQ+4FcKrqNxDR21QYdyFkVR38/h9P/m9cmByD3EqFcmAjVYkjCpgd8uBN
	NafpFKxscJJS4/iKLC2nYtX66nP8rMOGDqq3HNeQ9CviM9zldH6vGCtd0GsLx8uB6fnS1MVjd5Q
	wov3WhMgUBekfPX8WvKXzxQNe8+wfUWxEhZOec8dkrNFhgnho5RBIg+t/d36xsJUA6I/n8uVCpE
	ay95+v+8z0zxYcF7SBquTCwiVLdq2crwVs5Z9ZLLeXBnwz7uITx+Kxt3ZHegNFFL9ssQo1z6pLW
	O6kiaYroq36aO9WE5PXHci0WDjXM60ftsVqAaBHVJfMse8lNo+wF4AsmxF4TssndB+6H8wLki3J
	2/BHjCDtE2YTnfXAdE6xo2mpSqAE99QwYSXobT
X-Received: by 2002:a05:622a:4d06:b0:50d:c25d:517a with SMTP id d75a77b69052e-50e36821829mr251503961cf.11.1776731187267;
        Mon, 20 Apr 2026 17:26:27 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e39305285sm115231631cf.13.2026.04.20.17.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:25 -0700 (PDT)
Message-Id: <a87bbaa84fd5dcb2a585f82c4a5dfa1572b54588.1776731171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:11 +0000
Subject: [PATCH 5/5] cache-tree: fix verify_cache() to catch non-adjacent D/F
 conflicts
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
Cc: Elijah Newren <newren@gmail.com>,
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
 cache-tree.c                   | 46 ++++++++++++++++++++++++--
 t/meson.build                  |  1 +
 t/t0093-direct-index-write.pl  | 38 ++++++++++++++++++++++
 t/t0093-verify-cache-df-gap.sh | 59 ++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 3 deletions(-)
 create mode 100644 t/t0093-direct-index-write.pl
 create mode 100755 t/t0093-verify-cache-df-gap.sh

diff --git a/cache-tree.c b/cache-tree.c
index 7881b42aa2..f11844fe72 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -192,22 +192,62 @@ static int verify_cache(struct index_state *istate, int flags)
 	for (i = 0; i + 1 < istate->cache_nr; i++) {
 		/* path/file always comes after path because of the way
 		 * the cache is sorted.  Also path can appear only once,
-		 * which means conflicting one would immediately follow.
+		 * so path/file is likely the immediately following path
+		 * but might be separated if there is e.g. a
+		 * path-internal/... file.
 		 */
 		const struct cache_entry *this_ce = istate->cache[i];
 		const struct cache_entry *next_ce = istate->cache[i + 1];
 		const char *this_name = this_ce->name;
 		const char *next_name = next_ce->name;
 		int this_len = ce_namelen(this_ce);
+		const char *conflict_name = NULL;
+
 		if (this_len < ce_namelen(next_ce) &&
-		    next_name[this_len] == '/' &&
+		    next_name[this_len] <= '/' &&
 		    strncmp(this_name, next_name, this_len) == 0) {
+			if (next_name[this_len] == '/') {
+				conflict_name = next_name;
+			} else if (next_name[this_len] < '/') {
+				/*
+				 * The immediately next entry shares our
+				 * prefix but sorts before "path/" (e.g.,
+				 * "path-internal" between "path" and
+				 * "path/file", since '-' (0x2D) < '/'
+				 * (0x2F)).  Binary search to find where
+				 * "path/" would be and check for a D/F
+				 * conflict there.
+				 */
+				struct cache_entry *other;
+				struct strbuf probe = STRBUF_INIT;
+				int pos;
+
+				strbuf_add(&probe, this_name, this_len);
+				strbuf_addch(&probe, '/');
+				pos = index_name_pos_sparse(istate,
+							    probe.buf,
+							    probe.len);
+				strbuf_release(&probe);
+
+				if (pos < 0)
+					pos = -pos - 1;
+				if (pos >= (int)istate->cache_nr)
+					continue;
+				other = istate->cache[pos];
+				if (ce_namelen(other) > this_len &&
+				    other->name[this_len] == '/' &&
+				    !strncmp(this_name, other->name, this_len))
+					conflict_name = other->name;
+			}
+		}
+
+		if (conflict_name) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
 			fprintf(stderr, "You have both %s and %s\n",
-				this_name, next_name);
+				this_name, conflict_name);
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
