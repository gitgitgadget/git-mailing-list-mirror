Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBAD6AA1
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592564; cv=none; b=P0JiRr+887TWKSQmK4zTUZ5z9JJmwRcYXQz7bK5bupVISJrDX5DEmX7dhWrSjkjiWa4lWME4sZmLdDLrsoqGNCYrf4yOSr7UUU5C3eOrF5ayGwTSGLwSpc4T3sqK7nb48nAAcCLsjpKWl43p/l2bsemD40+UUIqTKweRRSxg7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592564; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=p9WvhNklXvTtnf5R9dNsLGfm0oeiat8e/L2TpOlMAWWivF5N9Jx2OFi3Av7hPrzMYiEil6y2EFmUwgJsnVID4sWtB4g0Al+GBho3ALzOTzsxPh3ydq/AvN6d0/iwZWKDZlqOaLRp1Ea0oFviZCo6mIE5ohwnFiRUjw+FQMcrMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Zw4U84Ss; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Zw4U84Ss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592562;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=Zw4U84Ssh5sgJHgxpJt0F56SiQnkZdj9vouxKm7zUCCmhlIEGnunUeW4T3TZiYz2/
	 NbWJyTFiOAv7bdUfqJkoDP18w9dfprFAwBbCgLZnCgziQgtNOOSwA5JVnfQs0CQ/Ku
	 JJRbdVl21ySOolpNo7yd5OhgHwLus8K6GgW9rPVygqAlxPRFdACH/Edob/h4egPulV
	 cUnoqno+Y21jIXfob2kle9aYli/MSALg7hFF1TWaMAUVeYyf/vrl2tyeUuOyx88Rzw
	 7LA4yx5px6ye/byu2u5OjG2BGbNpJFCazD2HxuKrqYLppXNzfL1iK8w6pw5r2tX6wF
	 2dxtLH70VH4LA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id 6A8723C0018D;
	Sun, 29 Sep 2024 06:49:20 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:49:08 -0400
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
Message-Id: <3558D70D-CFCD-4B77-85AA-528CD24FF5B8@icloud.com>
Cc: chriscool@tuxfamily.org, git@vger.kernel.org, gitster@pobox.com,
 kaartic.sivaraam@gmail.com, phillip.wood123@gmail.com, ps@pks.im,
 shyamthakkar001@gmail.com
To: christian.couder@gmail.com
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: IDXZCotCyOSmhbISS7VCGeos5oNk0wkc
X-Proofpoint-ORIG-GUID: IDXZCotCyOSmhbISS7VCGeos5oNk0wkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1011
 spamscore=0 mlxlogscore=659 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
