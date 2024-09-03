Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F57462
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370798; cv=none; b=u5HpIUALOvCi7SKKVZOAgQC0zSQjaBMrjx3VFwDJlZiMyo6b2X3i6ED8PpNOwfbqGnmxz98q1wU43B+l+s1pD/MyZogSz67aIVlVqR228o+LU8n79xvgaVbpUU2AI4Q9HDuk/HU0PPcoL54YwC6tOFUtnAYGEYPMALjUQVru1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370798; c=relaxed/simple;
	bh=dZo3t9R4X5+nHBIQLFUmQ1Wy1+TGJ81rHpyqIMEGxcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mA59OiDvSG/fpMAw8h+DbZeWzK36FQjbwFLwCj3VlBzbr+Mz2pneozEmLlICsmpDuNGv4PfLXvrAPnH6RUvtNNAe/Va2yK/Rh6zHvR330yGTgyPLBX2ZVzmFIlNwXP+aI+KxPsY0EhYv9Oh+z6qown9AMs2NRVLSjcJnlPkINpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [IPV6:2400:2410:b120:f200:a1f3:73da:3a04:160d] (unknown [IPv6:2400:2410:b120:f200:a1f3:73da:3a04:160d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 670823F113;
	Tue,  3 Sep 2024 15:33:43 +0200 (CEST)
Message-ID: <45a51124-7249-4678-a723-4ab9f82a5f2e@hogyros.de>
Date: Tue, 3 Sep 2024 22:33:39 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ask for feature on git
To: Loredana Tralli <loredana.tralli@gmail.com>, git@vger.kernel.org
References: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <CAEO06G+SLu-LAe0mkR3ZbaL0MZpBm9PhntQjF-YwVPMtnuH=rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/3/24 17:18, Loredana Tralli wrote:

> Is it possible to have a git command to find out which is the parent branch?

You can ask for the "upstream" branch of a given branch, using the 
"@{upstream}" syntax, that is documented briefly in the git-rev-parse(1) 
manual page.

The upstream branch is automatically set if you check out a branch name 
that only exists in a remote repository but not locally (then, a local 
branch is created), or explicitly set with "git branch --set-upstream-to".

    Simon
