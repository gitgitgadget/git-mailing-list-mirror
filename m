Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE1EC0
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595546; cv=none; b=nCpq8PDtooktXwgy8GciLlBONp7eSNz0sLk2MfquUcQEwsq5cjNoGeOJUrRbTEJ4PUaZYF5sodmLlHPF/wlMybnLABmka2EC7mYocpcFHZl3F0iVVPe0kh6XWUFLu6GrssXlm/TxMktDnnnKIHyUL+fVXSueBazIv1an4nnNch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595546; c=relaxed/simple;
	bh=WWBAoORPd+h+hgortM82YfEApOvg2odb21MPgST9FBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+Jc+Oo5kV6BxpuwWQEubFpJr56Rqc5qGov2cj4kSUBVy2kAkbI25wTyCBlFO4jUd73I6pZ0IWXC2760ivw4LkM0pU4PRMfAH1nVveBSozlgAjPrGPJSuCixLYi3L82jv8/2m28TtTXmyVCKYIVazzikSVgTu76MW0Ow2GPLcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbP9Tfoq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbP9Tfoq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BDC8114013B;
	Mon, 25 Nov 2024 23:32:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 25 Nov 2024 23:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732595542; x=
	1732681942; bh=qH1Cudu/QjS2QnmyUt/RFD0F9fzPokbBNPQmwNggULQ=; b=V
	bP9Tfoqel6O3yK3aXsH4oHzVq68jt2PC7ohMyA3e/OknmqJb67t/1FZULRunmpif
	mEi7dNmAD/8v2mEfDARsWQFlOovCqH5MrWRDMU98akFr59WHUlHrWtLwC3oIB9SG
	QHP75W69N7JLIAKIGfabzKhKfJPTDIQYK6ki3xyX9rzoI6dRgZiEkpyFzcTdzqWQ
	tT7qmRs8ocIh2m967CyzlR0/tmvrHKpqUxIhYQkP/1V0Jq6DxZYDGMY/fkuOG0RP
	qvrzuh1qaiUIs7mby53VjFELdavnvA8fBton5MvDtZJaCvFhEib4unK7XokOzdu6
	B++jSu6l9tBA8sunNHP5A==
X-ME-Sender: <xms:Vk9FZ-zmnnpFDH1WoaXcfKkCfd7NIaH7yH_RgUDIXY1W2Y2uRaDdAw>
    <xme:Vk9FZ6R2pso13Gw5EVoi42afhbr7h_roegH8TkLfKTcL_GoMlrOOdm2OuBaAykJTB
    TrVT0nd7V4MeTNjaA>
X-ME-Received: <xmr:Vk9FZwU0CGbR6-vQIgeNI14ghjQn8Z1Up3szZoy-wToEm21xPCOn2_i41IjBhr7CpsoJrJuFyez0ZQMLzuoQfefDEumQh-LR_yl-ZjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfekfeeh
    iefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Vk9FZ0gQul9gd0kvEIoIUpVd6hK0pJb8v2riAA0AGSL96YdZmBEVlQ>
    <xmx:Vk9FZwBjfZvFHRoTZ02Z53CPYOC7WqpBNJeJfe4MmIgeWk5OONPlRw>
    <xmx:Vk9FZ1LDO6DoS8MCLJ3zdSNdw06oV9gDuob6dGiyX1k0VsbopQLQRg>
    <xmx:Vk9FZ3BnI4mTYXnzwY86wN315Xi20S2mktfaUDfoEPJwvgWjIjKsEQ>
    <xmx:Vk9FZy3fgy6wSEOsySywuS4FucPJVBP93mdCYRo4uOOqsSjUWC9oK2IT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 23:32:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/5] doc: git diff reformatting
In-Reply-To: <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Mon, 18 Nov 2024 22:05:48
	+0000")
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
	<pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
Date: Tue, 26 Nov 2024 13:32:20 +0900
Message-ID: <xmqqv7wa1up7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is the continuation of the editing of the manpages to reflect the new
> formatting rules.
>
> Changes since V3:
>
>  * rework the description about -1, --base,...
>

This latest round did not see any feedback, but I re-read the
changes again, and did not find anything suspicious.  So unless
there are things I missed that others point out quickly, let's
merge this down to 'next'.

Thanks.
