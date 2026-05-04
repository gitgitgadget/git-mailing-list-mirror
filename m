Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD0B39B4AE
	for <git@vger.kernel.org>; Mon,  4 May 2026 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937123; cv=none; b=gE+76SjpCaKmXotwdF1Aa6AyGOouY3jiNVjWANY0ISuGeIY61SJ97PHZqbQ/E2pg0sGeBW070T9UC9DgW/ljHNOaNQyU7qZ7okWAP8i4PkLTIwvISwEDXQT3iZOOwllfyUDQIgPKp2+3RAsLSGtdfKWxfdnI8OYgxrKFHizsAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937123; c=relaxed/simple;
	bh=G60pxN/5VB2DGO1pfIZewmiOBx9kuyl3P0xYvEuBQTo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WYBX6AzzLf6NbWEzx+IGZBdC57swJ4AycjIJK7v8yGtwGQeGHZt47kiv5DpMPST8adv7SEspcoWKELoFedDN1+bq+nCWPAV/0+Lxs7hNp3VgGb/iua+4/twBgkmhFjHo9LUOg3oqD4OROQfb/XHzwVechdfH6CrI9jlilEKHuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WOdho7yM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARTI2iBR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WOdho7yM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARTI2iBR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 455E67A00B5;
	Mon,  4 May 2026 19:25:21 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Mon, 04 May 2026 19:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1777937121;
	 x=1778023521; bh=Ua4ItPFraWAy2l4zocWk5Jp5+teDZIRECqqm0Q7QUzI=; b=
	WOdho7yMiAqmFAtgWslYGMRv+Al/lPwldVSI7YifjrW6UoyWhc/HICYgAPa9C3Ou
	QO7ucMqSGV5XQ8uiZnrlQqRbDSBCPkADN9gG0B9HDxayXgvikp1ddUIsZUejwe/m
	V6aUf2y8Cb/cX+oYwf81G/fIWOGMMf55/+DZurKmsvIUG0IE/jy5buVflIy1NLnU
	3RMXHGV0sK0P55avFNNa9J5OYhOkno/lpeqFNrwXLrZE8fwLDFD480Kpf1eeEXPt
	Ahm6A8tMdH/TWU/h9nzct45rVL+YLYFMSKEiysNamKhx8m6FM0jFT5sWxVNwGNQ0
	S4/BdrCOOr15E9AUPDghaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777937121; x=
	1778023521; bh=Ua4ItPFraWAy2l4zocWk5Jp5+teDZIRECqqm0Q7QUzI=; b=A
	RTI2iBRLUntetQ68SwdXJjFfm7Oxw8MVpro0U4Ia5eaPU5UE9IHPB7hLD52UhGmR
	QBfrwOvMx6qK0Ro1KF6oBCmNOOMJCBHZbS+4ZlBHZCr0u+H3GFT0IVPmyLLDfWcf
	Df76Oui+0UKN6xqs0YEVJA/EzzBYT4Bt1WLDuOmbXITDZwejo9Zu6ZVF4gy8ImBW
	zQnlqTbU25dCYl5IYBfR/Mr6v5DXL5J/agPHYdsIP+EDvMftCsKYBxTJTub7Hw0p
	t4TfSXX8qyr7SPs945X5R97Mbwahs3NEWNsSMkmpOKp+PWRlzfrip641CmwUVJZy
	nDa8qyurDuK0xW3wrWtpg==
X-ME-Sender: <xms:4Sr5aRJaXCHwT9a8dTk20DnQ_9be1d0hRBrh2pmwJEiwrvNvXKjaAfw>
    <xme:4Sr5aX9ZZa3mEkcIu9Ucoh7EjWH1mpF_deTPEDqNuuul0kqHFCmjeWbbc1BSvjrIb
    69eIsHRoDgdTfq0m8TBXdVpXx8UTaPvWDencsjZzXY-x0YlKa6mAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4Sr5aVkrjbMgpHOsJ2G34BV5Ut_yBDgLtv4C4svBqYt4bc1JbhHc3A>
    <xmx:4Sr5aYnu41RLIp1TkN0YBlFQo_8iHSvYtZ5bxrADV6J_6X1jPYZ_Cg>
    <xmx:4Sr5aeshCQxAflj_JuaKovKMxJT_HWteo8-HS6yfl2l85Gd7Fukxzw>
    <xmx:4Sr5aTkUkm0QbGsbuESgH_UpEytEMXIm4unvJMqFqAQHa2FmpkQ2Hw>
    <xmx:4Sr5aUFNFKYlu5w0ICc2urU7f-1yjlRrYpScWjssiSviBs6l0zg8NBpG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E5C04C4006E; Mon,  4 May 2026 19:25:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANXxGyJ2AX0-
Date: Tue, 05 May 2026 01:25:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, gitgitgadget@gmail.com
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <2f809a63-3487-449a-a892-225d2b8122b6@app.fastmail.com>
In-Reply-To: 
 <e9f8d06a2bbab155b66e89c467aaeb2f37d808ed.1777919250.git.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
 <pull.2285.v2.git.git.1777919250.gitgitgadget@gmail.com>
 <e9f8d06a2bbab155b66e89c467aaeb2f37d808ed.1777919250.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/6] branch: add --forked <remote>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2026, at 20:27, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> List local branches whose configured upstream falls within any of
> the given <remote> arguments. <remote> may be either a configured
> remote name (matching all of its remote-tracking refs) or a single
> remote-tracking ref. Multiple <remote> arguments are unioned.
>
> This is the building block for --prune-merged, which deletes the
> listed branches.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

s/remote-tracking refs/remote-tracking branches/g

Here and below and on the other patches.

> ---
>  Documentation/git-branch.adoc |  12 ++++
>  builtin/branch.c              | 110 +++++++++++++++++++++++++++++++++-
>  t/t3200-branch.sh             |  54 +++++++++++++++++
>  3 files changed, 174 insertions(+), 2 deletions(-)
>[snip]
