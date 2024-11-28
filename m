Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32DC134BD
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 05:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772842; cv=none; b=M2+RmnXmZQbit5RZTcXls9b9CQ47I8cCcra9Pn6q23EKSJfrjhZ4AJoP86jGJZsKHgVV4qBTUbX/FIU6rQW0TvVz+pjfySelYznrm7/Y+u8oMTkOo2/YimEQYVC+hnBLpY4oS95gi9PMWe4TwNnpfMwvK561SwJLYJmumfuXO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772842; c=relaxed/simple;
	bh=r5MRx7/aMq1rkl93Oy0OpFC064xKCNeDBEUim9r7KXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qzeD/HlOjiIE3YVEvqLENhipQCUfy8X3Om+MmB5Mq1FWXwLDlAk3VUkRB6kRWfNIByJnP7LzoEYnHrShoP6x7z2m+LIZtv4/Z45wWTY9X6SGpm5d3hZ7LFegNeCsOdituo4ASjGZHaT60hMDOLNGZXXNFNwAyyQ5jD6jcI4kdFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+NJbSyg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+NJbSyg"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89AB325401A2;
	Thu, 28 Nov 2024 00:47:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 28 Nov 2024 00:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732772837; x=1732859237; bh=2eJdZqMcqZYq8qnq+D9MVdKsgpeSgSomYee
	/UHxvGfI=; b=U+NJbSygErc95jYF1tkSWdj904A/R1oV8gJ/hc8c9jxUF/LYRXp
	Ih2zOxtq0qxNlOjZbRqepu8GhNGL6Y3PGo4nYe1Vrf3iHFqP7xWlqGZ3HBVYuGEn
	k8W/kxybFSEsKzKbtETaG8VySWItXxxnv/U0XV0GgPb5brAUXk+tiMN+ZvMG+uy/
	HTHrq/4k2ePNyzmzgb9RUVIRHMJ/cLj7Jj+cNrOHEcXMVFclI3VayW3zdOs22pmY
	VuMx5qAtfjUZrhu9N0756qVMny+lnWf3+cIIfae08a2EpvvELtNDq2N4wSMB2DcI
	zVnjwi28CJScPdSSR18mrGXmXYaRtyL9psw==
X-ME-Sender: <xms:5ANIZ4QtrS92rx0efMvzSQJIVjSo7jUqr8lc9HG4dNYnMKa19hVTAg>
    <xme:5ANIZ1wVR5mjaZ3jqZAVYh4getIqV1iJx49eIo-BACet-4JG1L71NdnCExttNeK7U
    wgeuOIVzpjvLzlgQg>
X-ME-Received: <xmr:5ANIZ10YpZB9kiWyh1ISDA4Il7hc9w19GXeDNL-F3S7NvURkUOs7FLwdNIVR9nXDYt0jxb0EbtbT9JEQSZ-ApPH_uP_3KybJZKeQTu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5ANIZ8BZzkqq5ySoSVQWiYd3CoEL-F0JEirs3RPtgqaVyHwD8sCwZw>
    <xmx:5ANIZxh7wreQWPdg18Hk-gSjpzed9NBabw13ToAwItm8qu1h_Ui5mQ>
    <xmx:5ANIZ4qVbMNar2d-4JaHI4utf5fB1AuKAFdA7PC1DVHMMoyFXv1OsQ>
    <xmx:5ANIZ0g5a70vXu2eG_-wYcSUnW0P7JK1D2XlmVrMEjgxTyQqN0yoBA>
    <xmx:5QNIZyXS7iXkcPdWxEljjAYvZI_tteIRo1lvKmgNZ00v4pzEEDDuXTtk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:47:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <20240910163000.1985723-4-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 10 Sep 2024 18:29:59 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<20240910163000.1985723-4-christian.couder@gmail.com>
Date: Thu, 28 Nov 2024 14:47:14 +0900
Message-ID: <xmqqserboqot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I was looking at test breakages caused by this topic (in 'seen',
t5710 fails leak checking).

Then I noticed something strange.  Next to the "$(TRASH_DIRECTORY)",
running this script leaves a few garbage files under the "t/"
directory.

I think the culprit is this helper function.

> +initialize_server () {
> +	# Repack everything first
> +	git -C server -c repack.writebitmaps=false repack -a -d &&
> +
> +	# Remove promisor file in case they exist, useful when reinitializing
> +	rm -rf server/objects/pack/*.promisor &&
> +
> +	# Repack without the largest object and create a promisor pack on server
> +	git -C server -c repack.writebitmaps=false repack -a -d \
> +	    --filter=blob:limit=5k --filter-to="$(pwd)" &&

This --filter-to="$(pwd)" expands to $(TRASH_DIRECTORY), which is
"..../t/trash-directory.t5710-promisor-remote-capability".  I think
that is the cause for two extra trash files that are _OUTSIDE_ the
trash directory, which is an absolute no-no for tests to be safely
runnable.  Next to the trash directory, this ends up creating three
files

trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.idx
trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.pack
trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.rev

> +	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
> +	touch "$promisor_file" &&

Style: don't "touch" a single file to create it.  Instead >redirect_into_it.


The first failure in leak check seems to be

not ok 5 - fetch with promisor.advertise set to 'false'
#
#               git -C server config promisor.advertise false &&
#
#               # Clone from server to create a client
#               GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
#                       -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
#                       -c remote.server2.url="file://$(pwd)/server2" \
#                       -c promisor.acceptfromserver=All \
#                       --no-local --filter="blob:limit=5k" server client &&
#               test_when_finished "rm -rf client" &&
#
#               # Check that the largest object is not missing on the server
#               check_missing_objects server 0 "" &&
#
#               # Reinitialize server so that the largest object is missing again
#               initialize_server

but I didn't dig further.  Can you take a look?  I'll eject the
topic from 'seen' in the meantime to unblock the CI.

Thanks.
