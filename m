Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AD6F06B
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715062881; cv=none; b=g657Q3AVtcq4oYnP5IMua6XsZB1JLO0b7lHAN1yPubbQM+uKcfqm6V2WdNaBfryW6alWSJraS9LUNrYk9nPyExofA7ptTKENE91t9a2PEkwwcNBYQ3ybXMs/wAFVxTTtTPXWl+39bxlPc4H+6MlK0DYQ0SeVLCL3iYHFwhzG5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715062881; c=relaxed/simple;
	bh=/b4e1gWWAfFd/0Q21FXBy6wHVmvu7vJBDg6g7IJVVSM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=J82Mu3jxziY1dbUjiqroh2Z9BsAGCBXW9RJxzNtDsuGMbn+1XBugDGXk7FMbNpj/5VwJYVfW5pzh0uxORYVarqRNw/dh5NcCrO06IpOLV2qWHHOuS35yq60Q8CUTuXIK42JloHcg+67bmduj49FLwfAGUv11bSztm7TuQ3l1S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=oOMPQghk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bfylZ0Ed; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="oOMPQghk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bfylZ0Ed"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id A2658180018E;
	Tue,  7 May 2024 02:21:17 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 07 May 2024 02:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1715062877; x=1715149277; bh=/b4e1gWWAfFd/0Q21FXBy6wHVmvu7vJB
	Dg6g7IJVVSM=; b=oOMPQghkvykCUtR72qoqELztm4jZH61yXR4l+RSMhTMC3JMl
	Sy0yCCDrEt/aBMdeKE/O5nnyeKEaEaxrPpZEEaNOm3ySyaug+S19lky1H9xLOahH
	BUKV2Ea+mRKtTx30OWlYGhad2PXdjaTl9LfplZESjbZZW846bIFzSfeW0IVEKMjh
	7K0IVY8bX+TRpwhSvTpXM6ajka/QQFI0iDhyExcxJGgVbf+ETUBxM+VNnxBDpESE
	YW1BuTV3UWmNPd1jh4fseorIf4I2wV5HhPciN2Y2rZzrrUy8TeFNpQ94xwCUHbdk
	xMEaUAFY4AYeDZ6SFiKbJxkI8Udbo7Qp1oo/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715062877; x=
	1715149277; bh=/b4e1gWWAfFd/0Q21FXBy6wHVmvu7vJBDg6g7IJVVSM=; b=b
	fylZ0EdoutAwhff9M3KAm7orRbJJTcuxs+Xp8nrJ+TjjCKvrES5Go46/0jKC8Aud
	bObw1+dUNuK8KYQE1wOMkAkatj9sADOYpoZsG4oguCBBIrIJ6BzD33eG53EybZ6H
	VFYuVsy9UXFS2RAG2kUd+v5lKbzAACXIQdtq1uUQ6jx90YRNZZLcAnnFzGp2kH6e
	Yh5LzrsEqoTbW2VnUexLZMfvMnqFiN+udEAsH5xXHFgzvsB6uzRIICuCOjZPKpfA
	ChzGdaMI1j5V5a1ZW76dfH2B1mZPc/gVoTjeKzEagpoliHHlgsGJulEg/tfgN96S
	P+q+pVlYoR4PkI/pel8xQ==
X-ME-Sender: <xms:XMg5Ztoc15T6O3_oMl8Af1GL3fXhHGYXDOMvFlOQzb_h05fqIffH3KA>
    <xme:XMg5ZvpAcZAMT6WUoeFSGQpYY4AjxlPc8WlWetqoqrMfmzYZ0T9xW8jJvbjim9Mga
    xSvgDb3HjG3pLJM3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:Xcg5ZqOeceqoibzaNIx6hzwl_xMDZ_BfwLRdxOce01rOsWyFO-xfYg>
    <xmx:Xcg5Zo5pDsSsmtVYQ51_QsIkBciAU2qwh6fn1tDwAW18BCwaEp-62g>
    <xmx:Xcg5Zs5JJBzHPKOconU0_m324CB8MRB6sHi-jkrjlCwaE0WwRsch_w>
    <xmx:Xcg5ZggdkcQJctAYq-pCYMs_auAr42RaSkhUMwuSEYplSdyCOR6CiQ>
    <xmx:Xcg5Zrb99LLV4LffrNEmvxPesRHC-S7McGtwikaXd5x5u5AlqqJZLzor>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D25C915A0092; Tue,  7 May 2024 02:21:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e364b795-7920-438c-a2e0-ed5940065623@app.fastmail.com>
In-Reply-To: <04d001da9fe3$e9c2eef0$bd48ccd0$@nexbridge.com>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
 <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com> <xmqqjzkaanr1.fsf@gitster.g>
 <ZjiL7vu5kCVwpsLd@tanuki> <xmqqttjazwwa.fsf@gitster.g>
 <04d001da9fe3$e9c2eef0$bd48ccd0$@nexbridge.com>
Date: Tue, 07 May 2024 08:20:56 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: rsbecker <rsbecker@nexbridge.com>
Cc: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org,
 "Taylor Blau" <me@ttaylorr.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024, at 20:33, rsbecker@nexbridge.com wrote:
> If you really want to get rid of stuff that has limited use instead of
> submodules, it is worktrees, the benefit of which is reduced given
> sparce checkouts and fetch depth.

Git-worktrees is very useful. One use-case is having a dedicated
worktree for an old version of the program/app that you need to work on
for whatever reason (using the same worktree for very different versions
can confuse build systems and IDEs). These things aren=E2=80=99t covered=
 by
those other supposed alternatives (which I never use because I don=E2=80=
=99t
work on big repositories).

Maybe the idea is to use a fetch depth of 1 on N clones instead of N
worktrees. But then you still have clones laying around in an ad hoc
manner compared to having on overview of all the worktrees that you are
using from one repository.

--=20
Kristoffer Haugsbakk

