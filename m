Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8E316192
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776748071; cv=none; b=dy69BjVMI1KXBzZXR56QfiiG34z7KeIcxQ5MUTo42uan7lwRlAqvQUUiDkVmSDSeYdmds04YWRrREqTSWaqnwwvIG+tLRnocKkc5PkbpDzjMV2dkPBdNsyTVHQiWtU3xDymsc5ugz6bl6guEqQDQ8ZXxtYahC35avfxlpMmTAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776748071; c=relaxed/simple;
	bh=aMBnWm6QrAINntxcNFvfoaVJLG5C1TZW4lK7ues3Jfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT9O6tfv1OjFYfi+UO8GFTirfzurMRSPsW/dqVVD7DGef6DQf/DLcHN5OumIsaRoWFyrY4L5LuW6pU5kXLnIHgJxD/lSNDMCkkyDIq1HxWtbrisU3vcu5e/PrZm6u3bLGswocHwXs/XkDQwMBFJp2LVH04uHe/6UMKnU5rv9IJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=JR0S5uJm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="JR0S5uJm"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wF3Kk-00Gk8W-0H; Tue, 21 Apr 2026 07:07:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=jJ3SfKIiCfvHdT3H68j2p5RPYh9qSBlL8TjVF2CqL0E=; b=JR0S5uJmwzSCRb2IuQ+J9YC9n6
	2AjAvF3ImtpyZrLXj/j8tdcmDJz79WsyUyyldpj3j51tKb9JW2CX7gBIm/DPMjEiDF1MKi3LTmY7B
	2l19O5SeqSS1XNWhAhfsHNEEhQ+xNEgQSeb2AI5W9TKLYfPIECcc/wbeSGVC28AkA/pFRrqOjnubp
	5LFqsxy7lOo3ewAv0yh/kkhTn03NM+RGmMoMbx9C+WtjLgs5TCHdgQJQj6Bj07dL1ueGUGKwzD3Vk
	nUPMeUiz+uRxLFWSrj7Uz36BKGnpKQDI+zo48zTBmsa1JdmTyPKrnvDhD4SJTTY6/cSXqtBvLiK18
	TkyGqvaw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wF3Kj-0003fw-6W; Tue, 21 Apr 2026 07:07:37 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wF3KY-00D15A-Qr; Tue, 21 Apr 2026 07:07:27 +0200
Message-ID: <cca575ae-e5dd-4a5d-bde2-f493a3e62a87@howdoi.land>
Date: Tue, 21 Apr 2026 00:07:22 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
To: Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>,
 george@mail.dietrich.pub, Christian Hesse <list@eworm.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
References: <20260215201748.889866-1-ask+git@howdoi.land>
 <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
 <27104.58166.993109.63505@chiark.greenend.org.uk>
 <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
 <27109.13129.424068.382997@chiark.greenend.org.uk>
 <27109.63619.90318.366157@chiark.greenend.org.uk>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <27109.63619.90318.366157@chiark.greenend.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/26 04:57, Ian Jackson wrote:

> I need to think about this some more but I doubt this can be made to
> work well without more significant changes, including to the data
> model.  There would have to be some kind of compatibility arrangement
> to handle existing histories.

I would take a look at the test-cases for git-subtree.sh, which document 
some of the kinds of issues you will encounter. They may help you test 
compatibility.

Anything you can do to limit breakage to "opt-in" points-in-time only 
would be greatly appreciated.

> Colin, is that OK with you?

You can name it and develop it however you like. No need to ask 
permission here.

(For the record, I'm also not the maintainer of contrib/git-subtree. 
I've just been trying to fix a few issues with it.)

> If you would prefer, I could choose a different name for the
> resulting program.

If I were writing it, I would give the new program a different name but 
perhaps provide a "compile-time" way to set it to "git-subtree" instead. 
My reason for this is that it may need to exist with the legacy script 
for awhile, and it's good to be able to tell them apart.

Colin

