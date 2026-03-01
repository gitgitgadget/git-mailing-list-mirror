Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C127442
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362385; cv=none; b=ikZWnXFcG/okmdiw8oLoB0Ux7AZ/FzSTFwrHqczo+xTjpY7jWwI7x8DXiJNG1FCTeDVvwmcUb7IWp1RM09KbuT83d8Hvsvu3/Etihlb2f447dJZEkz4c7G5ETNSbm9amGCoweJPO6xwCoSsNeBe+0+5gbYCCwbTgiNLRg+6JVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362385; c=relaxed/simple;
	bh=hauuIc3j23YftB7iOPR2a8JDgk63qo0txyR1EzBzIxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t2aSHSJ9NFXIFaDefQSAv3KwaY04KunBE/mFXD4klMnjVERC/gSFnK8Og7W7y/pimSto/1tiPDNM499Y4ddLlcYcAPzI+F5uSeyJ9etsoW2tv/JUcV8P3k7/Yf6v42AI9wa3GZd9zham5OTjdHQ3eYQpQVCkR5rak4y92+1kKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWC7LK+r; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWC7LK+r"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso26025895ad.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772362383; x=1772967183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jRVMeegKI1KVBsWLP0fhnwtzvgQbylw+j7jMRnq4ccw=;
        b=TWC7LK+ryCPBsHEI8Pc2nx9C1u5SDP2Z8rxHVAptCqCdEGnCcvJ4Id4p9f6vc7dknn
         tgq+Do6vEy3mCyGBRnOBgTYZiIGJ05YklAn+1i1FuwRSaaSsK8FXD7Cz4zD8yN6DbI5z
         tn0WGw4E0+EcG0S5YR2337bXiXEP+TPcY9hkT2aUJbtb5LJ24C3T58f4s0ByBETa9XSW
         +c8fBGawmJygzm+0Tcx/zTrYVCMa6/Ic0xglsy8Cg3iJ1OC9vuE0FXFzQPd50lWyHaZ8
         z2+8xm214fSVDCcLumAaewabbEkSTODVezN4rjfciAH8WKUslB8VXJNcBjKc5m52L9Ra
         Fr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362383; x=1772967183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRVMeegKI1KVBsWLP0fhnwtzvgQbylw+j7jMRnq4ccw=;
        b=sQrRtRktRkhH9mHiujJ1M+maU9O9AZytP6rdQXbolLPN/Ritpd9dkJrzYb/zIkEsNG
         77EfNYqSxJpYZIdnNZ1phvXwOp2xT+AljlpC6vcinSFl5dzYll9j7Wc7CBZ+YYcoUWoN
         4eA8trXDnTkZaJ93BSJCo0VDnGYkNKi3tZLAubYOPwt1C6Bus37Hp2YSfN5jnbTVxbd/
         CjaYyyfKUqL4U78LSM+h0H2vPy1eHn+mugceTM5GFAIBQID4idgvNKsgPkKaLTMrni/f
         zny0XTixvhd315IsTAnKxmkA3E9iQrfaSUzAQO8BvG/dzZ7KvcsCImXaiPLgEqZ6ezME
         t2tg==
X-Gm-Message-State: AOJu0Yx0L6z7AySlDshrPJ+Wx//srggEGwEbvU0Lb3oKcN9AySiLqVDw
	EXcsm9oGQI+diRnTkaWRi+j81cxH8VEgEtqI2FkR7JRMfK7V1s26o743iu3cCQ==
X-Gm-Gg: ATEYQzzlHEYljd2100Md2Kw992GAti3eH5Nz7mTrk/YKXcLuS/MaF/pPYha1Z/ebrfQ
	7YkpwNzp1nzfeVw4JAGt5S4wB3CSlLBFMSXw9n9Q5HnMm1etxVWfQzoBX3RgEpYmX1wa82bk21J
	g8WC/nMxCYsyDzEBQpBk0C19/h+kUYaxmqjuE3IB1JTUkc+Q14y22TrsVmSOEONZ1ZjNiSoDR53
	Z0ux3grn3TH5SX5UQZDKFnYj3X2dUEEOaqrmQ2EjrQnbXa1+9TAktML8PLGd/WM/NFJn2WxxR9t
	57tNwMJO6hu3SMvofDsvfA6W+4IWpqu+XTCLfvvRdKFR0EH15Ikf/3qQ9hyGdtq1wma0MilfFLv
	FwAQ2F72M5YgUHHFRdNvBkxetnkiMLglbt3mYuk1ELaSROo2hXwWxgu6gRQRxU7zRgHxxlUz9Je
	MdVsRHIDtFn1frWHhpjmMk5QIyrzUrRWvp13/96X4L
X-Received: by 2002:a17:902:d489:b0:2a7:c188:bd1b with SMTP id d9443c01a7336-2ae2bbddf43mr77345635ad.25.1772362383233;
        Sun, 01 Mar 2026 02:53:03 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:6885:f84:629:dad0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3a9dd3e7sm43480525ad.40.2026.03.01.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:53:02 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH 0/2] Remove global state from editor.c
Date: Sun,  1 Mar 2026 16:12:57 +0530
Message-ID: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reduces reliance on global states. Mainly there
are two such global states in editor.c,

* editor_program: defined in environment.c and populated during config
  parsing, but only used by editor.c via git_editor().

* the_repository: used in git_sequence_editor() to read the sequence.editor
  configuration.

In patch 1/2, localize editor_program to editor.c by introducing a helper
that allows git_default_core_config() to continue initializing the value
during initial config parsing.

In patch 2/2, remove the remaining use of the_repository in editor.c by
passing struct repository through git_sequence_editor() and its
callers. With this change, editor.c no longer requires
'USE_THE_REPOSITORY_VARIABLE'.

Shreyansh Paliwal (2):
  editor: make editor_program local to editor.c
  editor: remove the_repository usage

 builtin/var.c        |  2 +-
 editor.c             | 18 ++++++++++++------
 editor.h             |  6 ++++--
 environment.c        |  5 ++---
 environment.h        |  1 -
 rebase-interactive.c |  2 +-
 6 files changed, 20 insertions(+), 14 deletions(-)

--
2.53.0
