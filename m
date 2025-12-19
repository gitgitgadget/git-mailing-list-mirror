Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A233FE35
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170467; cv=none; b=jkz/PzuP42JCzzP4gJ2z86H0RmCnbxmK5XOHaZdh1ARr7gpajlHCW3Vi8iQxaQZEzcOD1K0gE0ellD0amLKloKa+Yv1KYyM1awNhZv/h2RFkn3wWc/MgKr91Ayutj903jEBVbKeQf+IInZCc7rpfTLURTwpuHtR1Ah+cnAYZp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170467; c=relaxed/simple;
	bh=ehKKHiuEV/C3c2kODd3RhZFh7LVdN9oVJTR+uLwd/ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=OPzjnzjAZe/0Vf8M3JSeDWzNvydPr+JzhkGI/3TPm0feW7SXVke8UB1Nlr3ctzof0K31lGli5OLiqDog50KKYv9Y46vxS6+IS3E3A1ddO0fIbhu/nHatgOcthy/5FBG9hnnteZlpOHpVtsgR8qcmgh7EPC282KStrhIrt6OsSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLm8GpNm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLm8GpNm"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso24818766d6.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766170461; x=1766775261; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04PvSdz065CMz0P3S2iAY2Ypj+HhN4c/4JRSVlP8guU=;
        b=MLm8GpNmpnGuFC3I2WgoBYvbGsqvCWPgEn5zUN698fc1mX8a62ZuRZtSYicCSONm6D
         hF655Eu7BKmHIJpMnuQaurZ3XZpMDjSWnM/Ds67NvZpunXXyfZTNMMDBiYygyq8k1oDZ
         W7BZVIxUSHpT0dPlUtl+JED/l5sJs4Rn769J/Bix6k2WLbMSiSqtx3wHNTK8UD5NW7cQ
         tr7N/cWLAH1YEEvg3E1p7evl6jEw2OduI1/akUd0ywpRSYc4qTEIogyQTN3PX0fKi3c+
         oFumJwaCGFtX79EE9TMDqb1Ep1WtFeeLunFPgbQV8pOELdDGA00WSOP2DCPzUvM9hvK6
         QUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766170461; x=1766775261;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=04PvSdz065CMz0P3S2iAY2Ypj+HhN4c/4JRSVlP8guU=;
        b=oNqj/ZZwyKtq9oUE5yyv/HHqZSupesXhwv42QivxKfeDO+prL0j/F0z5Iu3DvsH+Ha
         yYnWq3mxYCzaWtsZSs7siqEILDguAbp3kDgHwC3RjgoOH7EqpuJSY77B89X8W4wjxvE5
         dlrLjFeYufMg2AQJPH42jD3TUfJLuW6pvaBauBZDqN773+fp9WEgaT5D90xdP/wCbP3z
         nKKKB4E5g+p4QpPDuMOAm5Rq5e55bWoDIvL5FZevLsB4J2iOPwyqMEYy+BqQImv8m03A
         2Pba3wPmUlr7Wd2GPYNWFILP4L3QaDfRdRBVD5OqeL8czr2MWjbawtglVKYiQGU13pxd
         2Uuw==
X-Gm-Message-State: AOJu0YzhoLg5cBtpt8atXgkJJK6UAgKq0sEUV2Cta2MDBNKKVGDlQUQJ
	DuusicMP9kuYjhfB+EifnL+Eql+ygDwW3IpQNGrXQ6At4YTi/euDLMSnA5DU7A==
X-Gm-Gg: AY/fxX73zhCrQR5t+eUYz7yUkYdPv/M/5K1VYtqeff7KLzOQ9S1OAe95ofIhKZ1vu44
	X7cWDY70jy7r+iUHtRmcnOj4HSf/HU3k4neRb/LiF8J6tptJjCAwULNug4y2k6ZJqObzjc6aMDD
	h96JCAyqCdLhCVd/B32/LnKvMvRCI/3JExMClKEOPlqzo+bvElqzEDl7biuE8VtqKL/n1Od9isv
	Or8l3wA7f5b7pOgnZY0TpVEIx0deRtkLzaDYpSIbDhZJdD91LYuFjOyb34KGXngMvPMq1tEsPeX
	uvJ8HONLtjorCVBhV/UaIB1xlZr8+8qGL9rGKGKWMTr34DjM5L9NZT6ADTsCbUp2DrFEl55HuGW
	1Y53SLm5YBdtM+CxOZbQ0Va/gfEvADKkRmi5dk5eomcUMb9PfpbrrOq4dLUVcD9H5RVplpskwFt
	5X138HcRB2yN8pZg==
X-Google-Smtp-Source: AGHT+IHPCstHOlFFIRP9Fizf2fm4ByyyasFRro/FNvojDsf2SWBq7G0SKeBpIjAB55h6WeWjHJd3aw==
X-Received: by 2002:ad4:4d11:0:b0:882:7571:c024 with SMTP id 6a1803df08f44-88d83f551a8mr45079676d6.27.1766170460510;
        Fri, 19 Dec 2025 10:54:20 -0800 (PST)
Received: from [127.0.0.1] ([64.236.133.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d96bec1d3sm24731066d6.17.2025.12.19.10.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:54:19 -0800 (PST)
Message-Id: <a3a76d448ac2871834576be6d79e4704aae11f35.1766170456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
	<pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:54:16 +0000
Subject: [PATCH v2 2/2] doc: correct minor wording issues
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

* use imperative mood for consistency in options descriptions
* add missing parenthesis
* reword verbose phrase in git-repack.adoc

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-rebase.adoc     |  2 +-
 Documentation/git-repack.adoc     |  6 +++---
 Documentation/git-send-email.adoc | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 9742833ebe..e177808004 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -87,7 +87,7 @@ of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
 point to that commit at the end of the rebase if other commands that change
 `ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
 tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
-see linkgit:gitrevisions[7].
+see linkgit:gitrevisions[7]).
 
 TRANSPLANTING A TOPIC BRANCH WITH --ONTO
 ----------------------------------------
diff --git a/Documentation/git-repack.adoc b/Documentation/git-repack.adoc
index d12c4985f6..673ce91083 100644
--- a/Documentation/git-repack.adoc
+++ b/Documentation/git-repack.adoc
@@ -77,14 +77,14 @@ to the new separate pack will be written.
 	Only useful with `--cruft -d`.
 
 --max-cruft-size=<n>::
-	Overrides `--max-pack-size` for cruft packs. Inherits the value of
+	Override `--max-pack-size` for cruft packs. Inherits the value of
 	`--max-pack-size` (if any) by default. See the documentation for
 	`--max-pack-size` for more details.
 
 --combine-cruft-below-size=<n>::
 	When generating cruft packs without pruning, only repack
-	existing cruft packs whose size is strictly less than `<n>`,
-	where `<n>` represents a number of bytes, which can optionally
+	existing cruft packs whose size is strictly less than `<n>`
+	bytes, which can optionally
 	be suffixed with "k", "m", or "g". Cruft packs whose size is
 	greater than or equal to `<n>` are left as-is and not repacked.
 	Useful when you want to avoid repacking large cruft pack(s) in
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index caf9d693a3..cdaf421cda 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -208,7 +208,7 @@ Sending
 	for your own case. Default is the value of `sendemail.smtpEncryption`.
 
 --smtp-domain=<FQDN>::
-	Specifies the Fully Qualified Domain Name (FQDN) used in the
+	Specify the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
@@ -245,7 +245,7 @@ a password is obtained using linkgit:git-credential[1].
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`.
 
 --smtp-server=<host>::
-	If set, specifies the outgoing SMTP server to use (e.g.
+	Specify the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
@@ -258,7 +258,7 @@ command names.  For those use cases, consider using `--sendmail-cmd`
 instead.
 
 --smtp-server-port=<port>::
-	Specifies a port different from the default port (SMTP
+	Specify a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
 	symbolic port names (e.g. `submission` instead of 587)
@@ -266,7 +266,7 @@ instead.
 	`sendemail.smtpServerPort` configuration variable.
 
 --smtp-server-option=<option>::
-	If set, specifies the outgoing SMTP server option to use.
+	Specify the outgoing SMTP server option to use.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
@@ -347,11 +347,11 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
+	Clear any list of `To:`, `Cc:`, `Bcc:` addresses previously
 	set via config.
 
 --no-identity::
-	Clears the previously read value of `sendemail.identity` set
+	Clear the previously read value of `sendemail.identity` set
 	via config, if any.
 
 --to-cmd=<command>::
-- 
gitgitgadget
