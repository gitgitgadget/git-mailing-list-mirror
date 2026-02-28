Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4142C15AB
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772249907; cv=none; b=Zzf7uD9OybyCmzluL1Ig4P/7i09JFfKmJ9+mb5SY77+MdbyMHtrUmO1NkGEvV/peaUkxXyJvvJcMiOxOdNxUfAqPTGoWarEw3sar74kWJ7E9sjFb2t9bKWAAsRuSBgH39/OcQ8AJTjRqhLQmkUc6cuKPymjglSZIBlW59+rvFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772249907; c=relaxed/simple;
	bh=2dwDTUvAQlxjqpsrqYEMy9Dd/eMEbrQ5509WRrurzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFJRHx9nMYmnwvGyTXZvim4Ap6rlQpVT6y9AoSr86VO7IPvOm0JNvhaHZrRKClCC8Z8SwF1AjT2rnkQsGMBOxwVjQTZJiKMLBwdgcebsPVZT3GX1sJlxijqvubyXNcPLyw2fLQXcBf7FEFklW/pEKFW2kBYbFH8npsUeHPyEXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=XM9IVwA7; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="XM9IVwA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1772249859;
	bh=OsiR2T1fhQvAdg6TNRJnr4QMmVbiHL5Ps2IPVVhzt4U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XM9IVwA7//I7IOoL7n6FdFPorsGI4XbE1VWOX6SE7E+vxeHT+fUvg/d3GwuV+oMyx
	 sX5ojantVia65zGHSU/dUJrRU8givu+FrlfbS+9+uXMCqtJHK/5Ftg8R1otFrM7dCR
	 sivTZ/dtPmmqfY2c7uwKXK39SRpBLAfMgd8ubZG0=
X-QQ-mid: esmtpgz16t1772249857t5b5f910b
X-QQ-Originating-IP: EzbAf0N5li+M29LqehM4BOiDtHNFqUc4myDrc/5Cc84=
Received: from hwlaptop ( [171.11.3.224])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 11:37:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9514083938540628086
EX-QQ-RecipientCnt: 6
From: Wang Zichong <wangzichong@deepin.org>
To: gitster@pobox.com
Cc: git@blumia.net,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	j6t@kdbg.org,
	wangzichong@deepin.org
Subject: Re: [PATCH] gitk: support config the color of linkfgcolor via Gitk Preferences
Date: Sat, 28 Feb 2026 11:37:25 +0800
Message-ID: <3FA6BA9ACF1B34AF+20260228033725.2546976-1-wangzichong@deepin.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <xmqq8qcet9ln.fsf@gitster.g>
References: <xmqq8qcet9ln.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:deepin.org:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OCd5OxnoBMVVnUFepioP/ovhNnbYnRKLC3g5GI5axjVu5My4iQ3UnhgD
	4PWS2O3jvpi4tZeZUYUnWu80BkAaEXsih+vgYCkMvFOyZQ9/Q6BKpOZSV/++CMmbLN7uRCh
	Id9qa0ebxIQ0FPVFe85TWKHZOzF4v3SNyZMVWeplhTfbcnqMGzI25DxflE6PGS9ebJ6fjtG
	1davZ8W8m91m0Ad8cut6WbY1bCT2w7DTQtKJ84HPq/859ybdMvv88gPogH++SeW6CBu439a
	ZytFsXdjMtDK4B/Y6baDDx1cAKa0DRrpeDaaz4FgWp37KiDJDhP4GTtj/oMvgc2jR1BWYgU
	iRW1MYldWaL2tOXMJeKIzY+fjA8+/i88zFIfUGzHEWy8zYhFSGiUErRM8dZkSN9IpekxdJD
	VbyDew8re4vpmT+EKT/PEs8SBp0Lxf6YTe9bgaDqZ9sai2jzVfKidRSTXVrnnlQ9oP6bQgm
	ig7R1xO446qyizSU1ZjIFWy8A/6x53CrQZWuxeEqznqf9590d8JZ7L9hf9zH+mcE2+FglOm
	VXAssjfiHzQRW7fXeD7dxvqpsqn+obUWJIxh/ozXixiHRsCnZnZ9PB+B0NuLe3Go3RtGtxB
	SR9TGKzkkyjaN9ful5Y52Qc6BlpTZO/+uVsU8FWzPw589mXBJZs7XI4T6CYE3XDDanV2pDW
	awk8DJsy0SYMKG2ne06TR94vK0B+nIhKm5FjEVtzSBha26snDUK4DSO/eGET0iHhkaWBLAg
	ro7iEifpoDbwlxLcL1BayC2b5PMzVcXiKnNBnlwYV3kSLUAo+Vh8BrtPb5wBszqbt/WbDP9
	D46QwcDjuWAygPR3N3XmUYvcskoJwQrJaqJFbtYVMVx37qRSfn26yAaBzCsFspiTnnRUxAu
	MJI8UlGoGUMtRgHPnWt0coFA11juufcXDcbnQAnpUBp9GGiShEyCFoAiABSpmjtjb75qTOy
	9If2rQw3zzbFePFPhfIRW/HLV43tyv5FyMZ1efpXOlYW3Azv4un7n5Y1IFSblm+aKdeds6X
	0jpL4nDXRqc2yippEKnd6mPaskMqe+pHQXGhOYvG1rNKd1LoJEHxvy9v5Vs9RtL9qKnRGMu
	Be6UyRBfP/A8QFTtXJdey+jQDeplr0kykhEVi9veCO7
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

>> Our usual style is to not say "This patch does X to...", but to write in
>> imperative mood "Do X to...".
>
>A bit of tangent, but I wonder if it would help new comers if we add
>what I sometimes send (e.g., a recent one found in
>
>    https://lore.kernel.org/git/xmqq343ehu4o.fsf@gitster.g/
>
>) somewhere more prominent, like MyFirstContribution?

Agree!

>>> CC: Mark Levedahl <mlevedahl@gmail.com>, Paul Mackerras <paulus@samba.org>
>
>It is unusual to see multiple people listed on a single Cc: trailer.

This usage is actually from the example provided at GitGitGadget's
landing page:

    https://gitgitgadget.github.io/

If writing multiple CC trailers is preferred, maybe we also need to update
GitGitGadget's documentation as well.

-- Gary
