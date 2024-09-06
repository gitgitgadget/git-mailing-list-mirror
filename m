Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6181C7B93
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634679; cv=none; b=LeEJyA5yOerizibVEem4ALR3Qc4uHL4URWqTdovjj1ezJu4829PVdDcGbSuVneeZLmKygs79iih5jPfzfuJ7wvQpCw+HYk5m5Wwkvo6uZwerFIG60uam9OXLcErmrq2cv1ro13XFAW1TrlSStltQN06CF+SMDt5sRNmfWbNO6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634679; c=relaxed/simple;
	bh=X0/ipg9rNLQBBGV/uOVM45r6tDzqnHcZ9gmz4wK1JCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfxGb3GaakXDDbatA5+Yxc7ml0gWehBu/L6YCrBrVGlfpsXnMFW5wmjzIOani1f7mKRAB2qekK09Q56d9lVoYwEIImLq/zNRdXSD1mYBXgFcej/NO1rDJfL4yzTBdKmbb2PyJIlxYHCcxg7HfKEADllJb1WGgewyCR5O8eJKzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whtd09Of; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whtd09Of"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70f65cad4b8so1554798a34.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725634676; x=1726239476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3o8iI2YDA0NKa16Gs1T1fna8awJ+XEAzg3on67p+24=;
        b=Whtd09Ofhu6x2SZwZs/kexLs+waqQRJL7CfAU1NNKYIMy84TJgjwBDKhfIRpWvUyrD
         f2J15vFfxI80BIdPqTbiYK5yjbxW1/r41jo/SreMYB8V7IiCqil2dpJ1Ac2MQRVf7at+
         ybvsV3Ct37bhUkzAE1JYr4zaRqXh2+vZ7EsSKejMTQRbVXk0AYRcMpXDBGGPrm0hLP2g
         Xm2rOjLZ8QR67rzd5L4AqN3HZGhgZEKx1lPeTviYcon6M+kqbPVZN3mcPk0++iPsX3MF
         3bWhCCuzfEO8iQKcgZDDfM3lHNsPS/l8fVb75WooG95wTbX79lbgYT41qrila6OxkyK2
         h2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725634676; x=1726239476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3o8iI2YDA0NKa16Gs1T1fna8awJ+XEAzg3on67p+24=;
        b=qW2jld3+uf7pF4TEuqvSmSciBtsD5kcg93wbPu/AkLKSJ9G2Oj0dzYMr/juOWgUVZ5
         UMLkqCXWeTKGmSj5SB5QHbKaGfl67eDMSDBvTbt7TpfqzJxG1uKes7Sf/PXZ17gcIRan
         6KlJc82CB0t9I3ohyk9c7dFC15925ogNRY+LjkNmBA5zcVFAHkngKQYOayvLN2xP08b0
         PRrZBys/WMZ71fvhipEhq5t9p445Vjuz5uRmKogeTTOCKj+WO7YJn3lnHWeK5yWNEQlK
         X6xFTmC5xrEM5i/696ORUy4HU+xd0IqsquVn3WgGlvzLVIXDEPrcibdBIGoCtuSfimBN
         ivVw==
X-Gm-Message-State: AOJu0Yw24ZJhHl+CkMiUwGFDns+J+53258fjBnWKGi68FAAe4Orsx7/c
	JEtU2wcFaYZRQIB91Eeq7zxeVu5sOcsFipG03sAq/0knnyZGzwdOmDmeYg==
X-Google-Smtp-Source: AGHT+IEJJiy5oTFLSrDhGmxlHcyqgCeUA2CPP0YwQtmlrA5BbAEFWx/ZWe1RydbzfH0hGrjISKkqnQ==
X-Received: by 2002:a05:6830:2110:b0:710:a28c:bf03 with SMTP id 46e09a7af769-710cbd7bf80mr1229329a34.12.1725634676283;
        Fri, 06 Sep 2024 07:57:56 -0700 (PDT)
Received: from localhost.localdomain (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f67164519sm3729905a34.33.2024.09.06.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:57:55 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>
Subject: [PATCH v3] interpret-trailers: handle message without trailing newline
Date: Fri,  6 Sep 2024 09:50:08 -0500
Message-ID: <20240906145743.2059405-1-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905173445.1677704-1-brianmlyles@gmail.com>
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-interpret-trailers is used to add a trailer to a message that
does not end in a trailing newline, the new trailer is added on the line
immediately following the message instead of as a trailer block
separated from the message by a blank line.

For example, if a message's text was exactly "The subject" with no
trailing newline present, `git interpret-trailers --trailer
my-trailer=true` will result in the following malformed commit message:

    The subject
    my-trailer: true

While it is generally expected that a commit message should end with a
newline character, git-interpret-trailers should not be returning an
invalid message in this case.

Use `strbuf_complete_line` to ensure that the message ends with a
newline character when reading the input.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

Differences from v2:
- We now use `strbuf_complete_line` when reading the input file instead
  of handling the lack of a newline when constructing the output, which
  drastically simplifies the patch. Thanks to Phillip for this
  suggestion.
- Removed some unnecessary `\` in the new tests.

The range-diff from v2 is not included since the patch is so different
that range-diff is not able to provide anything meaningful.


 builtin/interpret-trailers.c  |  1 +
 t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1d969494cf..e6f22459f1 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -132,6 +132,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
 		if (strbuf_read(sb, fileno(stdin), 0) < 0)
 			die_errno(_("could not read from stdin"));
 	}
+	strbuf_complete_line(sb);
 }

 static void interpret_trailers(const struct process_trailer_options *opts,
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 3d3e13ccf8..d78cae3e04 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
 	test_cmp expected actual
 '

+test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change" |
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		details about the change.
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\ndetails about the change." |
+	git interpret-trailers --trailer "Reviewed-by: Peff" \
+		--trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'with a message that lacks a trailing newline after the trailers' '
+	cat >expected <<-\EOF &&
+		area: change
+
+		Reviewed-by: Peff
+		Acked-by: Johan
+	EOF
+	printf "area: change\n\nReviewed-by: Peff" |
+	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with multiline title in the message' '
 	cat >expected <<-\EOF &&
 		place of
--
2.45.2
