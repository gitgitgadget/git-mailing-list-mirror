Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224328;
	b=UYwIex8QJabey6acFWBhfhMi2FfT+FcSp/WVykwSwiPqB9n8JLUOrqC80ThDB6sz3ZyW
	 yWtxtcalFcABt/1a0f/t+HiYrEgR7IHnH1Wd3QCQazL7jOvoDnnuj8WeDElOeOhkilO3P
	 hk5Kepm5c9c9wYsW5JvLGotgc3nFoW18SkXqEDzhIrJW7d3eWRK7v5QyiYyVBYCbobIrU
	 28e0iypsBaUVN5vC/c/OoT9L23UQ6vT9GDUXxkvwUcia1vwrM07+firqzgu0EsT8l7x+e
	 tTa7ebJirzMIP8XoKhvShsgN+SibzkuNvZvZ1Ix+So2pWi81/GqJ/DxQeu/oj5DzwdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sVchRUDK0bqOSRYondupHdWADCTtDVq0IZSl/YtQ2Ko=;
	b=g1TKN7FU/SOHOETgCN9VN+hRsbOiNWDkp8Th+PJ6sI2+6AwIR46C8dabHGXYE6+OQv4J
	 QCtn6j0rWQQfz7IvowHs58j/d++55UGWs5RMK+6JvKb0s1R4KQy2ksuF0hcV+ajcfThMc
	 2uRpLHWqGBCJGdRN3vBzmH6Ko9HcwsVT9IxxgRRRs+dFYIqJk2HCicjzTC6tb95Mc+4dV
	 EcNQjGEn3HTB7OYYCkIFvUrNT9KvGn2bV+cCkHLTJPm/NITbLSWlwMq7vNRvK8kMShnBU
	 8RKg/SNYerwPZPaeP37zvJ1RCHWyEn+Hst5jjfwx3MBVGqaIlqoMYGJ0K6CR3QEwpEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk3TXV5g;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574B606A322
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C574B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk3TXV5g
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c414e5d282eso195652966b.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793224326; x=1793829126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sVchRUDK0bqOSRYondupHdWADCTtDVq0IZSl/YtQ2Ko=;
        b=Dk3TXV5gH7of+fHnyGb0wUYMWDz3Lp/fKIMJz/CCNa/LiaPH0XuMlwMdv1AJA3mQ+I
         U3oE2m79imRAhGCyuouM0tPG8JuNw4eRfFG8JbOhrRP+opjvIaaOmYKkIUkSYqdQ4x1t
         81qkkvTEa6cqavUNTV9OLcVbWlq6P1wdwf2XM9K1eMPhzuf/Ub6qJ/f9k+2xiIYcqS3S
         mw/YX/JVXGZgyJzjWbWtZ8ELus5eXkcmXNFZZ3AnrstFtI3unRth8/r6JjyJYdok+gna
         9H69oVDChzk9qMQrDv9bNNv4NrynpYObOy9jmrRVGQ9LiyR1GWx5n+6gqqyZVLTF/UVf
         aM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224326; x=1793829126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVchRUDK0bqOSRYondupHdWADCTtDVq0IZSl/YtQ2Ko=;
        b=nEtXF91wItDtA/7eWSWJiSnGoE/WG1CrUL+zbV7qvDN5hFvIzEDfuP4Ry3fgpWMJuq
         NbxZ79c2DI7pg9felT33rJlPMT/qiNTqB0jbE4grY3+CPI7KeTWs8ZDx1ZzfD2rc/wFw
         feeQ9wJIgS6HEOnrYmyo79HIbfUfUdifv6yLLOcwmumx4I8633ucDhxkPW2KQ77Vpgmn
         oZ03JKXbTZv2UeiB2vvtLbUAaAE3dQ8tlfELBbNdd/clkCSzy8lCah4zUgBqpizPPC0t
         0njn0BNQc9SrD1tMSI6HTTPgh3Vj6/1JTLBBUwPqRlw72UbOqopxlWcURFV21OFJVtic
         h64A==
X-Gm-Message-State: AFq9FYKPd+1s9uwMWBDdJOK78c7sDIwtKxspJl3mhIYZTaGjcgifFVvC
	2yt1V3s3wG/nGba4WNuhxVg60BTKf1d6mYs5Djm+K5Dx3kFDIWzAPf0uhJTNtgm2bj4=
X-Gm-Gg: AYBFou3l3YmrOw0IUnWTfPYnOUQCBDgQKfxeLEIkDKGhdj0GGnkSw2eN4BGoTq1YuQS
	NwrzvY4X0gZcp6gP7t0eSnBaq7ulKYaLWqqp00ky2ij86muDJegnxYo4WQHdexAgxV40rEccocK
	XkwVGXIVvGYCvC0KiMUBpb9smxuORqS9qzo190zkRp82uhTaWzdofc6C6870d0Mb8VYiR9ChsNj
	o9Tf74gJnJZLxOi/1pMmXKtHHQr7P75rygOz7m5O78g0EL1MhNY3wthfNYw2dzsgtt3WQxvDVAm
	Hi61SgiP3e1IrNMp7GgWfdsT52DldYqmQAfFsS/ZeYVLN3GCtrAHIAC5tZnx9u40Sd6A2JC+U/W
	yime2P8e+Hlw6cjg6hwXETghUSQgZvTsD2XFg3pEUkcKkgv0uLFRI/5vrGmEmbLwWi8Ipm3QeiK
	7hav+84XzkJ2knrqzZn0LifjtbmWiOc9SdC6rOC5JMVF4AZrSY8Bz4VNTi38aTEq202joGMdlB6
	zBoYQSKGAC0CBqhxsnp17jpjiTheHfqtwYaQjRrEo65TnSsZ8sJ2SPWs9gDtoipVQZPyfupON6b
	PMwcOrltW9jhvZqyyx7BZZEX9tdFE1Q/kmXeIzBnaeNkHjb5vtKupgkijBx+OVxFcroLhroe4xu
	AxzbDx1iPX22jIJl9NrU1Q5+TTKGOwgcQFX08F6ldFG458hkZeBxtIaSGkZlIUa5Wx9llKuQh8z
	y8dXq4IK+wqZnE3eR5Wy9R5wL2v0cTmg==
X-Received: by 2002:a17:906:9f86:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c49bdd7e2admr323891166b.2.1793224326037;
        Wed, 28 Oct 2026 14:52:06 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd350a61sm654799366b.12.2026.10.28.14.51.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 14:52:05 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] range-diff: use the repository from the diff options
Date: Wed, 28 Oct 2026 22:51:37 +0100
Message-ID: <20261028215137.15262-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
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

output_pair_header() and patch_diff() already receive the diff
options, but use the_repository and the_hash_algo. Use the
repository from diffopt instead, and pass only the hash algorithm
to get_filespec(), as that is all it needs.

read_patches(), output() and is_range_diff_range() still use
the_repository, so USE_THE_REPOSITORY_VARIABLE stays.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 range-diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8e2dd2eb19..3f56a4f71a 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -418,7 +418,7 @@ static void output_pair_header(struct diff_options *diffopt,
 
 	if (!dashes->len)
 		strbuf_addchars(dashes, '-',
-				strlen(repo_find_unique_abbrev(the_repository, oid, abbrev)));
+				strlen(repo_find_unique_abbrev(diffopt->repo, oid, abbrev)));
 
 	if (!b_util) {
 		color = color_old;
@@ -440,7 +440,7 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, "%*s:  %s ", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, "%*d:  %s ", patch_no_width, a_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &a_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &a_util->oid, abbrev));
 
 	if (status == '!')
 		strbuf_addf(buf, "%s%s", color_reset, color);
@@ -452,9 +452,9 @@ static void output_pair_header(struct diff_options *diffopt,
 		strbuf_addf(buf, " %*s:  %s", patch_no_width, "-", dashes->buf);
 	else
 		strbuf_addf(buf, " %*d:  %s", patch_no_width, b_util->i + 1,
-			    repo_find_unique_abbrev(the_repository, &b_util->oid, abbrev));
+			    repo_find_unique_abbrev(diffopt->repo, &b_util->oid, abbrev));
 
-	commit = lookup_commit_reference(the_repository, oid);
+	commit = lookup_commit_reference(diffopt->repo, oid);
 	if (commit) {
 		if (status == '!')
 			strbuf_addf(buf, "%s%s", color_reset, color);
@@ -474,11 +474,12 @@ static struct userdiff_driver section_headers = {
 	},
 };
 
-static struct diff_filespec *get_filespec(const char *name, const char *p)
+static struct diff_filespec *get_filespec(const struct git_hash_algo *algop,
+					  const char *name, const char *p)
 {
 	struct diff_filespec *spec = alloc_filespec(name);
 
-	fill_filespec(spec, null_oid(the_hash_algo), 0, 0100644);
+	fill_filespec(spec, null_oid(algop), 0, 0100644);
 	spec->data = (char *)p;
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
@@ -492,7 +493,8 @@ static void patch_diff(const char *a, const char *b,
 		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
-		   get_filespec("a", a), get_filespec("b", b));
+		   get_filespec(diffopt->repo->hash_algo, "a", a),
+		   get_filespec(diffopt->repo->hash_algo, "b", b));
 
 	diffcore_std(diffopt);
 	diff_flush(diffopt);

base-commit: 8d1b215c01512b9658d4525c54ff9b9245f9a7e8
-- 
2.56.0

