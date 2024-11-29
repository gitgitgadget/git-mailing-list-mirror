Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB615AF6
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732909545; cv=none; b=EuG74EBfP1VmCY4+2Jk2FBXbaUOCNlMWAKIdEYNjmQBjLBOdlqhidT7jhwLnOKRuXMGAEo8gTAGny6aqn1nnqp71wQRxigAbVxVRRHEVPDL70+Yij0c/d/w6n9/eKdBZK5nVNY2oVi/lwsdVfsS75OCcy3tbd9ZbT23HfxGc+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732909545; c=relaxed/simple;
	bh=0BsqGllPNvF/bfjUQfHzGOrMYFicY1NSa3VpYiYrF8g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s7iirLglnMScW8Hep5TNt9YbIAIGD6JV/z9oxJ8jVEXvEtuoOdeBmWP+lCpTvNPv9yFkpgh8vYaPz2dn5oGguc+i6p5xhO2VgNcS0SVERFINId0EqtzDWfDJW2Sbe1nnudKrSC2Nu8h1eToJVOimRwS1AMJXgBfhhp3C+krVwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DHEENaif; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e10GharD; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DHEENaif";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e10GharD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E66B113805D8;
	Fri, 29 Nov 2024 14:45:42 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 29 Nov 2024 14:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732909542;
	 x=1732995942; bh=R+xSnT8vAjeLZj8D+wxp9j9daWznAY65TRxIwy0Umes=; b=
	DHEENaifJ3Z5P7gtGoF3Otk5tQBlfONrwOmRFClUIf8BSYgd6MX669hz6k/LlLNs
	ESl5p0GlOwQWAQ4tBA1xaYW0wxzdCzUPkE7+U7NZUh40TXDyGNDvK/U/a+ILDyZv
	1GfRBUdxWVBH1krGfo2gFK0l80WLk2STQ91PnqWUnMUIQKPqblT3K2kJ5FWxiL4W
	SfIzTMWG74/m2MG1r1ovAdBF4ATdB+T3FK54houoMF2t/2RH5nQhmP8je0k042rE
	2pKHpgxEhc7j8jqoPzuKiq5QHBbkbGQlsQd+wVjWyHbawBTISPqnO7ITn4aD65do
	YcnPSmP2RuL4IiTc/mDYQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732909542; x=
	1732995942; bh=R+xSnT8vAjeLZj8D+wxp9j9daWznAY65TRxIwy0Umes=; b=e
	10GharDeSnWj+XXTVFNJJ+LNmAm+67F6adoS75hYtScGpNQC3roj6rrM7qAtYMfi
	H1ETulWLJk1j5nvJe0JnclYTGYTxeX/LicEalLmo1FjwjX50LU3oHsmqc6og9Ba7
	9F141pMsA7gN9Az3E34en2tbT3AOL602tMitJx7WVNbA/W539fcxSbk9mAfJhYj9
	ePlITQ1XQEvJSdp100WjgiAiz4OVI6ZJZQpxPnMy8yKNQKqnHMC0ZfKUkag8HHOo
	JXXjHCU+UoR9l0eJLQoy6cIkIZl5MUOaYdlEzT1GUB4M3l6ljyk6Wybkb1dum+nD
	eR5CU9GR7Nx9+9NAfUI5w==
X-ME-Sender: <xms:5hlKZ5SVJfDpP3QQAzrqWpNzpYbrtFAq130QLa1EjW_wrn9AnFas1T8>
    <xme:5hlKZyzEyYiXnYsfRqYtX_APuyOn0eVdVApEqE9sM29jcf7Ogr2N5EAMz_-UP8OIy
    aWXPs_mGTMJl_4szg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeejudejfffgleduheegheeu
    feeffedtgfeffeevudeuleffgeektdelueekieenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrggthhgv
    rdhskhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:5hlKZ-1mGHzKKxTnS5BhRpkdhj1oY5jfaFc5cJPzXyVzQJ73dcbmiQ>
    <xmx:5hlKZxAtPHD3TzsEobsmEFzgTqTNJdKh5QstS81UY9esf2DSXDfgmw>
    <xmx:5hlKZyhUH4Eyh75dauJ-ptCppGX0jHlYLtRvRdKnzwKIauN4oiNKfA>
    <xmx:5hlKZ1phueVamFdrHQ_GPFgJrPs333iqLW8Ef0JITaV46dnhjD2uxQ>
    <xmx:5hlKZ2bKZWYRSjZj8KjpRu4yV4i6tvHISaSFNFC3MUgELnvOtagQkAg9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB752780068; Fri, 29 Nov 2024 14:45:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 20:44:40 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Kassak" <cache.sk@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <1c026a82-d24b-48f0-8206-47c2eeed1442@app.fastmail.com>
In-Reply-To: 
 <CADYnh+EUNUaTDB9uLSgZkvWGHrpqrrO4XMrjmHzdH-6WXqZLqQ@mail.gmail.com>
References: 
 <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
 <bc028fc5-c0e3-4d31-9790-86bdd3911cc5@app.fastmail.com>
 <447bb623-28be-4667-b571-935ff7d163d0@app.fastmail.com>
 <CADYnh+EUNUaTDB9uLSgZkvWGHrpqrrO4XMrjmHzdH-6WXqZLqQ@mail.gmail.com>
Subject: Re: Extremely long subtree split duration
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi again

On Sat, Nov 9, 2024, at 22:10, Peter Kassak wrote:
> Hello,
>
> I didn't compile my own version from sources, I wrote that it was
> probably after 'zf/subtree-split-fix', because it was related to
> subtree split.
>
> And I managed to find out by trying that the change happened after
> version 2.43.0 and was included in version 2.44.0-rc0, so i assumed
> that.
>
> Go on and try same split with 2.43.0.
>
> Peter "Cache" Kassak.

Back when I read this I thought I checked these.  So I didn=E2=80=99t do
anything more.

I just came back to this since I found this project idea about
rewriting this contrib/ script in C (make it a builtin):

https://github.com/gitgitgadget/git/issues/1410

I=E2=80=99ll link this thread on that issue.

--=20
Kristoffer Haugsbakk
