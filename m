Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D30427C856
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364399; cv=none; b=EIB2BzpiZ4fEUlabma7E5OXm1k69riPiWQ29Y6v+5MpGMHEy3PfshJN6YkXMGaaci6OwGahsvqqICoNimXuW9P4xOHtM7VQVh+nkAZPAeQvwDm/B5fb8x93pt8Z3SrKppBZZCLiAls3rTx+EC+ff+eD/QkYKWwNTNN08h4IHej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364399; c=relaxed/simple;
	bh=EBnSfpYy0xVl+GV66qACkKN/pn1ieFeDGQ9xTC/KCQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t75k9O3JK7qiFwqJVLi2i6sDPPSZF63w5PqybpU6S6ulUTzHTUn5N/XgEvm1YaaW+mu4SMOrHvnjkGP7hJRqlmHIrYnGj39KhPCMn9TP7MhrajX66ulYzyoat+PZR/M/8kwUsrd1uXlDqtrLJPBaEVfnn7GKL4JxTM4pwwl3DcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=fHOLY8Rv; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="fHOLY8Rv"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id JxOduCUffaTZGJxOfuoWcP; Tue, 27 May 2025 17:43:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1748364205; bh=zScrbjo7mo5/c/GFbGlfGAGq6IZsUMy5yiij84LMzxI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fHOLY8RvUL1U4d8F2EX6eYWDKGaY6ig6HHK1wuxa5/AL56j8wUHYlsoy0azYgkHe2
	 7lFlYgEPVodKFXY3Kp/GyFSTP9Z0WzWtIpkj8WIWJOmBv94/D7Yjt6+owFxrgh+t+M
	 dNmol4h/XCd4c2/ohTOzaENifpbwhT2la1yh8z1moRuN8TU5bygPPyKxW4zGM13rSo
	 nf2gmWYDeQAn6T5zO3rAIjfkjbBRswT3+rznCyH6k2c5gmVi2k2uZ0NDI5S1xej67f
	 PtNYhD+zFDdx7ZG+rpxx+AgLbiKu/zqqRjJxD8iDtnhpCIr+2H+zGHa9NyWiapv2eI
	 HRyy+1Ssu2Bkw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=6835ebad
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=QDcouhaLaV9eJGGbyuoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <3f6863f8-7fb9-4516-a36b-f55243794dd0@ramsayjones.plus.com>
Date: Tue, 27 May 2025 17:43:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf <dasraf9@gmail.com>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250527-b4-pks-maintenance-ref-lock-race-v1-4-e1ceb2dea66e@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-4-e1ceb2dea66e@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDSlrDFUI2yP1KU2GMQ+ZoMUu9nM5mnwdZQx60VLMSXrqs7UjHVZBk3Fz+rbgT4+Sl+K//dq+yvt7ib4zlvR6HhskC/EaacbDiE3trYdJN3xF3tM2Lda
 fNQ2r4FoJWXv497yn88BKfwFEXrIj2yppj8mD7yVCiG4SUBxi5pMXwxEAQuB7ymOuuJQ2OjHFTeFwdVQ8yvgrYeiDg2kL0yu5zA=



On 27/05/2025 15:04, Patrick Steinhardt wrote:
> The "--task=" option explicitly allows the user to say which maintenance
> tasks should be run, whereas "--schedule=" only respects the maintenance
> strategy configured for a specific repository. As such, it is sensible

s/is sensible/is not sensible/ ?

> to accept both options at the same time.
> 
> Mark them as incompatible with one another. While at it, also convert
> the existing logic that marks "--auto" and "--schedule=" as incompatible
> to use `die_for_incompatible_opt2()`.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
[snip]

ATB,
Ramsay Jones

