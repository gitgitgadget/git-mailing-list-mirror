Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636155;
	b=fUPhVA35HnWhm9TD/p4d44pHKPbwFHA8bN49b8ooGUKn0E0eRlM2Ozyn9M2qwk09lGuL
	 6K3k6kOJNdy0FbFPkE57lHrBU7OhU5ukyzYTzK9f6563kcHr32YL3MKZv1bkUb4luVlou
	 heHXCxY6ADzjkKvYSs4JG2ohjbOxKsCd8AZFUoiqMS+nC0uJVuaCuKr8djOagmADpOIHh
	 6pL8tcmw6V/261upYrBw5wJf2z0llXswjhaNrLSdJTOpNuC6rxDgyMZu33tXQfqu6nZ6f
	 esLXeZDtgTlSo8zd7MFnQ6Syi3BIVsbDf+OGeSIreLRRsSkWFX7q6735s/kbm8cSUnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636155;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent:X-Provags-ID:X-Spam-Flag:UI-OutboundReport:
	 Content-Transfer-Encoding;
	bh=w3BIId7/ASvS8NWUFG7Je3YGfDObQkrnyyy2ZsyYdvc=;
	b=J26XXVBD5LZGXZAoclUrZO5x/2/3LVW4w8FUjjkCCqT9y87Brs+G9IMUE6VzoDZrm1bx
	 EhaWtE8vbgDZ+8LVeSzou+xLZZONo/JzYAJ7QjUWdJqamcKQqeMtqDWrwwQlxsxygXkAp
	 1FfbwvIIBfSHGT2o9FmaVBsEp5FOkg9uLJp8NqP4bX36e8+waxZ6EchhEvDdlJiYwmvJI
	 NrClMk3kNO0U7s826YXlYFO+K+/QFMMpMKyOkJvCU/jeWCE5hsCkf43+TpAx+UDiX4VcO
	 L4s4BT5wgSZs7gf+XVBh/oLHFDDsd7I99Rzkug++xVHUjxXR/Ah/yWS16sXnExq2tnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bgUmLilB;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E7606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 993E7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=bgUmLilB
DKIM2-Signature:  i=1; m=1; t=1795636146;
 mf=PHRib2VnaUB3ZWIuZGU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:ZOKhEblx+dh4N5f1h0cuy39ZpCS4
   Aa0TA+PySwHrTY2EvC2dA/f3fkOcLI1aRj3E5VtJdOr3nVWfhHkw1RwtpzRbTJ9rEYcK6jx4VvQ
   iVv1MuOQJA5bLa9AMsot1EQtBLMUM2inlxEY/+Wz7K/piy2+7f7bJbS0URxKH9d5NzptVKOWhyQ
   LYv6F67G06hrgVKsWZtBPoQOjM4NFcKLuh5qrfJXkXHjHmj6FI9f3Xl+nvDz91H5vpel7yV3MMq
   d3c9aURVBcGHet09MKgcoyeZXNh+FtfgC8rsmdVL+Gf4U6LS5xjZSYFOqoqzqBKtfw75c/u8Mhh
   Q85xJvOlZxRNiQ==;
Message-Instance:  m=1;
 h=sha256:
   LhHlXIsXikiIQ1NhtJMKusMA7DPRu0eRge/WeIdez4c=:
   uAefR3mqy9r1KAzS/O12POkvdGkY2tyRgCLHKntNlUA=,
  sha512:
   DBcflPEHp1lllS+dpdUyUbX8Cbebi2IInLIJp/q3Mz9FufTinNmh93R6tGIqr4oTnvnIHpeqbhrWAmCsFUQvLQ==:
   PWQl54UgJjQCwvanZNC8wtTdLFmAiYfzkEUFtYmAvM93EPC5SWcRTyUMbt58Z90bT7L7PEAaE5Hehdjb10zacg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795636144; x=1796240944; i=tboegi@web.de;
	bh=w3BIId7/ASvS8NWUFG7Je3YGfDObQkrnyyy2ZsyYdvc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bgUmLilBC5cLp6LgWn8osF4i90sZxGp1w9Ad8Xa1aQsMwWwvJgtm+z32K+1M0ZAI
	 7tbokyEy/RmSiElIm81m6uDbkEp4IZNPp6FRWNt3UkwSRkhkatL6sT7vwlf8sL5i0
	 k2seULNnLlTR86JO4oDIt+7CJyMQZ4I/jENuBQJfy8a8EWMSi4zqUT54IKZ2BBXu5
	 uZMbeG0M07XES4tdtzlLa7SMLlQ2o+CO/890CEbI+vKS6rJr2FLb0Tn646FR7QDWF
	 f2pecops1v2SZmULYxfPLUIJsjNM0dBbgbesDERTArNPjZhT6zJxESIWY0jfvWwxP
	 RLHR8RY5raGUVFkhNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhWop-1y9C6d16AN-00htkw; Wed, 25
 Nov 2026 20:49:04 +0100
Date: Wed, 25 Nov 2026 20:49:03 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #08)
Message-ID: <20261125194903.GA27126@tb-raspi4>
References: <xmqqqzgb5qx8.fsf@gitster.g>
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
In-Reply-To: <xmqqqzgb5qx8.fsf@gitster.g>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:FP2n6JDXD5x++H0UfmrZBh/8v2u7iU2tAb7zTAUH5uz7+aEYrwQ
 wYbUeawZf5nRkDEr3I8e9BZHb/lttrTFmJ9nT4WapX/muHhSQPPhwT1RZOIAGcQBYHkNIU8
 vJ0ERy+2Vb5tt2l+uHlK4BpssmtaLbQ9QFlMdAJgXSv5OLed+0afcETX3Cn5xb1nvGyV479
 uwWaAIeeW8Az2tTUXW80g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Q9Xc/KFByI=;JrpH1bFjEEzBjNJNqTbZ1Gd9g/r
 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
Content-Transfer-Encoding: quoted-printable

> --------------------------------------------------
> * cs/read-cache-conversion-size (2026-10-13) 1 commit
>  - read-cache: do not trust a size change when conversion is active
>=20
>  The index refresh logic has been updated to no longer trust a file
>  size change as conclusive proof of modification when the path is
>  subject to conversion, preventing false dirty statuses for files
>  with only line-ending changes.
>=20
>  Waiting for response for too long, stalled.
>  cf. <xmqq1p9twdhh.fsf@gitster.g>
>  cf. <20261020205644.GB6367@tb-raspi4>
>  cf. <20261026192514.15844-1-tboegi@web.de>
>  source: <20261013180206.610-1-curtis.allen.smith@gmail.com>

Please allow a short question:
What can be done to move the one forward?

The patch as such looks good (*) to me:
  it fixes a long term problem and adds test cases

(*) There is an optimization possible.
  I think I did send it out as a patch some time ago,
  happy to re-send, if wanted.



