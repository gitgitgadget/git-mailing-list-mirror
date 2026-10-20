Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522270;
	b=RJUvcl485wdofgnb81rWm7mTTKHda1RCI/zHMzGne+X1dbiG3JMp0UkKgiy6BwpV8f82
	 lJ8xj3DJ92YapLvv++II+Sa4jR0anOht9H5ZuCV4Ll/2H0R63xTH9XdzIl5MLHS/R7N1t
	 i2J55m4OogAHiHbVE06mOVtBxBZIWVrvJQ9YfOd4gJNbPO/ZkUveiIIkNWFmw3KEI7AwN
	 uQ8Gr+vh7WUN9BBzhdhwuYO69EMS6PBTlT1NbQrjDOi1MjMQfDvVI5xiEkKiNMzFGeoO3
	 Ifc8uQ70Z/FC0zj7hTOXVyUUeioLWjHqXYGcwe2WR7qt2rFM04AheJ91UXJrFK3R+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522270;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=OQY0BmrULBgtii6nhmUZxhiwSgDEwRbxWhYS+NoGwV4=;
	b=MoQaaIGsgvxBmO9Vz4W5VfFirFFL2gVZx+iK/sKMVFbgJRTBSuVJ6FVHIrczOP/tVhey
	 m4btBiNtUXSLYw61ZVHg0bCKbE4JPV7CrYjqxCL+xeGORfmkB3vsFqkmDwig6dWY+AYhP
	 QsSuyEsd2FT1blEaB9g07g0ya1P9xeLEmTdrUjlO26nTvqoiowRQNN37V3uYcuuj5IZYf
	 U1ZFVIAKC+qZ0G0cSRsudp6RdojDqoCvT/8fcHi3ZYbsV8gaLQojV5L2f+S2Rj5mMXfKV
	 uP4NfrkkMF1+BjL30xIk8ZDxlYu5q6bExLZ4HBu8CQBgfZ0lK2TQPNYhwbLhzb1fJCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=qbYbl5HO;
	arc=none smtp.remote-ip=212.227.17.12
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CC606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 18:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9CC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=qbYbl5HO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1792522262; x=1793127062; i=tboegi@web.de;
	bh=OQY0BmrULBgtii6nhmUZxhiwSgDEwRbxWhYS+NoGwV4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qbYbl5HOQhtwNO8qvCIaq36S9fxQrvhr+qGBiFpSsRaa9xINAS32nD1NeqwGAMZI
	 gFtehfmPjHnWdN9FJUYr3ValjQkreMktYHd3hA3B08PD1LOUBWZDpJgZdDnl1sLaZ
	 u/ofPM7Vps/tCV6wrDRwpPvSCmUbwPAbIdVpNoJm2Hd3w7WdibT8vbHSKpqBC/3xp
	 NcDT0STQcH2bmDMTjlPTq2oDVe2Wj/ixPteuJrmq/6uKU9m4w0lqdK0y564Wwq7sp
	 P4+OIbNOD82mrUNYGVsvOI0oqCa7LvjGCfR3PeXr/kWXA15YIklMXPFfUmX3U3w8e
	 nJicY8G59AtWG2vgaQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfY9-1wyf8Q3p2h-00P6Nj; Tue, 20
 Oct 2026 20:51:02 +0200
Date: Tue, 20 Oct 2026 20:51:01 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: ps@pks.im
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #06)
Message-ID: <20261020185101.GA6367@tb-raspi4>
References: <xmqqbj8tckpu.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqbj8tckpu.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:+0ER+j4W6Z9O75QNw8gGEBji0rxbdiVgNmK4ybnJGRdFp59hTp2
 xGZ2hHB9myICu31C8rVw8kTfh/sqz20nt2L/UsdiUPvhyUZ3IZMy7tY+8ZqijwUeu/iDyM5
 gCpojTZc/NDp2EBmvkzJ6xSw2nHtU7SOZ0UZU92nOLGgLU/SKK4vD1u9wHF+aUUoiIOUD6y
 ESB17OzCzQYiRtIWSkY+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RYOlK6uuYrw=;gYIZdOtUIxbNi8vck5vDYGUmGJz
 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

> * ps/pack-check-bigfile-threshold (2026-10-14) 1 commit
>  - pack-check: fix bogus corruption report with core.bigFileThreshold
>=20

That does fail here - the read-only files was not overwritten.
Patrick, can we get this extra line ?

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh                             =
                                                           index 16cc5d5dcb=
=2E.a19bb27db7 100755                                                      =
                                             --- a/t/t1450-fsck.sh         =
                                                                           =
                             +++ b/t/t1450-fsck.sh                         =
                                                                           =
             @@ -544,6 +544,7 @@ test_expect_success 'rev-list --verify-obj=
ects with truncated loose blob' '                                          =
             cd truncated-blob &&                                          =
                                                                        blo=
b=3D$(test-tool genrandom one 5k | git hash-object -t blob -w --stdin) &&  =
                                                          obj=3D.git/object=
s/$(test_oid_to_path $blob) &&                                             =
                            +               chmod +w $obj &&               =
                                                                           =
                                                                           =
                                                                           =
            # Truncate the loose blob such that its header can still be    =
                                                                       # pa=
rsed, but reading the object data fails mid-stream.                        =
                                                                           =
              =20

