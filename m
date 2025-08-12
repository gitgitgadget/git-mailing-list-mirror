Received: from outbound.mr.icloud.com (p-west2-cluster6-host7-snip4-1.eps.apple.com [57.103.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118510E3
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009476; cv=none; b=gxbDP3dvC6JIOhPCo18MMcPbkU2Fjmfkmm4bXgmq2Cz5ugZ+YKNBI4skGGkHEPtP1nqNwVQnw01QqRKpStiA8ZvMrb4PA/ZDAIt47kwLfgrvJbfIP1OAVWVk2bPA4aN3Y8yDygumPbWMPgxEbmTswI4g9UPfUriV0CxKOBWmIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009476; c=relaxed/simple;
	bh=c2ZHajZr17Lc69PhfGcQiro5y2HUemG4jqz48M1Ij4c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qYwGFp4Vjv526i01zPBEPBUAi03ICIwIAGu++91fiMITipEpNGZ4Gg3o9JdcilSfQjAiJAAkYIbvNYTOCGo6Zr6SVUq4s8bpYh7OHNkKNnUDaeOavArg81au8N7QF0fdoBjua6GrhtgtSQC1o0ZyPlSSOvMjpk81SUHmEt9DhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is; spf=pass smtp.mailfrom=gregoirege.is; dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b=Jx/czzPE; arc=none smtp.client-ip=57.103.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoirege.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoirege.is header.i=@gregoirege.is header.b="Jx/czzPE"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPS id 0EFE218001C1;
	Tue, 12 Aug 2025 14:37:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoirege.is; s=sig1; bh=c2ZHajZr17Lc69PhfGcQiro5y2HUemG4jqz48M1Ij4c=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=Jx/czzPEQ8xfPENbaUpfD3GJQuwGzKmrdcCHFgABY4wmiJCIKaRO7iJ9uPylPzBQB6RBnlNjNx+TRPlLv6KhtCwUuzIiexGhNxiNHmL0uKAwZg5wkrUtzO/pLIkX6ofMffShbA/hQV4DxoymmoSunN+T8CGI3b6YkAKo0xIKT9Q/y+BFW+o5uLk/ksOj7/dnPHb9gg+fSS3MiuKJJhXmyS7Vlqvon6rEkc0r5EQC205KrN52dNHXREeXnzvpGvsrNEfsikBiwvozHrfysPU1ToP+9//ajkQCCiKvjAq1S66PW1S+sce4zQ7Zx5A8Otc+kn9KYC8FgfE1UFPulotNPA==
X-Client-IP: 118.221.50.200
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-11 (Postfix) with ESMTPSA id C883B1800135;
	Tue, 12 Aug 2025 14:37:51 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] diff: --no-index should ignore the worktree
From: opensource@gregoirege.is
In-Reply-To: <xmqq1ppk58ob.fsf@gitster.g>
Date: Tue, 12 Aug 2025 23:37:39 +0900
Cc: git@vger.kernel.org,
 Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Transfer-Encoding: 7bit
Message-Id: <B90C049E-677E-449A-A899-B6071F852298@gregoirege.is>
References: <xmqq1ppk58ob.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE0MSBTYWx0ZWRfX+ansKhnBDlJw
 A2bMR7YSLbpnf6oHQ2WGDaxXGzviFyXa1TFjHTJQ90uunww5m+G9z1bCje7HLH4Huaeh5XgzTLD
 ZVKlo4V/1CrbpNuFyItNWR39Cv+FtFdi0Fs6UbrarSGJR7twwWT4Co5on4FRfTOeU3o8FECu+e0
 tB4bKcsVDFdP9z7WZjQw1/eE0h79hDj/brR+5X8vFCgHAJMdS2R+kl0F8VmHAocFsHNuC5DZeJ+
 pO6fvrV/wB5eObxpbStINlEJm/IH/q1nBYziwtnfnA+S/cdHVEaleUuT/I0D3trLj+n6HBnik=
X-Proofpoint-ORIG-GUID: C_NPJRhp1Y1fltmDK4QD5mUS_d2yklKg
X-Proofpoint-GUID: C_NPJRhp1Y1fltmDK4QD5mUS_d2yklKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1030 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508120141

Hey,

I don't know how the review process goes at this point as you took
over the patch. The handling of the chdir failure in v2 LGTM. I ran
the t*-diff*.sh tests again and tried a couple of commands, and
everything seems to work.
