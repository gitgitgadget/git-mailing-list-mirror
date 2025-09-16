Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC932D5D7
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041960; cv=none; b=C31wFnzc/iB5WUi7Nk3ZiRXif11oNbHnMRIxmnwdZocGH7L6Vk9uQYBj8xOWYnD68uy20EDFbJu32IDmeZ/UnSIp2kgSjULQ5ts+kLui4Rjw0qn31pTizXh5oZBYZzMQs8oB8HIaL5g1/WvbpRuchgPbae7asiYlh58xCMgFwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041960; c=relaxed/simple;
	bh=XBcC/LSjxeeoJqkJNXjCo8a13SQmL1rVOBnKtoRvgbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuJxAy0DHIwjW9sTAWQml1U6NVMOdbO2nZ+XHBnhVQiiMx9yqp4GyDnWfJB14KJfJp9F0hFj7/u356Y5QVfzzPhzk8XCNYcfrGx+fz68blPytJkFqBdVikyPghIIiOJDM8MwaiuWxmrEFtyPVI2L6zi/ah+8Djy9R5DcSVWX/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tVZmKdUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cgqb/WJK; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tVZmKdUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cgqb/WJK"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D7FF14001B2;
	Tue, 16 Sep 2025 12:59:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 12:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758041958; x=1758128358; bh=NrY/IdrFee
	7nE8z/h1gqEsSmsVipoXW956GNi6vjeNU=; b=tVZmKdUI3ZgVbrEmGLw9sH8V0F
	ujAj3Hb/SVR2ilv+d8HSeyo3LCmk2rzlDUjMqdAuPWIvgvoY1SsK/yTWSD7+Zl2z
	BBpIGdzOmfGx+vXJPpTxMhcQxrKcxOf1ZgUInJIhF5kG/IaBPSc6lMfAqG+Z50++
	YFHEkoP5qaCYYB7uxO/0sBivjU36oLdlXuh0eV4eeyy9OzwqfQbGrZ5Nmpiux/K3
	QWmn/b7I/VlC+SMx19QwzMFvMg+6fvv0EBSJtsjBgDokyQ8sGAjfPS4Sb1o9AE3f
	F9qc3a8TTK5uSWxX/mkPD+Xjx6Rav2M/DE3wZ32iZZaEqfcOIvO9y+vnz54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758041958; x=1758128358; bh=NrY/IdrFee7nE8z/h1gqEsSmsVipoXW956G
	Ni6vjeNU=; b=Cgqb/WJKD9eODM11IVADjivP7Imiuh/ma9/YQQdtLU9eKFZUo6W
	nLs1tpHXE2HYpXf84rlBTx5jTbRcNFGDe++PJWoPI8yTd6xGqEFeVeGuZG5bLKyS
	v/HTEks9dyPm9JaZH195H6iIH4puYisNJ0mdZUT4zLCmn9AwnYWJswmKjmrzWs++
	M6m5ATSvqUEV7rmDxT8IJRUl8Q3zQOKcGuSxT7BiMxsG2WIajSXza1FzBPEefpbu
	v1RmAbkQFzj5sEhZ8gWMlf5qnuNYlyGQbissj75N9WhtOp21XBis5mUzpgjaERx3
	IWKd2JhsbNcn7Y78PKrBVZdZvfOI/2wOicQ==
X-ME-Sender: <xms:ZZfJaIWdVuPsX1jhjCHG1G-Rubf_4YGNtKHluYDBILdq8pvVGgvVYA>
    <xme:ZZfJaHKd7JffLAUfuRggiL-MkpwflwVely8K3WgLxaQfrLkgEED4ripMaZ42h_dO_
    IkSHF4dKMgsDekH5Q>
X-ME-Received: <xmr:ZZfJaI-Dax9nEcX9_UCdmW9Bjox_9-NeL7hIcBnbhy7e0d5Ua2xEVWZw1hUIJUz-HOhSrw1KalZSXSKkWrQpf1E7l6otS9I6Yo4Nzqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZZfJaKKzDvBwh18JWXsNNaafGTcstcdA7iIu_cSNJlyxCeR2eDvvgQ>
    <xmx:ZZfJaNlVlM9b0wQJaGRQZ7CviSs_PHcroQ-aybVEqZ6eLfeWsi2aqA>
    <xmx:ZZfJaOOWQIFFKPKHAXopdMK0-xS8MnMooDczy3GkQfVpgoY3tPrR5Q>
    <xmx:ZZfJaD0XgR6lSbsSo9Bi6kou_kuG7VfZ0deTA350NwaexATMMxYEHQ>
    <xmx:ZpfJaFF-imdtfc2pLUW9mQ-KmZgS20dHieOfD5io7pNxYQTAC_1CpMgX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:59:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] bundle-uri: ignore bundles without uri
In-Reply-To: <87bjnao1vd.fsf@iotcl.com> (Toon Claes's message of "Tue, 16 Sep
	2025 17:25:58 +0200")
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
	<20250912-b4-toon-bundle-uri-no-uri-v1-1-f4525a406df8@iotcl.com>
	<5hm6qdyn5ifs2kr33nwuc67qa3vdgis6w26rlvicrdzznzazzt@uytayxq5r25n>
	<xmqqbjnfmvwo.fsf@gitster.g> <87bjnao1vd.fsf@iotcl.com>
Date: Tue, 16 Sep 2025 09:59:15 -0700
Message-ID: <xmqq4it2nxjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I tend to agree.  Instead of papering over a misconfiguration, it
>> would be better to let the users know, so they have a chance to
>> report and/or correct such a misconfiguration.
>
> So are you okay if I do `return error("some message")` instead of
> `return -1`, or do you expect more of a change?

I am not sure what you are asking.  The comment was more about my
preference of honestly returning failure with explanation over
pretending success without actually doing anything, wasn't it?


