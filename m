Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4C2E3392
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006882; cv=none; b=giSOL9t2VzHwCjT/pv6PgEPGDIKH9aEM7cb7IsrY89zZXTi+kcnUWWZK76x0Ut+a9rew5fZsXXt463wgesW+RJej/efqOHIFdGpbk/m/uKRK9GfNRtIah/E69OWI5eGWPTsYYB1mzgnK/G9zDl0RHP3X6b0zl7pqe/1AJPBW/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006882; c=relaxed/simple;
	bh=H6dtQQkW3gL2rwJSBnZ+4RpeXSQEwYskXYghF1PWuyg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kqg9CJt4eXUmDoWtSVRF9hpGi4tUy2TMSDJRcPnRBbYuuHV7BZytWYRrCrzRrXMaxE5hNANr2SUjvhRaAjt2EquAqqaDKztVhSSrs68chfuPAiXyiFdBM5FuosGZkYz/3kIQaprREjwItdIG5Z2ThzFOxeDiwVYKfvn98EsEWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=F5vSf7Nn; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="F5vSf7Nn"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id tHZ7tGMvvvxWAtHZ9teQC5; Sat, 15 Mar 2025 02:47:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1742006879; bh=NaDym7njn1N77KB9O4fkFJyowFgvj5EL6ZEWxKSQZYA=;
	h=Date:To:Cc:From:Subject;
	b=F5vSf7NnH0xGlW+FvBKd+uTNNTJ8ZpNr4vvlV6xhkMxq+a6WTag7vBt6arCANpkAt
	 QqD9k/CxP+GWqGSE5SdbZceWeWxKxcI9N3/EUFUZxKDM4sn1zB/ul5Qth91AT0hm4e
	 603UJdcfuTjIjdL6gJW1VvSsC/09W2WGXR5mjicZq4PQUid8YX4y0/BSUlOpFsJ0OU
	 UyAboMX0M3wO9Xn2xEjGj50+fRxYM505srH1BknPE5hdKL5tLzAww4xZgtLr/q+nUu
	 5N9/LC0LpZlV68Ndi05OYsLoUJ2nC8vmKLA3Zvodkyq7PrRvkzO6KbDsNGBlFOiFQD
	 qecJ/W2XndP9g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=QbDFvdbv c=1 sm=1 tr=0 ts=67d4ea5f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=5XmO7F8k-BOE0I3eWfsA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <a415eb92-bad2-491e-99e1-1b28b9ce73a4@ramsayjones.plus.com>
Date: Sat, 15 Mar 2025 02:47:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 07/12] config.mak.uname: add HAVE_GETDELIM to the cygwin
 section
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfD95vY5QFt3JcT8HhhNGmdubeQ5W8n2YpSDHaJbOB2WAfqard9ZWoVnCoRqdQjkk8MufYh03P0OB229yw1mmV4pCbEoTTaLlJ3mQUc52GHkx/sI8lD8n
 pWrTTFXmi9ydm/Amt6Yb5HlwZT1suQoxXUSuotOASW2QxmBq2pherzyVsTgmmBKuM1ECbapNLv5totVNR39yW1TgIQes4nOT5UE=


Cygwin has provided the getdelim() function as far back as (at least)
2011. The autoconf and meson builds enable the use of this symbol.
In order to have the same configuration for autoconf, meson and make,
enable the HAVE_GETDELIM build variable in the cygwin section of the
config.mak.uname file.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index b6adce0bc4..1b3ba8a341 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -250,6 +250,7 @@ ifeq ($(uname_O),Cygwin)
                 endif
         endif
 	HAVE_DEV_TTY = YesPlease
+	HAVE_GETDELIM = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.49.0
