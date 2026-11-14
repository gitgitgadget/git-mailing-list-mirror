Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619282;
	b=byLnWXTr8dqtEaJcPDSfkZ96Llhufs/mroMUDNE5OR8fm3PEEsnrEGcrJ1YYB/KRoTyC
	 1k3YbVCNbDzgzF6SHswtIInaFiH4t8IPkrI7ai+Ou96zszJhCBb1bHPd9fYg2JivQJ7eQ
	 Qj9LQ3R23qtCucYk3/wPphEJFX2LYNi2k9HZXpovZA0jMMLUZYBO0kTthNAM++xyM2ZuB
	 ivErP4AWRtj4Dr22xQfOwHkyG7ss1Yv8lbPlbguhhy3Rv0WEtVjMyecKR8VRlX1uk47ze
	 A9j9Vi3xDW4bzi9l97LhmqsV9EhcTOEqsReDxhajIwn12yZqVOoB2Om3Y20X31DZ+3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pVev7byy9Fn3LZTD7U0urQYSqdLZ5nFTvCQj9bZzQWQ=;
	b=IxrwKf2vhMZDluukucBRjaDNjJ/XN0aXPJgiQl+aU3rawTau01KbJWRF0fE1gvTqcQK3
	 DUypMy4lh337XOgf0NhMRtzbWiPJu0mjmnVcYoRm7mCvrLCb8tcOf3r7Mv4FDE3+z6dV1
	 no67FWl1j01FVEQmfOFmz6PZhqAOAdR8zX/fUKejfGEmVfzBBfZBzgfhvgNwRmZYssdBT
	 /OEZEPUNO9Zi4P3GzWcHjeHJAbK2rKnRcEQ/Y8ZVzPTJNb9RzvR/ourt2n4j0nVM0bpfj
	 C4okM/lMpga2onio9JiXGbDHHgWRLy+2X4ivP+mFrtHHwzqkm4sD4c36RW0kODlkaKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQp5ZlNd;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47730606A32E
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 01:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47730606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pQp5ZlNd
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a214af2076so9867775e9.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 17:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794619280; x=1795224080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVev7byy9Fn3LZTD7U0urQYSqdLZ5nFTvCQj9bZzQWQ=;
        b=pQp5ZlNdN+Ml+fJjSJlTSjgCVK3Mv/4H5hiLhwWiMREkwaEIIdJJhAva6PrM9SwYWD
         Ii69RVb1Di4gXHClyxfwYHcST6I9ZNRlpirz5mdGmJ7JpwhvE5uSaETTWHvd1SqEQKrg
         uweyBtGwhblmWbNS9n2NslzKWBqUWaAO/YuJ0JnvTpiPciT6YuL1a/riHf70VcfvA77U
         2jHQbc6E57M+HVikQ/0Q98bjV55ZUdh8BWqQ+C5OFDCBrQkEEKcai7rnm+cf7OV1f5rO
         OcJOVpQxMYGZUkrKuFD9F4EEJ1Lb41Kn6VjF2hUFcQzmaNYInAacSNWWv9iIc7bA/wf6
         /9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794619280; x=1795224080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVev7byy9Fn3LZTD7U0urQYSqdLZ5nFTvCQj9bZzQWQ=;
        b=YoRg2vP8aNZpX6EOKELqXbdL8D3O6Q9stCjDuK9ciBFUWVL7NrW+YMaDoXBounO2dm
         B91xLx4wkXqTmu4OB66tK6B7uOV4Hrp/WZFhXJ9wxnCD2YiiCjfpYnPQvts8OJ+QwbiX
         2wKocZAbK9JEQIL0vPHSTtM6biYzRjYHN0FAP82SZbrxE5BVm7A/TfYdPT7u7oCO6Xqv
         pQ+3I4uAvZUYIGSqK5wa44ouv+B/4ZRHEazxXFX33t4YZA8KJPYaI+b66e28Jm0ozvoN
         Nc8SAMlU+4mK46JJOTCG1RYb0F5jmRs6y3Yb0t3EooEKhonkZVFGPIJU9RGvAA/h9wvF
         Nrfg==
X-Gm-Message-State: APuU4Z/Gs9wuJy/hVHaB+/tOiSrwtLeewWvvjvGzJYfGtULT/eHJ3EvU
	Z15Lpq56HezLtuh9CMJjj/YnXpFgMV4dj61r4SGlBKAg+HGs7ky4mVS8VMVJGL8k6h0=
X-Gm-Gg: AYBFou2KlFTCVbqihlBs3YFzS/o4s8MVGFJX3yidpzl1q890wkFRbZt9fOcZSJGEM5d
	7zSa58PwEgwvAaacsWt6gA+inhGe9XyknuJ/ge/BppFERemUuH/euH649YNBPPbZdjOGSKfSNHU
	I6XnR3vyjPcRYjukFX7QlckvM2L9n8bpKMLQpKv9IOl7nnAp690ZRsDtObzofRhXuIW2n0sYHb0
	QaEkznffqjSb1qNKU55x0fqjfz8EJfO3pV6nPVKVeqv0qHncJAGr0+qyy2jgk8NuvsXeded5nN8
	tGLcA8YcY+CQDvfZQjc2rEGrRtnEuuL2ZukjICjppUpkQuIQ1pjnJZ2rhMlrGC8a4oNwMrIFk4I
	kXvV76rfQWCKtBmWuh1D2GUuODAGzEWZhqAZg4E/2wevHQgKSumzqUVwbszG3+fKFEsg3Q2v18l
	qhspvyhw2eyHQdNbNu4PQr1/O1ONy6EOrQz4zPpB/XO8Ch3X4Avx6a/YYOaGuvwDX2Xx+v9GQ/B
	i6wvBnm727Ym/x3zvcxAMHgnKcD3HeKTIJDmeFbLtcZhPdwkM9XwZmEwdBHeCaIe+Cn5yH9uBia
	e+MIq1IXAzdCJJV80JeFPE/uEUU+lb1jnEWry2N6wuV9HaHGTDcRyFxuebv/iAL4+MhqmtRsMRi
	6IOeGo+3sVA+NkOdTEmwV4wcQ8KWCrBmtKw==
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb55c5f579mr87305055e9.2.1794619280421;
        Fri, 13 Nov 2026 17:21:20 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm97277455e9.13.2026.11.13.17.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:21:19 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v2 1/2] apply: reject a patch after an empty "diff --git" line
Date: Sat, 14 Nov 2026 04:20:54 +0300
Message-ID: <20261114012055.127905-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261107195429.96842-1-tangajoris@gmail.com>
References: <20261107195429.96842-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a "diff --git" line is followed by a line that is not a git
header line, such as a blank line or an indented "new file mode"
line, parse_git_diff_header() stops right after the "diff --git"
line. find_header() then treats it as an empty git header and keeps
looking, as it has done since 206de27efa (git-apply: ignore empty git
headers, 2005-06-12). It finds the "--- /dev/null" and "+++ b/<path>"
lines and reads the rest as a traditional patch.

But parse_git_diff_header() has already set old_name and new_name
from the "diff --git" line. These names stay in the patch.
parse_traditional_patch() sets is_new for "--- /dev/null", but it
does not clear old_name. So "git apply --check" dies on the assertion
that 5c47f4c6e7 (builtin-apply: accept patch to an empty file,
2008-05-17) added to check_preimage():

  check_preimage: Assertion `patch->is_new <= 0' failed.

The stale new_name causes the same crash when a deletion with such a
header is applied with "git apply -R". When such a patch modifies a
file, it applies. But its "old mode" and "new mode" lines are
ignored.

These are corrupt patches. "git diff" does not produce them. So
report the empty header as an error, instead of reading the patch
that follows it. This also rejects a "diff --git" line that is
followed by other text and then a non-git patch, which used to apply.
A "diff --git" line followed by another "diff --git" line is handled
as before, because 206de27efa ignores empty headers on purpose. Only
a patch that is read under an empty header is a problem.

Reported-by: Gingrspacecadet <jackrawlings2011@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v1:
 - 1/2 no longer reads the patch that follows an empty "diff --git"
   line. It reports the empty header as an error instead, as Phillip
   and Junio suggested:

     error: corrupt patch: empty "diff --git" header at <file>:<line>

 - A blank line after "diff --git" in a patch that modifies a file is
   now rejected too, as Phillip suggested. v1 and master apply it
   without its "old mode" and "new mode" lines.
 - One case that works on master is now rejected: a "diff --git" line
   followed by other text and then a non-git patch.
 - Dropped the test for an empty "diff --git" section followed by
   another section. That case behaves as on master, but the test fails
   under SANITIZE=leak, because of a leak in git_header_name() that is
   already on master. Also dropped the subdirectory test, which only
   made sense while the patch was applied.
 - 2/2: the code is unchanged. Its commit message now says why patches
   made by Git are not affected.

 apply.c                    | 13 +++++-
 t/t4133-apply-filenames.sh | 86 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index f00b7ba4d3..c5d4fe7887 100644
--- a/apply.c
+++ b/apply.c
@@ -1604,6 +1604,7 @@ static int find_header(struct apply_state *state,
 		       struct patch *patch)
 {
 	unsigned long offset, len;
+	int empty_git_hdr_linenr = 0;
 
 	patch->is_toplevel_relative = 0;
 	patch->is_rename = patch->is_copy = 0;
@@ -1644,6 +1645,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
+			int linenr = state->linenr;
 			int git_hdr_len = parse_git_diff_header(&state->root,
 								state->patch_input_file,
 								&state->linenr,
@@ -1651,8 +1653,10 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
+			if (git_hdr_len <= len) {
+				empty_git_hdr_linenr = linenr;
 				continue;
+			}
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
@@ -1670,6 +1674,13 @@ static int find_header(struct apply_state *state,
 		if (size < nextlen + 14 || memcmp("@@ -", line + len + nextlen, 4))
 			continue;
 
+		/* Git does not write a patch under an empty git header */
+		if (empty_git_hdr_linenr) {
+			error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
+			      state->patch_input_file, empty_git_hdr_linenr);
+			return -128;
+		}
+
 		/* Ok, we'll consider it a patch */
 		if (parse_traditional_patch(state, line, line+len, patch))
 			return -128;
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3cab1038cf..751a01f92f 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -60,4 +60,90 @@ test_expect_success 'apply diff with old filename missing from headers' '
 	test_grep "lacks filename information" err
 '
 
+reject_empty_git_header () {
+	file=$1 &&
+	line=$2 &&
+	shift 2 &&
+	test_must_fail git apply --check "$@" "$file" 2>err &&
+	test_grep "corrupt patch: empty \"diff --git\" header at $file:$line" err
+}
+
+test_expect_success 'reject a new file with a blank line after "diff --git"' '
+	cat >blank_line.diff <<-\EOF &&
+	diff --git a/f b/f
+
+	new file mode 100644
+	index 0000000..d00491f
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	reject_empty_git_header blank_line.diff 1 &&
+	test_must_fail git apply blank_line.diff &&
+	test_path_is_missing f
+'
+
+test_expect_success 'reject an indented "new file mode" line' '
+	cat >indented_mode.diff <<-\EOF &&
+	diff --git a/f b/f
+	 new file mode 100644
+	index 0000000..d00491f
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	reject_empty_git_header indented_mode.diff 1
+'
+
+test_expect_success 'reject a deletion with a blank line after "diff --git"' '
+	cat >blank_line_delete.diff <<-\EOF &&
+	diff --git a/f b/f
+
+	deleted file mode 100644
+	index d00491f..0000000
+	--- a/f
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	reject_empty_git_header blank_line_delete.diff 1 &&
+	reject_empty_git_header blank_line_delete.diff 1 -R
+'
+
+test_expect_success 'reject a modification with a blank line after "diff --git"' '
+	test_when_finished "rm -f g" &&
+	echo 1 >g &&
+	cat >blank_line_modify.diff <<-\EOF &&
+	diff --git a/g b/g
+
+	old mode 100644
+	new mode 100755
+	index d00491f..0cfbf08
+	--- a/g
+	+++ b/g
+	@@ -1 +1 @@
+	-1
+	+2
+	EOF
+	reject_empty_git_header blank_line_modify.diff 1 &&
+	echo 1 >expect &&
+	test_cmp expect g
+'
+
+test_expect_success 'name the empty "diff --git" line in the error' '
+	cat >later_line.diff <<-\EOF &&
+	some text before the patch
+
+	diff --git a/f b/f
+	some text after it
+	--- /dev/null
+	+++ b/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	reject_empty_git_header later_line.diff 3
+'
+
 test_done

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.43.0

