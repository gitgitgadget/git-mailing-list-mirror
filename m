Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22D1991BE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555248; cv=none; b=dugQMBOV1qfq71ykVMq2uCH3P2EWAW2QQXW/rbkFO09kqHmnnztUzr/0TFMLDdu4gNEYLylr6Usl1dSgSx/pVz28pgnlxL789gs/6viM8WRtJMexqRQZwqT13FQA3mYubIOkabsYS4gTCxpOxo5mZ7ghWChhAhJUjg9S9hV5Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555248; c=relaxed/simple;
	bh=1a5ILBz22pu6RZT3YOj0aOzydeQe1Vzt6CJg003m8cw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NEN/SPjIVOBMp6e+zjtg0lUN8UeX7g+jrfgAtz8qfQu0AiZsXixeCpLsbzfDhtNOIO+f2+lpFQUUwIGdYzzAaYomeEoxbV77G+Ny10KcxdH0/2oPslHYaDL4/9A9duxjWVGy7C73YggmIYHJZg8B0lcf+fF79aHnmLi6iYIJFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=tJL6jpwm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="tJL6jpwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723555240; x=1724160040;
	i=johannes.schindelin@gmx.de;
	bh=7/t0sBXRfy1+PBD0ZyPt/uyZQcypdTUO4TjbObt+sjE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tJL6jpwmpNnBVJb2EC5BnpZ1f9OYocdF0xGCfleowMGCMDvi8v2voYjwSZTxvZnk
	 ZVm+2O81no4F/cqlil+9KvyrY7T+1+1LAKE6WbSoerUpxmTgtWFR2Ru/1udKX/cu4
	 ae4h6OxnnRG+skh3P6M5uQjrumtY2GDAb6cILPQdMy17Ey/AzN7irxN9ZL50O074v
	 AufZ/0zKMKP/da1+E1G47rjYsKpltD4BY0TV4QuIxpCw+FIWhLGx6YrJ6umVUfO2W
	 giMBFnT6YG7yRrWKVP3QJ/y7P+FldXjJd5h+vBP6iUqPyCnoocwiOWAfxM0dE7em3
	 zUTVH3xdLfHmKt8U4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1sENwL23nB-01155Q; Tue, 13
 Aug 2024 15:20:40 +0200
Date: Tue, 13 Aug 2024 15:20:39 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: PEMBERTON Brian D * DCBS <Brian.D.PEMBERTON@dcbs.oregon.gov>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Technical information about http.sslBackend schannel
In-Reply-To: <CO6PR09MB7381B7819CC314C878A73FF2E6AB2@CO6PR09MB7381.namprd09.prod.outlook.com>
Message-ID: <3d235ec1-5294-c9ff-0b9a-fa443e570b79@gmx.de>
References: <CO6PR09MB7381B7819CC314C878A73FF2E6AB2@CO6PR09MB7381.namprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Mgf54Os1MQ3I+GLyWG4GiVCRUMpwJ9EC2NXvwDkSF6iYCqcL8uY
 g9JmXYTln5tHmXJ00dxDdMXsuJhg1nuKtCfocrzirr4GCACUbkaMsqRsF3dYPnCJx6WYz4A
 1QfwkNXDQ9GneVnZRBff/qofkQz4nVBwHpBgnlP7KuK9vHqtDajQEYkTrmLPVqouq+iK0zY
 mcK5uamiqNH/1CgNg6RQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sJqEl/aNum4=;NzC/gsBkwMOo87ZYcXc6Dfditm/
 FJH3JIjPPRqg31vMvNTXQufqBRlJawH+W6EC8rwroRMmvFtALzzWmelOMFdLvNtgDoCGnOzLe
 UKr6Q/Em1GKZlKlNPEPIps/xUlRGNv18DbtdVIazyzFROUQMXnx8nGx1bUBIcPi+eHtjpbqO5
 HRI81vVcMLOo1Nc6TidV+YszqxfSeA3r00DWRyCryAD4axK2v7LSuFzIatbO3JKQLA3XWJg9S
 CW1f01pN1Zc8MAqwtezukiiRFgD/kSV+fhBoWvaTkYknntDzcThcjM/xqMtAWmgw169He/4Uc
 qaRRXypGmwmgSyYJaOCBABufrwieEeFlKjH+9FMnX2rksyVhKiByfmyMHx1VsmvULVUGeVAmQ
 cowcnbeRs45iEChcVuzpjaMItU1r3pgn14E5nwenfYSNr7AsCx4OYnBFuJihqZx30jXLDDXQL
 fXilSUOmyWPH+1aE0eltt3UMtlBza34ERmFUPK4owd4B+RScBgmKokQctriAQ1Cq1Z6/Chf8E
 zq3ikqECQyfVSNNNVAnSiLb7CLRhg0QkLb7IpkSB3Wy3VKPC+0ZFhYwuBQfkwi8mALvSaD9GG
 cPOaHcc+mfrED9Q3XunltSnCmD3JqK6kziMGycxMpbw6ZlkwWGQ3YpUMuq1GrzfNKo9g/NL8D
 sRuaQy0NzgBUXF0/L5mIBn9BsLkEZzNP811Pj2KXyreg8b/PYDPLZeuNJAKQMiCH5PGKo+JZ6
 IYgZj3T+3Cpuq4FbfOgQuigjUcNyPtfg0OLGUuLS/AyAaEHX99AwEFLwwR6sp0Qa7TbSvLSBK
 Y3+U4OnzmAjA0/eehENhlgUg==
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, 25 Jul 2024, PEMBERTON Brian D * DCBS wrote:

> I am in the process of migrating our SVN repos to Git for my agency.
> Our infrastructure team is requesting to have more information about
> what the http.sslBackend schannel setting does than what it stated in
> the documentation, as it seems necessary to connect (clone,push) to our
> remote.
>
> `
> http.sslBackend
> Name of the SSL backend to use (e.g. "openssl" or "schannel"). This
> option is ignored if cURL lacks support for choosing the SSL backend at
> runtime.
> `
>
> My understanding is that it enables Git to connect to the Windows cert
> store, (sorry if this is windows specific, I thought to start here,
> sense the subject is SSL)

The name `schannel` is short for "Secure Channel" and refers to the native
Transport Layer Security (TLS, formerly known as SSL, for more details see
https://en.wikipedia.org/wiki/Transport_Layer_Security) support of Windows
that is required to transfer data via the HTTPS protocol. For details, see
https://learn.microsoft.com/en-us/windows/win32/secauthn/secure-channel.

The name `openssl` stands for the OpenSSL library (whose home page is at
https://www.openssl.org/), which offers an open source implementation of
the algorithms required for TLS.

Git itself does not use either of these libraries directly. Instead, it
leans on libcurl (https://curl.se/) which implements a variety of
protocols and optionally uses a variety of TLS implementations.

Now, what does this mean for you in practice?

As you likely expect, the various TLS implementations all come with their
strengths and weaknesses. Here are but two of them:

- OpenSSL is historically much faster at adopting new technology. For
  example, it implemented TLS 1.3 much earlier than Secure Channel.

- Secure Channel integrates much better with Windows. For example, if you
  direct your web browser to a site with a self-signed certificate and use
  the convenient GUI facility to add that to the Windows certificate
  store, Secure Channel will automatically know about this. OpenSSL does
  not, and will require you to jump through quite a few hoops to access
  that site.

Seeing as you write from a `.gov` address, I suspect that the fact that
Secure Channel is part of the operating system (and hence is certified in
the same ways) will be of most interest to you.

I hope this helps!

Ciao,
Johannes
