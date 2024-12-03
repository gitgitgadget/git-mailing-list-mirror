Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351F4847C
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189010; cv=none; b=VbwqT6MSE8bE021yOeXFvApQ8skMR1dRXisyEjW2yQTNte8Sog5oBl8Y/3HaPughaX8ZTNR1pnaFB9FeBJopZ1luKrwycn9oPVU0WYwtLYmL7AbZD9Xi8jLvfdtBv/HxI7J6gBNECzfL3TzDi1wmd+2r29xDzYQHsqBXH8JZUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189010; c=relaxed/simple;
	bh=n4EZxYO69Fq3kr3Zin1H5HmWKYUcuwLupFGvUCdEDAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWtMKlZnPxjZ0H03s575/MLdQ0jNwa+tCyr8V2vgjwt7eJaGVRmsneaU6o9i9qz2w2FgGmKsBOPCHvDorbMkMWtsHC3wv98vzrGSb/ih4MDQim+n4V4mwggxnbKSR1fDXRbtO4berQOpfaFlTz1RFJJtFVPi5TrIgvPzjuR6fBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bvnsekQS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bvnsekQS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B66A1140081;
	Mon,  2 Dec 2024 20:23:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 20:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733189006; x=1733275406; bh=WWwMkHBDowKajslbPBPw7vZNo7EWSW5o9Js
	AGNjtrqs=; b=bvnsekQSAaMy4qagQgSADKlH4d919YlYwrs6PbVAWoMan1bZFfz
	Fh6+piVrC7ZJtulaUNQ4jMEOzSk/G0wmMyBxbrS75DBpAFTL6E9UxW2X+/V5Agbr
	E54qgXLjSpLOt2Umifjqp/3u+1Dd4Ljw4FGmswdilghWZffxjsUa18bNa26oVT5x
	uyn6XQy8m3Po27Xan/pfo2pBIRcCAojQiKdEe1qJhpeJaDY1yrYy/sgv0AUbcXFp
	Lvr2PuILnHx0E4BolGZ/epL7ZW3B6in2YGn8UitMHBT1Yk+RK32vXFfS2R+SpNnH
	2/WjbhA6N9hJJ5PmaCLQhTCBYVj3sbmE4Vg==
X-ME-Sender: <xms:jl1OZ59FmFs_Q4HHDhUWbB08kmCCNqKkpfDh2rzcUOOBR48KZOH_EA>
    <xme:jl1OZ9ua7CaQzOpkSeMnx-APAwvkfN83ukmsAofIwgM8gHZEYF1G0EJlwSuq-TcDa
    -nie9ySmTdXn3ICig>
X-ME-Received: <xmr:jl1OZ3AJI8kpn9QP-FltHSwmLYko55P86Gq1DyDtB2lYDretctuGigDv3d-_F-ZHpBXyWcllV3D5NuxGxYCx_WcPlr5DUmr1IzKJJ1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesjhhofihilhdruggvpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jl1OZ9cQiTalw1XU5t0nW7xZTH4tnju77cg98MrQfD2A3FKnafbtrQ>
    <xmx:jl1OZ-MZ9ZEHwDmCS7H2JsT-7QzRDNGwiWbrsJ2w3qLGTFTrQybd1Q>
    <xmx:jl1OZ_mTyJL21iALmWyS9lXwSjWAh-nO24yYUzfMhcWShMsIVMHu1A>
    <xmx:jl1OZ4tIgn5i-I4MOMJN_-_QtdgeYK7mz4eVNf2KsSZInYqR2l3HSw>
    <xmx:jl1OZ7o94l9eR4r_iIHd68kwMFx5QAR_68RRfdoXyeVmurWS9l9QKrlX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 20:23:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  git@jowil.de
Subject: Re: [PATCH 1/4] refs: move ref name helpers around
In-Reply-To: <20241202203743.GB776185@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 2 Dec 2024 15:37:43 -0500")
References: <20241202070714.3028549-1-gitster@pobox.com>
	<20241202070714.3028549-2-gitster@pobox.com>
	<20241202203743.GB776185@coredump.intra.peff.net>
Date: Tue, 03 Dec 2024 10:23:25 +0900
Message-ID: <xmqqbjxth84y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Dec 02, 2024 at 04:07:11PM +0900, Junio C Hamano wrote:
>
>> strbuf_branchname(), strbuf_check_{branch,tag}_ref() are helper
>> functions to deal with branch and tag names, and the fact that they
>> happen to use strbuf to hold the name of a branch or a tag is not
>> essential.  These functions fit better in the refs API than strbuf
>> API, the latter of which is about string manipulations.
>
> Wow, they are declared in strbuf.h but not even implemented there. So it
> was doubly confusing. This looks like a nice cleanup.

Yup.  Another home that may want to adopt them is the object-name
API, but I think refs API is good enough, and certainly better than
strbuf.
