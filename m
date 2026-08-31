Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5783BBFBB
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158707; cv=none; b=gMEyA0CVs4BfsihkGO8h+bGJFDOv2DC9dZ+k0Rk7kEJ1LYnzwlqByxgIuHjeZewpBgB4nSAv/XoC5pNZsJUxOlJTzyv4yMw9jF75tZeCQMLEGPLpLxHkyTI850Dwb8pf68qiJgjh4P76R6K7fUZ8GbTbHKOyu8WOhibhC832lDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158707; c=relaxed/simple;
	bh=/8b0RApSzDKiy8fPlbCTSZHTycyLsYe7DUeE7i4wec8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDwkiPH7FOuTPNsjG/Rk5ouATJp8X3GumUNA2r8VdXEOAm1zewSiF0jB+r/4cGH7MPgsdpskujHdM3SVGX2gFg35mInDlc5Ib1NLN16M6JbJdJDeJ3vzuczNEvEijb441pwxX3Mp3Yw/dpb1m2zZPU+R3PmBiHMXuZp4rpdPBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HwgoLTLg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NU89t9sJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HwgoLTLg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NU89t9sJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D3DE7A013D;
	Mon, 31 Aug 2026 02:45:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 02:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788158705; x=1788245105; bh=gi7f2ANoxe
	l2kBs8qOneU9Ax7LRLuVAGccoHzc7nFlA=; b=HwgoLTLgq96B/A7uBWZ/3qcwCp
	VUIhsN1C5S9yWIRgDTmJh0k5mPM0PprBtoLGoaE+9jdiPzGCKlKPIkvy0XNx881g
	jOk6/UEFYf9Ia6K9f0Y62vvY3ePh7VZLyCG0XcCjE5wxOqY40gQoMClgtqVrAGZD
	l4BuHw2dWIlGbYye2gnj5maCZuucCW+TZ3o5O/WpsP8Rzdt9i73Oa422POB0Ftgo
	KfSsbvDhvTGq53uqZUp4ROK3Emvq00quYlHLxoFVlfw8EqdmamE4WwLx6+YEhGU2
	RE68RoGJvXC3gVfE+mGU39MK8u41qMT/pDN0uFqYioLVvhPrhVWamTgHDdFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788158705; x=1788245105; bh=gi7f2ANoxel2kBs8qOneU9Ax7LRLuVAGcco
	Hzc7nFlA=; b=NU89t9sJNi2wt/Red7t/mB0/6Z4f1eSK2/g22LlXxyj0eRBTIWW
	KlQlpHGXKjDE6IbR75Ib0041IAFIaI5Grk6gp80mIgslgFY+ChUktAten63PEd9C
	V2cq8jhz7Hxo1HKwGvNEMD4Rsvs1EbI+qPsasqYjf5m3y/WY9FD+J0Z6gFjznuca
	9nbB4vQYLPE3F0FtATQeSqphJXkZFLanzPtCmUlsqcOmUqB4k1cOeIzSRmOfdsTX
	YQVYn6lZCPOMygWK6u8/Mvk4xyByHq4linaABQFHA2KbzUqrkbgkwuAFfj8uv/xX
	rCOcmErizhoBqenmxofAsjoGbyUEBLI+nkA==
X-ME-Sender: <xms:8CKVaojqVHIr3WSFgpzHPdOFs8F8vmcw-byiQwLD_LXOqB17_d9wGw>
    <xme:8CKVaqV7KwJ5gS21nEO23Uwy7oroKImErvIoq8_bbQwlGNsL1O11r_t1dYEV3gGOI
    HhZfqAUbd8NbP33IM9vmB7eDC2TY-_O6N44BjWyeUbyBm1Q6D950A>
X-ME-Received: <xmr:8CKVanWyK3Ypmn0NjG3V1A3spd5PhyoE8n3mPVoTZnEDT91o7I9FmZkNgktpxNNw3RdUWA>
X-ME-Proxy-Cause: dmFkZTGRMJIBfY/+ObDXyo7W//g4WVS5enPXXIGAPKdBdxeF3CbfSrEF2us7bf6hKsvnIx
    9S2eunt7XU5tUDBojUSpDVWZvpEC4NbZ/sNe7omwiyk1010vDUkESgVcmx9LoFHDKdzXYv
    qflvvL/lxHbWTuX8AVQs9oFNOzriSzQiaI4xU789Bgutz9vT//WzZbvuA8PEf0sU59pWF8
    1L/DTNxsuqmsTBetkA+sulNum9p7Cuhm5LRVsm+UfsDxdXbrzF8Hpn5n7D42rscY2OcMAf
    ZQg4Wkw3dyBztwf1uFka6vS6e3UDjaPPUSu7zLXgo17PfVNIr2JF4a0dbwHpXwm1hZLzLj
    LUCqq9DMgSHDocauMFRGEAv3HYhGB70yS7FGT9gpAD4/lx8oK7DM6kJD3bgXK1xv+5QQIe
    Iy8G49JrWlfLVj/oMD6M/gfmZTt1W0p1nyRkA4blLHlsGeyVdozdZED5z0OhkdG0HliFI0
    kAaIUjqfYHtfGkStGxlQSFbrox18bmGA8FyUjhUbU+D9DrCzy9brLkFmoHyAmDkYAuhowR
    6CBL6c6cm6YQhpwp1nZhRkXtEWZz445LwcYLqPNrGVHY4zYbYTCvRqA5ArTL/Yz/vSng2x
    dQQ8nFk2DT6TSW3pwlgqF6rLoylnl7otQ79h853nhE9gyYvstwytjRxGV9Vg
X-ME-Proxy: <xmx:8CKVaqg4_Bt7aetG6IAkp5DoOHgSZFV1hlvwW4dwvvqlL3O_NN5uQw>
    <xmx:8CKVaiaGM36MYIIed211S22KDl5Z-tjFOgAy44-4q0sUs5RQRGExDQ>
    <xmx:8CKVanpGTKRGEqtORtGyvL04lXgM6sPE8A-E6uMif0EaY703SbCEVg>
    <xmx:8CKVavN5hyvXOGaEbi0RPvUjtwfuNkZKaxAKLDyGZLdvWbIttAEKAA>
    <xmx:8SKVarqF7VJxdF0J5sMenuTH8Drh9BCEGlWDH4TAVpXMES5TCMJ2umIh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:45:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a23cf690 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:45:06 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:44:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 1/3] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Message-ID: <apUi5iUeNUkqVa1L@pks.im>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
 <20260826-758-introduce-hook-v4-1-6b14975ad957@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826-758-introduce-hook-v4-1-6b14975ad957@gmail.com>

On Wed, Aug 26, 2026 at 12:19:37PM +0200, Karthik Nayak wrote:
> The 'Documentation/git-receive-pack.adoc' contains documentation about
> hooks which lie in the lifecycle of 'git-receive-pack(1)'. Unfortunately
> it is missing information about the 'proc-receive' hook. Add it.

I think this reads a tiny bit awkward. How about the following instead:

  The manpage of git-receive-pack(1) documents hooks invoked when
  receiving a push. The manpage doe snot mention the 'proc-receive' hook
  though, which is also invoked as part of that process. Add a paragraph
  about this hook to plug that gap.

> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
> index 0956086d61..4349487e6a 100644
> --- a/Documentation/git-receive-pack.adoc
> +++ b/Documentation/git-receive-pack.adoc
> @@ -236,6 +236,12 @@ if the repository is packed and is served via a dumb transport.
>  exec git update-server-info
>  ----
>  
> +PROC-RECEIVE HOOK
> +-----------------
> +This hook is invoked by 'git-receive-pack' when it processes push

s/'git-receive-pack'/linkgit:git-receive-pack[1]/

> +requests. It handles refs whose names match the patterns defined by
> +`receive.procReceiveRefs` and executes the actual ref updates. See
> +linkgit:githooks[5] for the full protocol description.

Instead of reinventing the wheel, we could also just copy the first
paragraph of githooks(5):

  This hook is invoked by git-receive-pack(1). If the server has set the
  multi-valued config variable receive.procReceiveRefs, and the commands
  sent to receive-pack have matching reference names, these commands
  will be executed by this hook, instead of by the internal
  execute_commands() function. This hook is responsible for updating the
  relevant references and reporting the results back to receive-pack.

I think this is quite a good summary of what it does, and for everything
else we can then still provide the link to the manpage.

Patrick
