Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955533B3C1A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889579; cv=none; b=pgX5paI6BsEwdcM6wMh3bXnRYiqZJUdkzM2xRMbNfEkEd96Np9/BWmoquToR1KP48bTximSxnY48jWlDhZJO14TU0urJo1LzwgSSs+4vXVriDPjDJmXc/sGw4YalmBJH8WerbtYToWP6ePjrjqx3/g/mlLpwuyzBgNR5y5voWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889579; c=relaxed/simple;
	bh=rp9KU7HgQ8lnTmUlrYGi3kPSfTPVXENknw7cz9DCa4k=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=SRmtdntSKoY+Za2YMvlt/23kd64+x1GbXZDewg0+oFVGEI1BcSe6cvY05hVm7LcSeEVNYb8phI8cBk8TK+vonSZ1EMgw3oihfrF/ACF+iykUJ4BqCv621tp0J7O3iiqEk6ats03o+CLAdKjFUVpIfKBIVEMY+xnvMV9L8AVQjW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=y6O0m0xu; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="y6O0m0xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782889572; bh=rp9KU7HgQ8lnTmUlrYGi3kPSfTPVXENknw7cz9DCa4k=;
	h=From:To:Subject:Date;
	b=y6O0m0xuSE5GPs/Q3VXEideBzgQJlkCOxbTW6qVnCK4K2Ya1A0vY5/5qhUa+7/uIo
	 tQeLRifcBXSOdzWlKsMT8fLqu+ApugGiVFg5t00VOEeFunzfsyPzhQuBLK/uFbsHE2
	 VwMwQtMhjaIeNF0EiUirNfOLvsZzyUSZY/cxpofM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: OOWntbL6xj16C+fESTdpSWwRcIC392TefXtVyhGEEOtHrObHpWIEq+xPqu2zbV
	 UeZOANUfyDFoJvD0gH8d5zNHaCrLjkebY3gvb9Z7rnQtqQBQoqMUOWrttydbvEVWeongBeSA8b0dl
	 NngoJBUuPqFVvMc2Mk3PCt2UnIXKEuCXFcJZWJ7TFPH1PXPzTjvOWYt+Q6jJe55MFDSim7WTQtkw8
	 1dSrmN3N7L+pkBxEQ442+327dIEu+OnFfaNxuj9jN08fnBV6nZqyBea3iO9iYQHFm7swTHFiUF29J
	 F+O16LQp6YdFB6wlyqXAKRUcZhNOb9sPybzvP4RktWKNorrjFeDDOX6uqJ6Pm7FICf3anFoLZVB8l
	 XMGeVyXajQvsMxYsLv6jd1DBOgZriDqxisNbNmukRWqiB9OON3Ajubf9cmad+c+l72BuSAnz325XV
	 jKR8/2MR9rj0g76pYVGpv2PETRBgRYBXk2HwiVE1BxgQ7TZnTFHfw7fbjVFJufzHKIasKPB/JT+7t
	 66V1Ud52EP4KiljDuVvn/Wa9KYYm4nY72eSCY4xyvQLVzGiD3UXRytrFBfQHalPaAFLeRFtoHJHPG
	 PcoTq6sTgoogN1hOrjRSKS9b+XmMvTkuuToy4KNSpZGLtIpZ+udyfzWdxOqeezbGMoVCNe0Lm6oHB
	 QFQscsEO8Biuw2b14O+/g2E7tyNQjFQ48sO+QTL8mO2RRfxzsrHIm/hwk4I/DqH8VCmkdSokEzp5T
	 yw7zL6vKx+lOCdZ5Pqs1AfVHxearRwK7x1n7H6FX49jN0FyK6kp+7/8gylzOHINsSOyRLh7ChHyY9
	 3bgEmTIf133gbf+429ONJZ1Tx2DOIeM+awIjgaOcLB0Zj5oG1LbyNnaEb0jEFw7bxx9o6R6Fki15A
	 1hpUjrMFY76iHC2EAKqy1FS4V9BwrO/oL1Llq0LpS/MMjemiQvCGWUga/XNHRyYDdFyGiJsaX4fcu
	 hc1aO8PJ6f4rstKgoUH4yFJ6ZE6qpncV0eriQdCCJ7MYqw+vSoUqc2pH8K8H+uC8edbbXJYoL2mse
	 1980/YMSZM+bx3YU=
From: "=?utf-8?B?MjQ4NDkzNzE5M0BxcS5jbw==?=" <2484637193@qq.com>
To: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>
Subject: After installing Git version 2.55.0.windows.1 on Windows, it is impossible to pull or push code using the domain account password
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 1 Jul 2026 15:06:11 +0800
X-Priority: 3
Message-ID: <tencent_7021B02790D4CB40EA0EF7A9E93DE4D48009@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezc52-0t1782889571ta2zzv0gj

VVJHRU5UISBBZnRlciBpbnN0YWxsaW5nIGdpdCB2ZXJzaW9uIDIuNTMuMC53aW5kb3dzLjIg
b24gV2luZG93cywgaXQgd2FzIGltcG9zc2libGUgdG8gcHVsbCBhbmQgcHVzaCBjb2RlIHVz
aW5nIGRvbWFpbiBhY2NvdW50IHBhc3N3b3Jkcy4gU2VhcmNoaW5nIG9ubGluZSwgSSBmb3Vu
ZCB0aGF0IGNvbmZpZ3VyaW5nIGdpdCBjb25maWcgLS1nbG9iYWwgaHR0cC4ieHh4Ii5hbGxv
d05UTE1BdXRoIHRydWUgd291bGQgbWFrZSBpdCB3b3JrIG5vcm1hbGx5LiBIb3dldmVyLCBh
ZnRlciB1cGdyYWRpbmcgZ2l0IHRvIHZlcnNpb24gMi41NS4wLndpbmRvd3MuMSwgZXZlbiBh
ZnRlciBjb25maWd1cmluZyBnaXQgY29uZmlnIC0tZ2xvYmFsIGh0dHAuInh4Ii5hbGxvd05U
TE1BdXRoIHRydWUsIGl0IHN0aWxsIHJlcG9ydGVkIGF1dGhlbnRpY2F0aW9uIGZhaWx1cmUu
CldlIGFyZSBlYWdlcmx5IGF3YWl0aW5nIHlvdXIgcmVwbHku

