Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9D2E7631
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166762; cv=none; b=U8XtfLQIk67y2FwOayiSq3hvIHvA4q3+tbL1DhkXUkMvSg5J8pZALI+5SQQQ1zlxLdzbLCP+B1UUcIAp4uTty74QlvEV2JI5obWMZrdQnQirula3BOaO0idvSQNZe/OWGq0tTGTQNgHdCbHLJLTg3kHHYJaz/HZefqNCYy5v1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166762; c=relaxed/simple;
	bh=t9TTf49pu7WSkG1KpBH2FjJmhZACnMVFk6uhSA5AY7A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QoJnJAuuVt+EfnWws25C1gxnb/ZAD+oSuviPVgfyNrReYUeL46gelsGiytPP+rNVRMJzqq4L5mqjYdCBLfXgnYy23YWhoFQwyg1b8pvOXDHlzulYKmNo/WGODTKrZUiQ8R2fB9bWCjtP8Z0zuK+wNmQdmKkyF/sKXuRuHMiwnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DBT4t+MW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X3Rs6p/o; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DBT4t+MW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X3Rs6p/o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E511C7A01C7;
	Thu, 11 Jun 2026 04:32:38 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781166758;
	 x=1781253158; bh=t9TTf49pu7WSkG1KpBH2FjJmhZACnMVFk6uhSA5AY7A=; b=
	DBT4t+MWioUC1Rt2qlHeeWMzZ3tMHfzQ81JsAhjUdXHPRCI3SYjocbGU8KRb1YqM
	aMYQALsiOAtp0b9F4gKfwB6UIMvdq7UDp4yGRz3+ZqCOQR88WFLjPd2YmZlpnUrl
	lCD+/4Bnwtou8trqAZAZlrnmNsVQJ6bR6xdR02eRvuX5DWUtT+8COBac3Q4y9jDY
	RbF+4zPKFbJETxEKUJpoMhd+Vnj9q2M9gBBOOOUysZsOxapMDtBuAktTD6twK1CI
	c1cLW+M6A8OXmMIZ+koKNW8uS7FrG3Ja+C91qcF/vrxeAgodtqmO1wOfO7ehHfVe
	U6dYBBBCeZrkgsl23Y2uFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781166758; x=
	1781253158; bh=t9TTf49pu7WSkG1KpBH2FjJmhZACnMVFk6uhSA5AY7A=; b=X
	3Rs6p/oZYvzOsg/ZNhbTnGW8NlNLHOkyQcaagg1zAopE7wgaFHlWYna3xlpDOyQE
	uS9vltbSBfIArRltWla6Y07Wzl/I++ZO1c7ekRJVJx6ZNeyxcD+iMhU7b6ikL4XW
	TrYMb8gsfcw88AxSlZ1Ei5EsRObhk1RK0FCV8Pka5m0F1kZIoR/ZZY/OsRwoexwW
	w6cssX9wa5ezEw9Mo9ufpQHX/adjQ4BgNH62WIdn4ijavefM2GW/3bZmTxURKIVH
	1KyMcKVHWoM9m0I9HovrYcZuSqPxwXCshwy3z0vBDmRyTFddDHgW0Y+/IjPSeQdO
	AIgiLaaMz8BvPMq31oDSQ==
X-ME-Sender: <xms:pnIqarDmbPhUEKCM1kHgI0YsUWdCWPFdMADCkCHC6q2NNsW46IvZYxE>
    <xme:pnIqasUsb8MSFdO5q7hCtrx8JXHcHubDCzK4vtm4N8Ec0zCPm-5yWVQiu9FtS3oBr
    PYPq7XlyReBRm8H2FOloS5RiG0Zxk53LZI1PPU7I3SmazNq2GfSaw>
X-ME-Proxy-Cause: dmFkZTGKZcYKgGHPgAgJkD61R/NCoKZ8uj5Hr74JY9V4OYcx8eJNaNQu8wqUzy8LoCh5Lx
    gBlCNEA+B2isO0bW2UyK5BDa/bIvRQKyeZV9p29nsEr3Nv+Z8DpPJAVFe2xZo3gSfMrt3q
    4CxR4H3UWkVtoztp3/30TYB9f8mV3eI0vqfBd92iVbhJqwqEtOeet10Z3vduB0U4WVNeY0
    4e01zDXUmLzGFqQ4MCGuTJi0e9pGPotY5aajqHAu3kpb0VFZIjR6y0D2bCy3VRXGgv1s4l
    buXnGUEsbQC86oBOu+QAqx+sXUoZ8UUVHOCE6xul9Xhx59KEMLDpc/gl5QahHZlU9UFtKF
    DaM5GlqsFXazGjNpG9Te8yqvTekU96tRW35zNGgZ/wNP7zwLceGOAG71hejJAtJU+bRDHB
    EbxzUbDLQZsqTBI9M4kQUILl2eUURpP1InLbZb6BLHCBAfX9m7yS2jNYFo8cCG2NNIeb9S
    wE6nX+/nVJqYmof6la41A8r+dk5FFjxciw/W4tge8oT7K9/+lEM3vkx5tqiZ44dyXS2cwg
    YAaL8N9MOhDvVyEvvNJEvC6UnEvCUviiBG4ieFsTxZfPWkQvlI7f957TfP1hPNjSHhA79E
    BRLhQJG3Noapnd3C3sajVnCtCDWALZ5F2tHbAxYmxLYpNZQOSwmorEHlot2A
X-ME-Proxy: <xmx:pnIqalpJpC8vYK--SoRVgqLKcI54zgJe1zAhDPfXE7qbqvnlYIRRig>
    <xmx:pnIqalcl8mbj6phhkQw3SyrN5fVtFMhxB9N_HrtGllBoi1yDwW3Mtw>
    <xmx:pnIqaspFG-7R_09WsUWT9Cxf26ojxJjUYlbW0NhSlkhtBivlosuO1A>
    <xmx:pnIqauGAHrOYyq0nLPPBIH55NaIv5ci0ByphtQZXfhRS8wFS_9Ah4Q>
    <xmx:pnIqavfwMpCdB5nE4v-TaNhgR6zAHr6Y2OvAYXkxNFoz3Syll-iJtmSv>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9BB2630201AA; Thu, 11 Jun 2026 04:32:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzjX8kAM2llR
Date: Thu, 11 Jun 2026 10:32:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Johannes Sixt" <j6t@kdbg.org>
Cc: git@vger.kernel.org, "Koji Nakamaru" <gitgitgadget@gmail.com>
Message-Id: <7b40cabe-d243-40dd-ab29-fc4dd91fa20d@app.fastmail.com>
In-Reply-To: 
 <CAHwyqnVSnf9K50xgUjeHFM395Rvj_uTVvZ1U8EZayNDZeMP4Bg@mail.gmail.com>
References: <pull.2318.v3.git.git.1780555730228.gitgitgadget@gmail.com>
 <pull.2318.v4.git.git.1780742303298.gitgitgadget@gmail.com>
 <950f70ea-1615-402f-9cd4-3317bf177c5c@kdbg.org>
 <CAHwyqnUpiWmXo0SVr=7L-+cwA+qhVyqodpV-O4C46w=kLqaLMg@mail.gmail.com>
 <fdf7f988-d345-4107-845f-e089d7829c16@kdbg.org>
 <CAHwyqnVSnf9K50xgUjeHFM395Rvj_uTVvZ1U8EZayNDZeMP4Bg@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: silence install recipes under "make -s"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 10:26, Harald Nordgren wrote:
> On Thu, Jun 11, 2026 at 7:37=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> w=
rote:
>>
>> Am 10.06.26 um 15:19 schrieb Harald Nordgren:
>> > What does it mean for it to be queued here, should I expect it to s=
how
>> > up on seen or next?
>> It means that I'll arrange that it will appear in the next Git releas=
e.
>> Until then you can find the commit in
>> https://github.com/j6t/git-gui/tree/hn/silence-make-s .
>
> Thanks! So does that mean that 'seen' and 'next' are branches that are
> added to only by Junio Hamano?

Yes. Because the git/git repository (on GitHub) is a mirror of his own
gitster/git repo (for these branches but not topic branches).

When he is away and there is an interim maintainer, they may push to
these branches on their own repos and use git/git as a mirror. So I
guess they all have commit access to git/git.

That is my understanding of the matter and what I have observed.
