Received: from outbound.pv.icloud.com (p-west1-cluster6-host3-snip4-4.eps.apple.com [57.103.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E6276031
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652356; cv=none; b=ng2zOidCelSBAfb7XMY05JIpLPUtvnLDX1asvq2kdFvRAeTNkOzIfkBfx75WNHjXFWXD7aXOnaMVrUVrPUXOSwI62t7+aOBSk0jVcG/2PTie7dULG/934rJifonGWphV2DhLKeQOC1FB5INCiUmJuRz7fstVdTis6RTF3EbT55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652356; c=relaxed/simple;
	bh=ekW3PLoiGJ0ck/iiHkO7W+CH36xoKOGYErfwvnryzNE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d9pCPjpqjs246vdWMgU9VWM7uqH7+HjMiLgpOPgk8foczzI57QlV5fzsf7btuMkP1CbjFIzDhP5uvsnB7z1bOU1uRSFj6nblHXtqZZ7Y4CtKv8u4L8oX1EaQGuqJo+w8OlQhgjSsOr8sTXKXlyrjQ4U5NG4A6zjggqecNSnzVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is; spf=pass smtp.mailfrom=gregoirege.is; dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b=mVpdqbUa; arc=none smtp.client-ip=57.103.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b="mVpdqbUa"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPS id 7225D1800145;
	Fri,  8 Aug 2025 11:25:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoirege.is; s=sig1; bh=ekW3PLoiGJ0ck/iiHkO7W+CH36xoKOGYErfwvnryzNE=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=mVpdqbUa0cOJz/tEpcsR63P3T2CzXQR6cjjw2AAUVfEy4KOCF26JGtOFEzon4Xf9AXO73fhgQx1YSwVxSptuqPbIU/iuWm+ArOGPJgyE2W+9/zriRNTaPovtThXskXV45NxfmDwvFT5D4een8P30inMosK1oyRguSuDI2x62209lZ3yDfwBaOnV1Dl9o0cdBLUV+bbXQv6/Q8pd+DgdlRU3ywjiBrciRNg/QoZJFReVcxXxf3fEWblERo0lOvTYVBRKk8Puq+LIMX3+5dmeE8OiftLRdatErhURoAsmTMn9uJ3IBd7nZ2ymIVpQQ/8sYmGoiOFH9xR/AenVY+m6asA==
X-Client-IP: 118.221.50.200
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-3 (Postfix) with ESMTPSA id 361FD180009E;
	Fri,  8 Aug 2025 11:25:50 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] diff-no-index: fix stdin path in subdirectory
From: opensource@gregoirege.is
In-Reply-To: <xmqqtt2jm118.fsf@gitster.g>
Date: Fri, 8 Aug 2025 20:25:36 +0900
Cc: git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CCF4B0E0-980D-472A-8689-7615FFFE0198@gregoirege.is>
References: <20250807150613.32177-1-opensource@gregoirege.is>
 <xmqqtt2jm118.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5MyBTYWx0ZWRfX6LXCEkUAZqUb
 6TZHPTEoDYmOJt8jncm6jxev/6H1TRjRlc96woWmijrJClDcPednFbh0ZancFMzu2DmNy5a9yQn
 sLwZ9K+6h3Ska6pEci9McJ2kFk3wcA0XeTi/9IFoKpxquApYhB97pQoqaIlvfnXp2nXIVHuxYkZ
 Yfw+wqlGpTg/cenQEQ1nZonHFvYhfcFwDXtJp11wKxOlv7a0cx6QfMOFo5sq1CrWlpCwN55cC+0
 N2bTboIiJOlkGwbvMkQS5TRP4g9lIgh+t8e2f56mAu8DFYpuWoDrPcw8ptMUyOHx1JMnhhJ4c=
X-Proofpoint-GUID: 3velwU4ePCWFxzaw6BPCFKmd-Y1L2wFr
X-Proofpoint-ORIG-GUID: 3velwU4ePCWFxzaw6BPCFKmd-Y1L2wFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1030 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508080093

Junio C Hamano <gitster@pobox.com> wrote:

> ... there fundamentally is something wrong here.

Thank you for the thorough response and for explaining the
reasoning / implementation of the more correct patch.

> Would something more direct like the attached patch work?

I am not familiar with the inner workings of Git at all, but I
cannot think of any problem with this approach. This works for me!
