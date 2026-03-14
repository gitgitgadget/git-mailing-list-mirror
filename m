Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9D2253FC
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773447729; cv=none; b=Is4nQekRjjYT9hpbyk6Tbh2nP+RP0jRA24Y7QWbym7nPK6Pr7o7MPl306gKFPdLWlJjgcfEhsTzBcaKltoj7bdUCVY8nmBKvCOIHAXNvbx9SM5yfDV1dZPP1eJFIgGdQuo+sYYM8cLo0/Xbrjue3e6DsOaSw5Ap773H81pdnd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773447729; c=relaxed/simple;
	bh=H/AlD3uj2GT1EMjJYwBmLOf5U0KOQfBatBwa8KCrcBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XEWmfn1MunD4/dTHOC8H3p0fVjce2NnpOz41A0Dt3qA9HYcfMAz4W9ERWU+uvfiBKryyABPplbopaGacCXzjG+3ddVL+0Ev2/uLgdJW0Z3T1ntJ0EuCO9HqestGl206/5GrdsIiCgB7IDng6xxQoaUy/vi7JSwH75eR6eS2QwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LEp413Fq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oRuwQ0Y9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LEp413Fq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oRuwQ0Y9"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B69E31D00136;
	Fri, 13 Mar 2026 20:22:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 20:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773447726; x=1773534126; bh=ZH64APEusK
	gkZPLGn4yWC+Xz1hZMG6xZeETZkq/cCl4=; b=LEp413FqIb1QLHXb5ycOBV5Vhe
	oOCLl8qOtXYK14JbRl+9Eug/EgC4IuNSUobx6heeFjBx+XEpgqlAoXRrlIaQc2+c
	xZraLCmokkOD9IeaxkQlnnJQhlJoPu/yoOsDtQDaJ/Z+2bcCIN2F0vEwoyzmyd5/
	/9ZbE2i1r9TtbBfC6CdpjqXyrz2nfXIhYHhwtappjgls3I8M97SqoOZyfMNExSPr
	Lf6f9mqwRC23VLPeEU2qqDjRYSfB2WvL4Y+5uB+8+R4J5ZZujH2jxSpV6b5KBWdF
	OYKdEQLTfHbBOlfFxZoNV/iFAVxJZ/sssxVDiE9JB6cCA+0YXQtluRKZrRVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773447726; x=1773534126; bh=ZH64APEusKgkZPLGn4yWC+Xz1hZMG6xZeET
	Zkq/cCl4=; b=oRuwQ0Y97XBS0LhFcIkpxnn8t+/A/fuBKdGbQ9Bgx/E6zEP2poa
	rz4bVuy8UA9GwCkM3W5FeDWSD0nRhHNJ0wdQBwv4faF3KgQf+tBGNplBpTQsxyzY
	+PHQxKyYS5lkQPa95bEWLvReDDZtOjo4/Q4a4d8BGNyqMHeJNJpwSYLO93dQW5gH
	R2P/N/xldQlMmqo2jUhVD68fYg4bfSMnepKMoCYs07ubnTSeFFPz2IC07AiXneZE
	AT6JTnlsRqiXneOdyDwCsynFSxAe9yJH0dCePZfwEGVG/Qn/yGFhGZQlRAdpTAwx
	NO7p6Yp1mJALw8xshHxWjj2aQfTxvJ09Z1Q==
X-ME-Sender: <xms:Lqq0aYTrsRNM78BGq3awpdIq66JiYRpQgOSzgTWLN8cUqSLweFY8AQ>
    <xme:Lqq0acyfODVFbqwVJ1mvpCKXPpkAxcFaxINI0jH2Gs5fFogED93mVh8HZBvO-h2hD
    zfQqqCIIBDZQAPjCShgWjSpdxddzKwK5NF8dcq2muZXKPfjsca085g>
X-ME-Received: <xmr:Lqq0aa1fpy5iloH7pNrpUbj7EF1wHJ48h4Kd-V_clZGAXTeo1MMZpFQ6Tgs8eohYdPVS2EvJ1zsCe2T_wt6hp_wF82k8_e7Xfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleduuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:Lqq0aa441U9t_SjGU9SI8w988rOmgUdR3pl5aPNUNadNhBNwNfI4rw>
    <xmx:Lqq0adWrXmDdS3vWcZdG3TRFhJgM2wfDWaQeZybBJ2X0QoGXTKW9AA>
    <xmx:Lqq0aZDVooNiEfpYuqdFXu_jRA0bVk9r9PzoUsPQ80mO1cmpF_XvMA>
    <xmx:Lqq0ac5h36Bb75oJHNNhZ5hzjqeMv8YIi6oVisfcIpx3DSRTq4Jvfg>
    <xmx:Lqq0aZcu10giFwVPXxmXAqrTQyG_BsGNlaYrenKhLXrEg8WOoboVnMJp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 20:22:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 1/2] name-rev: wrap both blocks in braces
In-Reply-To: <name-rev_braces.4ae@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 13 Mar 2026
	17:03:37 +0100")
References: <CV_name-rev_--format.4ad@msgid.xyz>
	<name-rev_braces.4ae@msgid.xyz>
Date: Fri, 13 Mar 2026 17:22:04 -0700
Message-ID: <xmqqeclnz2dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> -		else if (++counter == hexsz &&
> -			 !ishex(*(p+1))) {
> +		} else if (++counter == hexsz &&
> +			   !ishex(*(p + 1))) {
>  			struct object_id oid;
>  			const char *name = NULL;
>  			char c = *(p+1);

You are correcting "p+1" to "p + 1" to honor our coding style in a
few lines above "while at it", but there are three others in the
same block (we can see one of them in the post-context), which means
these are now inconsistent.  Fixing all of them would make it a far
larger change than qualifies as a "while at it" change.  Either make
it another step that is an unrelated clean up, or leave it as-is.

The primary thrust of this patch does make sense and is executed
well.

Thanks.
