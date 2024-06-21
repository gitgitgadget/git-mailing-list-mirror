Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C715F3FE
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993423; cv=none; b=lZts3zJ4d1DhW1NT5JjpCSeJw7DG91mDSQMv3hsN6lQDHhiORg4VVCdlrwFk95R4EjekCTjsuJ1Xvou9vgOMG0l6V+mXSEW5u1yS2vQjUmmwzfcMhGjj/Xb07qFOgHiS+hzXQUemSXXIQHrfCmOf0gta6KEgGPlOkf0P6IbO310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993423; c=relaxed/simple;
	bh=vT5lB5s+UtQ6X7oH0lDX2EhyNyZzWBz5LGr8tKs5Xl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi4gmijkG42QNQfnlv9c+4NUusXM5O5Z+aL6/8dgWLXSQmXNsUei4fGXqofX3r/TEuCzstiAruROc4zk0WPt5gSWyBkySRz1YuXsL5Wy2R4IFteEG8iDWUfpLxvNT3AnACQZwdXypjCimy7Vs7KwAVW8guwm98lUIILCgw6Esv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbVkx0nn; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbVkx0nn"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-700986e3092so605082a34.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718993421; x=1719598221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hltbkZ2lQSVK1eLAtEBm7f1SMqPDr9Tc0CNEjJOmiU=;
        b=CbVkx0nnegpwUCez2w0lvW2eBjVKyR59VKrG2rQsxgS5t3PEfacfwm2ms5id0Or+Bj
         UeqqdQ4tG+rmBQK3FezkCJak9qpfnqTeQ1C/NY9+A3TQXW/U70oiggdC7Ncj9a/0jdxt
         S4H54RYYX/9Ndlq/Z3n1f2pByk/IVNrQRF81xMQU3PSNx2jIS5Y6u02wL/EOengsq02H
         bLEiUw2MREzVhBeQembi2L01TUP+P4qV6qM3JFWCe++gROzIdtEA/WYncmHCtqjjwPFK
         HT0kO3YUZtwGoMIwG5jndatfSa/RyPUNeDBZP/UNGOZ0e2bdFEsOKXR+AJw3UY0iCksV
         a66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718993421; x=1719598221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hltbkZ2lQSVK1eLAtEBm7f1SMqPDr9Tc0CNEjJOmiU=;
        b=XHX69H+LmhSIi+gZn4l6tNWVRBP12rGmvnTs3PhD5B6rlDG8u+WCqawMMpf5tE/U8B
         cqHvGxd52qpLUbwHcO+VqlkMu1n6mzfPkdHMRK8I2QWlIe4jdE1x6zV7Z7Urf8T9i76H
         eRo6QNYdvDlKGxO+3eyHqdr9/b0H7I76JcXS9sHWhNzxqzwecf4SLwzRWeaZO6/oFdOd
         ZNLK3KJJ+OCZP9vNpYchocPUUH417fEdZZTdRX9tz3QaNSspkVZ2N6i53gSSA7ym+hUJ
         cP4XGc3TSigErj2p7H62tmln1RFm8MGHIIRWROKD/Bjw2J7ON3Ev7/vBBj8zTrGo2Nf/
         t47Q==
X-Gm-Message-State: AOJu0YxGnc/ULRbxF92JkU9QC2LRw3t1+cdpbLjyLjVyvJ0J7OmGAkq3
	SoAQuYzL39xj0yMofr/KCWZHxLTem+27tX/PYUHMan67fpelIDL4KnC6LQ==
X-Google-Smtp-Source: AGHT+IHuwedZ8eZt01CiGtPtm3/dpz283pQc+W6G5vWbx1tzzPrg34rTfHakucUqXHVIGdLIkVhIfg==
X-Received: by 2002:a05:6830:34a2:b0:6ff:389d:89cc with SMTP id 46e09a7af769-700771e7227mr13018653a34.34.1718993421194;
        Fri, 21 Jun 2024 11:10:21 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:3f9b:a900:bce2:445a:248e:77bf])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef678ebsm10878116d6.132.2024.06.21.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:10:20 -0700 (PDT)
From: "Randall S. Becker" <the.n.e.key@gmail.com>
X-Google-Original-From: "Randall S. Becker" <randall.becker@nexbridge.ca>
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: [PATCH v2 0/2] Teach git version --build-options about zlib+libcurl
Date: Fri, 21 Jun 2024 14:09:45 -0400
Message-ID: <20240621180947.64419-1-randall.becker@nexbridge.ca>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This simple series adds the zlib and libcurl versions, if any, used
during a git build.

As an example, the following is appended to the git version --build-options
report:
	libcurl: 8.7.1
	zlib: 1.3.1

Randall S. Becker (2):
  Teach git version --build-options to know about libcurl versions.
  Teach git version --build-options to know about zlib versions.

 help.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.43.0

