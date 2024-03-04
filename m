Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9E20DC5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546090; cv=none; b=t+DX+82t2HjrS0zhZSpc/gHAHlTVPRoZgLQBnwIhh4EmAtkursORYL6/l8486faBUbbw9EqIlK8ro6qAbtxqUe7ucWw1a1eMv6cj+wU4+c6DG3PpostI3zfdA6mdD5TWyp5vhmpLLt0MB+yqJ0jFPHKKSEE65LnyvzDwV+VgW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546090; c=relaxed/simple;
	bh=338+sTv/DldUmPbJiHHVpkvR2FEdCTllKdaMgdHLHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unAubRFKQPpvZhnhrXPc2SSbydpgbjvFDC0oBZxRiCckcI2acBDtSMtxa/NyRAuEV0iok29/gfQpwLVfFpi4wfSm4DXd7bXCL52aV8v5OfMPsVDcNqIohVL4b4pD7SQEkegGbc7ceiXS0cF57VWKcKPHqtACEe+eJOcPvZLsDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnhwO06a; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnhwO06a"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d944e8f367so28301335ad.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 01:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709546088; x=1710150888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOmfc+uWSg79JQQgxuDjKO+mKnjnPDL11GO5GkyvTLs=;
        b=gnhwO06aLo0lNYihexs3oWWV3eIlm52u/Hv7OoIhSGzpWjfq1vLopALJCBGZx2iC/M
         ZzNmLWVeaRoyADlHBHB+uCm/OcLaLZ6G/2Hyg/0ZyHfRNGjoEuB5jv6PaMz+lFe5UeDn
         hhRSCdkfYDzM35IyUv2EIIXlqrKMcBi8cSqQZijOOgKNN9mQazDG16BldW76twN4VlN0
         66rdttJWpzRiEQamdlUDuEyWJkSdfn8Fwa0SKdH3eUKrG8iUm/9waMMZ14SdCa13siyF
         N3CMA6joYxElPpt5gbX9jA4YSkxnhz5rtKASQvY0vyEak1yTHen0WClVVATqNlgNVPdK
         kX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546088; x=1710150888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOmfc+uWSg79JQQgxuDjKO+mKnjnPDL11GO5GkyvTLs=;
        b=ocdaloqXqBq4T2ThaiIgenQQQPBMBSBgzVApmqCtmB/Eee9TGJ7/jqnaSFEFfySk7w
         CDvJPKWazVRAjPdnpjIqfwMdv4IXCzaHsshX0aYNZxtg415R7bAQnJp0396SmJAQl1Pq
         0ThR0w45yWmd4DC4jfoH+O7CNer9yY6ez2rphvdDTsK+Pi238bSi8S3iQ8+XNAn3hZbK
         c26MJ4HZH5kMXunCGaTKLmKBPgcsi9GS1On0B1YZ5HM38IgTtTclnNRMOhjMsSk0ZELX
         DorKGEpkHCulv/wr3PE7hC4VuuYwnkZvX+nyBPN1KS4ODjocZPiKgbjwdpbh0kU+iHoP
         IX8w==
X-Gm-Message-State: AOJu0YwfsNt3HBHTytEjaa2DvudxL9cvou+kZEq0qSqYEJavJiijDTJz
	5iAAmsbGLcKysfyuPqcX/RCKWqksRksfGOzBlCC1TPH2TRvlnjoXTQoJ9EbbvQrWmw==
X-Google-Smtp-Source: AGHT+IF9b4v0ZTq+wgCIBzy8gbxbGHwm3AjKCVSrYWaIWWjOKZ7wNdqtI8bwH1wZfsJEUgNWiZm3sw==
X-Received: by 2002:a17:903:11c3:b0:1d9:edf5:c858 with SMTP id q3-20020a17090311c300b001d9edf5c858mr8442298plh.52.1709546087799;
        Mon, 04 Mar 2024 01:54:47 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b001db9fa23407sm8094022plk.195.2024.03.04.01.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:54:47 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	shejialuo <shejialuo@gmail.com>
Subject: [PATCH v4 0/1] Change commit message
Date: Mon,  4 Mar 2024 17:54:35 +0800
Message-ID: <20240304095436.56399-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301130334.135773-1-shejialuo@gmail.com>
References: <20240301130334.135773-1-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This version changes the last version's error message.

shejialuo (1):
  t9117: prefer test_path_* helper functions

 t/t9117-git-svn-init-clone.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.44.0

