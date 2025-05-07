Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6482116F4
	for <git@vger.kernel.org>; Wed,  7 May 2025 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629626; cv=none; b=TgX1xvtFhdejwbBUCqMQ9yuylkGvrVeDTBhoK6OiTjlthfQ4KXCmSHx1PD3fZaHQtdzjt1LwzOtX5414/Ctnael6VMD5RKStZFdRW50mkSrS5PFeFcYbrzeUJXhz1H0NcWRM7yYc+AQh/HYurXEME7iiai+lUKVShKAZpxrhGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629626; c=relaxed/simple;
	bh=0zvYiyMnaQiQ5QabCqGpBW/osAkoDplX8+m4nMpIQ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+AZ+PBXomJI/50LkcNO0jWsRXlFrqM97XudXx/ttDNaQQUvfQWTy1bdjmsI5ydRYPL9fmr9BrdEmIH9gAW323KL7mJZp7uneB9Iqtwai14cBKITv6b1cz0I5213ypp137KBoST17L9ma/Wl/6HsNYvgINo4/5lwS+jBUcLyP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aphUJqJE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aphUJqJE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e3b069f23so23744765ad.2
        for <git@vger.kernel.org>; Wed, 07 May 2025 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629624; x=1747234424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8WNbHhZ2PnEP9BQbDxbZgMmEE99bsX0F6wT8P8n2WTU=;
        b=aphUJqJE87RHgKDbUixQY9Td23ObE0GJ6OKLFrjmc0oM9iFPHJRd7E7m7C9+WrDEWm
         vqN/BeL23RfPb3iBE4lmM7VYbEz7gVg4A1EzS/y5+WzG/SNKjJdkvqxKUb3xhNBPKpQ6
         jRNoI0WefGq/izfJdg4Qw0U5G6rJqfshfmDAow5GbLwVaaBvizQNBLA0t3q4W8nuRgMA
         PtB3nRCqs7SKJPH4JWPMk054SiZ5zDD1ZO8g9smfW6R8gLrKSZdkPmMFUy/DQvtEnfm7
         l8oJMmX5KKu5nBGx1aWm1wCfy4T3sWbLdErA6XsBjOEQeuuR4M7N0JzpTT53U5W7heWo
         iWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629624; x=1747234424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WNbHhZ2PnEP9BQbDxbZgMmEE99bsX0F6wT8P8n2WTU=;
        b=e0tiEp1V6sWcblNsJfkWmd9IaO5txPlbNUFhJBwMpgdrnJeRSCo61dGuB0clCv6ikD
         G1ofcgj73NXZYmhgLiMtPe/ZTKwz+2aFd3zd0Tj1B3EHV9R/o4vRXuROtDXrMee1MGY1
         hDwgMUjkK421V+/BWVg9asjcCQQ0ziGSCOCGRNFxlW9wT6SHmhvl8NfmswwekjjJTAHs
         KegLCxzmfLIQpkzsgWjX14eh/tv8w1F2FtQqWRgwlbQFtVKuOvVLkVSQFVDYjYyBaUR8
         P5nnEEO6f0PRdyfbsXd5lbUso3MCqNUuMPDienz1ngpboF3/sumZZudCLbxYKzMzvkJJ
         9toA==
X-Gm-Message-State: AOJu0YxZ1rGMcpzsc4pusgii4+t6eJNitQmh24feyGne+clDtw+no847
	IU1QRWh0cygIqSg/XcJOBGiOTiG6eKoB6NdioeyRkaoZ6BtYpA4itpLk4XFAatw=
X-Gm-Gg: ASbGncsmccwng3G6CiNZ5FrVF0E9WZm0M4PSKpeDhB6+oXtREYXp2bUyqGHAvfnuIQS
	ULkjYAjyosjj8tXF2llR/Vn145dO5lQ3DVzNr8V/n3mJX/ZDMyPXNWeqQXmY5VN/NDF6mzU7CpL
	AZA7aAOyd9fBMuvvMYjSmSUkhHYeVzgTJbIzBnmlF8D4qYVsWaZneifa4MeFsitdQ9VqEnLdDU+
	6qsJ4j5c/3Jt+3KCwAqHtzvkUSmhwnHezbMPvi3U6FCSg3h0e32RYCFNUmSvv8zUiitORFoBZES
	q2AjoAA+N/PB3ErVrIqbN//apNYE/0IerkXK
X-Google-Smtp-Source: AGHT+IHO3AIXB0tISb+neVfA9i6Ay4hugz/9Rc8nKGZC6HbiEFtIJHyIsPLOQrHhPMwQ7gH/t/Mu6g==
X-Received: by 2002:a17:902:daca:b0:223:5379:5e4e with SMTP id d9443c01a7336-22e5ea70aedmr68443495ad.10.1746629623560;
        Wed, 07 May 2025 07:53:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e152320f5sm94525445ad.236.2025.05.07.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:53:42 -0700 (PDT)
Date: Wed, 7 May 2025 22:53:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/4] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aBtz8xAYze-Kobk7@ArchLinux>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBtzn4nwLsI9p5Cp@ArchLinux>

During fsck, an empty "packed-refs" gives an error; this is unwarranted.
We should just skip checking the content of "packed-refs" just like the
runtime code paths such as "create_snapshot" which simply returns the
"snapshot" without checking the content of "packed-refs".

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c    |  3 +++
 t/t0602-reffiles-fsck.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 3ad1ed0787..0dd6c6677b 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -2103,6 +2103,9 @@ static int packed_fsck(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!st.st_size)
+		goto cleanup;
+
 	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
 		ret = error_errno(_("unable to read '%s'"), refs->path);
 		goto cleanup;
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9d1dc2144c..e04967581c 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -647,6 +647,19 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
 	)
 '
 
+test_expect_success 'empty packed-refs should not be reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit default &&
+
+		>.git/packed-refs &&
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
 test_expect_success 'packed-refs header should be checked' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.49.0

