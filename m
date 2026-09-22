Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F83EB105
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096820; cv=none; b=MCQV61iBXMz6P3zOeNpf5UGy18AsSRr7g5jvWMHQ1W0j+mME5JjIbp57Xmvb8ZYXCoMCytKpCN0epymGy1Tq65tH3Ytn23VPXDKeno47a86nY1IX8w+2RiTDOWOoofTE+HwkBLZ+BkQ7NQWWmGFnnVZCGwjpY+bg5mp8ukPeICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096820; c=relaxed/simple;
	bh=Ixhlc7axQO6x5/bd5Hq+g4iNBLrobECuxDxAYQpktT4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eWdpMT9PzVqTXgJZB0IbFSaZaM/zXdgsecIBItcRtBlRgO2YiFqegVwtVO5UN4a8f6aJlo9KHAWEa1SDtacQtbS7i3yEw9OFWJQtwdAWivDYGIcyKn6X6WNiEXwotek1LYuWAvnxOTApciXy7BhLTwBgzRaaOD7T2GHs8J0Ljgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=bMc3wGmq; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="bMc3wGmq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790096815; x=1790701615;
	i=johannes.schindelin@gmx.de;
	bh=5qekyp1vmKY7frXvGR3Iv1lDlr+F8n7R+Z+pin09VzM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bMc3wGmqpqwFb2ewBY+KuAl5PzqqseK43++DAklkqCOwaUEfwGra9vKpvCBtfCrU
	 6hWcPbNmdEbFQenu2eK8l9aCK+clRE8fowsM0AIvn4RGUTfQzftPq2q4QfuizCuFm
	 I16kYykbD+QjKQtinXxS0r3n8F8Dya5Q8qG57mNyfHbcL+RNNd2Iu2qCvvhRRWnlq
	 Cofmr7kNminAOGEQkpRvf2+9eL/3gTXWEg3MaELiiM0NHGd89Ag6mK1/+tNC0O59Y
	 jeAgGNqi7jZ9tsph6e2tvf4ZLnxGQGbwCt1I/1H3xaLy6bYMdk1U/5BMMpstqJm0g
	 CKZmTrf+11yBQ/RbzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1x9sts1gl5-000YnE; Tue, 22
 Sep 2026 19:06:55 +0200
Date: Tue, 22 Sep 2026 19:06:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <xmqq4ifhgzvx.fsf@gitster.g>
Message-ID: <5f34a5a9-9f72-b725-666a-94798895d122@gmx.de>
References: <xmqqwlsei1pv.fsf@gitster.g> <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:X0iS081mtNKs7S84m/yhdk1oosRVzA52HCJOzeS6rrDvMIQ76zb
 xS1pYuthYQhrb+5WIu6di/o3pcMNEmyJFXNFJt16D/IuNYVLF+WJBIYi435YpOiQaF+daqx
 6LTS/dR6m92qKiUQBmcwnyqB1efKNGGG52AdryFxhayX6Pw/Z+Gx2PpaoZ2qpdrYlYO6bmn
 a6ZkcqwsNwYv+wktAUfdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B3fu1K3RC+4=;thidY8dwm2T2YlXys5XKn/U6TlI
 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
 XRLlk1gT7o+66
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 22 Sep 2026, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Mon, 21 Sep 2026, Junio C Hamano wrote:
> >
> >> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes before
> >> the final Git 2.56 release, but otherwise I do not expect any new
> >> feature topics to be ready before the final, so most of the
> >> in-flight topics will stay cooking in 'next' until then.  As
> >> discussed at the Git Contributors' Summit, the version after the
> >> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
> >> year.
> >
> > Would you say that the following is an accurate characterization of th=
e
> > timeline, so that people who need to plan dependent projects can rely =
on
> > it?
>=20
> My outline was deliberately limited up to end of this year as I am
> hesitant to say beyond that point before the meeting notes are made
> public.  I am not sure who will be releasing it to the public and
> when, though with the open nature of this community I believe it
> will happen soon.  I do not recall anything controversial in the 3.0
> section of the meeting notes.

Fair enough: I did ask you to confirm my summit summary. Let me separate
that from what I need for planning: a proposal from you as release
maintainer can be discussed on the list on its own merits, without waiting
for publication of the meeting record or claiming summit consensus.

Could you use the next What's cooking to outline your working release
plan: whether paired 2.99.1/3.0 releases in March or April 2027 would be
your proposed target, what conditions could move it, and when we should
review that target?

If you cannot yet choose a target, could that update identify what needs
resolving and when you expect to revisit the choice?

Your assessment would give dependent projects a common baseline to
coordinate around. A provisional planning assumption would be useful; it
need not be a guarantee.

Thanks,
Johannes
