Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDB1EBA0D
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689368; cv=none; b=rXPUTI/5rFzFqz5uFiifNd8MboLtNPnq8mrhfDE7/a3n+YVfEEeG7yNZV2agDoX1JhLjhyYeTiCr/ii0+gOtmeN/lFPM3qKwstk6ZW/FWVQ7JPWX+aaVsV01HNxecNEtw9zoZL4c3pl8FOoctM8BQaWbcDL1y72QgM1YzXmplNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689368; c=relaxed/simple;
	bh=NFymaXAMyrAccQzwDzzEx++A/Oub/SaYjYk26SQZgdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc3fBMcBr6fTpWggyZRUM+QxyJ0wqJdaZxHBE3Oif8t0E8sr5MJYJtQve7XCz630lm6dyMROc2SqZ85lGsqwGPVT9vOB/s13ZAQbOQ5lUmqrAmSxcQlhRMINtt6MHJnwM5SqGSgIb6X4zANmSod+PMKZkC3iTRou2AWLXEMvag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqMElpy2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqMElpy2"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so286236fac.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689364; x=1744294164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiaiteUhMpEOjyBe7VlqILWyor6CruNFchETREDG3o0=;
        b=hqMElpy2qXdHHKeB2HLVrX88EEPN8cwZ0DS3f6s5v1QCSCm9lrMN0Cf444s3RBkaE2
         NM1/grlXwkgmAf9APwUDR76aSZfPNucNWuIa/6h5GbiOmp83Jz2LRgxgNM6UdlfA9+n4
         pE1oacfrvpkIHOl8o9LqYtQxVf1Jd8JBytLmAprfXRbgQ4DNrqRPEvXrRMxx80YnUOLN
         ObYc6q1kUrosh8oKz/Aves45mOcAYaHR3mor+IU8E/oT8UfFtQLnUrbeUNI5pWQ+lx2f
         wVVmB/EBdh5iQSj0L98yNVcM7SeHSxij+/nLGkIc10NnWPwJCkXpNjSdhjbfnDrVlb56
         8nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689364; x=1744294164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiaiteUhMpEOjyBe7VlqILWyor6CruNFchETREDG3o0=;
        b=D6D27pCxhHKMUxbFPdRMDpbvBb7tpZsotPl9FIStNi/DTxVkFkA8yImGB3941POKOK
         gzg6g4drJgashYf+rg1AtoG4IGoUPAIhNVEb+tuHmUEipDxe25O8AbkyvQ0QjOswbUtq
         EUcEs/1YP8Eo05aju3BGUbtFwYbXf+K1OqU7+R2XBTgtz0D7ZRK+9r1pconsiPyoYYlv
         yAqddU2VAVyFQTiPpfymqqqk3zEjkilYjL/0sJ4WYZWGhn0qqUGWQhSpV310H6bzIbsS
         6RI7XIazysRtRqqQHElQ42NxwLTBfvbOE+IsDnLCZhQOlOWVzi0BtW1VqHq4GPAOtfnG
         GwXQ==
X-Gm-Message-State: AOJu0Yxicm1QNOqNPnVnFowDuvIldx39rdiNUa5w+UC0W3tOIDAQ0yeF
	ipGmByQWgB+J2Dni6QKO9H+SAr5OuTBAQqQev36v3ptjTSK9TEaYN502CA==
X-Gm-Gg: ASbGncvYD2QXZwiDAev8EjLBnQ6PSWweIjLyLdpG1gJ1w9ewta1I7/bmrvi03YW/uO3
	PtGzLeTjle6D+qtWbf4mUR75fWsV2CdWqzsn9RvlVU/JoSJzJfN1PITP/ZhSpzANTKww7rPZE1K
	Od8aoBi5AiN9U+g8C/hW/xWFHlvdL5TdLquWktXu1M+C0C45lUGFkG+3p8PEbcL6/O1PleF33Nc
	FVFS3RADHf9l2VoAOXYdsN9e6QOMNJR4XXum8E1CaOqfIhF+u5yb0WwYcyIFZagnRyof6syxEGd
	NmVFH0HCykyzCVU6yvKJFQbh0krbtawMowaqsrrM+6PticnvcWaNr9vIRrhatW8=
X-Google-Smtp-Source: AGHT+IFLjWTvWwo5AYgJNyglb078cYK4j/8uqXMOJypdVd0wleNGHCmsmAbeWftXUPDTXrDFQ/ZfLA==
X-Received: by 2002:a05:6870:b4a9:b0:2c1:556f:f752 with SMTP id 586e51a60fabf-2cc7a120a9fmr2306693fac.0.1743689363861;
        Thu, 03 Apr 2025 07:09:23 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc845bb8fcsm261557fac.11.2025.04.03.07.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:09:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/2] help: include SHA build options in version info
Date: Thu,  3 Apr 2025 09:05:27 -0500
Message-ID: <20250403140529.497876-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401203630.285451-1-jltobler@gmail.com>
References: <20250401203630.285451-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

Additional information regarding how Git was built can be found via the
`--build-options` flag for git-version(1). This currently does not
include information about the SHA-1 and SHA-256 implementations Git is
built with.

This short series adds build option info for the SHA-1, SHA-256, and
non-crypto-SHA-1 (if any) implementations which may be useful for
diagnostic purposes

Changes since V2:

  - Updates to documentation to provide additional context.

  - Inlined `get_sha_impl()` function.

Changes since V1:

  - Each SHA backend is expected to define either `SHA1_BACKEND`,
    `SHA1_UNSAFE_BACKEND`, or `SHA256_BACKEND` as appropriate.
    These symbols are then used to print the SHA build options in
    the additional version info.

  - The names of the build options are used instead of
    human-readable names.

  - Appended "(No collision detection)" to warn about SHA1
    backends without collision detection.

  - Renamed "unsafe-SHA-1" to "non-crypto-SHA-1" in the printed
    build options.

  - Small updates to documentation.

Thanks,
-Justin

Justin Tobler (2):
  help: include SHA implementation in version info
  help: include unsafe SHA-1 build info in version

 Documentation/git-version.adoc |  8 ++++++++
 hash.h                         | 11 +++++++++++
 help.c                         |  7 +++++++
 3 files changed, 26 insertions(+)

Range-diff against v2:
1:  aa0f464c52 ! 1:  b01e5a18cb help: include SHA implementation in version info
    @@ Documentation/git-version.adoc: OPTIONS
      	Include additional information about how git was built for diagnostic
      	purposes.
     ++
    -+Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
    -+have collision detection.
    ++The libraries used to implement the SHA-1 and SHA-256 algorithms are displayed
    ++in the form `SHA-1: <option>` and `SHA-256: <option>`. Note that the SHA-1
    ++options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not use a collision
    ++detection algorithm and thus may be vulnerable to known SHA-1 collision
    ++attacks.
      
      GIT
      ---
    @@ help.c
      #include "help.h"
      #include "command-list.h"
      #include "string-list.h"
    -@@ help.c: char *help_unknown_cmd(const char *cmd)
    - 	exit(1);
    - }
    - 
    -+static void get_sha_impl(struct strbuf *buf)
    -+{
    -+	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
    -+	strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
    -+}
    -+
    - void get_version_info(struct strbuf *buf, int show_build_options)
    - {
    - 	/*
     @@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
      #elif defined ZLIB_VERSION
      		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
      #endif
    -+		get_sha_impl(buf);
    ++		strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
    ++		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
      	}
      }
      
2:  95c92a05df ! 2:  cf33e4ac9e help: include unsafe SHA-1 build info in version
    @@ Commit message
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## Documentation/git-version.adoc ##
    -@@ Documentation/git-version.adoc: OPTIONS
    - +
    - Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
    - have collision detection.
    -++
    -+If built to use a faster SHA-1 implementation for non-cryptographic purposes,
    -+that implementation is denoted as "non-crypto-SHA-1".
    +@@ Documentation/git-version.adoc: The libraries used to implement the SHA-1 and SHA-256 algorithms are displayed
    + in the form `SHA-1: <option>` and `SHA-256: <option>`. Note that the SHA-1
    + options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not use a collision
    + detection algorithm and thus may be vulnerable to known SHA-1 collision
    +-attacks.
    ++attacks. When a faster SHA-1 implementation without collision detection is used
    ++for only non-cryptographic purposes, the algorithm is displayed in the form
    ++`non-collision-detecting-SHA-1: <option>`.
      
      GIT
      ---
    @@ hash.h
      #  define platform_SHA1_Init_unsafe blk_SHA1_Init
     
      ## help.c ##
    -@@ help.c: char *help_unknown_cmd(const char *cmd)
    - static void get_sha_impl(struct strbuf *buf)
    - {
    - 	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
    -+
    -+#if defined(SHA1_UNSAFE_BACKEND)
    -+	strbuf_addf(buf, "non-crypto-SHA-1: %s\n", SHA1_UNSAFE_BACKEND);
    +@@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
    + 		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
    + #endif
    + 		strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
    ++#if defined SHA1_UNSAFE_BACKEND
    ++		strbuf_addf(buf, "non-collision-detecting-SHA-1: %s\n",
    ++			    SHA1_UNSAFE_BACKEND);
     +#endif
    -+
    - 	strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
    + 		strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
    + 	}
      }
    - 

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

