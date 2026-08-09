Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA25222565
	for <git@vger.kernel.org>; Sun,  9 Aug 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786304543; cv=none; b=LDKoYvtEKMs2vvfneimMXWhBxs7qDit7rVuRFzknJ9x3ObLKkGjGlVRekboRroBEDu23NEVv+QZFyJcWfqxhGnl0PIYT2nf8H3XCa6ALksR7YnwNSd0kQGgkbk8YH0mS+TTq56qxjF7l64RAN7scA1Vy+O3c88Sh2z4DBXpswHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786304543; c=relaxed/simple;
	bh=Fy2vpCZhd0VPIY2g5D02pTdGCImU6Bm0cthZOcvAWFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzmKzcm0oaWvxaqSa/u2dnzsJqLYJUz58TIz1DTNpP+bgMd7tfPdx0Su7ndtQGTNR0VRzTIWeFQrJOH4jlrM1XEUnjS64htpsV1CtaVHQfGgODyzqyM9/dU+/uLsRtRW0y4dpCmZDmLV7VSdmQ7Pzbi3Omnjd7a2pHLEh70fzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWWF+ht2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWWF+ht2"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caea3f742bso19567445ad.0
        for <git@vger.kernel.org>; Sun, 09 Aug 2026 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786304541; x=1786909341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=giIa6EK2TBUMdEfZ+PU9o1Vsq8H/VnTijnqBUgNvmUk=;
        b=oWWF+ht2WCV1qvwgo8lq75F9f1d4ITiRxMxxoHX1j8ggdkFfh5DahDcpgJQKd1tgii
         6QgklEJocDaopa2eQIMequ1Drg8CsOaQuH57h1pc/bWf6zhvo7jIIsYC/0WlFv8Hf/3O
         C1KTa9VNjcvwomR3NkPsvO5TSo0R2NKC73OvRBk9W/jJ3JI4VAxKorrtHvKBp365483m
         DCXD2rYkvF4AWnZeQKf/TtHfMP/Oq0ycAzDOFnUi9a3q/BUWIl1l4IaEf6JlKj4XLzKy
         yNbabwl90QjXF52OIRZ6UwnXDA3PagTlQG9qNFO+ACNn/w1aLfE6VQVnMlDQSmR3CTDa
         toEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786304541; x=1786909341;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=giIa6EK2TBUMdEfZ+PU9o1Vsq8H/VnTijnqBUgNvmUk=;
        b=bwvLGZI83F/4/kSF7/RrwT+w1aSVdXpP0Y5dq8GMGJp5KWI+rByVg7DYexk9ow3gDs
         bekfqIdJ/LSS8C9mNBfFXUYM9a9GRaYPkoslhbVCNqnS/r/SavD2ocm/tCSSg+wrSk4U
         5/veetfs9r/qudix2lDZN/+ZMxOEXM68Z4W+hPWpSPk85qpKWONhJjtEt2b0NZ340g8u
         EABokCNTaSv/VSsdAVa/wgebuMykVelQ+4OurS04DLuW/JV8fhlr+h7vsnAi1e0KdU+3
         BJvoxluRDCMvRS0p5Czvq6PzCc4MgmHZ/yWLlhrayIOIr9mRFJEp1SYyA3Lhdzn4Y5Yh
         jW4g==
X-Gm-Message-State: AOJu0YwfA+ryQoFyak9gZ4cVwQh1Pa7dnCGL3Pxf97z/vOzcsDDXrCD1
	NifyXZQndvVjPzucCtub9jhiWUqRXoxFDpUd9Yq+dlJsok4h9O+q+U7fFQDckwja
X-Gm-Gg: AR+sD13Q6Gx5jc9OmygbDMKGuNRtJg0JNOy3Cd2zXoCXEC57juNvC7X1sRaOwQkjaiI
	eb6uQDOsOXTP9DOGrhgqmxxlQCe+aAhjM1jLI/kZt1UxgE0pHMLtUxZHVeDB8LHId3T5SkSMID4
	VM/CKNRrs6SaON+9dUz33O28mP5rrRxjM6YFtunhfC3zH7cbfxmycVtUEiJ6DLf9fTi+Blp2dlL
	2/BYPLqgJfk9is+gmQF+RYbuB6RbYsK1yzgZ5O89cpuAocitOHP1VCI8WLWBpb3VhQ9/fkYp+Pk
	X1qVQw9CPgVj1RK7q1T9WPBUhEs7vLBvoms1pfHM48UXNtuVKZPRrKIcjnfOMgOCR9hs9Z/9fpm
	SW+GlWAYt/zbVNNSi7idsvWnrWxTCHG36B0bnjgaIuXl87r7qfpF9r4Teae9vf3XCMP/c8gfvD0
	sOCQ2WjjbQ/JV7fB/Ayd2Z8sA45G09QxAKXF1ohY6e3rBegd0J92wW/mYLnAondgewLHKIMH4UZ
	177FYNe/e5tGFf/w3/s5juDXw==
X-Received: by 2002:a05:6a20:4305:b0:3bf:5b7a:fc8b with SMTP id adf61e73a8af0-3cb85bc7b77mr38241235637.0.1786304541118;
        Sun, 09 Aug 2026 12:42:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:12d1:d4b3:58ba:dabf:94b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e917sm39149946eec.5.2026.08.09.12.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Aug 2026 12:42:20 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	l.s.r@web.de,
	Johannes.Schindelin@gmx.de,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v2] object-name: avoid use-after-free in get_oid_with_context_1()
Date: Mon, 10 Aug 2026 01:12:09 +0530
Message-ID: <20260809194212.77439-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260808200832.24313-1-diy2903@gmail.com>
References: <20260808200832.24313-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

When a ":<path>" argument names a relative path, resolve_relative_path()
returns a newly allocated string and "cp" is pointed at it:

	new_path = resolve_relative_path(repo, cp);
	if (!new_path) {
		namelen = namelen - (cp - name);
	} else {
		cp = new_path;
		namelen = strlen(cp);
	}

From there on "cp" and "new_path" name the same allocation. Later the
memory location that "new_path" points to is freed.

	free(new_path);
	if (reject_tree_in_index(repo, only_to_die, ce, stage, prefix, cp))

But here the reject_tree_in_index() passes "cp" to
diagnose_invalid_index_path(), which calls strlen() on it, looks it up
in the index, and formats it into its messages, allocating as it goes.
All of this reads memory that has already been freed.

Collapse the two exits into one to ensure a single free() that happens
after the last use.

Three things have to coincide to reach this:

1. The path has to be relative, or nothing is allocated and "cp"
still points into the argument.

2. The entry found has to be a sparse
directory, which needs a sparse index.

3. The argument has to get past the check in die_verify_filename() that
skips a leading ':' followed by a non-alphanumeric, so ":0:./dir/"
arrives here where ":./dir/" does not.

Add a test to t1092 that covers the combination. It fails under
SANITIZE=address without the change to object-name.c.

This was reported in [1], and the shape used here was suggested in
review [2], but that series was not rerolled and the fix never landed.

[1] https://lore.kernel.org/git/cf6bcdb43e5b4abab464c30a914d64dc8e7a9925.1655336146.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/xmqqy1xxw7rc.fsf@gitster.g/

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Original-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
Changes since v1: credit Johannes as both, Reported-by and Original-patch-by,
as pointed out by René. No change to the code or the test.

The three conditions make this awkward to reach by hand, so here is the
recipe:

	git init sparse && cd sparse &&
	mkdir folder1 folder2 &&
	echo a >folder1/a && echo b >folder2/b &&
	git add -A && git commit -m init &&
	git sparse-checkout init --cone --sparse-index &&
	git sparse-checkout set folder1 &&
	git show :0:./folder2/

Without the change below, no sanitizer is needed to see it. On 2.52.0
the buffer has already been reused by the time the message is formatted,
so the path printed is whatever now sits in that memory, and it differs
from run to run:

	fatal: path '' does not exist (neither on disk nor in the index)
	fatal: path 'M-6?:xM-@M-:M-L??X' does not exist (neither on disk nor in the index)
	fatal: path '?M-*JM-^M->M-YM-tn?H' does not exist (neither on disk nor in the index)

Still without the change, built with SANITIZE=address, the same command
reports

	ERROR: AddressSanitizer: heap-use-after-free
	READ of size 3 at 0x607000002a20
	    #1 diagnose_invalid_index_path object-name.c:1653
	    #2 get_oid_with_context_1      object-name.c:1807
	    #3 maybe_die_on_misspelt_object_name
	    #4 die_verify_filename         setup.c:216
	    #6 setup_revisions             revision.c:3103
	    #8 cmd_show                    log.c:694
	freed by thread T0 here:
	    #1 get_oid_with_context_1      object-name.c:1806
	previously allocated by thread T0 here:
	    #5 prefix_path                 setup.c:149
	    #6 get_oid_with_context_1      object-name.c:1784

With the change, the message reads "folder2/" every time and the
sanitizer stays quiet.

"git diff" and "git rev-parse" reach it the same way, and so does "../"
from a subdirectory.

The new t1092 test fails without the object-name.c hunk and passes with
it, under SANITIZE=address.
 object-name.c                            | 15 +++++++++------
 t/t1092-sparse-checkout-compatibility.sh | 11 +++++++++++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index 83efba0ba6..bffe795830 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1803,13 +1803,16 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 			    memcmp(ce->name, cp, namelen))
 				break;
 			if (ce_stage(ce) == stage) {
+				int ret = -1;
+
+				if (!reject_tree_in_index(repo, only_to_die, ce,
+							  stage, prefix, cp)) {
+					oidcpy(oid, &ce->oid);
+					oc->mode = ce->ce_mode;
+					ret = 0;
+				}
 				free(new_path);
-				if (reject_tree_in_index(repo, only_to_die, ce,
-							 stage, prefix, cp))
-					return -1;
-				oidcpy(oid, &ce->oid);
-				oc->mode = ce->ce_mode;
-				return 0;
+				return ret;
 			}
 			pos++;
 		}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4140c4d8ef..e88946c254 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1357,6 +1357,17 @@ do
 	"
 done
 
+test_expect_success 'relative path to a sparse directory' '
+	init_repos &&
+
+	# A ":<stage>:<path>" argument whose path is relative is resolved
+	# into a heap-allocated buffer, and a sparse directory found at that
+	# path is reported through it.  Cover that combination, so that the
+	# reporting does not read the buffer after it has been released.
+	test_sparse_match test_must_fail git show :0:./folder1/ &&
+	test_sparse_match test_must_fail git rev-parse :0:./folder1/
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
2.52.0

