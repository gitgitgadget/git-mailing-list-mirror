Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605373090DC
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995747; cv=none; b=J4ds7ZCHTWYJz+wVdstHEwmLpGlCZrTTvKiJYtCnHS2w0Jsh3APKgzgpQXkgQjampCCBDuN0DXvPfT07Hm5eTvmLCvDoojzYiqJnyXWeYf7cZLL/RoeTMcuaRNW590jrWr9EngqEx5BegfrQQo5RWHETW17FmmBfZftIBdj0huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995747; c=relaxed/simple;
	bh=6F4xNzO+w0TxuW1Z0ruZz4Oxj9IPndLPZZX05dWpqZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPPm8Jxx5/5pkujam8XsANX8qbLbVEyJWMJ2ohjOP0lhN777tERCFv0kWMk28Tv9UDvpnu22hOxzqPraLBn+m+bRR9y9EbhKKhq4xrW0/XAjRSwHW1SeMTRMNhh4OzDh1PEUDDBTnKeW4CbDOohbjQKpnJ3XItuwGiC5bHJHdMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9KUR4wA; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9KUR4wA"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b174ca9bdso757886e0c.2
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756995744; x=1757600544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL1TeFSTO8VHnItclI0/T0S+AOYITq0vMFlTUhcur6w=;
        b=c9KUR4wAZUcpn8DHAgRrsFOhBQLnDdnwEaAc9bgFnhz1HP0iTTVu2w8dfXScNLUknK
         iOhI0eQYRybU8u3FdDS1R9Y4M0BZEFBWJDmTT7WZgiZUv7Fv9Na1F5bKp/9hPd5xz+Z+
         h5ed+ALomfBGFhjzrknjbqf0rUgwi0JLJU2RgqqLK3e6jyM5Tp5UdqaQp88yl/fwoybw
         DRwEx74sbNUdCsea7tXmNOl0cnbDKzrouw08QEsRmBOrN0aHsWrHlXBnAwoKjuhQlrUT
         y7CQKoVx/9NDJA6K4AGFopZ1aKxLVQM+qic9n/LJzL48Mr1H/SsCzTpl3ebKtn2PflRU
         5xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756995744; x=1757600544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL1TeFSTO8VHnItclI0/T0S+AOYITq0vMFlTUhcur6w=;
        b=bIlYauJATf4aaDbyiZTrmtFzBE4nfh3ZZywdiZS0oBMz+NVCyALBUt17MTHyF+dw59
         YYEJIWmLY0G/h1Eqxbjski0kEC6GdGTirigmY+EkmRA62PcbSOr0u4A+qJ7G+ev6VaGL
         qD7hS2Mc/q06CCVTDH7CjjRSC0JH0jL3k2cXQK6SWL+qb3iRpjPfITYErOEodTg453m3
         0UarvwbkrNz2LS4kRVDKVVoKgw4nbAjyJOzuyuxFyDeMWhqFql93GofjOyvhEBSITbIH
         mhe2tyiWRhSI027M+b2wx/lG1bRPlvB6tHOY56B9578d3qsUc/X921jIznbxlW6B3/FZ
         okzA==
X-Gm-Message-State: AOJu0YyFLKz2xpIADTQgcOsXYyHBpekQEutpaCdcrDjgmo7GtzC+arId
	0ThKp9Cki/SzC6gV/xXMljO7XBz87P7ghPfjjFVYsY2cE9o5M8ft8Siq0asoPg==
X-Gm-Gg: ASbGncuDXxE2CPNqGrlJHDiorUltITLJcg+sQZrJVt7SGlJ0cMCDwPN0MucCbcrZgYW
	oAmfj4XSpGnj9Ts3MiPaef6hNlnuare8DiieDvsfICHMlFT6YUi1ek3LrEjpEP6Iov20AWEr3Wd
	8H5ZU1XHTUG7FIdM86Z/kCJvqP1p7bASVKUlI/kvLBqCg0kRkr8bpr4h9yy3mtsVYPw5jKSotWA
	nv99BMLmneSXHewBV+iWjQSohcmnURDctst/FtHk91I5prD9Bcv1qp+Cq+bOLq7TPP5GZYp9Mvv
	sXCVFSzSSHIx9nhE/CHDdkUBullRm1laGIlKCiks2Lsm1w5G99urcgY01Vj0NtFXVXDe2I9pmqT
	QRzZubucEVu541BcWsZTDhL1lbqO/hzcCt/FMwr1XbmEDzfk0xUDSPBNjF1BcUUU=
X-Google-Smtp-Source: AGHT+IEZflqkL7z6iYDvmAdWkDvMbUk8mczp6cF/qDndtE6cTUZVdW6nrbXmyabc/Pmvs29wjdNzyg==
X-Received: by 2002:a05:6122:3d06:b0:542:59a2:72fb with SMTP id 71dfb90a1353d-544a02b1510mr6907168e0c.9.1756995743853;
        Thu, 04 Sep 2025 07:22:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:8aa:3d64:69a5:cf8e:268f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-544b1933316sm5409732e0c.9.2025.09.04.07.22.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Sep 2025 07:22:23 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v4 2/2] repo: add the field objects.format
Date: Thu,  4 Sep 2025 10:40:17 -0300
Message-Id: <20250904134017.47364-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250904134017.47364-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250904134017.47364-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flag `--show-object-format` from git-rev-parse is used for
retrieving the object storage format. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Add a new field `objects.format` to the git-repo-info subcommand
containing that information.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 3 +++
 builtin/repo.c              | 7 +++++++
 t/t1900-repo.sh             | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 6f5ee88215..209afd1b61 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -55,6 +55,9 @@ values that they return:
 `layout.shallow`::
 	`true` if this is a shallow repository, otherwise `false`.
 
+`object.format`::
+	The object format (hash algorithm) used in the repository.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index dc9a267469..bbb0966f2d 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -38,6 +38,12 @@ static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+static int get_object_format(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf, repo->hash_algo->name);
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -49,6 +55,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
+	{ "object.format", get_object_format },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index ddf788d5a2..2beba67889 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -63,6 +63,12 @@ test_expect_success 'setup remote' '
 test_repo_info 'shallow repository = true is retrieved correctly' \
 	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
 
+test_repo_info 'object.format = sha1 is retrieved correctly' \
+	'git init --object-format=sha1' 'sha1' 'object.format' 'sha1'
+
+test_repo_info 'object.format = sha256 is retrieved correctly' \
+	'git init --object-format=sha256' 'sha256' 'object.format' 'sha256'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

