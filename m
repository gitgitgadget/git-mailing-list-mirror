Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4258155C88
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161789; cv=none; b=kj8A+n5xgy5s+Qcf3pjw+f9h7yyWSIktqklnYWBBVFah5vjck5Ast/P8IPI/UyH5MKsie6zFfy8/9tBo3e9LOHsHFEGxhxK4h26dik3T7sVOhghaiUNUFWLMOWTMs2X8iG6RH0pWPQjxWlMncWmDZa3fuDocJhA3jIh2jrzs/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161789; c=relaxed/simple;
	bh=hvePB6EWEBgDzR73JfkMR7E3932dO0S3VEyuS42pA4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGLK6eWKMG6qbyRudWeERUvG/AKcNAz++8JOJlRbr+WkzFeT6yL8TD/e/MiF7XUnjSO3NEHWYiDnyBt9I6Gcj6rDsGmg8uH5sZl0KtxWP7sy1C4573+BIXRKnq1LJWroJknTvaDmYSKZ5/lVLqoABCqKsReGAIY5jiSdYKL6Sbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58I2GIit939686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 02:16:19 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
Subject: [Change] Git build issue on NonStop
Date: Wed, 17 Sep 2025 22:16:13 -0400
Organization: Nexbridge Inc.
Message-ID: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdwoQZPDgsGqEcYKSp+HVyoI5GGiyA==
X-Antivirus: Norton (VPS 250917-4, 9/17/2025), Outbound message
X-Antivirus-Status: Clean

Just a quick FYI. The addition of uintptr_t in clar tests has broken my CI
build
on NonStop x86. I will be fixing this locally. It may take a patch series
unless
a quick workaround is possible, which I am hoping.

For those on the list from my platform who are monitoring, this looks like
-D__NSK_OPTIONAL_TYPES__ is now required for the build. I am unsure
what else may be needed.

--Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.


