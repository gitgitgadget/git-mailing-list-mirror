Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794876279;
	b=MeZH0qPpK2Ky9ZbO84S8Q2CgOCIxcsxGV8kQCvD6GUFQd4eRPkRMR035n3d3Oa9rnBUr
	 Ar5lRp8CmpZQb55tWEvJt5NpcGDF4Y/cAsGyv1w3WIWxcJbQ+Aj9JuDoF5mifW7MDvTjg
	 85KoyTwuZ/NLLMIV5as21hdUtQ/RXZJJSnmVu+zonHDJItdtr0sn8CBKiRRH8LBGfsOFE
	 eFV3Ip5GntkzF97aXjnATSUnerMnXZMySQSke8d/skfmHFBu/czDNap+7LK/mJCHMtT7V
	 /Vei9lU4CsYDfj6acyG544S7dPl5Ip20nvnQ2FD5ud3bJbRwnnFLNenmonQ9qWD3qgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794876279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KiL0llCAI6xxnfTQBoo92zJnAy0h+qducPYYjhH97F4=;
	b=cmbWIjhMmLkscaP2/tFWvCbn3dKuLBtWtRNtJI+U1OyNR6ct9qjdI/qMoGyH3/fKIr8T
	 F0ACU+GcWZKBjRDTzoxoj1SRvYniyQa5MBJpBwSNGdiP9xqvWleNLXzfLkW9DhtERO+4v
	 ZrhWN3tNqGCNtlOciXr3QbRfluf3JGdbd/clBrvsP1xQ/BoG60gOu7ejTuhaPtR2mrxIj
	 KcxdpOGm2kPetd0d2h7Eu6FcQ8PNexHQY/Pe5WKIZMYT3hw96X2s0UNYb4FDHUn+YVrlz
	 fiE7OJCL/r32u244ZpIEsyS1wgX/J3S8byO1xYnivfWFasDu+Ixxseydup94UlA/Wtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmn5nl2P;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7471606A323
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 00:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7471606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nmn5nl2P
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so4278823f8f.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794876277; x=1795481077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiL0llCAI6xxnfTQBoo92zJnAy0h+qducPYYjhH97F4=;
        b=nmn5nl2P1DHwyACJQiope6IZGL3FomUb6gVO3XuS3u+ErAH+4XPUrIoDSpJVB2EgIl
         HE6Nhs+LrKeidqz0i2/vx14/lWrUJfstrraP5JhYkehsV7q7D0F2HXp0NmhRm16ppQUz
         1exQsMrLt6mpnwk/SKEL71M/ebPrgrESkZa3j8eZnmf12P/6+xog+Ase/UlLaEn+Stfa
         QIIGhBDli+bT4LLHwHttw2sjQI/Ih2sDHpjUJMnVijvNE5pwRCw3DTxmLs+FmgMIxfaf
         8+ISYNqba0LPh53RjnADwSxWqzfVnD0Gr/c3vhvBawABwp4o+FNA8cOu8A4KxN8nOHJR
         Ad3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794876277; x=1795481077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiL0llCAI6xxnfTQBoo92zJnAy0h+qducPYYjhH97F4=;
        b=E9U6wlyZKWmYUctITE8bDazYJ0alAsSIhBHzec8VytFMaThSP8qEJsBP1qxU/TFbkL
         y4PZN+/Dhl2vOuEdbWFW+Qacn70G9y9aIo2RZgBEg/uCSHTo9lUn3AJ7r3SyvBLIABPV
         mzGh9z16LM+YUqKaTRfzUfB3nKT8AdDw4qVsMTrBrQkh01G/2PHkPojmRMNcJHQ8V44e
         iWyPj3XZ+MSpZr3RJxVf1XwcPaJ/GYsVcdoHCQpUnh5Uydz9kY1Od4nScLNE7LdzHMwr
         g1Z5h9ay1ujJp7MxQaRzR0YL38tBcqBN7ZGX699ME44xGXvi+ZFEdjDZYM2fmK+2CVZP
         cFlg==
X-Gm-Message-State: APuU4Z8GkFySKAnhaElodr/QbIpUdqaaloGx2ESbtQ2PRQ7kvB1VYG6+
	m9+rMLFBUtc+7lXU0oi/flEjh55BkzY7W5KKeOycx6R9CO89swt4Y+QyRLpfyY9GKOM=
X-Gm-Gg: AZFdTZfyjN1hEkoMgGFIHG/pMvTg8z6eWCEYW3oUnjfDI65xCCMoBs4ZNjJ/nSwRzfC
	0LlOzwrfaKvGMrdcub5pEem3DuZz664cZVOPmx1UeUbj2xfhDLcSq4+OOnv1iR5u0/xxdrVUOxo
	p+dHQhH0Vo3mVsRnvdhy+qRbsw526Xi+/sGqxa031sbjjCIQxyN7uyEEvUlT7Vh910DpEUsYDq2
	/TEDzw8pwlafIzfURMeLC7wGcl2pfqksWXZXmodCDSrpx8uG8O0mdDRwaP2B9wafL+mTEBmqMH8
	smsjK42qNuojHNrbnKxI/4FYPJQT1846qzf21ylQ+sDJCUvcW0nSZytF9t/otRZc7v5RGEjHdmG
	U0ayTwjdiAEk2aEPzMYZvBPSHrhZH9nBfP65om1RVE/MqCEkb4fpd4TWSr1vEe4hVJ31Qka4quk
	kLtICX536DXvpxdSg3xqgqobPsMVpxQUiooK0DtYFa0shjMEkcsQ1+2iH5iIE3TTEw6QzqZCps5
	Giy3HD3mn9vIGN2gazLbFiJco3Xf8uYB4m2gt8UI0AY8/rZuE55tELxr3MkNQcinjeVIlELlU48
	7V/FE2okI5/S2ZSzeIEcELso/1fF/neEJWjaStpObtd8n2tWrAOfgkBS+Mpu6Uuguab7gWcgwIa
	LOEt8LuNwkgxINpOJuTcwdfm6HQ+aObjzng==
X-Received: by 2002:a05:6000:1615:b0:48c:466e:9d08 with SMTP id ffacd0b85a97d-49c72e8536dmr16727288f8f.43.1794876277101;
        Mon, 16 Nov 2026 16:44:37 -0800 (PST)
Received: from HP ([102.0.122.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a3d39b8a37sm953876f8f.46.2026.11.16.16.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 16:44:35 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	jackrawlings2011@gmail.com,
	christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v3 2/3] apply: reject a patch after an empty "diff --git" line
Date: Tue, 17 Nov 2026 03:43:47 +0300
Message-ID: <20261117004348.806694-3-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261117004348.806694-1-tangajoris@gmail.com>
References: <20261114012055.127905-1-tangajoris@gmail.com>
 <20261117004348.806694-1-tangajoris@gmail.com>
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
 apply.c                    | 13 +++++-
 t/t4133-apply-filenames.sh | 86 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 0847835357..77a665a71a 100644
--- a/apply.c
+++ b/apply.c
@@ -1605,6 +1605,7 @@ static int find_header(struct apply_state *state,
 		       struct patch *patch)
 {
 	unsigned long offset, len;
+	int empty_git_hdr_linenr = 0;
 
 	patch->is_toplevel_relative = 0;
 	patch->is_rename = patch->is_copy = 0;
@@ -1645,6 +1646,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
+			int linenr = state->linenr;
 			int git_hdr_len = parse_git_diff_header(&state->root,
 								state->patch_input_file,
 								&state->linenr,
@@ -1652,8 +1654,10 @@ static int find_header(struct apply_state *state,
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
@@ -1671,6 +1675,13 @@ static int find_header(struct apply_state *state,
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
index f8158faec0..b6b9195924 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -60,6 +60,92 @@ test_expect_success 'apply diff with old filename missing from headers' '
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
 test_expect_success 'ignore an empty "diff --git" line before a git patch' '
 	test_when_finished "rm -f g" &&
 	echo 1 >g &&
-- 
2.43.0

