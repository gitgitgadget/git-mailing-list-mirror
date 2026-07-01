Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28D63EC2FB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895451; cv=none; b=Oj3+zt/Oi/yZ8/uhtV7joMYq9kF78g8vB2xqyC90pD04RsbH0a3XY6hohMU7fpawzhJIWQOnFL9hp/qaNeYUojZx+NdypVfV05SJC8MbMrV6vCebw/9AVtd1Y7ucoA4ZGn3ZvBOczEI68SD+18Q6v0FSdd68/9MYU8cAPXrK3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895451; c=relaxed/simple;
	bh=ELwileHOgPnGNl8iaYnwlxWcukO8tGVlszCcEfHcUWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcHuAwl2S0HyTCB9KXd/RDzuyaPVbss5qnX7dWJ96AvbNEVVwGsu75SjlPXPDlhttIxU6wYQDA6UaM2dKYu3RhplmrsBj0x5IW6nXxT6fpZH8WyPRdx/W8MFY+vEUwCP6K9mMc3+ECEwbR1zlzaocF99UdJqM+UztBz6p28C0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=eaOUAlhW; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="eaOUAlhW"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 40C9D240103
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 10:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782895435; bh=uqpFMhlFB0CRMh9dZQ7bkPalytgmiN59HzkpeMLRtJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=eaOUAlhWtGLfij63dwtuWJ2YxNcJJ/24y4jlq/slrsCWtyXalvv3Zb9TzhvWPoXfD
	 2hud3cZtd2hG42rmSu9iy9EQowZFQ9G3ijpV3zo5dQS08RrkcdvFPBIeaOq67E8Khf
	 O8BtKDk/HSPuZTuxeWDHbdsajUht/0UxNDcLfwwahYJdw9Kr7/ddPLHdMgUPjsZ0Pz
	 sswdh7/Zoa6dzTobj/hsTV/eujKsRshjtWsejyRbeK9O0rpryYkKi9h77MfB1wI9pB
	 kwNS09rndjEHulY0ispaUeUOUPstWPjvIFj1xg++lxEfmWZfp8bK4mSrYnr+YJhamr
	 uSroCjaVK6auw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqtpf2hwjz6v3K;
	Wed,  1 Jul 2026 10:43:54 +0200 (CEST)
Message-ID: <6d4b0156-4de9-4f67-b864-cf6314a1e772@posteo.net>
Date: Wed, 01 Jul 2026 08:43:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: git-blame vs. abbrev
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
 <xmqqy0fvreps.fsf@gitster.g>
 <7df1312b-c5d0-462a-a03f-9f07e7338de1@posteo.net>
 <xmqqcxx7raan.fsf@gitster.g>
Content-Language: en-US
From: Laszlo Ersek <laszlo.ersek@posteo.net>
In-Reply-To: <xmqqcxx7raan.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/26 23:24, Junio C Hamano wrote:
> Laszlo Ersek <laszlo.ersek@posteo.net> writes:
> 
>>> ... the same object, I suspect you wouldn't even notice that the
>>> hexadecimal digits you see on the screen have one digit longer than
>>> usual ;-).
>>
>> That's it precisely! :) I do *not* notice that the hash from git-blame
>> has one more hexadecimal character than the central abbrev setting; so I
>> just go ahead and blindly cut n' paste it, using the mouse, from the
>> terminal, to the editor search box ...
> 
> Which means that there does not need any configuration variable to
> trigger the new behaviour to protect your workflow from breaking, I
> think, and instead we can just go ahead with the "-b then no extra
> column for '^'" change, right? ;-)

Yes, certainly!

Thank you!
Laszlo
