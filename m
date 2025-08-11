Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31492D6608
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945608; cv=none; b=j9mWa7ymsVp2MEYbTdHMPOesqU9MD0L0FT69n0JQBH5VaeDMOq6A4z16RsEPIN54iHvX2y8ZoJKd1swL6w/ksgKaIfKiZ7+Fvd+Nl/rFRIEovUE9g/2peZmqhIu/8suO6DX4u3SDLmswbojZgxf2SHvOQzSE1lh9ACgYV+EXt6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945608; c=relaxed/simple;
	bh=EFRlGS3XaUpBAhrlPc8yt1TrLKOkS7+PKGO6stDRsbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IyMnSRV32UuJEsLDz3XZeJld/J17TSHLpP0Fx2P8Ds/H7rGmEr76blF9b1SGbdfdN05imQVXOHb56UboqRN0zEjjMF3B+1wWMzIoSte77AstoIAPGo5fo5/nd8DVJpGQqcjeB4BrH+Jc8i4t6B2/LtYwIeZSa+yvs3MGbUigiis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJVx0FnQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJVx0FnQ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so44208135e9.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754945605; x=1755550405; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=FJVx0FnQ7fADkDW6uQiFxj8EKXlKrPWUqhwKn7iXH43vaIFC5GYVGeGykP3joOqKsM
         D3mp5kQuztgy+W8CpWNuxbAO9tXHdM5Iq2VTp4Rua2QJtaKTAUw4pgj1YKrWZUnylZrJ
         M89gVup84272LFPbSugdtSpeDjXdt8T5yW+wBVil5gSXL57cU3xDCLRb/gd9ZDTpMve0
         UFleJygRRodcaCjEctKnxEWKlff4u/RcjS/X/sOMDE1ldIWTFbfatT8pWg6XwBC1AyKf
         rdVChGtnum6V29w65c6FiOsQsFsmFwMyn167ozgxHIuBMW5RZ1qB/FU3/YatuOl3uvSy
         mxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945605; x=1755550405;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=i5TOTOa/Sr7PlxgtuJQ1fBnWewJqwJPfgV1PREUEEZM0iUZBOpLlLgdfaXP9q11yIt
         u6tu3eSdA2MKkGMJ2wwHfM7BOxqHDUnOCZ4rNYc7igtWHWqlkiQPEiZcQkX1rs6CJUCw
         bjkyH6QQ45iFWkIyAOKFGU07SEBaca11HoKZHKoSPbSce6vDDt1syysO7jtXRE4K/gQL
         dZlXaXgQ2oWabnRQlXQdbzRBh/jQw9F5wH7bMeuUVrOhSZ5EZx3occJyPeWvfc3Jv7jj
         JEem4KmxXAFgS5UEBWZ7eLcXEWzeEBenNomGxqUb/GVfD/x/xYyrbzQ8I/SshLvJJUJ0
         avQg==
X-Gm-Message-State: AOJu0Yyj9I/8qzCJOpPlCQ4Pb4fFuS47Ecy18TE2Q0dzMkFiJbq84CLf
	paCfLaeV2xbCR+KArWdB1gzGhOmLT/b3cpMllvd+aUL/M5VKhDadwT6y9a0yrg==
X-Gm-Gg: ASbGncsfaTFCjjvG14fM/ejmSLWiYqjXWm3wCxrL05P9jwVvWhI1wwchz9ISzBSWITP
	flErxzdNAcyZrJuJ5vcGi0h5hqdzrqPSZT/vHc31BqYTeifSuZZHLaTT2I5qOtF0chHqef1cp5B
	dzPJ3mwl7kZ10dhWcphROYWl1PTWPeYSaP4EcqPnusQmEzqon9F+PWRIQEHGt3TiVEMWlxrvAVt
	jmMshN9+dv32Sg489WIs/E5wfXYtdD8Bv+ZjWxxc176ureDMHcbMdnGpMczAys16vDHAjbHHLHq
	497L37xRDMpt3TnDZQJiy3yLSxgTBlQig+S0x43FS4ztT7aqIxis/ppb/oOB0Udp0OrZz+BWpLt
	02aEfQMcbVI/hzEbdP8Ez74c=
X-Google-Smtp-Source: AGHT+IExLxWavf5Dcfk+dal12F2t+8fOf51+MW08FLvJvMU/dSC+gaQu7tJ/Q1ofm4FH3Q/cWjiwYg==
X-Received: by 2002:a05:600c:548f:b0:456:1a69:950b with SMTP id 5b1f17b1804b1-459f4f9b23cmr112776215e9.22.1754945604375;
        Mon, 11 Aug 2025 13:53:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm340922985e9.2.2025.08.11.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:53:23 -0700 (PDT)
Message-Id: <e79bd6a67ef2ea7247359b2449c7c313c7fa9922.1754945600.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
References: <pull.1945.v2.git.1754421045.gitgitgadget@gmail.com>
	<pull.1945.v3.git.1754945600.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:53:15 +0000
Subject: [PATCH v3 1/6] doc: test linkgit macros for well-formedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Collin Funk <collin.funk1@gmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Some readers of man pages have reported that they found
malformed linkgit macros in the documentation (absence or bad
spelling).

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/gitweb.conf.adoc  | 2 +-
 Documentation/lint-gitlink.perl | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.adoc b/Documentation/gitweb.conf.adoc
index 1348e9b12504..64bebb811c97 100644
--- a/Documentation/gitweb.conf.adoc
+++ b/Documentation/gitweb.conf.adoc
@@ -178,7 +178,7 @@ $export_ok::
 	Show repository only if this file exists (in repository).  Only
 	effective if this variable evaluates to true.  Can be set when
 	building gitweb by setting `GITWEB_EXPORT_OK`.  This path is
-	relative to `GIT_DIR`.  git-daemon[1] uses 'git-daemon-export-ok',
+	relative to `GIT_DIR`.  linkgit:git-daemon[1] uses 'git-daemon-export-ok',
 	unless started with `--export-all`.  By default this variable is
 	not set, which means that this feature is turned off.
 
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index aea564dad7ed..f183a18df284 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -41,6 +41,13 @@ die "BUG: No list of valid linkgit:* files given" unless @ARGV;
 @ARGV = $to_check;
 while (<>) {
 	my $line = $_;
+	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
+	    my $pos = pos $line;
+	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
+		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
+			report($pos, $line, $target, "linkgit: macro expected");
+		}
+	}
 	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
 		my $pos = pos $line;
 		my ($target, $page, $section) = ($1, $2, $3);
-- 
gitgitgadget

