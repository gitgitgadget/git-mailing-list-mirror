Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261684;
	b=LMf6aVUvAH/MgCcn4C9KCRyHcXPCGofR3QjtALRqOkdL/NUfaqLwRXsgI7vWppyyXjYm
	 xpeoxDQpIZc3kaUbjExFWHqBYGO7xkAC2RHfpdNmDtzKmUP4hlkVNSITvePtR9dC2YEtl
	 +C2huGhrKbp6jbB37tzDzcbIHus1Ib70Ge5+Xs/a2/ZGqU0FDQximDWD2ctbGljIG5Tu3
	 OwkpHuhEH1IrrQoNF5u3cqWrOgJxsbgFZwAyNa4vmyUub3oEqM2t4gdgeDnbtbQeYouz6
	 o9aDLv1LKpfTHfVrveSc7Znf2qrpDS9UvQejxRYj4/ZKtRk+UfS7z4nm6WF1/zpYGXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261684;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=tSvr+Xk4bNqpkYp7UzMhQ1TRVupxgjtYZRDmtoOhl8c=;
	b=zUhrmd/nFkNVQcJGtokf892AOA34Li78BKzvys1kpl61WiR/qR4CkxV3NFbxpl3GxsX6
	 E+TVl+oo7qGTPVUXXEzppsxBShEgg077uhguw9+rcG3MInGGxV05ykekUKgBnuUrilrtN
	 td2INP+cg2BmX/Ws/OQD6L4IHTFp4mkSyueMZCXTZ8SLmSUFyRUhwMKpIbOW9tbNzm4JP
	 J0zDV4Mu6fcPOZmYiqT7PvsK6ZDxZmGXRqPEGd/I8icEYH6OHNJ//tBsWtYqxRTBthuT9
	 wTPdEdybYLqqkgtgsjVoZA4TS3neI2iKrjjOTE7CZ+/b6GYCrkM8WZzd3o/wDvggFog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=GfMWmL7a;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QqHcIFDL;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B562606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 22:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B562606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=GfMWmL7a;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QqHcIFDL
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B0C8F14001E8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 17:01:22 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 17:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794261682;
	 x=1794348082; bh=tSvr+Xk4bNqpkYp7UzMhQ1TRVupxgjtYZRDmtoOhl8c=; b=
	GfMWmL7ai+K5JDd4RC8XxnMTd62Q02KOdHWyp5XWEITo8MY9Njekx+74X/vKxEsp
	CT0Ay1Il5wJtGAVkrMp2Y7yMi+WLedfNf0zuKVdV8hsdRCgiOIOY3U9mZ2RmDx/n
	+zMrHkYOyAlabUSdw9S3zdddBl3k53hrKZFBnH6q43I1PeyC6PXEgVqIceqgLg3f
	huGTVRMCzxdQAzw777t25FpnmHCGoUDM4mU4/OT0iXnw98prta70WMyUJ2svaIr+
	XaFEuwBrse4e6ntfhcaolTZ+VlkUsVmPKEWGZ1LSyfEdO7Li6i8e6l/neDihQ6s8
	bBZOO49MpDYe9fA8TLdIeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794261682; x=
	1794348082; bh=tSvr+Xk4bNqpkYp7UzMhQ1TRVupxgjtYZRDmtoOhl8c=; b=Q
	qHcIFDLof9PCJ3Yd6/7vFgMFZcFvXGXGqpGO64kRc6/35TdAwEk9rmYuXVr8k/Q/
	r5UQyvnImZpiZG1ivBrhGbBHBR0T66gCYQLNFjFkLyxBeE+G/QU2UTx3nraOC2KU
	dJOkZlJpCc2KGAJrY+ABddOqH1hOqWNEUxRzZa48td+98QHBBx72lmfnFe41pnWW
	fS4gXjEYy/0pf49fZ39xQUrVBWhwNCVCzFXXGf27SpGW0nVM35Lwgyv8BmHSNHa9
	ppkdrTY9rMMZ3YF91d8AHax1iTIXKPi7qX+VTfHFIdlENCzpwM0ODjBW+lk6nrCH
	4jDqEXIiHKEaxyQZEC1jg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794261682; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:A/P5N7lUT4trnDoZnMZL/R8cR3vw35CJXVLHGNfbJHYmMxG
	AC0ts3l1mSGJgwKSIx6P0CgFobzCVDhem4t5JJdWDbCmLXeXom+HGGsWNpZcnq1w
	rmk3KXJ1x+ZLxwPxx2qopfURdg5fqxGoezs6TqDpUspc2InYshxNfvazsko0AUGt
	ThCbzYDyneTPYYjr2er7pxzyj+axXHTC+H2zrFY9CFdHJuk3qqGYBnvJKOAeN4X3
	Icy7N3m8JtEY7g/yl11yIRfnfxHnf1BiZiquZ2R9H2WW3iYfaZeVvvCrb/IoFbCo
	9t0PjBIwe8qn8nSHBtf/6JhDSKfH5n1uD03gjgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eytSSB4TIAeeccIZLEriZR1fuHlpEWWdQuDXmSflLos=:tEplhsrEGeJF0NuKXJlaqeUgjgoqkqMKb72i7Jq3OH8=;
X-ME-Sender: <xms:skLyahNY6-E-KxL3EBLiNUlaLRgwwZDSJlnFQNrTv3qIOECtErumWg>
    <xme:skLyauxlaCmVgBkIEfvM905oJYpnBMjUCIKieTDTuVwlXV3YhpznXTFHZtcWgH_tO
    te_gjsUcEpR65i2tDo4QeNzDIWKFEWutoa3FabjgOreYapnLr3pdL0>
X-ME-Proxy-Cause: dmFkZTGB3WUgwuZlZMT//Nlc5eFXmmobg6k/AxxWeSsZOqY2eh4ktOqBQLRKmyLrMSAaEF
    nrjWpgBWklxB9O6NOaFBxD0Z8PdrjJB6TsldzRcH3xlzrC8kaRKc0w6vooYEgQvYzmZBe7
    1f7Jl22T0BOjMLNTY5HwqwNAi4HC2xXAZt38ky1iP6u8WbCVaYe7bHXRwiqlmk1O2KgD7r
    Rpm+huBpRzAGZjB/Glp1plZsh3Vn7zs6/F/FVHBtxwcJRfzMQkQEeGZT65W/ZyubmFotsd
    IjUCYFC7ge6kr/dTGTce7VNsfS0DUy3deMPSQShwGOg/DO73hHpso5NYIyBlm3kkYXXqCn
    16S6OlXUvsbvGkrWL/qZFVV/n50c3X3QtnPiXXHIG/pPrvyMkoz0CXbh9KY/eaWa5GgB5c
    CTY+5lUfs2ZKHyC7tDiMN7ic789Iya8iAwH211cbvNB4T1M36ztEBf/huFulsV+W8hZ6/o
    ZKF4wHPJzui3RaRup3mG8qQDwKCex4Tsq4QI5ygoTW6eKtiD5C8dsqm5qm0SylZ83sSNUO
    hYEJjfL+LGnh0WqcDOhEL49ilu6fcK7+UJbyOAVj9OIMTAeMFl+3L4D9gclFIOkuT8VpQj
    GivWvVXwdGA3isi5fJco/Ekx0otFgQvwzIgSvzOAm91s975XE/ZUPA0BtWig
X-ME-Proxy: <xmx:skLyapwbqlh-h0pgPeL90jhpikySMa27t3AOuQNF7UtPuVR3Ve5S2A>
    <xmx:skLyaqwTrdZasH8Mp3d_n76ZeVTiyX_jLiVvltiG9F0Z3gQdBaJVBA>
    <xmx:skLyajalA2e8ffof_IUCgU1LPTpbKoYgCeXK-CDWw7Fc1PqW5YxU0Q>
    <xmx:skLyarU1wEj7e7B3H7jd3xdLqShASpsAwFIn4O4c75Yj3BJnPfLo6w>
    <xmx:skLyaiGYTFaW0WRUScw6SCOdGJLW-prkxqGNMtluSEGrIfjIrVnfGJ6A>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5A7D678273B; Mon,  9 Nov 2026 17:01:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A6BnYcedRdqN
Date: Mon, 09 Nov 2026 17:01:01 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <4696f458-62b5-4d18-a74c-aa692708f7d0@app.fastmail.com>
In-Reply-To: <xmqqo6bxwtxa.fsf@gitster.g>
References: <pull.2307.git.1794259990263.gitgitgadget@gmail.com>
 <xmqqo6bxwtxa.fsf@gitster.g>
Subject: Re: [PATCH] doc: add tutorial on branches for beginners
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> I wonder what incentives, carrots and sticks we have on those who
> have in-flight topics that are so close to the finish line to
> concentrate on completing these topics before sending new ones.
>
> Ideas?

For sure, I can avoid submitting new topics in the future until the
current ones are finished. I don't have any other changes in progress
in any case. 

I'm very conscious that reviewer bandwidth is limited and I'm very
interested in ideas for how to make the docs review process easier.

- Julia
