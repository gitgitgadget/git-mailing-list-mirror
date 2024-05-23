Received: from smtp.biuro.ib.pl (biuro.ib.pl [185.38.250.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA645146D4A
	for <git@vger.kernel.org>; Thu, 23 May 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.38.250.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462915; cv=none; b=asmO1MULpolFCZCgqr1yuprA8jf2mR6osz3afdUjCFH4dT3g5lQTj1hVsDpReFOequwffFOu97hf8DKfcDNLmvLH9QKvzylR9nVquycMRjH90tKU2dDK4gw4AANXtQI0nzOUlck3OD7Od4e76BNTw/jUpZUKGecUAxf3bAuMMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462915; c=relaxed/simple;
	bh=zpn/IMckEFIP9yg4OZgpPH252YdzmcqyvyjSY+ykNeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEooZp1UFskl+WqhVFQtGGt1bzGf4ukKgwMPxlYZu52nfZdaRdyoNQFW9AO2C7HTHoDnXUyjqdpAR0Xzv3T4k3L9zhL0XL0lWE6p2YQ3DjfFzTd88TucIqqnVb0tJigim8wI8yZxUKKp+oInGsNt3ha5ChSjKrO2XaC5bPGSkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ib.pl; spf=pass smtp.mailfrom=ib.pl; dkim=permerror (0-bit key) header.d=ib.pl header.i=@ib.pl header.b=GQIGRqqr; dkim=pass (2048-bit key) header.d=ib.pl header.i=@ib.pl header.b=WH9RuMFZ; arc=none smtp.client-ip=185.38.250.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ib.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ib.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ib.pl header.i=@ib.pl header.b="GQIGRqqr";
	dkim=pass (2048-bit key) header.d=ib.pl header.i=@ib.pl header.b="WH9RuMFZ"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
	s=20200714201541; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aMc6Tx8kkP8dmqplxMvK4vJyLQvcffPe4a5uCtzGoVY=; b=GQIGRqqryOSRJ5Yg4j9a9+XQGq
	awnopX+v53OBXwNZTTYX8sBdgxk/yYzwVB11xVo32RoqA1/m4ko0Lygqi9CQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ib.pl;
	s=20200714201541bc; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From
	:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aMc6Tx8kkP8dmqplxMvK4vJyLQvcffPe4a5uCtzGoVY=; b=WH9RuMFZhWlVVrUBmDRd6whEaE
	6pQyspBc9/x3BmXOgHUmAMMFrVhN78ajRM6LP0WvC1ePmghu9rO0EiagJzJtuILRptmxolCLu2ngd
	kLT5A7Y/90vzZ9XeS2b4BABQ4FZD+W8JF+ND+eOflvgzgYRrh/42VRDDX05+uBUHiDdo8udI/Gx3m
	8fcLbyu6lQdTucxTmnsnC16IvwqrndXoeiW+/qAX7QtnQU/0gR7bmvr/+6EP2/jUpSJ5TxN2xx5Kg
	adkAOWwd90x1CHmIAHeAfO07oWNGYGioX4Riu2DTchkZgJDnJ4xd1QeA4tbHnEV7g75ar2X07X0cy
	ciF7Hzvw==;
Message-ID: <011b01e4-eee7-4300-8498-3af436c15a81@ib.pl>
Date: Thu, 23 May 2024 13:15:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Cloning does not work on available download bandwidth changes
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <ed79092c-c37d-4e4c-aae9-af68cd8c20a0@ib.pl>
 <Zk5pDZ1gTcyrGfUk@tapette.crustytoothpaste.net>
 <293afb32-99b1-4562-b339-7862698ef00f@ib.pl>
 <20240523090419.GB1306938@coredump.intra.peff.net>
Content-Language: pl-PL
From: =?UTF-8?Q?Pawe=C5=82_Bogus=C5=82awski?= <pawel.boguslawski@ib.pl>
In-Reply-To: <20240523090419.GB1306938@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

W dniu 23.05.2024 o 11:04, Jeff King pisze:

> I did run it a few times. It usually succeeds, but sometimes fails. When
> it does fail, it does so in "slow" mode, without speeding back up. And
> I see one message from before your "error:" line, which is a report that
> curl reported that the connection dropped (curl is shuttling data back
> from the server in the form of "packet lines", each of which is prefixed
> with its expected size; the "N bytes of body are still expected" is just
> that parser seeing a truncated response from curl).
>
> But I don't think any of this is due to what Git is doing on the client
> side. From the client view, the server sends a TCP RST (which I observed
> with wireshark), and the connection drops. I'd suspect the drop is not
> even from the application level on the server side, but rather that
> something in the network path was mad about the delayed packets (or
> possibly the spam of duplicated TCP acks that I sometimes saw).
>
> So I really think this is a network issue, and not a Git issue in
> particular. It's possible that the networking stack that github.com uses
> is more picky about the things I mentioned above. But again, not a Git
> issue.

Checked once again with...

    $ export GIT_TRACE_PACKET=1
    $ export GIT_TRACE=1
    $ export GIT_CURL_VERBOSE=1

...and git dies with...

    [...]
    remote: Counting objects: 100% (6960/6960), done.
    remote: Compressing objects: 100% (2926/2926), done.
    12:55:29.776311 http.c:756              == Info: Connection #0 to host github.com left intact
    error: 3805 bytes of body are still expected
    fetch-pack: unexpected disconnect while reading sideband packet
    fatal: early EOF
    fatal: index-pack failed

...a few secs after interface speed is restored (git transfer increases a few secs).

In tcpdump of above test I can see FIN sent by client (192.168.100.100) first:

    # tcpdump -i eth0 -nnvvXSs 1514 -w test.pcap 'tcp and src 140.82.121.4 or dst 140.82.121.4'

    [...]
    21346	2024-05-23 12:55:29,776138	140.82.121.4	192.168.100.100	TLSv1.3	959	Continuation Data
    21347	2024-05-23 12:55:29,776151	192.168.100.100	140.82.121.4	TCP	54	40624 → 443 [ACK] Seq=6192 Ack=19611541 Win=65535 Len=0
    21348	2024-05-23 12:55:29,776702	192.168.100.100	140.82.121.4	TLSv1.3	78	Application Data
    >>> here git client sends FIN but transfer is not completed <<<<
    21349	2024-05-23 12:55:29,778374	192.168.100.100	140.82.121.4	TCP	54	40624 → 443 [FIN, ACK] Seq=6216 Ack=19611541 Win=65535 Len=0
    21350	2024-05-23 12:55:29,836364	140.82.121.4	192.168.100.100	TLSv1.3	78	Application Data
    21351	2024-05-23 12:55:29,836364	140.82.121.4	192.168.100.100	TCP	54	443 → 40624 [FIN, ACK] Seq=19611565 Ack=6216 Win=65535 Len=0
    21352	2024-05-23 12:55:29,836421	192.168.100.100	140.82.121.4	TCP	54	40624 → 443 [RST] Seq=6216 Win=0 Len=0
    21353	2024-05-23 12:55:29,836441	192.168.100.100	140.82.121.4	TCP	54	40624 → 443 [RST] Seq=6216 Win=0 Len=0
    21354	2024-05-23 12:55:29,838428	140.82.121.4	192.168.100.100	TCP	54	443 → 40624 [ACK] Seq=19611566 Ack=6217 Win=65535 Len=0
    21355	2024-05-23 12:55:29,838448	192.168.100.100	140.82.121.4	TCP	54	40624 → 443 [RST] Seq=6217 Win=0 Len=0

Cloning

    $ git clone https://gitlab.com/gitlab-org/gitlab
    $ git clone https://codeberg.org/forgejo/forgejo

does not generate such problem after interface speed changes so maybe it's something specific for git <---> github.com communication.

