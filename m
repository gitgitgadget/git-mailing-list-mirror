Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B11A294
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767060288; cv=none; b=R/MeDeFkboXGa/QnXBBWPmKMbBKPoXGUaY2TB671eSY1eS9OYPizIHdvNLT6ENWEMil34vyoKYbujS5JFmAzwLe8yYzXR9XSmmU9QHcU9E86DCylDxAWpAzWgKKY9UMKFTFjfxZMPxLISgvw7shEIcpL3WHBmmcw4n7HfsTTyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767060288; c=relaxed/simple;
	bh=Ov+l1x1xocsNWXWUXXkjniAmPuRyESSklRa+nk4gAQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fssVZNWYcJ2sly3AZihrk7HmZ52LBnVbGqA+86VHagpboD00HW60kKzKF+fVuwjWD0LNchuh6++8mDAjhgSNpb1x2B+ox5+dJIp5iVzSF0sopeE+5zJLg+zIwu1k/xmBSSt8imKnf+aHkiO9xn4MRFIzf+afxrN5A00iCBSoenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUyCQ8jJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aO0Q08Jn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUyCQ8jJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aO0Q08Jn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB54A7A00DD;
	Mon, 29 Dec 2025 21:04:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 29 Dec 2025 21:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767060284; x=1767146684; bh=ovo2OOPF4H
	btJ/xMMzOzixx9AQUOFqxSu3OcQqQr0+8=; b=KUyCQ8jJjQrKgPzIL/pJ9g/by1
	ZfP2xt07LS1aPK+ySUdEQv4fytuW8YH+kNMBiJdQxdqqEIMhbMll4YYTxFG0lvR9
	3RJeG+gpZ8dRGPFH9oJVu1IHWGAlz3SPPNVgA3ZLrLIXQjnwihwoH678IesEiMRz
	U6gF9I43n7rx6j++2PFdDwCKePcj/nYZaK+1HcEUwkCbdTvN8ic5FDoGSdvdQ/S5
	DprrAOwtenjI1I88yOsWZa0szJHuAJAO6kDG9U1ScjaCHJMJlWpjv/4kbApDxOmo
	75iLyOPjTi0qNBPyWGlGmURDTAwGiw66jSs64MKKctd9th+PtCRiH0A1GdeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767060284; x=1767146684; bh=ovo2OOPF4HbtJ/xMMzOzixx9AQUOFqxSu3O
	cQqQr0+8=; b=aO0Q08Jn4foUCyqbeGJZpJaW9Moo6tEa+xcq1FVSpd3IDaO7ayg
	/T0whskiLNMHZ/71s7vZnkELNn4zdN/6Fg6PT50n9SUgd9+kIgQhRJOAYo/+ijyK
	OzZlVIhsT6wSHArVQjcHQjL2f8H/W62n0g1Ym4Pnj0rH7Oec39BuP3U0njXOk4Zp
	G7vr/rbyh37odFhpoG2AK6hDPaqM3PkleFUkA8suoBmK3wOzcbulMJu1X4uMDDA/
	NdlzEkLXQkgPvUgfExip9vIfrahS3Kem+xXtxFzRyTOJzgLnCWTYT/TgJ0w8wl0h
	Mre7NESo3pcah2nRC3SujTPZ9O/jRtD2DFA==
X-ME-Sender: <xms:PDNTaeE_sqRGff_FY5zpMLk7eoRV40TThoDRwfV0-xgNW3ScczydnA>
    <xme:PDNTaWxQh_hjUr3ZZRyPOF1URtBKk8BKgfQtmcm1JJNWV2uYM1vuugJD4goFdE92v
    08jbQEIr9GGPLcFcp1B8gPJlw8_NL08tS4Zn5LiIIdLHRSoxN0SYA>
X-ME-Received: <xmr:PDNTaVhO7GOv0Fef-NjDltkx9gbRRXPKsZrpBZo2aGyadc_dup8KQOtsfzQvG1tYWKU7JdI3-fDip23dGP87o5S5i1P8OzppaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghoiiho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PDNTaRzv6ktcbltFxk-eaFBS9A8NUNqK34oi7yen0xwSniZzyYt8gQ>
    <xmx:PDNTaYJyDIZs4bttHkS7jX3xxafqZfxQG2clJ3mwiSBAUabJ86BHJA>
    <xmx:PDNTaYQOl5jg-VLmMhny8JBu1i_JerTLtca-fcd9rSnl2iQNReACjQ>
    <xmx:PDNTaQrQ3vaXWe4UkrnbhxAus3yrvilakMpTMw8DcNHgzwydILpgUA>
    <xmx:PDNTaaw56RJAjYHanXfgdANxFdmxCSn8ivKhi0_fa61uKcsfa1W7c5Zn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 21:04:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: How Does "git log --reverse" Work?
In-Reply-To: <16fc8ecb-01f7-4056-be58-e3aa20345f77@gmail.com> (Jon Forrest's
	message of "Mon, 29 Dec 2025 16:18:55 -0800")
References: <16fc8ecb-01f7-4056-be58-e3aa20345f77@gmail.com>
Date: Tue, 30 Dec 2025 11:04:42 +0900
Message-ID: <xmqqy0mkhghx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Forrest <nobozo@gmail.com> writes:

> I've looked at the code but it's not well commented.
> Does the answer have something to do with commit lists?

What revision.c:get_revision() does should be fairly obvious.

When the .reverse option is in effect, it grabs all the commits it
needs to show (with the usual traversal, as if .reverse were not in
effect, by calling get_revision_internal()), queues it in the
.commits list, goes into the reverse output stage, where we output
what we queued earlier.  After that, we yield commits from that
queue.
