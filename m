Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com [74.125.227.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A203B3BFE
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667565; cv=none; b=WY5MIbnkRy7W/CNAAH2WDM4a6bH2TPREgP8uUv6YJKOeCTNbsGf7Y0y55yJBmlFbH2mewQZV1e0SBjKqWg5JDtS7Gk5ibfX2SDdETalcqf8v7Hv8K1CXOiWHSo2OyKga1Cdd/nnffiDElPjkWM/USWRQ1j5navkx6M8I5vlOMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667565; c=relaxed/simple;
	bh=GUg0iyxlboTsZdylsUkv4/J5GQ6QKceZG+U9KxImwbE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VkPx1ZuoZwvHm5JSfIyjm10wIMmVL4R5lsX2s1c3oZjkCydoSKv61w4T1fpGITKG+CmgQ/DmuoUFjdNekZYYqKosa/DRzMnlQ8WKAcsIgxjfXSJ9XkWQes0rltKQWt9VK7lvgXtWyWnhrJrtn2TdtjZo9H9sfCcilG3FyPjNzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+SC9R5B; arc=none smtp.client-ip=74.125.227.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+SC9R5B"
Received: by mail-pj2-f17.google.com with SMTP id d9443c01a7336-2db1ca06a25so8723935ad.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667563; x=1790272363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qauVpZE3XaZi7Wee+e2S9UXo1yKeRws7MWXu/5Ex0b0=;
        b=Y+SC9R5B5zpF/bCykBAcN8T++fiJ17Wtd9hvQsNvm+3DkLhikOXft6ZBbgTAI/Xv1C
         /y+TgTPDJMEsBCv+sZ3E0+bLK1DU/oTq8UWsjTnfXILt4yhXfh+5pWmoWifZWPZGW6Nw
         sN7SsB46QEC4zSgoaBMwpL/WxxY4UUKc8YDcU7qs7D/HMtdvKcIhhZEMaDBIUFQ7rvAm
         Kf+CWVlnJmV7caS5UgsPvj+ctWplAsljWxIQCAelJFRRia/x50tD8DiBdGtsu3wY7Yiz
         CHLj0biT/hSHq61bKjttTFlFZYBGnlzl09R4zP3f/HvEfK3DiEBcYiPxHMNAeohBmbHm
         TYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667563; x=1790272363;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qauVpZE3XaZi7Wee+e2S9UXo1yKeRws7MWXu/5Ex0b0=;
        b=nLjXIXue+Sa2OoURDn8X3M+Az0h7a5VuHX1a1n4NQvpM2YdPnzZWc1TedvoD2JotsN
         3tRkN9LziVj2e8Wr+M+rv+4PqsjK0XCOAj6GE5SUGOhoOC4iPpNXRuKWiFOHhdzMMHH1
         yAfaN3AhDfGAo6/2gaouSP0wnQmGiExZW4NaOrkh641yyqoCjsYtDVt4zz7pJZLyN6sQ
         XltSoKoe+mnpiQiiPIgIkTXoAFYQJ+D/ooWqW+1fxZZc4xWhMNtMCndTDVXNUAhyUOog
         9AGnPfxzUUbPbUx8lKIV4JwLRCsWLhVUNK8WaDgNTdX7YYm8CrAHimgaboii2Qn0YST0
         GOzw==
X-Gm-Message-State: AFuF++nR1O0VT4pcP8yJeuAHyfaosoNAH7KnHu7agvy85XFDJykQVdL5
	kzA4wKdlryxEdNKzwX952rolEeHDTMpBRLaocA/PgMSNjQyd9/SX50cvBs0SuQ==
X-Gm-Gg: AYBFou3JP2GcZ0QX7lmzzlF1ib3K2bZCTd15UhahntKHx8WFs3K55+4u1RPwWXuCOFU
	2XvscuEIN+fxus1XcctH9SzI+uvgqK+KHseVlKZF9VxMNDICbGmI2zz2udEvolfB9JkG5eeC3rX
	HDzb+jnqV510E7sxZwhUmMPlq9rsS+09a4mlOXln4sFiMtV6cxN0uV+Dyx8pHV5v945G/1VOPKn
	yqO9JlK16LJQuAfV0xXUbMGnXnm5Wgc9xCYnc7ZIacdT0NVvoiF1BtTVcLBFn8OqX90Kw3DcfcF
	++SVnEzFTX7IrOTaXEqsB3/+Dra58zBYLn86RyHNdrR8bcKPgfdgcpIdauWdIz9HmixjgstrBzu
	Hwgk6pgiDOn+TsE8G6xR0XaXIH6PD8VHOFtasZ8zv4TUwvX7pQmzAEgGlTKI1dPhHEAh9dL2NNN
	Aa61cdnjH1p/bUZ1kRVSYknXNqGZYUPfiZv+jc92BaRvJMznXu1o7bd2FengttF29F4N30r7DUa
	QDHHQq0rPg=
X-Received: by 2002:a17:902:ed45:b0:2dd:ad74:ac2c with SMTP id d9443c01a7336-2ddad74ade4mr15808075ad.30.1789667562651;
        Thu, 17 Sep 2026 10:52:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89e9345dsm30840835ad.24.2026.09.17.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:52:42 -0700 (PDT)
Message-Id: <3fc7774ba867a10f35f7a74424baa4527f038232.1789667556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 17:52:31 +0000
Subject: [PATCH 2/7] gpg-interface: make signature-prefix matching
 length-aware
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After merging v2.56.0-rc0 into Git for Windows, its Coverity run
reported the following issue: The `parse_signed_buffer()` function
accepts object buffers with an explicit size, while
`get_format_by_sig()` uses `starts_with()`, i.e. it expects a
NUL-terminated buffer. A tag object with a non-NUL-terminated payload
ending in a partial signature prefix, such as a final '-' byte, could
therefore cause an invalid read past the object buffer.

The observable consequences are limited to reading past the allocation.
In practice it can crash Git if the read enters an unmapped page. It can
also misplace the payload/signature split, corrupting the compat-hash
object being written.

The older unbounded matcher predates this path, but c8762c30df5b
(object-file-convert: convert tag objects when writing, 2023-10-01)
exposed the defect by passing exact-sized converted tag buffers to
`parse_signed_buffer()`. That commit first shipped in v2.45.0, so the
defect has been latent in every release since.

This pattern was noticed on the mailing list in February 2024. Reviewing
a patch for a very similar issue in commit.c's find_header_mem(), Jeff
King observed in
https://lore.kernel.org/git/20240208214137.GB1090198@coredump.intra.peff.net/:

  But more interestingly: even though we pass a buf/len pair to
  parse_signed_buffer(), it then calls get_format_by_sig() which takes
  only a NUL-terminated string. [...] That raises the question of
  whether parse_signed_buffer() has a similar walk-too-far problem. ;)
  The answer is no, because we feed it from a strbuf. But it's not a
  great pattern overall.

That reasoning surveyed the callers that existed at the time and missed
c8762c30df5b (object-file-convert: convert tag objects when writing,
2023-10-01), which was four months old at that time, and does not feed
from a strbuf; `convert_tag_object()` hands `parse_signed_buffer()` an
exact-sized `xmalloc()` buffer, and the concern flagged and dismissed in
that thread is exactly the defect Coverity now reports.

Jeff went on to add `starts_with_mem()` a month later, in
https://lore.kernel.org/git/20240307092638.GK2080210@coredump.intra.peff.net/,
precisely for "cases where the buffer is not NUL-terminated (and we
instead have an explicit size or end pointer)", so the tool for this fix
has been in the tree since v2.45.0.

Even though the issue had been latent, it most likely surfaced via
Coverity because of 215d305f450f (odb: compute compat object ID in
`odb_write_object_ext()`, 2026-07-17), which moved
`convert_object_file()` out of the `source->write_object` function
pointer into a direct call in `odb_write_object_ext()`.

Preserve the existing NUL-terminated behavior for callers that provide
strings while making signature-prefix matching honor the known buffer
lengths, via the `starts_with_mem()` helper. This keeps reads within the
object data without implying exploitability beyond the observed invalid
read.

Assisted-by: GPT-5.6 Luna
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 95abf1ef4e..60c315fba9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -133,20 +133,20 @@ static struct gpg_format *get_format_by_name(const char *str)
 	return NULL;
 }
 
-static struct gpg_format *get_format_by_sig(const char *sig)
+static struct gpg_format *get_format_by_sig(const char *sig, size_t len)
 {
 	int j;
 
 	for (size_t i = 0; i < ARRAY_SIZE(gpg_format); i++)
 		for (j = 0; gpg_format[i].sigs[j]; j++)
-			if (starts_with(sig, gpg_format[i].sigs[j]))
+			if (starts_with_mem(sig, len, gpg_format[i].sigs[j]))
 				return gpg_format + i;
 	return NULL;
 }
 
 const char *get_signature_format(const char *buf)
 {
-	struct gpg_format *format = get_format_by_sig(buf);
+	struct gpg_format *format = get_format_by_sig(buf, strlen(buf));
 	return format ? format->name : "unknown";
 }
 
@@ -669,7 +669,7 @@ int check_signature(struct signature_check *sigc,
 	sigc->result = 'N';
 	sigc->trust_level = TRUST_UNDEFINED;
 
-	fmt = get_format_by_sig(signature);
+	fmt = get_format_by_sig(signature, slen);
 	if (!fmt)
 		die(_("bad/incompatible signature '%s'"), signature);
 
@@ -706,7 +706,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
 	while (len < size) {
 		const char *eol;
 
-		if (get_format_by_sig(buf + len))
+		if (get_format_by_sig(buf + len, size - len))
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
-- 
gitgitgadget

