Received: from send100.i.mail.ru (send100.i.mail.ru [89.221.237.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172E0364059
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789201836; cv=none; b=RuKtff1lr1txIsMmwBAXudsG+oLVIbK2rYyJP7NhpIcsW1fC+h7IaV/+zIoM/QLd6b2lxSvQz24QmG0qbn7dFOVM4ywlFwGR1yq19yBtrIRBnicZLJIFPhaqgCwq4bAYujHn0ATUop5/gjyaqYkpZ/YOtVpA9TqZIO/kxhwQMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789201836; c=relaxed/simple;
	bh=D0BnI7PwZ/DiOrNTfZZOk5q4m+bwbspRjQwl2NnfmR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7vl+ij0B6SidThJju/gqLrGu+wNBLaEiVSlka44QwZtpeDCqEQkwWr3bdpoXvsMW5gB2CV7/kNITfh6p3M6oX2q4jSg9E8A2TcIHagmC7JefUrfjOUINrlMT8LOoq0AGNSpSgF2EsWQwe+TM6X/mfXnuBdRhxejAErEZgOPJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=bMG8uurg; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Sysgd9Ed; arc=none smtp.client-ip=89.221.237.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="bMG8uurg";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="Sysgd9Ed"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=5QHsMFoBftwIldxHf7s2g+7y5YZ2026UrvTB6wCpvX0=; t=1789201832; x=1789291832; 
	b=bMG8uurgrPujUYCajcU+uN/n5NGrJ4nusmGUAkAvMx3yMPshDhnTLpomqYwlHdPcWJqm9feSM8V
	x4hsPSg3LDhDbmKxsbOHy8M4B0RyMJ2oLtmtGWQbwaX9zqYspDahNejOmDwk2vMz1il1YFVk9M7E9
	ng8W3J2pmdXdCWUmjyL4AXqhtGLecnU2XPA4JP/Av0JUjrfM9VjJpWrhry9xhsty7cIQX6vWogKOe
	rBDPeSFLLAcGk76TGdgy8H9ts2ybz/ifCSixZarYTBPt8ugMRIq0tp91KahbGZL/8xwnpAsMJ0ijz
	D4RFBvODVNEjkx+EaCITX9JvYv7K2WcbyuEA==;
Received: from [10.113.10.253] (port=33006 helo=send36.i.mail.ru)
	by exim-fallback-79f4db968c-2rwzb with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x5IsD-00000000Ner-14zT; Sat, 12 Sep 2026 11:14:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=5QHsMFoBftwIldxHf7s2g+7y5YZ2026UrvTB6wCpvX0=; t=1789200849; x=1789290849; 
	b=Sysgd9EdLBdzN+gExIit4E9dSxt2ZJsoIbNdlw0oDo8t35D3WSpvcrSJEYqL89jprWp9a2Wz2uy
	xX3+is36CAShTGo1FiwNjqCL4Ty2PJED1xNGSirqxNNJE8vq+N7FmLF/diHDOBGbBr0a8xTbI709M
	HNUMWPH4MwkYn3ALWT5f1IaB0h8x/4nPH0ri8wJlENCJxiBnGg+I9UweMur9UvBuV2a5NOiphRhBS
	PftGWEsUQ+mGCtjimURFKWVE6C0P1PQts0j8sTeC1lRtLIe1WZmWCBVLwWjUNdw4/pTy4f+TqHB8w
	W4Mb3po9EcgvyFS1e4wZ1bywuEzs3BCzmAFQ==;
Received: by exim-smtp-5d69b54bdd-tttcn with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x5Iqu-00000000TT4-0yj6; Sat, 12 Sep 2026 11:12:48 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id 66C6D9F664;
	Sat, 12 Sep 2026 11:12:47 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: gitster@pobox.com
Cc: ben.knoble@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.me,
	peff@peff.net,
	ub4nal@mail.ru
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Date: Sat, 12 Sep 2026 11:12:45 +0300
Message-ID: <20260912081246.133514-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <xmqqcxuketuz.fsf@gitster.g>
References: <xmqqcxuketuz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD969DCC1097515C5903066DB7FC94FBFF7DBAAD18DDE8EFE10182A05F53808504075A86F8BF42AC5123DE06ABAFEAF67051F643F38C70BA744DDE0D0E7451322EC2D8445145E24918E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D05773942AAE9CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB55337566A65793D567D8D18CB2F3AA5C4CAD2C0905312760FF5AF7ED81338734A961676D8EEF46B7454FC60B9742502CCDD46D0DA5ED62E35AC703CCF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249A70DDFFB3186CBC5CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C07734D68A6916D8318941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0AB41560568D6D2267B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA97C6FCE95544A9834B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B4F3EE084F8D9587975ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A52D4C21737866A34E5002B1117B3ED696DDC00CB49A73E05A7E0012C66AE17B00823CB91A9FED034534781492E4B8EEADF5E532225D4D775BBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6591FFD79A0303D6E97D3F614F34668C2109870DE46FF582EB16DAD7F60103B3A6367A9BA5194D3CE5DB8341EE9D5BE9A0ACCEA6CC0EFE4EA72BD29836F3B7FF8BB0AD96C538F9E2671721D270AA2B885D14C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWN8ifehC7RqmAP+qXqN/L60=
X-Mailru-Sender: 288943BA7BCC8BBA2C509D5366AED3E5B520D2E1E8B24177A7CF1FCFAF80C0E920C696B2F1F24EBC4EE5AAA83A876F4D3B7E521F6A5800A996940349D467AF430D26F6DE3BAD3FFE4DFFA654C60F801316CD019DBEDFC45331DC91172AC7F52EF91D4A7208CD43CE3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4297D9AD4AAE60BCB889F8BB17C61FC303EF13BB334223BB968F3CF0E9FE49B69D646A6B51C3E940849FC002816C944D6B337304C5CF74909CBC8D8283A01DBD53BF98E267B618DF8
X-7FA49CB5: 0D63561A33F958A5F38E57772A0449D55002B1117B3ED6968EE786C7BF579B0F38F1085A36400C8202ED4CEA229C1FA827C277FBC8AE2E8BCC48758271F0A4AD
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8az02NgzhzIU5Ei8rWJOKvjA=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

Junio C Hamano <gitster@pobox.com> writes:

> It is very much understandable if we didn't mean the "use 'git
> config advice.foo false' to disable" as a cut-and-paste ready
> instruction, and rather meant as a general instruction that any
> intelligent users would tweak for their own situation.  And it is
> not surprising, from such a stance, the 'git config' hint would not
> come with any scope indicator.

I think that since advice.* was originally assumed to be disabled
globally (as Jeff mentions, he expected it to be set in the user
config), adding "--global" to the hint is a good solution.  It makes
the hint actually cut-and-paste ready while still matching the
original intent.

As for "--system", "--worktree" and the like, I don't think it makes
sense to support them until there is a proven need.  I propose to
choose between local and global via a boolean flag, and treat all the
other scopes as YAGNI for now.

Thanks.
