Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719414885B
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466903; cv=none; b=VO/RRZLNMGcZWCN2dtuWIwbv3R1CUElZmo59FnURhB1sYDh2U3cL0MUQFAIohz6gxX5dukTaRkkq++7+0yLZwYjt4CQe3HxXl6uvOjF3PFv91/JWll6M0QmkfNmYiISYNEveu/MRF3I8rBzKP21uSaGFvic3/7UzdQuWBWTCMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466903; c=relaxed/simple;
	bh=1azSbQKYCPejxeWaRXCBMOY17YmyOrHDmymbygycnEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cgM+oBarFfcjv1UG3JD/ayyEqmDv1BZ1VKf2lwlnkkKtWM76F7jeczlnoQOa4qSU6q0T3A854zW0UnVRdpyQqRw4ELDOue31gG8biq6Tf2jW8l0V6uK/+cT8sPf5LEazLDyVzSJCitaBEXl2JAJo92Us/g7+YC6e5g9SqJuZcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pukjk0d+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iK2nZgI/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pukjk0d+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iK2nZgI/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AD9A254017C;
	Tue, 17 Dec 2024 15:21:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 17 Dec 2024 15:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734466900; x=1734553300; bh=PPNzNHX332
	o5Wjf2r/rZ7BK4JMJQzoJ9NWDqTFGWeMs=; b=pukjk0d+Y5E0pC6U5vx5tcXmyR
	DcCHOtZw6maBUwCp6YgEjUGBCwfA/KnLzKTDJLTmt+vjqjmlwtI66cV4txACMyh2
	8KiB6Q+ZtT8YLafIH+OM+1bvrstjIHjKYKoqqr07mhl8Q9nosdYvR9uTUVrtDV9y
	na3L7rgUj4CRmq7W0mM7FJius+MlTaOCxd535qYASKDcmIK+b2fiFu4HG1tA11NV
	0GZNfTNq33Tr+vs4P3GUnCc7Byb4k37KsC/zfapGxm+5wn0xZbYPm/5rBSR0O7i5
	pDI5kRNC8mJANQvyBV6a7LZwzAykf7RjdFS9iq/5t2YmP9BZwWZaLwhfycAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734466900; x=1734553300; bh=PPNzNHX332o5Wjf2r/rZ7BK4JMJQzoJ9NWD
	qTFGWeMs=; b=iK2nZgI/7gV+iklZRdtrNI87++LlbShRT0l55Bx9PCfmjcZnunS
	vZNirIGD21yZYQo20K8bpUiITP7fqXR5W1rSIJMJGHyB7waYQ8a9DKAYexbhFj+d
	CdcdTpHtol81jLF48HUM5P7qBrrhSftNkPV+PQ40WH/8jo40y26yk0RLu1GYZ25T
	Gg9CU0GD00khWxnyTMP30x2ZPnIjX/jC9EkVWPYbbFNVTa7DaJ700BcXas5uNm66
	23p0xmg5Pm+/QpNp86qXv23neWVYd+aktxAbihMbB4aaTycFleKgNMvf2caYDOdf
	dIEu8fs2W1fMZT2d0HBOY3vb8PUudi5lPbQ==
X-ME-Sender: <xms:U91hZ4humDjE9VB3YBsoQ8izvbEB22UmnKD185h15ERlUqHkMwtCYA>
    <xme:U91hZxBciynhRFO10FhYB8tnMZ1P6I3E0eGC2b7g9BgYx3O1R8qjicTTypIpAF9dD
    6zEMXiXu9ebCCCulA>
X-ME-Received: <xmr:U91hZwHrLJvX750UnvR-D-eAYPZmC2QngKBhgkCL_wgDeMXo2CrVRvIi41AtMxsgddzYq3EiqXkmP3OGfD0nTfs7dlmNWRJELTC3qzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuoh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhouhhishifphhfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:U91hZ5RhEjXRtIiM7G-vjQCyFcU_Sm3RHHyBD0wehQ_vfnHkTrwh4Q>
    <xmx:VN1hZ1xIMqW7W0NaKWFBSX4wxmFmLOdSQZzfRqFFz0C5IE52ROnOYg>
    <xmx:VN1hZ34TIoGdnXLtjbYgrvpgPlAHzJ6-9-J1loM8kWRhOluhk8c4UQ>
    <xmx:VN1hZywSy0eIsGQTHvZSFmw_5GuQ-1fFMqnNm5ZUPJBxBYMew1x0sQ>
    <xmx:VN1hZ4pexMnSPNlnn9DaZRbakljrywaYuFGH3pcwIwZqbJaLOwC1vuL2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:21:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Wang Bing-hua via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Wang Bing-hua <louiswpf@gmail.com>
Subject: Re: [PATCH] remote: align --verbose output with spaces
In-Reply-To: <Z2F7VAsTjfBCVCrG@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 17 Dec 2024 21:23:32 +0800")
References: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
	<Z2F7VAsTjfBCVCrG@ArchLinux>
Date: Tue, 17 Dec 2024 12:21:37 -0800
Message-ID: <xmqqr066ysa6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Dec 17, 2024 at 12:39:36PM +0000, Wang Bing-hua via GitGitGadget wrote:
>> From: Wang Bing-hua <louiswpf@gmail.com>
>> 
>> Remote names exceeding a tab width could cause misalignment.

If all of them are named with ten ASCII characters, on a terminal
with fixed-width font, things will still display aligned ;-)

>> Align --verbose output with spaces instead of a tab.
>> 
>
> Good enhancement.

With a Devil's advocate hat on, a change like this will completely
break tools when they are reading the "--verbose" output and
expecting that the fields are separated with a TAB (in other words,
the tab is *not* about alignment in the first place for them).

Now with that hat off.

For users with that many remotes where the alignment of URLs in the
interactive "git remote -v" output matter, I am not sure if this
change is a real improvement enough that it is worth the possible
risk of breaking existing tools.  With that many remotes defined,
wouldn't they be doing "git remote -v" piped to "grep '^name<TAB>'"
or something?  That use case would break with the change, too.

Thanks.

