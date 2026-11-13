Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581660;
	b=iYUVDON1iSsQyIPTNv5Zt32SqZ3onCpXAE09py8wctNExpa+MgKCmWFtEuwuTu36gDf7
	 b1XHNh3he3KkYh/HPjx0ESZgtpcseMRJOgpm+mitGeLNjmKnOCQxuzXfHqeFg43/gDrpy
	 /X2XCgUL2jPe/ri1C3dkQH3j8W60wwIqUj8t6q5njh87NFxAof5vKdlb9A1Kakql3pF2Z
	 E3K7TxF9YXtI4IlOvCmjz99TMC4xTOF/ysYJxaO14rV+z0SzF9aqilo913tu3H+roDnsK
	 XjxHhkyEMqvr/5FUGbnglC9g9eVU5jXB26ko8VXdcsfll8PpuMCjt90BaiO9XOwwmkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581660;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=+iFD5chCVxC1FLtRLxZkRnRjmbaFfnIsLQgcQDvmde8=;
	b=AkX2vRA3EYPb3cQX3kP5hHRAcWD2tbjyb+92hHYeCFACIzVnzGFuhjQV+qW2W3GPwNV9
	 4axRAzSmpq039yIHygpVIP6zzHyXFh1qWrbnOmYM5hmLM+0H5c50ZHKxEKl5T2fkNc7Xr
	 Tq+nJWFI3BUXr84slDmMXjafC5iMgqAx0oVDZR/ejx0s0tKhZ3854BFdbaFOOBC0ah5To
	 0qk3aKRlk82Qvf6g9IPv7DemU6VNbP5uOlW1KTSFOUoNsjeFwLqiw9iGS9xQbkgVm26Gr
	 iIIEMgmGW7ATmdmjf4qSejnLfAhV99Zv5Cp8DILJPR+Sw69ulbFKiadBEWvvnxhV8AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delpeuch.eu;
	spf=pass smtp.mailfrom=delpeuch.eu;
	dkim=pass header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b="IN/wggT8";
	arc=none smtp.remote-ip=217.72.192.75
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18503606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18503606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b=IN/wggT8
DKIM2-Signature:  i=1; m=1; t=1794581651;
 mf=PGFudG9uaW5AZGVscGV1Y2guZXU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=delpeuch.eu;
 s=s1-ionos:rsa-sha256:mCWdctIaN6EqmjAQDwPE6PTOloiy
   aC1krrvBje+xuVfR52IXOJjEbSAa/0Fv+Iw6RYQDqBjols6Q7X1L6JuoDOFfPOEP4dUEvX0Gxq7
   l5Qh/NoK9bzM3MMQb6/FzNbuGVMSLPjQHcNRuIx4MH20ELk/4W6jL/JKk1C+mbyY6wbQm5yMgg7
   lqF97Lv8Am0MaiTroIWNKBVVAiFTmSSIjxJCRgJDwQWcwA/8HRwBuf5AdmsasAwPYKweUZZZebv
   BjEMT44CGpiGjcxLSz32DPkaWUy3Jp9F/iGnS3Z5i2fk3iirDOWfr+K2ko/Zv/JBiYSNao2mhBZ
   X83rtAtJ2BseiA==;
Message-Instance:  m=1;
 h=sha256:
   7oRwGX/5MjuLrgFGXJDV2u2AtG0lAy9yxQsmPgEesns=:
   +iFD5chCVxC1FLtRLxZkRnRjmbaFfnIsLQgcQDvmde8=,
  sha512:
   NW6DFHDlgbFtuRUFydLqu0xBOvLsSBUoEchlySL8r22OZSICgNdcnDXFmoyrDs+1AZssLInD6EIicwP2/hey/g==:
   2elCIMzXCAMtblIqARZXWDcKHgAWdZD1TDEbSg4ZJAdrmMmN+pLvlOL7xm+MxYQ+eCh0Gf2Ny63aOus/FuHVtg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1794581648; x=1795186448; i=antonin@delpeuch.eu;
	bh=+iFD5chCVxC1FLtRLxZkRnRjmbaFfnIsLQgcQDvmde8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IN/wggT8AcaQJ5kVM5oKhYxG4uCUeQbRf672QtUId466Cngc1VyFXOeqlGx8BOkt
	 CmK+Qq2BAwOM1cRj1jDofEZeaYJVal1Pcww25MMVjUI6OSXeakQS8FZZs5kVXl4Ni
	 npJX71Dg5g5nCFIVmQYvHlahCWFxdzlsutabLb5edNxRPA05lYdOqxBGAkfrvpbKU
	 jqwAFOQhbh8GZLJjoeoRMHQkvhA86P2mAs8qQjbz+6ExRuvHxoeE6y/PrHJ8pHf5h
	 ncHboPtmjHOCSw3Pb4l1pRC+ioO6dLXpUHVFfaSyZ7/PuBLx3K8gSmiO8AGOYFLLB
	 x0RaUqiIfBdCoOAiew==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N8X9L-1wNneb1oPZ-016osJ; Fri, 13
 Nov 2026 15:54:08 +0100
Message-ID: <bac63196-7f6b-45b2-9666-a9894f6e1eb0@delpeuch.eu>
Date: Fri, 13 Nov 2026 15:54:07 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document the current project governance
To: Junio C Hamano <gitster@pobox.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
 <xmqqmrrqg7uf.fsf@gitster.g>
 <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
 <xmqq4idtke19.fsf@gitster.g>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <xmqq4idtke19.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NwJb8k+bHPwr1n54yOjQIf1Ziq0yc3G3zLYU6fSfsOH8uMtJWkk
 NTJGLTjys7bJ7e272QDuawJmjM4hRP74z4oREGahyHBN577bjVNsLUlQYFOSjk3jYBbEDXL
 wqEclGhYKdqGT4NcSTmBye8R08XNJzlc9VIV+FV+CBnuGlKTCzKBAzqdSxM2Fb3PXz6V18P
 vuxmdarXW0hroggaxA5Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EpFB8uST6m4=;nVYjB/KVbeqwmz5oaGM4kfqC2T7
 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


On 06/11/2026 19:31, Junio C Hamano wrote:
>> Thanks. I think it would be worth documenting who is able to add
>> subscribers to this list. I am assuming you are, but are you the only o=
ne?
> You ask for membership for the security mailing list and access to
> other resources necessary for the security related discussions and
> reviews, and releases by asking <git-security@googlegroups.com>.
> You will get a response for by somebody, then join the security
> mailing list (or not).
>
> I do not know if it is necessary to advertise anything beyond that
> to the general public.

That makes sense, thanks. I will integrate that.

I will continue my little investigation to clear up other topics before=20
submitting a v2.

Antonin

