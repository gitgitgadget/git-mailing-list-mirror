Received: from qs51p00im-qukt01072102.me.com (qs51p00im-qukt01072102.me.com [17.57.155.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FB156896
	for <git@vger.kernel.org>; Fri,  3 May 2024 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754535; cv=none; b=V47GiN/G+c+ZdW86P5sB88FXN2p3+/EROuzVHsI89+XN7Eqfzh6/1G7sw38LwPMLsipAhoAovOex8CzqFZilMKjoXl8xgZEmx9Ws6CvlG5TYnUVB/lszq4cM7A3y3rLUfjUraYLpQME3HCxvV5lRd6DXKabGk4QaXz72iG7GhZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754535; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=hynqrxUnZA+tyjWzMgZeYPym6sIGrL9xoX1/r1FM3l7gXa0wpuEPSyxzVtI9vgSkxovEUyrMV2UH+MPgou151q1yvR9Lb+vARC7s284q88vuwlrvqpc+K05lNas5iIwhhEI3wnmF96kWjikpJXV4/BIusuw1XehFWBWCKyuzvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=1UFsHQ0v; arc=none smtp.client-ip=17.57.155.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="1UFsHQ0v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1714754533;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=1UFsHQ0vryiYHQm5p6Vjb+4HkO64m/RHEBoOXV3IaWomMT10XR1m1gl9MNnyS1yAj
	 tv8FxC0aqjwVT2ZwhjGXzhqs5Y9fVcpMtvfCsLSQFFX1PVnFsgJYCnV7c7bu+8gS8b
	 mhe6j9TyZUH3N8ZHbE0CgiZ6R5rQkyu1iPHATp6aHmCNleEOcLPylPNKuvvcxfJ7Gl
	 UqM2vM1FxeCIzguZP7ED3FC9K7ihJxbsBM7ZAbkeJmm6iNKWD1WrxpAryqG8NdGzu6
	 trfXYFwmGjC/rP84QbeKDYp9vtY1xLv7x7LB3BQyN5cyvsVGGUE6T6OfTe6ZPIj7xf
	 xVNRSFhP49wgw==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072102.me.com (Postfix) with ESMTPSA id 901413402FF;
	Fri,  3 May 2024 16:42:11 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: eycetee2022@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 3 May 2024 12:42:03 -0400
Subject: Re: [PATCH v4 13/14] builtin/config: introduce "edit" subcommand
Message-Id: <6BFF2745-1142-4DF6-A161-98ACEE786810@icloud.com>
Cc: code@khaugsbakk.name, git@vger.kernel.org, gitster@pobox.com,
 jn.avila@free.fr, me@ttaylorr.com, sunshine@sunshineco.com
To: ps@pks.im
X-Mailer: iPhone Mail (21F5063f)
X-Proofpoint-ORIG-GUID: UpUYXRymL_Aw3oEhVI8pmCDGhK5DXDjN
X-Proofpoint-GUID: UpUYXRymL_Aw3oEhVI8pmCDGhK5DXDjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_11,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=528 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405030116


