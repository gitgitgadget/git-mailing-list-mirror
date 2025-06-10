Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88172AEE1
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749531670; cv=none; b=IQ7rQFDevI9BHDs76xKcqmayVH/d8kqQfysS2Ai6M6TGYyEFvTMtxz8qD6KExcxHuY6bcuRY+sjhQHXtWX2k1YLTj+/Bgjtj+BzDlrf3RXSiQ6962vZTdyl7jBdkiBfIa76pCKRp75V/fqaTAFwU0WBnXRWQ2akkHrAT5WcHHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749531670; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=kMVWhcn/lId+dmm6fm4/DVSNymEICEcSPWoEHDcOljZgSG+dJfZqUGKDSyX/h3Ha5p3OYULkeMhJ6BCA2NjlDromnWIZNLQ6X0/N0EfCGliaAWLiR3YIeGi7TBtpIt4X7ONsWk5e4zh08gi+3lPtuA+qkPUpWqjoy0ApieFCyBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUC+d+VU; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUC+d+VU"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c73f82dfso4025513b3a.2
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749531667; x=1750136467; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=hUC+d+VUp2reXYUD0a+CR8/FsbeN8QXQqm3E73NVY9iMohY0TyoH79NEAbrQujHsyV
         vDDkD6sUFCvCCioCCssPGRQ0RNgHTIOxj6Fdl4LLHleb3hjv3pFYvTEgloPcyepfcXOq
         6zvsQXVi4Ni0sfXhiSNurXB3gzieiM68pqA4u9PuI+aLOWWlraNhaSdvvjAkgznLLT4X
         8G14H/vsDtDEaxJySukZ9BsqMuvXjveHJSvOU4UPvxLrrgnEPtUGVg1F4cXL6IP3vg5j
         UFx5SdHtGzVCbw0iBqV1uHRtO4/5uA/zb+bvtnes0nwGjtVNc5c/DtlUOjS6Q4G9OVZM
         FR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749531667; x=1750136467;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EZ0kWo9Ig5JKD6EQqwZCT1oW2yFwzmQKCswvHcj3T37PsZB5xOei6YWUv2djPaMZEH
         Q+iew/vAOygaVmL3Wtrt0O9UBqdRr25ejFyQTDxqoC+qJf3YpflCovZKOz+JqKKUSdwW
         jJC7b2ctfCa4UjaIfYMrp61T4A0DibNdILSFNog379eCV+Y1+izYALHSaIx7pqAWJW52
         bQYcJ0dEuNHn4MakUW1PSHF3amF4WNnYNAK9GBuLZMajXTi9HWolh4yDv6W/EixJzSig
         cgyLhuGplJRb4M12zFpEmPWYskoG4m3rnVncDfeedkC/AK2SmAW3p9A0yBlvxwRapSrV
         buWw==
X-Gm-Message-State: AOJu0Yy/DP8sTZRJEPHtut3QKQcQ3EYdVedwVVK/XYgeVgzvk4eAiq58
	rp8JxEeQ2Nxe/ZKkoX9w2jkHBpchrrCPyxlaNPnIW7Anw/Zr1LRG6iBB37pQ90AwNvc=
X-Gm-Gg: ASbGncviV05+Y0rK8QqF25VblbyOeSE7pHcEw0Xz+MOFyiGYBVgtt/06JE6ohsPOLZP
	rBo8OnsuBzcduHkbCF7VX+h9YEMCKpRtGT+U7GqYEXpej1g/d+QX2YreG6yfiFYMyswdjOfmcGI
	Plrs+NzEeb/Cfm+EeAeaZdKqoYrYoB3uMf8SOWzZ3vKtAE/HR/cXwZj1ckMtg9Hz0qcMwgRDKrq
	T+0PDEpIQ5IpJOJ91kP3ON5W9E+wl+NbnL+nvAK3cxGTtpAxftdB/MGFYtHFT3OdwQkigYnCepA
	c3C3RadnZk9gmbzAh9AYV1vuFWnLgVGIWiErDH5VCwmEWXD86oamt6sgqeqrQLUfP5+Gt66aI/0
	1so/g5lrR
X-Google-Smtp-Source: AGHT+IEsbUnLlw5d8uGB+tiSI2t79SW+U5Po8NZp3rPTpnVCQbWExp4pIPTr4ziE4Lchtahf8Wwyvw==
X-Received: by 2002:a05:6a21:2d8f:b0:1f3:33bf:6640 with SMTP id adf61e73a8af0-21ee25554a1mr24780416637.18.1749531666767;
        Mon, 09 Jun 2025 22:01:06 -0700 (PDT)
Received: from smtpclient.apple ([138.199.22.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f782246sm6071752a12.51.2025.06.09.22.01.05
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jun 2025 22:01:06 -0700 (PDT)
From: Jay H Lindsey <jayhlindsey.developer@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: JOIN
Message-Id: <5D0632E5-97DA-4CC6-B116-3AA1B5A2E498@gmail.com>
Date: Mon, 9 Jun 2025 22:00:51 -0700
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

