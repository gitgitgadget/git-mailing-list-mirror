Received: from outbound.st.icloud.com (p-east2-cluster5-host6-snip4-10.eps.apple.com [57.103.79.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218404315F
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875775; cv=none; b=Q8QPr1sYwYr7seAmN1bf7yLfkLAhR3esOEWATDgXihM7HfZ3570UuWoYFU7KKTLJqGNJnWOALlyQPMxHbqjADUNz3V8cf2jePhElFuwwp5l09J6I3aBsZeRB/d6i0N06gcfJw2dr/keKA3dd5NmyBCi2Z5hW00Gq0f+njXgf/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875775; c=relaxed/simple;
	bh=JgC/sGh9peGyl6CQ2dogtbr36seYAsV2Lfv3qK9uM80=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=qbrV1r1IalvrOFjR+umVIZr5k1voDoiP+/ZNS3HNnJT4wSSQyYbcWqrVR8ERsx3GTrmuw6Y0BNYTGwo8ThjjQcU5C29aOhcM2iK/nYZh2O1KZTaiZWuolSkWmcixN5bAlMS8uAl3k8aKm0nQTWoiCWvJGCHH3dU4JusfOtWWGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tb74lCSx; arc=none smtp.client-ip=57.103.79.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tb74lCSx"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id 24211180040A;
	Wed, 18 Mar 2026 23:16:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1773875773; x=1776467773; bh=JgC/sGh9peGyl6CQ2dogtbr36seYAsV2Lfv3qK9uM80=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=tb74lCSxT3T0CnaQpbRy1mardq3UqMyRawWl2Nu3O0KT9GSlrF/p6uvogYBhkK1C9p8aTWJB3ZT1A1rSNDxV2IOLg/C3Y85WJswhKBDasULZ+jQ4GwWp8VSI/PiZCZ+hAY827eJ8PnA/JYU+pCOIJDMqmERYHEsI7rxDNHMguSruy97/wsuAIsVkHYv6/GcSLN0a3fhHQ+KAX9y/wtJWr9BN8EgOJ6iKihuB+tvsjJPi9yl3k2+pUfO0iecxpW3MHbIoCLGc0wEc/uTnARZ+Fq1R6YnrgXD3LxapfaXMwrkEAjRzCWDOAE6wiim+X4ABMZd08kEQjGui1ZslZynXCw==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id 6CFA51800718;
	Wed, 18 Mar 2026 23:16:09 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: =?utf-8?Q?=D9=83l?= <mdzayed5050@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Thu, 19 Mar 2026 03:14:24 +0400
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <E595E43B-DCB8-4322-9034-FCF447DF1A2B@icloud.com>
Cc: ae@op5.se, git@vger.kernel.org
To: junkio@cox.net
X-Mailer: iPhone Mail (23D8133)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDIwMSBTYWx0ZWRfX0bBPPrbgsRiI
 dWC9USY/VpJhJC1WNI72z/Mgo7/EvoFQoEY8CaMyNClafeyXpB5jwuhXjbtjk4hUwZdrJa3zJAd
 /6W9LSFTcqsNNULMqnRtsTMwsnxMZlH3bIjdw6ykHjJvSif6Xo1iilNgHRMHV8qYtl5nMVZLWUQ
 cE2HQdaQg0c5UEsIK2QPNa07OEbdSHOwtJlARodMsF07/gpXDKq+dycxBD8bJiNnKz990z0HQU9
 ufoa+n6G2CuTmGSxX0FAQCRe51BGI2sfQ5tnsCS3LR2H9uwk05iQURCygyw08mH2hVIkYdDT6yq
 IweZKNrUm+1Ee5yPqiWpk7iLCYVlTRIfZTc9s6h+0wYV8t+fKTujJjB9d0mTnA=
X-Proofpoint-GUID: AfxeFVrXL48K6C0FMjw1EQk-gvfRpL1J
X-Proofpoint-ORIG-GUID: AfxeFVrXL48K6C0FMjw1EQk-gvfRpL1J
X-Authority-Info-Out: v=2.4 cv=Ta2bdBQh c=1 sm=1 tr=0 ts=69bb323b
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=oJR226sLcn0A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=f3CkY4c5JepO9Wok6zoA:9 a=QEXdDO2ut3YA:10
 a=DtlQrunQ72SSMXueVTg0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_02,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=576
 spamscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603180201

SQ0K4oCr2KPZj9ix2LPZhNiqINmF2YYg2KfZhNmAIGlQaG9uZeKArA==
