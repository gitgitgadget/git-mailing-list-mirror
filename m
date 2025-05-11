Received: from outbound.st.icloud.com (p-east2-cluster4-host10-snip4-3.eps.apple.com [57.103.78.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755743172
	for <git@vger.kernel.org>; Sun, 11 May 2025 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985631; cv=none; b=vAhKarxN+//trkay5/hLx3eOBWU3si6cFU6SOlCTg+FrfBKgfDXiS0JRgYke8p4gUn6pnXZWMHwlyZGzCx/hjLpZerf1J6JGx/+32/9JAwrDtWvaW3NEcdovcM7R1wguAh7WSuF3FlWUHFfWSSBhGsay2CUZDETEFDBAcDG+LHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985631; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=Sty7sQtnlq8V021WEkflEtwCsvxQGen2jXAVeavJq50zRVUbn3drJBCVk6y2icKmo9nI1PzM6jHak7Yc/9aQTmeXS59vvY3HBksByTudKuSG8RX9A4zkl9D1QVxA78/vJ5/2JuXJ5elgMG9RhT4uiGst6reT5b7WFEwMKRi7xWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GJN0KBZJ; arc=none smtp.client-ip=57.103.78.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GJN0KBZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=GJN0KBZJ7kjhB1eT45H+x3enomArfbEYERLXFY07CaIGDdhHWXbSJUYuoWNC7ylwq
	 F1vsSdCtIz/yRhM2S2z+x/Y/tA3hKqsFAQ+JyMOFovi8VGLnPdoKnSxckXWjWoqRWo
	 VoEsDq/jwfgjPoOm60wZT8RJYIFUErDlVZUx1/Qf3w85qs3Nssc3f6VF0ErtTnw/Ah
	 T9NV/cXZuffeMPUaXGHvc8ODg/u1LQuaMr0pCcJfNY6566HI31pdWIu5thzUcEUi4+
	 pj+XOeND+QKPwcl/dILmBlc6PHWujznk4y7v7tkXC6HrdpY1uGlCSx6X99HCaIHbsF
	 4SIpmetZd+soA==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by outbound.st.icloud.com (Postfix) with ESMTPSA id C60CF1807268;
	Sun, 11 May 2025 17:47:07 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: OryAkerbay@icloud.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sun, 11 May 2025 13:46:38 -0400
Subject: Re: [PATCH 05/22] reftable/basics: handle allocation failures in `parse_names()`
Message-Id: <B2E9C3DC-7C08-4E89-843F-9E6C64D39496@icloud.com>
Cc: ethomson@edwardthomson.com, git@vger.kernel.org
To: ps@pks.im
X-Mailer: iPhone Mail (22E5216h)
X-Proofpoint-ORIG-GUID: bk2kJI7C1_nSXiuE7NMPFi650p3sRTtI
X-Proofpoint-GUID: bk2kJI7C1_nSXiuE7NMPFi650p3sRTtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-11_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=686 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2503100000 definitions=main-2505110187


Sent from my iPhone
