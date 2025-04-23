Received: from camel.banana.relay.mailchannels.net (camel.banana.relay.mailchannels.net [23.83.217.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C34A07
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 05:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.217.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745385831; cv=pass; b=tbHfK5PLKCn0+uUp+/sE8fMJ7aFCH6isppQ3os1FWjsGBhYYFCdNCFSBfjKa46On4MVEHXk1G6DwO/KufdVqIvhKXGjb5QM2zsVfvD2HhN5ir1PYIRWF2raWhS8D3ILvi/PZC5csMWi/OxcVk+ExoRhX4/zfFViGiTPmML7JsrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745385831; c=relaxed/simple;
	bh=YfoiC2VX8Tb91/utywRic2D3SKmLVgzFftSSP3CMYDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA/ah/qnEzbQXQ5ay0Wb/a4hrZn77F3fJ7VztqlN8S5dhiCXMX/34ZZjOAs/z7W61xYw8gQUsGamPSfz2lAVdj0u0wCtT4l5MRUxRe7kb5ELtAaljhs0oCwQwvMFGPuzhmcP/BVpaTPGuqOdEROwwncwONHSgTZAis3b3l+lfHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=lGiYFQ4v; arc=pass smtp.client-ip=23.83.217.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="lGiYFQ4v"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5CF751C3B15;
	Wed, 23 Apr 2025 04:45:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-106-221-124.trex-nlb.outbound.svc.cluster.local [100.106.221.124])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E349F1C3B8F;
	Wed, 23 Apr 2025 04:45:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745383542; a=rsa-sha256;
	cv=none;
	b=72UTDjis/wXDCGakrGh0RBBHlgVUUTqVo/Y41JPpGEq7H+aaY0kbp76h8xicHWiY5gh4Jp
	6ULqMoc/Rc0SQ8lmvRnhSkcPo1GjtR874GoD7iuSn4EuXyRhneAR+TZVyG956NjMBucjuC
	3fh9jS4qurJGnr0aYJ5C3qQltJEFfYxg/nZT6TgdDUTR6Duafe2e2rKDDzDCvZYDXW56GV
	7XOcpU72MxJrD+fqe98DvXjHGX6pq0Q2QLPYICi9ov4W9X3Jr7WBqy+TDo+nL6L9KCKp7b
	nuSfyPcIFiw4dL9MfgvgwVWvydiM29ZOxIClACKecx8iNzWazTGrH4W2Ct+znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745383542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xFbIby8jcVjSg3v+MJ38qPoaHoiqWkjSIkb7UZ0gckc=;
	b=pNHEL1KEX70dv2XRVOCx+Ayfiu7WuemMLaPZRELC2Dr7XvJDg3H6BoolW2aPiJxj+40Jj1
	SQ3grV3DVPqc7T78Efrn1+eG1HR6O8cEXOJ3dqgIUDs313ALOXmqlcXxvRauw9/3kyQMYp
	/vrf22ar4rYVqjelKXEzvZHWIJM9a6jnoTB1mjiZVdA1j8IDJNBSiXyDLDnju7RDOA+uKs
	P0iTn096yPkue2jPSYNdR2ovkxkRm18Nxw/CMKOBhrFGRvl1DQJkVvvu2Wycuu2BQUYGFb
	FH8Xu7cNnsWo7wdahqBsJa9lWBQNAgqED/GNsoSQ+mUD//l4p1wzyxHKN/644Q==
ARC-Authentication-Results: i=1;
	rspamd-5b8599699-7gn55;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Power-Average: 7443c15d08b75ee6_1745383542205_2048918115
X-MC-Loop-Signature: 1745383542205:1788395476
X-MC-Ingress-Time: 1745383542205
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.221.124 (trex/7.0.3);
	Wed, 23 Apr 2025 04:45:42 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4Zj6444xPMzBD;
	Tue, 22 Apr 2025 21:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745383541;
	bh=xFbIby8jcVjSg3v+MJ38qPoaHoiqWkjSIkb7UZ0gckc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lGiYFQ4vulctlgrErrrGKM4Is2hP1wnlEyr6GWSJmJWcrOmPjvEMLsBBCvrlGEORN
	 IAnVUeT6c9SBIAKtjPCh8NGl5evgSmmyH/2ySElT/u9iyyvfVndyWclzuQ1d9e+pDP
	 nYumiPdSiLszHmj7+00z9hqPdNbP+j9mEL3lsikglA5Q+d584ifvand3knf4iCe584
	 ZOZqE1ZaNSGOeBp6NAnqIIEVWUDoUR0uxKNcu0MDT9QN/E6DbKTnR9yXkirCBszg00
	 wRknf2ZXIhOn7ihGrShtL8gtqjpm5USk6mh1tUqBBqKlRqGNNgKeqjGa0LUkdz/7lI
	 i7c6GJdqCrCog==
Date: Tue, 22 Apr 2025 23:45:38 -0500
From: Nico Williams <nico@cryptonector.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Junio C Hamano <gitster@pobox.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aAhwcgzSIaE6l1O9@ubby>
References: <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
 <xmqq8qnr3jji.fsf@gitster.g>
 <aAgdauFt/mdCY+GZ@ubby>
 <D9DKHI316ER9.PNEG774QLFL8@buenzli.dev>
 <aAg1ALkWaRQswZtK@ubby>
 <D9DMCVD6EG00.317YDVDW95P45@buenzli.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9DMCVD6EG00.317YDVDW95P45@buenzli.dev>

On Wed, Apr 23, 2025 at 03:15:28AM +0200, Remo Senekowitsch wrote:
> You can stuff as much free-form metadata into the commit message as you
> want, because git itself doesn't care much about what's in there. The
> better analogy would be to put the names of your mom and dad in the
> "parent" header as a free-form piece of metadata about the heritage of
> the commit author. That's gonna break stuff.

The point was that lacking a change ID header people have been resorting
to conventions, and to point out that people have been using ticket IDs
as change IDs.  It's just an observation.
