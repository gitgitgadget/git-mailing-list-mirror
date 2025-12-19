Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A52D7DE2
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149224; cv=none; b=cRyISA+RSYWywCY0qCe7kl9qvFE9uuQ24xdzYWInw4NEHrfOKG1dlyVx5NFSnaRIcWblwcLK2B7CSW8ygBvBUnmGRD0TjUWclobWXYCfZrqe2DPyxsMYSc7lBbYTdbRXAzTF4QlH86UwmBFTGgTijI4SDva/Lj9xytg7krBzarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149224; c=relaxed/simple;
	bh=53ZuZ9iLYnWEaADvrza6EB4ZWb9wqZTnd9V18j+N0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEr/XUif83i/lsrs1vTj8AnUx95YG0Vl9Odzhsytaei82uMMgEDK0U27rR5bXhD1NWduqRKna6VdMsR8WF/zz5A5bpJ88I7eRT4g+giIckTigHj/b070R2WZSbYJ9ZU0x19XD1bjVnDYONUCt+xM1vIpqqhXoGJRiR/kgh1BuPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y63CPQzk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJjUjGd4; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y63CPQzk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJjUjGd4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3267F14000CA;
	Fri, 19 Dec 2025 08:00:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 19 Dec 2025 08:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766149220; x=1766235620; bh=daKw9x0MX9
	YiOWgsLKSLevY2BA8lq5ldoSXG1+mGnA4=; b=Y63CPQzk8zIcv/zHhDk0t3jyo/
	V9bgJGHdDUaQ4NSdw6WYbmH78tmBDTfcDXtkEFrfOhKyrfyX6dfPHS2z0ZgVG6IW
	tl9V8vxWvEZQ+JVlmdEbBbfYP5OynLcDalvAGOR3w4cA/QEQYMMT6451FgerGu1R
	UcZrMl31hoYTVh8DHnpYxBeYgjDhOE/TEQTmjfjX3vj1x+F5ODNik1885urhcM09
	hrFf6MhYL/nM98LvM0MOvEY2a5FTDI7E6IJirawyjhRu3j2Degb3Bvw6tP/7iWht
	yXdZM3fBpPABLSdqgBTYScjiIsalcwQObwEjwekcdv9Ihlf6sXQN6YQCP1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766149220; x=1766235620; bh=daKw9x0MX9YiOWgsLKSLevY2BA8lq5ldoSX
	G1+mGnA4=; b=mJjUjGd4cf/AgICUvlUW9TZ0mJRLfs3SELDrZiluSOwATXQrlbh
	hQthlmcmkM4kXHg0p2R3PVfuqtSjmHaEqwWcWX0DejBOX1sZyQAZqkOPlRu2o44f
	Vk0JG/Gf3cZhWr6FIYJG8tdxCuhliYbhnmPKdOJMg+M4BqZfT4GEWiZbeqayi+8e
	y/4mcbdzgB7cFRAz/AIXZ2Ck0od20k7ha2a0eBYHw7Ep5q+vpEpF7Lph1Ml4BqQ1
	zjiyqdF5bPZr7jDyhTyxu1+7qIZ4GDfY0vtB6tj++hsQklMO1AjESK2duBhxzsWb
	enxS3/qhQXmiJT15Z8tATIhbHuuQYDtaI/A==
X-ME-Sender: <xms:Y0xFaeTzt2laFQijh29qCRqxz9dKEMinoIdUdUteOfqWlQyTCaNn9Q>
    <xme:Y0xFaW2xFgdn1Od9dwcrdrtrpKJjHxu4Lpey8EFRrFN-7JrB2kmngbFTor6Zorz_l
    37eBS6hiaS8uVLu2IA25XB6gWSCvhxyDm4o6UbAo9BKfyAhk0C8Tw>
X-ME-Received: <xmr:Y0xFaWdRq9qQ2MjM3uYa-ZUpH-XVMv4J2r739K3bsZkVrVXsTtxCVj0MmfHUiWT8oHfWN4VH0bm8RrFr7wVwq0AVNVt52W7hxsJ9w1CD0LIS3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohep
    jhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y0xFaWOqCjyLJ28PZd-kOSIDKkRnfx8-TmSEszVAz-BZp0KGxUP_qw>
    <xmx:Y0xFaSXno6YGIlJ7kyJT6gtvxN0-HWEPZzhGPORU5GSFysT0eaoNzw>
    <xmx:Y0xFaWy5AiSNtbGgC2BfEUTTM5M2S9wKgtFRJlTzweN5AdMB7doYAg>
    <xmx:Y0xFaR-9yugFve0F0NlEEFc71O-dT7OTpdE4EGU4LW8Q2eU1CMPGFw>
    <xmx:ZExFaQhH2yYbiHvNb-Hi-vGXXdIjyyKASesSFvHzRxqRHGUk1OyaGnR2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 08:00:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2bb6754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 13:00:16 +0000 (UTC)
Date: Fri, 19 Dec 2025 14:00:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 11/11] builtin/history: implement "split" subcommand
Message-ID: <aUVMXKT0sqiE8Qx2@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-11-407dd3f57ad3@pks.im>
 <a27fce64-0d4c-4280-93e5-00cce812d1b2@gmail.com>
 <aS81GAuKV79x_V2K@pks.im>
 <48ba9303-45f4-43bf-a257-10d58474096c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ba9303-45f4-43bf-a257-10d58474096c@gmail.com>

On Wed, Dec 10, 2025 at 09:51:33AM +0000, Phillip Wood wrote:
> On 02/12/2025 18:51, Patrick Steinhardt wrote:
> > On Fri, Nov 21, 2025 at 02:31:14PM +0000, Phillip Wood wrote:
> > > On 27/10/2025 11:33, Patrick Steinhardt wrote:
> > > > +	* Construct the first commit. This is done by taking the original
> > > > +	* commit parent's tree and selectively patching changes from the diff
> > > > +	* between that parent and its child.
> > > > +	*/
> > > > +	repo_git_path_replace(repo, &index_file, "%s", "history-split.index");
> > > > +
> > > > +	read_tree_cmd.git_cmd = 1;
> > > > +	strvec_pushf(&read_tree_cmd.env, "GIT_INDEX_FILE=%s", index_file.buf);
> > > > +	strvec_push(&read_tree_cmd.args, "read-tree");
> > > > +	strvec_push(&read_tree_cmd.args, oid_to_hex(&parent_tree_oid));
> > > > +	ret = run_command(&read_tree_cmd);
> > > 
> > > Why do we need to fork "read-tree" here rather than call unpack_trees()
> > > ourselves?
> > 
> > This is an artifact of how the `run_add_p()` interfaces work. They
> > unfortunately do not work on top of an in-memory index, but they work on
> > an on-disk index.
> 
> Oh I see, but why does that mean we need to fork a subprocess rather than
> writing the index to disc in this process?

Fair indeed. I guess it was laziness because other parts of Git did it
the same way. Anyway, let me change this now.

Patrick
