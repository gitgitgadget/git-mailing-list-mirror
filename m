Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A12824E4C4
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613534; cv=pass; b=KGPyFExzjUSIwDu5Q7k8nftSH63TyVdBQW4GjN7ChDRYvYdBrs6q9maVBhuhWlMJVMHdH5LfY4hYfqdlbZlFweDCUkNQz1wh0slmf++DUnsHp9umcza8o6ey+eRPPIkRRZjdORTOtV9RiGuxkOZT22EL8A2Ddn3lcHukwK8qdvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613534; c=relaxed/simple;
	bh=YMOIviqOM+3Dl0xV+OV0Nhx803glwa/Y5+wJCiaUKlE=;
	h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=bOhHwtbKHqjl+nFPddV0Jc9134fuEKChXpu9zds6MVCIvz0HfkL/qRi55WAahxPZ/zOn40vJNttTAwCpMQXXpGOrN/7fBNuyzhpDHuN3keGsuGWwCro9+efkhrIjINaK076U9Am6YXGY34m117ubzfEHpUK1j/ZBrqP70zt3EX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=UIlCLyvr; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="UIlCLyvr"
ARC-Seal: i=1; a=rsa-sha256; t=1755613528; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FzxdHecRrgFlhH8gNv5rc14WhWDhVFlaTKdaGrKwuRiGt8hxsKPSgoyegaNQ2nA+f02vjWAB4V6m1cZkZR3TTR+zAlx4UT34G2sZFSCU/po1d2Ph5boEzX1+olyRhYlBF2pnXrPQ/gHviH5iNPpMr1V+LI1umeglJ4ZKSU+kXro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755613528; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=YMOIviqOM+3Dl0xV+OV0Nhx803glwa/Y5+wJCiaUKlE=; 
	b=QOuI5+DBBz/e19sDE0IFHvtW1SPgZjOwWE0GKJ5v1dI5sHGxKwbEyymlNm2ctMu2Kj59WTHrWsJMsgzSrgiYLmQO9ATMY+dajVswnM7kf6N0t5K/ZZSlg9xRDahji/Xnm2yv+On29nYvvnWQ35irc8OwlbK8S7EM/ntpFijby6g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755613528;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
	bh=YMOIviqOM+3Dl0xV+OV0Nhx803glwa/Y5+wJCiaUKlE=;
	b=UIlCLyvrwfKr480VoZzqWDWLqEwU6A4r5pOmtOKzaMChBCV9+bbBA2BA5zUtuOhG
	Wztr8ZoRxEU8mfFjGoOt7ItljmiMS3asbgASgNf0nFUU6hSiIcTidx8TGBHpAGqqRRp
	eReU4YPFGT9KEPACTdzTRbjAXA3PB0VUkFjUAUeM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755613527943334.56907629377565; Tue, 19 Aug 2025 07:25:27 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 19 Aug 2025 07:25:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:25:27 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <198c2b87f70.ff0fbb4065293.4919681043907358329@zohomail.com>
In-Reply-To: 
Subject: git: prepare to regularly change hashsums
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr080112272f42cd32c90d37b265c035c600002ae3c5def064f28d025640bc0551af5c87fc0cd37a17ee225b:zu0801122710d0ec121a02cee77a9fd3950000c44f431ebb5c5508731abc1c2a07203a551633a583c0e2e764:rf0801122cd8997502dce3916afb198955000000c20d14c1370d3e4822f6cecf6ec6d5dbd59318bed0b5042cbb15820e97:ZohoMail

Hi, git people. I just noticed that you plan to change default hashsum in git 3.0.
Cool!

Please, prepare for regular change of hashsum.
No hash is forever. Be prepared to change hashsum algorithm once in 10 years.
See here for details, i. e. why no hash is forever: https://valerieaurora.org/hash.html

--
Askar Safin
https://types.pl/@safinaskar

