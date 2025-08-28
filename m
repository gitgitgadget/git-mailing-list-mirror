Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6A26F2B8
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382856; cv=none; b=MyfxdYRH93DK6sBBWuANXALnkNUQRsJ53CGPDtnb5iF+zEcgaWhJNCWR4rMyjVOxKCSPDBI9sayW6HhYrcYTj4VaQOwDgdRyCzvFlFHmXJl/JcX+PzlGEO/0iJXv5UJzeiDqt8sCGwtKl6SgWDXzH1RMbUlmLXjopvEmUiLOshQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382856; c=relaxed/simple;
	bh=/haumz47sTuzjjNbe2czT63CbZpbdH8sk3KZAfv1zg4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IhzNjp0urszXVm1nm5EkzXmEqyKgTw5wCp4I1fDqR3G+Ks40FKo7P/n89gPXOzGnBRDMwwZwyf23PsHE5SMef/jMLUnV5nLF2gtnJhZPEFtGTQz4Yx+JeGL9CU/giEHFKyZkskWxBwE+Fpt0Vqy8QMY2IaH6xcToqWYlBWsYB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=vbQtIFzm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AX/CSixq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="vbQtIFzm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AX/CSixq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CFA0D7A01BC;
	Thu, 28 Aug 2025 08:07:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 28 Aug 2025 08:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756382851;
	 x=1756469251; bh=VyJfUGOOztOT3u05ENojxyug0Q3homh+aKNXswsc+AQ=; b=
	vbQtIFzm/ba1WGjJSp8VDfmNVXUFinkzeUNpXMuFsLIJ0GlSCxMeA5nodOUJHzAq
	zfnvT1TGUQErVbwTwv0w2ZJqu52srztXqLZub4PDtNT+qrdx3qqzDFtDc+eoqKu7
	0grRO+EVB+2tUhrQULJHLXLeQrw2r6i4hgobO+cPjZpX0ceDSKWiIvE3z7zEJ/YF
	4IgqIPehFJi61e52ph2brGKKNE8lOMsdiiURDHRl+hYHqKirOEiEV4UpWazIYAIJ
	bzurP+0xZvHqtMfJB1FxQ+vn2gJMK8i1I/RSwtyPqXRkpozFrCxjLJsoutM1XH8t
	4bzbu1R1N5g2hr1/Lr121g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756382851; x=1756469251; bh=V
	yJfUGOOztOT3u05ENojxyug0Q3homh+aKNXswsc+AQ=; b=AX/CSixqkmjHimQXo
	OkISsvfpJ9AABMDKfncaA0GlvdSiwgeMuKMinsy2A9JuLu+1jsHqlZ4hp+tjYh43
	H1SmqkQA9uk+npCjUqDFhCaZjh74zxO/AnPkxGbFCwYGDSdC4T5prJVZR/qKmTEL
	L1VNcCfrDVYp/gPpUcPhR0JyYp2awzJw7wuw1bgLdjo9iTnm25iB55l2Hhsq1zZX
	EczS6/aooaIr0PBhNKnx4ynb/7zv1aY+an6LKm8fhIVAsOJLoX6TdMvamlEbki2O
	2P2VWlKiyXXd0V6rDwWIlq5W82fn8g+DwKar4EY36if6FQGzv8pIZg2d7C5RsMWp
	zFA+Q==
X-ME-Sender: <xms:g0awaJkToAe1F0ZrQXwYqVIT3Ax8hw83V8RcRzM6_wZdrOZkinohJlg>
    <xme:g0awaE3qxReM_RmcR0AYOj2d4EM7fP6878JSK-GM-8TUFdkyCpeksiQY0pV428i4y
    wfiDYNRp0CzSapobw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptefgve
    evudehheejhfelfeeugfehvedutdeuudefieefleefhfejhfdvteeljefhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g0awaBqRjRzIiZnk5DK_iBfwvhKv-I6azFp9kPpAIz_OlJLQXw5Qtg>
    <xmx:g0awaMmhYpLQlVnEC4Wuj0ytTkhFoB31rRX-oGrjzYs1VHeCMuzBhg>
    <xmx:g0awaAJkPQKXy-Y1NqyP6UmKSrMqfvbOkXDiLOQPfeORdSedD4oleg>
    <xmx:g0awaJwTauXY2TGLXS2cMgqYkfH5dd0HSM3Ja-N_Vc4mkskoRbpNOw>
    <xmx:g0awaMI4A_BZTxwJTg4dAw9SP_OouFHLOvQV7JT95rCeuNLqYDSS8090>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C4781EA0066; Thu, 28 Aug 2025 08:07:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AizzdEHxvRsg
Date: Thu, 28 Aug 2025 14:07:11 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <97e67403-7f46-4555-8edc-9fc1c1109bfd@app.fastmail.com>
In-Reply-To: 
 <5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <5407c0955af7b5bb30fbc32264481990b2e4e8b8.1756311355.git.code@khaugsbakk.name>
Subject: Re: [PATCH 2/4] whatchanged: tell users the git-log(1) equivalent
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, at 18:29, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>[snip]
> [1]: E.g.,
>     =E2=80=A2
> https://lore.kernel.org/git/e1a69dea-bcb6-45fc-83d3-9e50d32c410b@5y5.o=
ne/
>     =E2=80=A2
> https://lore.kernel.org/git/1011073f-9930-4360-a42f-71eb7421fe3f@chris=
palmer.uk/#t
>     =E2=80=A2
> https://lore.kernel.org/git/9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.o=
rg/#t
>     =E2=80=A2
> https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail=
.com/
> [2] The error message on 2.51.0 does tell them to report it, unconditi=
onally

Missing colon.

> [3]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intr=
a.peff.net/

I=E2=80=99ll expand on this.

    [3]: You only get different outputs if you happen to have empty
         commits (no changes)[4]
    [4]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.in=
tra.peff.net/

--=20
Kristoffer
