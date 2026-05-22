Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C23603D8
	for <git@vger.kernel.org>; Fri, 22 May 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462379; cv=none; b=rFIzB/tvWcCsk9ilkIc47butxLWzplKWBhqRpOhvZjPH3HcNvbfKp3xZKA9TlW2c6F7rXI4DHwHXQV4DyTsSjQECDIjQG6zXGfINGWap5h3ow4BXVgrj1usRtfiFPB9BbAXs6pHNT9WGH10cN2GSHojn4W+z8OL+TWyuw0NA7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462379; c=relaxed/simple;
	bh=c4wMttGlfAuXXiATV+kBVOUlJ1TxigMteu48VaiYIGw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=k2hvpb1i8wvVnAPRM/EENXKtXv1vuq83jBL4s6xwuGh2aYx9+tBWhsJ4jVhMrO0F0E+P0HaYMS2Vg7kHDGStiJLUQQ/kphktgdJDLlOx23kY8o/3KXax9LFqHpT1velvni/fxw9xbF9FrPvc2UiBG2DrFGrpSpzCs/TjgLwfOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ad6w5bHK; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ad6w5bHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779462366;
	bh=QPvfTe+IZTeD4uZBHH2IvzyW0/Q+Py5SzAJkQLN2vmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ad6w5bHK/1krhqhcKHDQpxinuQshhW1P1ACwiEfzgqDyESic+EZzGvKQCaWqmV5GV
	 JV3+bJ5Y87kOeTWmsg8wuDdU0P9D6xvSeDH50WifvBoaBH/XJLecGS5nCnzgTzRavj
	 1erPgT4kBwFrT/lAuqHRhqSvmXkL5r7O26mfcA7I=
Received: from localhost.localdomain ([121.224.209.33])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 18338630; Fri, 22 May 2026 23:06:03 +0800
X-QQ-mid: xmsmtpt1779462363tvzs8f16y
Message-ID: <tencent_1DC2E8E76788506425483808F7CD56931406@qq.com>
X-QQ-XMAILINFO: OeJ9zRfntlNPJpmEvKkXglAEhTaPG/MNY5DGBAwohBsct2ymrtpHQOwPC5vxAX
	 Y06Ff2brS38Bh0mAKd8uyqXpnbhcrFB1jnJDxYYqmfUWgdc1GeUn8FBhuhxot2C5m7PmTiPpaNVx
	 K41FMpSD1lTpN8cfgQIJj83bptAT2ALo/goBeImQCy4ItGAUyWiaVjdrcD4+ebFdkdk+0TztdA5N
	 9dcOY5qJXMdkTKWcth7H3VbdESQSg/CnyQTyJxhSwD30e65/G2M0bmlltkKmuOpZqpn7NhtnDwYb
	 gNKey+X4f7qS3n2t3T6BX3NDgPzivrH3nJDCKkXzaySJSjDM2uxvUF3/TtZChUsHjW7slhPwG5uE
	 7ReyTMbBPzuIsZ/wffXuCsJI38jUJeq0iwA6cMETqiV6KvYYyME4lK/oSBMup9f4EoxvfEweBKEz
	 DHEk+p/nMm3mCEVA5SNOOdc1H8XMZONUMtgyJGNgZIgF47HOTCGNw73+ZEhE4gk2mgueLAa2KYb3
	 dcRfIVWIg1GvSOjE/b5liwxoHOEt8zob4XdaItGSpx+SyptGXfjGjsFUGMa4mKNlWCjCn8CYFOZB
	 dgT0W89ZFb+sq50ckox5gL021URZKgf0140wW+LETOGV3baLEVGX3pfciiyJ7CtSt8iSRzxeZeRg
	 CpVNp2iqIGTIGHc5MS/nJ8cvs2zr7ZgTgdSLHhoXyWHJiZrtLQk/u25ZRDBCCiKESWk01nZN/gb3
	 ThNp9Vyk1dt/Qyw+Fe9YF4vi/QfAfSJT53AE24gV/bjMW2cij5jXGc4XVJ5HDpqOiE3MwaSDcd25
	 ozkQ1gzTVlB88p6d313Aqemo2ygLmu5rpJpLdslMEEVNrxQOnlnPTDveStPIUEcOPZIJtH7DuFTC
	 cji2pGjIJpwDxB+RKFsGixG+vZAuLVaqtvqeeds+Jriqn1PUsCL0uhHERr1wH3QTm1mdjnv9GbCm
	 TUsP4g6lznZtak76vCeL1xVdldyWiOHcTgvVhD/wzFihhJeknARToCYe2kd0cXG3uq0jC6aPXz11
	 eUyJuylwG1YJIi+5yePfdOUJRK57WR+Qy9hQ5nqZOtkwpkPXnQ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Aina Boot <bootaina702@gmail.com>
Subject: Re: [PATCH v2 10/11] git-gui: adapt blame/browser parsing for bare operation
Date: Fri, 22 May 2026 23:05:25 +0800
X-OQ-MSGID: <20260522150527.1894-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <bb38c5d4-b388-4eca-badd-69ec7ce67b90@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/22/26 1:35 AM, Mark Levedahl wrote: 
> Asking the worktree that is on version 33 about whether frotz is a directory in version 2
> is just asking for trouble, at best the worktree is authoritative for the checked out
> version, but even then there can be uncommitted changed. In the root of git-gui, I get
> 
> /git-gui.sh browser gitgui-0.9.0 Makefile
> 'Makefile' is not a directory in rev 'gitgui-0.9.0'
> 
> so the types of objects are being checked.
> 
> Mark

You are right. The input is subdir instead of subdir/. All the 
current tests work well. Patch 10/11 does not cause damage to the 
functionality of browser and blame commands. 

Shroom

