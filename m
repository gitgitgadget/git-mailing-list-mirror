Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A1326D46
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765953639; cv=none; b=XqlgV09I7dZarTiv2bnxh9YYvSo60IgRnvLLVUNgu4br70prLLKojYdnUru+vQywFabP24K70/YM7JTpDPD/UDvrLzAPSy3eBT46IaB4fcZqQuZrHA+cQQOdkP+YeNJLZ/JjkPzZ0N56bqKJHB2oP1zZnxbVP3PAz0CniITtaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765953639; c=relaxed/simple;
	bh=VskSGLjOcNSaUU0WPd9TcptK6ugfQf7NowT12F9H278=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KwSbksisdXbPDYaQAOM6v2cHM+AK5uAMy0JgsiYGYdL/QoaRTHTTnRG8DAt/3GE0B6d6oGyHd6e8cxHpPyN+V78Bbg56dODGOS0Dw2+8n6zodRjO271SQquQ4d+YqxiHhgBkbxOx0MIFN9gADrGMXI5oxleIH3r3kYvBtYvQ/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.94] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id E3DA53F11A
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 07:33:24 +0100 (CET)
Message-ID: <0e1e168e-e90c-4aba-a474-50d0df75a8e7@hogyros.de>
Date: Wed, 17 Dec 2025 15:33:20 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
From: Simon Richter <Simon.Richter@hogyros.de>
Subject: rebasing on top of reformatted branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I need to rebase a branch on top of a version that has had automatic 
formatting applied.

My usual approach for this is to create an empty extra commit after the 
branch point, then filter-branch all the commits on my branch with the 
same automatic formatting, then continue rebasing. Because the filter is 
applied to the tree, no three-way merges are performed, avoiding the 
conflicts.

Is there a way to automate this in a nicer way, especially if I have 
multiple branches that need to be rebased in this way?

    Simon
