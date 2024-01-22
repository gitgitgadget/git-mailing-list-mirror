Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25842CA8
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956937; cv=none; b=ALYj/dbcJwu31BnmjkwvuGTyzk4tpE1qnI8Qh9CEUBRVak4hX0hr9hQ41i2FRCAV/N7yYfzqO6PtRRjw/e5iVKMHEh7UtPGbtd4A8k5/6h/pJdOGuC0le/pxoIh1bahsGqT1VTaejFwhld90mxGZxkm7VDXRuTZHvo0ceWc+IpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956937; c=relaxed/simple;
	bh=KvDkGDHh9ubGE/mnX5WDe0OvgNgibcGei/nT4LiZPSM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oU/daFP38T7SrD4XvjuBldLAVEymNUE5ydp//+LjXe0Mo4A9Fcuf2fJ9qJ3klX7qEWVbYwdcB/1G8Ot0hQ/m8CrcqCk3kIXuZwppfGh+n/axSs1iwkzrCYS6uV/IiR2trRUkzNipXT/+sJrUSPsrOZVY6xExkewcDJm4s8rn7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=QajxF2Bu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxe5XIF4; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="QajxF2Bu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxe5XIF4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A6D1B5C0130;
	Mon, 22 Jan 2024 15:55:34 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 22 Jan 2024 15:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705956934; x=1706043334; bh=KvDkGDHh9ubGE/mnX5WDe0OvgNgibcGe
	i/nT4LiZPSM=; b=QajxF2Bu+DxpfCnhFrnQ8JoL/CBB0Q/24JqOuFiUi69iSSq+
	dX/Z7UeJFcW45Ys/HWSpZWvQDFHN0yECd8KCHT9asiof4ehJqOBsiOD6QMdbuTus
	5XF7zj/aLi7dvrVhROSOB5IzIf7KBWjj0otF8hUgSwolirPKEKaZ+CQt8OryU5Kr
	knx0BUd4rDpE2hikMPwi33eAIMpBv6291JqpwpTQA41WK1UJg8qny3ckm3kwgAis
	TyKZZznID2ZS8D/vbRn9Dc+E4XqrK/S3QuoeeoGnxpO0intCv7T78zb0t4QJqicX
	XOToOAmkfR78jq/dDVwbqXJfTw8pL+u4tjONmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705956934; x=
	1706043334; bh=KvDkGDHh9ubGE/mnX5WDe0OvgNgibcGei/nT4LiZPSM=; b=l
	xe5XIF4lrEoriC2tBzHrhAGwkIhYhE/A43sTY6SZeL8Slkcmd7d1NFHTwne8ZohW
	WdPYbijMLi46Xfudd9aLFxG2T2t9csOgl+obxCBCI1NW0r57eZGcv5cPPvVhz5+G
	wDsEbDeWkPai7KLntB4fLlj9bGSwxyUW75JU3ogMmPXbh278ScVXyB9LnNTEtou3
	JMj9+TUfoKuJdLgF8JHoDtWWoUlnwVfyDozCH1L+H1GpqeUThV2H9J67e9VTNEu8
	xOTrTX3q80F5hWklb1ziYJad7hKtaIJb6kHyBgQfuA32uc5ipFU21GJrRf1Cs9Yk
	+tHu5aoHNb1xRY9dDQpYQ==
X-ME-Sender: <xms:RtauZTjE7g_aPVcoBrFf6zw2mePnGcep9vdPREaLnVAaDhQ-x3PHBG8>
    <xme:RtauZQD4iQjggg4hBCsKwgwNLtPUHYX_Yc0hOr-H3v6GtNfZymbgkGqcLpfjQgp3v
    MqBn0_UuLXVca9A5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffduveegtdevvddtudeggfekgeef
    gfffhffhgefgtdefhfegfeeviedufeefffdvnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghdpvgguihhtohhrtghonhhfihhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gv
X-ME-Proxy: <xmx:RtauZTHw7i59QObrJyUUsbEbHFyzYSwITguxtNVToB0nR2arBytGVg>
    <xmx:RtauZQS3l9dAAy0a6uF_YtGrugKnsuZYpLCw7Tmcs91UYiA13oCDnQ>
    <xmx:RtauZQxJ-oViRawYkD9G0tB-jagkp5ctzT576MbHykvkqZQ1AT7T9w>
    <xmx:RtauZdoeJRB-p4wpZbdPySDJmLv_zasc_ZrNRyXZ1TjEfGpe92rZSw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6319115A0092; Mon, 22 Jan 2024 15:55:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <10838549-c364-429b-a086-68a41b7369de@app.fastmail.com>
In-Reply-To: 
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-5-brianmlyles@gmail.com>
 <06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
 <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
Date: Mon, 22 Jan 2024 21:55:13 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: brianmlyles <brianmlyles@gmail.com>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust redundant commit
 handling
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024, at 19:28, Brian Lyles wrote:
> Thank you -- This will be corrected with v2.
>
> Is the sample pre-commit hook the ideal way to prevent this in the
> future? Or is there some config I could set globally to enforce this
> across repositories? I was having a little trouble finding a good way =
to
> accomplish this globally.
>
> Thanks,
> Brian Lyles

Oh, and this thread reminded me https://lore.kernel.org/git/xmqqle8hrtcs=
.fsf@gitster.g/T/#t

that editorconfig[1] has this option:

```
trim_trailing_whitespace =3D true
```

So I guess that should be enough for all editors that respect this
config (although I haven=E2=80=99t tested it).

=F0=9F=94=97 1: https://editorconfig.org/

--=20
Kristoffer Haugsbakk
