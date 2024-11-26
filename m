Received: from st43p00im-ztfb10061701.me.com (st43p00im-ztfb10061701.me.com [17.58.63.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9913CF82
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609365; cv=none; b=LjJGdHuMOYkGPW9BZYeGb4u8SLNtUxiFQOxjCO9Qp/hK5rQLLcHska64mFSDJSiblg3vmsh5u38sdbDHAvhinb6QZ0KhgiJtSOQD1SGvs90av70WXCIEmxqKzbE0SFuzBTMOum+v8GicBMc0816i16aW/Itn836oU8injvJ/IqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609365; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=WWR65kLJiFQFfbroBGy36toA684L8o0QNu4QRB2AL64zbhBTgI8MtOsdk7dhoifCijBfHmNPxnAZ9PAEWzYT3TZ0+pPsOqzjZKIJ9DVC1+qeS7VxKziwmY9YhdLfPWbBONg3xdSTEdfABeIDsaYcX/tcOHOnjVUS0RQCid/sQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=pyRHd8bh; arc=none smtp.client-ip=17.58.63.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="pyRHd8bh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1732609362;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:
	 x-icloud-hme;
	b=pyRHd8bhP1YkfZ7zdCkaWMGKjBY5+HEARHZq67B2C7eI6+l8NaUYOZZ8ggBkthiFI
	 XZqRmV0NomGqU0kgRxEkOJq6UdnzgQ3866qrPZKkfeS0MakCrmLbzpDhhOp02xpyXp
	 rWcOG5KsHe/9CV+eStc7HymtnhfGo7K2uGL1pxly/6afgBqK6R4Pfw/otqXBSUbUSP
	 0MgN77AwYdJMtCRMQ3RxoL0/H3mj9J020lv2jSqcqShZ3T9TwvnECvb7zM9XZPLWUy
	 QhFL2mbdbn6TmHMAobl/010mnMbU/TtTY8OLynKyZpCnFLVc0+unNZTaPYaoDmJihW
	 iKSB23DOnMtjQ==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id A119338012A;
	Tue, 26 Nov 2024 08:22:40 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <oryakerbay@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 26 Nov 2024 03:22:28 -0500
Subject: Re: [PATCH v9 09/23] Makefile: use "generate-perl.sh" to massage Perl library
Message-Id: <B34F8FB5-F5B3-4080-AA94-8FDEDD5DA5FA@icloud.com>
Cc: chriscool@tuxfamily.org, davvid@gmail.com, eschwartz@gentoo.org,
 git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org, me@ttaylorr.com,
 peff@peff.net, phillip.wood123@gmail.com, ramsay@ramsayjones.plus.com,
 sunshine@sunshineco.com
To: ps@pks.im
X-Mailer: iPhone Mail (22C5142a)
X-Proofpoint-ORIG-GUID: U0HRkRxN3C8buwHB0v1IRlvXa0cC72WV
X-Proofpoint-GUID: U0HRkRxN3C8buwHB0v1IRlvXa0cC72WV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_06,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=481
 bulkscore=0 clxscore=1011 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2411260066


Sent from my iPhone
