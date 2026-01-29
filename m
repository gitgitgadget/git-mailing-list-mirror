Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E0379999
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681104; cv=none; b=LG5XfAH7l4rv8ScJ/bGnj4gmUkYrgLWjjVz8bnUAkRcTOQiOpaorWJmCmJ4lyS5gnl0IwTW2qRvM3D8h6D9Z4AjASILMbb4ZJZ+gqiOX9bvT9Ol/Jgk6C05eXVR3add+6e5JBwx5nD0autA+4c7FdsUggPYzUxstcHYO3P43kTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681104; c=relaxed/simple;
	bh=zfkGciEm8iT5iDl3S7Ia+cOcH9ajaEp+esqobvyM1Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf+9AYy0tk8MaEXqRcJKtgnGwuQYTdmwL2T9gNlCUILQny9iW4GE0olg/3aySE9zneSY5Kr9zpr6EYnvKGUEDBBv1cKesPnpoyXaksvZG1lt/wo5YHnU6wjEsYO4I6eCUVUQe3l2GfYpMowfAvW1dG9Lf6WJUnb9Vh5+SsEV51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4f1vrl4fBfz7QcK0
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:04:55 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4f1vrZ2lgLzRpWt;
	Thu, 29 Jan 2026 11:04:46 +0100 (CET)
Message-ID: <7f45bdc4-d164-42e4-8a84-36410654b4e0@kdbg.org>
Date: Thu, 29 Jan 2026 11:04:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
To: GitHub Chris Idema <github_chris_idema@proton.me>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Michael Lutz <michi@icosahedron.de>,
 Pat Thoyts <patthoyts@users.sourceforge.net>,
 Chris Idema via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
 <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
 <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
 <xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
 <71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org> <xmqqv7glcmee.fsf@gitster.g>
 <AXTzN5mRXdWYZx55ARuBbRgndXW5zA51_wcnAV4KaUpk3kz6t8ZYfOk0Du5rg6zKhz0_O-4ZSkLNX6WkhTp4fjDFDMfCZAsTRCoBMH_IpMU=@proton.me>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <AXTzN5mRXdWYZx55ARuBbRgndXW5zA51_wcnAV4KaUpk3kz6t8ZYfOk0Du5rg6zKhz0_O-4ZSkLNX6WkhTp4fjDFDMfCZAsTRCoBMH_IpMU=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 29.01.26 um 09:31 schrieb GitHub Chris Idema:
>> From: Junio C Hamano <gitster@pobox.com>
>> I noticed that gitk has code to deal with octopus merges
> 
> I would love to know how such a merge can be replicated.
> Is it also possible to have such a merge visible in Git Gui?
This case is not relevant for Git GUI, because it can only show what is
in the index. We have only "theirs" and "ours", and together with the
current file contents that's a 3-way diff.

-- Hannes

