Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569028;
	b=pj5v0o8kb21AuJNdAG065DUznE0tsz/zI9huWJdqcsgrn+dill695l/cpKOWMPLpgyz4
	 tqpc/8gw7GNIiYFKbTzuI+JLCwsw5j7+nIMRVMDF9E6WYjdFopQwELACYy3YC6J8eiU/0
	 tYhsepdkzTiMGjToS/ViSlhBctVAxCYvv87p7nXPgQsRTv1R/69H0ZFGs4oCdWxNnGvWB
	 dKERKBwFWabkRF0SVIQ2OsV8xOghlmkuDYsyKSp+9ZHfKAM2IooMzEUZN0yLfyw7nKHuj
	 aE3W3VYRAjGv46TSZQeDvDZa3UBwhvC6UdrhwwQ7b+SPmD8w3xGU8ge5N2xmnPJyqFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Ui7JZ5uH9z9nYwKt9uV00fJioekaalFxCGZee4CAbw=;
	b=tLsrqRAJNRrbbO8Qt3klVZvMhxTYXNiPBPHhWlV+EZ3graoy0lgFpHTnzGlB3XCcAMpy
	 hPFaAvmhN5FitIPtq0HRta6Zve+sLLWaqXR68RX9eS+NbZ7bWX0lzIYrgrP5/KPS2CcZO
	 d2yX5ISPB7jWr8+8hHwEV2bvJRLfSxecOGjGFhznuqBGH3XaVYV2Qcz+JQen0BDrDByrT
	 bdd2wa+ajUsV6QU3xxC1ZvbWcSJTAWR5C8p3+G3J6YnOt3ueZqGBendsX1qpcBSisZEbO
	 qEyClBmhfTjVsZUhPPwPGSaE94nGNeW9IddhcxdDaMeV3dHS7fs6y6kc5NrPrzm1ctw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOaa5UAK;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4A606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE4A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOaa5UAK
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso1235015e9.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 17:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569026; x=1796173826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Ui7JZ5uH9z9nYwKt9uV00fJioekaalFxCGZee4CAbw=;
        b=OOaa5UAKdrjObUeIZWio1Qpvm1AmR+yUQ+LAvtUVRqvJ5HVR6w3iVmVhkMqERYMYmv
         XK49pvxIpYCM7TxFmrEWIQgKw2TpxR4fb/z9sQOVXsO8/uYmii2gcmQt3N7r/lV3JeIB
         kHqSyLQW5ALsAwbF3dcsJuSDTMr8yrf7kRPcygA1bhTFDrHOhcdGDqlrgqgWxpJwFNIt
         QR8IURgK3TVN5B0Y57Aq5fBJo8Jpf0iaPnRSpAxYTk1D6E5PR1mt4NpGnH+vz5VplYG8
         tMwhiv04WvBF6wDhigANc6OzYjR0jAcaN+YuRQk3Ei7rLByRAtppBGCciVvvxqraeu17
         5Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569026; x=1796173826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Ui7JZ5uH9z9nYwKt9uV00fJioekaalFxCGZee4CAbw=;
        b=KGGi9KwJku8kRruQgI0BMi70bBmrq/95t7uGw3Oz4iXJOVCtaItR4v82e1g38wibMz
         nnH/vokqO68iNqzb0KycqQtAeKiNf4dSJ9B5oeLx+/ZnCu3VhuIWPnTMDfw0zn8A7iFs
         DK5XVd27QdPTlpT9igSWC0YYZouEfnrv3VyV5xCAM0XAoIZ4SmQQ0046aET2p/52gvhH
         1jdJZK+BTbXC6XpljMu3k49vZ6tbfw+nOoDeCkR0k+YMIjpP9ISLadAUuqWA1k8VO4h6
         7F3tCwChgiOhiJCYdfbmcLI8vgwCtNOyVQD28trMqWY0F0WW8JzAn2bSW4gIAFy3iNvC
         03jg==
X-Gm-Message-State: APuU4Z9KwKp3f5agMv0Dz3vb9hsXeWQiHejBenOQyQu3zaGd3ETFhUDQ
	YEJ1FgStjQlxQwFLdaXm6tasiL3wQ3c3nZSrfgtEOzMgebCprrbd00IFlr339L2wOuI=
X-Gm-Gg: AZFdTZcSuvN7wxtaoOt7v9RxHtmq2fvRsViW6+bqpIeD2c50P/eYf6uXSVlkLxstSP9
	2qC0jgMgi8fGWOF6iUth+2jSA1ndHyABIeBjK3A79+iAoYxW5C60OJKPIH/1JkKPwLxcul+pkqx
	Hac5oSl1o0RVNUwn31lKAs6Ag086dggvA/hGutP6Wmj68xRwduj2kHEYjS6ed1x+2ExQHVV6VC5
	KhdPgmRmuCjnSp5IBR/wLWm2bWzYIZMQNpFtsaYyZ3XdeC97YqUUs06sk04TzytT3pmn5Y36V/q
	h/qLUJfWuep2l68PtwfthSNQ4i8MfODYxwL3bs8uNNq0dlQm8AiCdYJhJzU/6Eku6/Eo5xh1SVF
	rfgCNvwLtlks/7Q3DL+0guY/CWve1f88QqWi3t5PYHNy6ftc/CI1vcvh10LDfHsBY8HwchpYJ+n
	MjRUQ4GLlgW8aecPJ1n+u7bYb03BF8V0qcQCihL4zc4TeGUhp1ZpTd4oVuRfmUC+yZqu1Lq9vF1
	yAvmvApq1Ia4W1bEtnf/8kpfWFze8dVNjZB0sZFxclyfyb6ScorKudfcrM/dDNd4nGxw+P0HZUL
	1kehE3vDgeeWqzbgVT2OvI7pUm+A3pQF1ExxK4dUzkWxOV6tLg70uMZqeCnWkVAsMBYiAz6laqT
	wxvUx3HPp+CRVZk/ODo+2h10JXmK5B5Q=
X-Received: by 2002:a05:600c:848d:b0:4bb:694e:496c with SMTP id 5b1f17b1804b1-4bb88810b39mr346897215e9.22.1795569026368;
        Tue, 24 Nov 2026 17:10:26 -0800 (PST)
Received: from HP ([102.0.122.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm435336135e9.12.2026.11.24.17.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:10:26 -0800 (PST)
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
Subject: [Outreachy PATCH v4 1/2] apply: reject an empty "diff --git" header
Date: Wed, 25 Nov 2026 04:10:01 +0300
Message-ID: <20261125011002.589285-2-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261125011002.589285-1-tangajoris@gmail.com>
References: <20261117004348.806694-1-tangajoris@gmail.com>
 <20261125011002.589285-1-tangajoris@gmail.com>
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

When 206de27efa was written, Git printed the "diff --git" line before
running diff, so a path with nothing really changed could end up
with just that line. ec1fcc16af (Show original and resulting blob
object info in diff output, 2005-10-07) added the "index" line, and a
pure rename or mode change has its own header lines. So today's Git
does not write an empty "diff --git" header, and one in a patch means
the patch is corrupt. Report it as an error, instead of skipping it.

This also rejects a "diff --git" line followed directly by another
one, which used to be skipped, and one followed by other text and
then a non-git patch, which used to apply. Text between patches is
still ignored, unless one of its lines starts with "diff --git ".

Reported-by: Gingrspacecadet <jackrawlings2011@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 apply.c                    |   8 ++-
 t/t4133-apply-filenames.sh | 104 +++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 677c01dc02..b28c1401f4 100644
--- a/apply.c
+++ b/apply.c
@@ -1645,6 +1645,7 @@ static int find_header(struct apply_state *state,
 		 * or mode change, so we handle that specially
 		 */
 		if (!memcmp("diff --git ", line, 11)) {
+			int linenr = state->linenr;
 			int git_hdr_len = parse_git_diff_header(&state->root,
 								state->patch_input_file,
 								&state->linenr,
@@ -1652,8 +1653,11 @@ static int find_header(struct apply_state *state,
 								size, patch);
 			if (git_hdr_len < 0)
 				return -128;
-			if (git_hdr_len <= len)
-				continue;
+			if (git_hdr_len <= len) {
+				error(_("corrupt patch: empty \"diff --git\" header at %s:%d"),
+				      state->patch_input_file, linenr);
+				return -128;
+			}
 			*hdrsize = git_hdr_len;
 			return offset;
 		}
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 3cab1038cf..73d3bc4e08 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -60,4 +60,108 @@ test_expect_success 'apply diff with old filename missing from headers' '
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
+test_expect_success 'reject a "diff --git" line followed by another' '
+	test_when_finished "rm -f g" &&
+	echo 1 >g &&
+	cat >empty_section.diff <<-\EOF &&
+	diff --git a/g b/g
+	diff --git a/g b/g
+	index d00491f..0cfbf08 100644
+	--- a/g
+	+++ b/g
+	@@ -1 +1 @@
+	-1
+	+2
+	EOF
+	reject_empty_git_header empty_section.diff 1 &&
+	echo 1 >expect &&
+	test_cmp expect g
+'
+
 test_done
-- 
2.43.0

