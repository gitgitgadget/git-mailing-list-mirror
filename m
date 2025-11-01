Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC12C3262
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001711; cv=none; b=c9usrf+wryVQtBoN9nX1VkOxKX/zui4gWttoTohB/NC/3dN7c+sK0ObUFlI6eNhuTaJ1t2ho6+1EtcCvJyTFbOp9CcNqB6fwjlgLmefnvS0X87WkOpmZ5dd1ATYEa+IGBRx+81hhXxvruzdzogqI1PamLxnCPmuIw0no1OsswkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001711; c=relaxed/simple;
	bh=aH1XrIkDxzyqjs1FuvAkPFr1+WT4zmGuTqMCO6D3p28=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=p+BsqikRuwg8aaZ7nzCX19axktMEXQc0r292g8TdePc82pD0aMkbwGqHQX2fd4VzwF+E+b84M2/boiuG4EoS3Mm0I/882nniIZayVf0JMX9WqEKlUfByq1Od8C5TS0Ww98EdnoRZeMzHFZKLWlHpllrIBqYGGSEkXox7Yj2zl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O5ybacZJ; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O5ybacZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1762001698; bh=aH1XrIkDxzyqjs1FuvAkPFr1+WT4zmGuTqMCO6D3p28=;
	h=From:To:Subject:Date;
	b=O5ybacZJXrpyPkhN0LNdm9O2ERSPJaaNdJrDAl5+f/wVT+Y1csmqjhCkRsVFC7kOQ
	 Jk6RYldsOyc0tnzeUcIjSjsIgScwzpHQwZUQCZZTXcbupl95DhB7uY0v2es4rHh6gq
	 yaVkP4seylhZ2qkurwn72qSHhbtsuJ18x9erOcqk=
X-QQ-XMRINFO: M8wFrcb6n6Ii4I6kYxweyY8=
X-QQ-XMAILINFO: ORUxNCQxhJ3z5CWPiSYSvuzCjuMzQKM0T35bFb6iqFvqhbtFW+8xy/3R/882uK
	 cJlvbEidoYl6sqJvKYlOpODUmZneGq7qu5E3VVnn9fq/8YhUlxOIvbjB9PZbalr8qyuPS5ef2Y7Kk
	 vZoSSxC93jDujWUIHL+PMg10U0xvRjKiyx2DQl7fnbLokl8ofQYAFM4XclUKFL4WHRPhypAyIdph3
	 0e8Aa23JVwTWqJ6z8PrI8Mb8iQnSt4yPOngPK00VjHBqiE/911VJ1E0cKHCfTEgCEAbYFK94R3Qwh
	 F2+fMNWDmts8iJTuJ94aRK0syGszU5A8IYmgTKYGDHyll+OZ+Ahi1dVChV4eKwMWPMtk+ySWLsaf2
	 2pFKzFw1fKEQieH0KXDhKtOdH3Z0RH/2uEXDJI3kUGCVkl/15IayYCjuWlI/DPqpQR7MvFhUOkDmI
	 DENNTMhBYbKFVsr4Nl47WjtNXofNcX694GNh5u6Q+qAVoRkPmpUjApuzJo8Y5uXzzy8wn6AHDLlW1
	 KITIw9eHj+KYpk5SrQMM5zn2HZnPwlMkLxedajLbbGjECccYPVOrpFX6XE+JImfGpAIzi7qAvc1Hg
	 //7sWEFRd0lpM9sDwYeVET90qNPoKzcuX8X/EkokOtYTKnv+YakQvD72WVgAUZZllIo9A5qwY84Bv
	 8rdNLJ2Gh763QDQ6M4LjyFzQ2Mk0X0YZaiKIQJ6jdscJHG43IRUAgM/uDKxE+P0e2ZiPDMhXZ72Yj
	 Fic9r54bo6F30C0leupoaqaV0VblyT1Jfq2R74RdnRUi5YXbT53QPeOsqW+Q/0ugpjg7Zx6R2otTC
	 Asa9WljjXoTGnGUHWPLhefYX0TKr+qVEiue+7GnlTLNHvJU1rY0cHaNe6lipPU+/kzafM8VP0G5To
	 ZogVyaMNZvpfudCc1BdCCkAjjQP8yFcns+tQ5I84n2tC/YyuFUrab9Na7JkYdD+/oA4xI9cs2NNot
	 nnBTzKZTtmo66xGzpwXj/lUzSBvlngjPFnm6NQR2vK6fje+HmrHaFSsEFslAN1gbybyhoVxRKXwtB
	 VO1fbpeC5gBew2m07FD4vJrpZ65qs6R7vbZ3GiOGkihvvpCl62Ivp4q/Emw==
From: "=?utf-8?B?ZmE=?=" <fa_ge-akarinnnnn@qq.com>
To: "=?utf-8?B?Z2l0?=" <git@vger.kernel.org>
Subject: (Bug Report Form, zh-Hans) git-subtree not respecting commit.gpgSign
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 1 Nov 2025 20:54:58 +0800
X-Priority: 3
Message-ID: <tencent_D8444AABD439465DB4FA0D624A8E85A0220A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmseza56-0t1762001698tp072gcfq

RGVhciBnaXQgZGV2ZWxvcGVycyBhbmQgbWFpbnRhaW5lcnMsCgoKSSBtZXQgc29tZSBwcm9i
bGVtcyB3aXRoIGdpdC1zdWJ0cmVlLCBpdCdzIGxpdHRsZSBib3RoZXJzIG1lLiBXb3VsZCB5
b3UgbGlrZSB0byBwcm92aWRlIG1lIHNvbWUgaGVscD8gSGVyZSBpcyB0aGUgYnVnIHJlcG9y
dCBmb3JtKGxvY2FsaXplZCkuCgoK5oSf6LCi5oKo5aGr5YaZIEdpdCDplJnor6/miqXlkYrv
vIEK6K+35aGr5YaZ5Lul5LiL6Zeu5Y2377yM5Lul5biu5Yqp5oiR5Lus5LqG6Kej5oKo55qE
6Zeu6aKY44CCCgoK5Zyo6ZSZ6K+v5Y+R55Sf5LmL5YmN77yM5oKo5YGa5LqG5LuA5LmI77yf
77yI6YeN546w6Zeu6aKY55qE5q2l6aqk77yJCkkgdHJpZWQgdG8gcHVzaCBhIHN1YnRyZWUg
bWFuYWdlZCBmb2xkZXIgdG8gYSByZW1vdGUuIFdpdGggY29uZmlndXJlZCBjb21taXQuZ3Bn
U2lnbj10cnVlLgoKCuaCqOacn+acm+WPkeeUn+S7gOS5iO+8n++8iOmihOacn+ihjOS4uu+8
iQpBbGwgY29tbWl0cyBwdXNoZWQgdG8gcmVtb3RlIGlzIHNpZ25lZCBieSBncGcuCgoK5a6e
6ZmF5Y+R55Sf5LqG5LuA5LmI77yf77yI5a6e6ZmF6KGM5Li677yJClB1c2hlZCBjb21taXRz
IGFyZSBub3Qgc2lnbmVkIGFzIGV4cGVjdGVkLiBPciwgY29tbWl0LmdwZ1NpZ24gaXMgbm90
IHJlc3BlY3RlZCBieSBnaXQtc3VidHJlZS4KCgrmgqjmiYDmnJ/mnJvnmoTkuI7lrp7pmYXl
j5HnlJ/nmoTmnInku4DkuYjkuI3lkIzvvJ8KU3VidHJlZSBnZW5lcmF0ZWQgY29tbWl0cyBh
cmUgbm90IHNpZ25lZCwgYnV0IHNpZ25lZCBjb21taXRzIGlzIHdoYXQgSSBleHBlY3RlZC4K
Cgrmgqjmg7PopoHooaXlhYXnmoTlhbblroPlhoXlrrnvvJoKSSB0aGluayBjaGVja2luZyBj
b21taXQuZ3BnU2lnbiBiZWZvcmUgZ2VuZXJhdGluZyBlYWNoIGNvbW1pdCBpcyBhIGdvb2Qg
c3RhcnQgcG9pbnQgZm9yIGZpeCB0aGlzLgoKCkkgcHVzaGVkIHRvIGh0dHBzOi8vZ2l0aHVi
LmNvbS9Ba2FyaW5ubm5uL1N0ZWFtd29ya3NQYXJzZXIuCllvdSBjYW4gc2VlIGZyb20gY29t
bWl0IGBhMjg4M2E2YCBvbiBodHRwczovL2dpdGh1Yi5jb20vQWthcmlubm5ubi9TdGVhbXdv
cmtzUGFyc2VyL2NvbW1pdHMvc21hcnQtYW55Y3B1LW1hcnNoYWwgYXJlIGFsbCBub3Qgc2ln
bmVkLgpXaGljaCBpcyB0aGUgc3RhcnRpbmcgcG9pbnQgSSB1c2UgZ2l0LXN1YnRyZWUgdG8g
bWFuYWdlIGludGVybmFsIG1vZHVsZS4KCgoKCuivt+ajgOafpeS4i+mdoumUmeivr+aKpeWR
iuS4reS9meS4i+eahOWGheWuueOAggrmgqjlj6/ku6XliKDpmaTku7vkvZXmgqjkuI3mg7Pl
hbHkuqvnmoTlhoXlrrnjgIIKSSB0aGluayBjaGVja2luZyBjb21taXQuZ3BnU2lnbiBiZWZv
cmUgZ2VuZXJhdGluZyBlYWNoIGNvbW1pdCBpcyBhIGdvb2Qgc3RhcnQgcG9pbnQgZm9yIGZp
eCB0aGlzLgoKCkJ5IHRoZSB3YXksIEkgcHVzaGVkIHN1YnRyZWUgbWFuYWdlZCBjb250ZW50
IHRvIFlvdSBjYW4gc2VlIGZyb20gY29tbWl0IGBhMjg4M2E2YCBvbiBodHRwczovL2dpdGh1
Yi5jb20vQWthcmlubm5ubi9TdGVhbXdvcmtzUGFyc2VyL2NvbW1pdHMvc21hcnQtYW55Y3B1
LW1hcnNoYWwgYXJlIGFsbCBub3Qgc2lnbmVkLgpXaGljaCBpcyB0aGUgc3RhcnRpbmcgcG9p
bnQgSSB1c2UgZ2l0LXN1YnRyZWUgdG8gbWFuYWdlIGludGVybmFsIG1vZHVsZS4KCgpb57O7
57uf5L+h5oGvXQpnaXQg54mI5pys77yaCmdpdCB2ZXJzaW9uIDIuNDMuMC53aW5kb3dzLjEK
Y3B1OiB4ODZfNjQKYnVpbHQgZnJvbSBjb21taXQ6IDRiOTY4ZjNlYTNiMzJhN2JjNTA4NDZi
YWI0OWYzZjM4MTg0MWQyOTcKc2l6ZW9mLWxvbmc6IDQKc2l6ZW9mLXNpemVfdDogOApzaGVs
bC1wYXRoOiAvYmluL3NoCmZlYXR1cmU6IGZzbW9uaXRvci0tZGFlbW9uCnVuYW1lOiBXaW5k
b3dzIDEwLjAgMjYyMDDCoArnvJbor5Hlmajkv6Hmga/vvJpnbnVjOiAxMy4yCmxpYmMg5L+h
5oGv77yabGliYyDkv6Hmga/kuI3lj6/nlKgKJFNIRUxMICh0eXBpY2FsbHksIGludGVyYWN0
aXZlIHNoZWxsKTogcHdzaAoKCgoKW+WQr+eUqOeahOmSqeWtkF0KCQpCZXN0IHJlZ2FyZHMs
CiAgICBGYem4vQo=

