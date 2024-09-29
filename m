Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4B6AA1
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727592602; cv=none; b=dZyI/qvq3R7FmsCyWfsxC8F0Rx4ta9uaJBhBbWUfIPqSTf9JnKxaaz3zWThPvC6nrTd+f4d+Q/Lvu/6XZjExdaQXQdWDjCX9xkFtrxG1CUxRiuSbYCG5hPdgXvmG7eRsF+GEP878EPagrUPKOR8OUzdc4z2ciHxiK7Uyl4Gv9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727592602; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=H2ZY+VR5AYHcKUdQBYjXNp+iBX8KZCpYpBDmi64zeO7RkR+LawNWPVRfIUB7Q0CqZ5Be4jaoCFmLxiawLLpxdM/tpGGmflEwlBEQ1vfR/fwgoSwkdo1dm3JOGDJC97iclbP6A82ZJd7wtKVVJHIrZaBDAKgu2JRUZZr2X7Zy7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=HtrGw1tj; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="HtrGw1tj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727592600;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
	b=HtrGw1tjrjixlT1WstFgw5IFyLnXdasosQvgVbewMPxv8xdaAaXHkIA4SeKP24ahy
	 rbbCktdVIZUjGtOnL4ROFaBdfcMfG0+n9i12VdvwZIc+Z2RI9VIc/kGMSijlElPahK
	 0I0B2nP3zRKXXdYHd4MxPQ/ZjSao6ntRNRQ0QRJT4Xz5/o7AbIT5VPGUdvtdezegfn
	 5yud8MaePJN6gaUt9g+kiK87U8nN8sF0QyurmCJkSlMDYLCUPVgMtf6rkStsR6fe+c
	 pTKz37RbTG7ii/njY3TSAu5+irENmDRuiwTIOLOnSc3qP6GZ0SAiQZqsV2OsoBiwaz
	 ZkV01kQoo7fww==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id 3EE3F3C00148;
	Sun, 29 Sep 2024 06:49:58 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Crystal M Baker <bakerdot@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 29 Sep 2024 02:49:47 -0400
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
Message-Id: <1DA158AD-854A-4B73-B1F0-7DA0E8AF40B9@icloud.com>
Cc: chriscool@tuxfamily.org, christian.couder@gmail.com, git@vger.kernel.org,
 kaartic.sivaraam@gmail.com, phillip.wood123@gmail.com, ps@pks.im,
 shyamthakkar001@gmail.com
To: gitster@pobox.com
X-Mailer: iPhone Mail (21H16)
X-Proofpoint-GUID: 91V3mO6rDOPnRVmqhcggxIfnpNIruFAd
X-Proofpoint-ORIG-GUID: 91V3mO6rDOPnRVmqhcggxIfnpNIruFAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-29_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxlogscore=659 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409290050


Sent from my iPhone
