Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121665;
	b=VluVKCeSm18wmWUVFmMVhl9/MT81GN+LL7t2XUr/itXraIugMq/XLb/UX/b4rQRGWz2T
	 xkPtUjQ3JC4aIEH4NkpkscclUAhr+p3gAWaEj0GDlhcwCI91OX8/gW/geycTvIymObgae
	 5+rQ1ckTdIH07gmz84letscWSAoqXl1WP4QsGh9bXwlUu6Zvlih/wh4eyzsQVJFMdYqXv
	 EBncE28XSXZNCmfysuS2DkSf2kIXQlCWacUtCMgWuvU0X0wF72g43kktVIbbBGvG5tQWj
	 4dWe27h5Iv6lke8vAfp4V31lRYd3o5BuOzYt9AUM/+RfHJvM2TlHRne/codCeVRcw3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121665;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=igcoXEfZs0h5xdmTUpk0zkuXS6bf7Ru+BpWp978HH1k=;
	b=aTwlszi9mQdcGTljXmBqqlwxrw0/5y1r3/ZlzKlMvijC1YGqATOxbdyI655fL7sMBVUr
	 a75pn4HkcEKI52ap0AdCyVs8MQhUk4/0fQfDW6nnmTJDwmZRe2w0OS5UZaPLobCy9e8z3
	 NO1+XUTyrgl+bgT9y+pehZlNm6dDJrtIx2o0bKSRusLm7CSayrxDheWAJevjaNuEEb9Hr
	 15DEcZxIli8LOe6J6c5Y/Bz4k09QanRm57sQF7JZhCam4MiVMj6sgp526tmOa6yUD5Xjf
	 qf1EQcHol5mPyzbxvDwsQt0w3p6tOTEEqWTumj2vpPaZxDDYoADDJXrb6wRyPWuYlvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=itHyVgzp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="BhR+bR/t";
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F250606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F250606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=itHyVgzp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BhR+bR/t
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 644901D0013D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 13:21:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 13:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793121663; x=1793208063; bh=igcoXEfZs0
	h5xdmTUpk0zkuXS6bf7Ru+BpWp978HH1k=; b=itHyVgzpdwI6ukDnocJGhkCw0V
	N9f+zuOYQd7wd501CpxsLG7VrkA5PZcVpmBoqYcDq/FG9uif17ICkBHYfRK78bs3
	9AbC9bLJ0tYSSyUFjCfXYJdP+Zw3066brFF9X2hy1VoB+vXE+6ep5J8by5wRDUpV
	4cwZLb52e1Fj94cTpD/sJQ3MMufJyXzVWjDEcHg/lGab23bVRhJ2ZmKG7So0FGQ+
	2zaX3/VCLDarz4Q+EgGqOzAKNIPNmu/slNWHaE4PHHBs10xSPwDIHzv6WXsRnzKk
	Pi4BYRpXPpIaq2GgGBEUMKx1NBhEzenjLfC3fUXjRwwF1Y9pV6ZE8vNZ7PqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793121663; x=1793208063; bh=igcoXEfZs0h5xdmTUpk0zkuXS6bf7Ru+BpW
	p978HH1k=; b=BhR+bR/tD3E8sso0jUTVWqIFVCJzulsC72WlDVkGabjtbtR/ioS
	UcWStNxYN/fN2pEWD4hJE7MBfQVcIOTRBqQfpUJUEiuJeltrmCSQJGxG/bKlXNuz
	ffpnpmggM9djSXC92INB8Rg8ZfP5qkEMuIUjgedxhIQ6iv3fzAM0ISIlGvgicF+B
	kcsZC1TVd6afSDBczkgNTPZ04Cxt/AlID5ts4DNvBbZsoeLn0OllkqDC9NkJt2wZ
	/a4QPx8vx1vVjVVr2nUXXe1WCilqdKmvOcmRcoPP0K2EQTH9Ggqf9Y/dBca2f6sW
	g5PubPk6KPj9sdDjV5UQW1FSn79PKRwaw8w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793121663; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gm3cnoYacwjid59CdkDoVKlR5asCk3LNUbfHQ1bN3mKDBMD
	0yalkkUK4onAOxhM9beASiIzXXqEUo10FFq4hqRKZj6oyA5NeI09/EquOrxVGsoa
	eSH2vVgEjonGMUYBjNJTu9QKWjOkCrj9JnRQ8J7+6Jk7IXWLItB17BgmXD/OOYMv
	IjwwOLcaq2AqvrJq4R9qvTVNDDiPEiPQKXeM4EYaU7ArKA7ePU/g4kswz0gfJuxx
	knzxdROaz8LHatShlD6DrGPes7gENcGKXpvNEes0ITm4mc+G7a/rtAhliZZVlc30
	4UJtqNvqHftj+bf8GL8QDeOfQ4GPhk6Xbh638yA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BvmMOnunlq9rCr6DNbiSteQmnQqnvAljB5O55MK9so0=:ndk2TdQTjdo5BAJYfIqZ4C9VbAdKZKOG991T4yNTypk=;
X-ME-Sender: <xms:f93gan6aGvlZ9NpcfQXq_BWHTAsDlq8ROXDHRyd7pBTHRo_vWFxEaQ>
    <xme:f93gagk9up7rd3HSOOfb-UdWpUR20jQEw7aBFhF0o_SHz99fK9zxTCLcl7OnKugrh
    Gl74a3JzB15Qpljg7prQQXqdIVvJk90vi6cmlF_zYWoe8lJszDkt_g>
X-ME-Received: <xmr:f93gaoRtMUNVHmrTsAulgV8wZqeUECqgWiqKTN6mgMne9l0jLD4jLOwFINZyfjWOvOhJhpuOlm8U0JVI9olwUWRneQKm1QUHmGll>
X-ME-Proxy-Cause: dmFkZTGSErhpjqR9b7kPug13YXyBZKjuINHsEKq9EYOuJYPMxRSrD0u1vE0sGBEgK/31X3
    zwRxQl7RoSYvkzFY2J2vNR243efnEbybbwh7GdC4py3L+kfbxGPxXhFw5Xx2E+q28E/LAS
    Vf2O7ys4u5eM1gLsuF1puq1ij/O60h38RoOwjZCUoQceAsV5fHHLEQkcLb1WR9igkYJxU/
    tiMt7KooS3An9GWQqnxM2m2qw5RejPF2W/FB0jGI18qp/Y/H/3N601r7tD0SKM9Ufrt0uZ
    hkBRzW2AtWY7pKTYr7B4nYxzf6stfv4lq3nhmQH9ZlEMe9lN8swYn+dMrYBh1I87QbTaQ5
    X3fpN3PoS/DKY7DcVd5pQwFsG+Scr7jLo3TuY8uSDurhBx/mqAtRBNieRlwSGDZJTPI22t
    Ss91YtrONN/k2glxK6aZ5/PI2j6uYE73T7RtdUz+S9Eoi2f7iQ2AC/oNDkB5Sko0/hMPkB
    NRK9HyTY4Aa1JYlZDG2Y50uAhV+1+vA0SMBZjaSFPL4dK24Qj2f72LhOrCGX0N+rJ+/uY/
    5Q3qjB2EVYBRqc0s74ZATUI0QlqpOPvRFrCTA/IjC+sC0yZoCz15ByY2blU1OGKylDVEN7
    TOCv8XEYYKtLdbDWW4qeelJWnBJNBt6mvzv7QchWccH4oUMfa+vL3zOxPgvA
X-ME-Proxy: <xmx:f93gavGoDVbjW655xPZcfil2DmDypv2itg2jBEPW003ZX_AkEqhIhw>
    <xmx:f93gatFDOwy7NUfP6fwoi6y3purYNO0ch70c4OvwNX2lpEb__mrc8A>
    <xmx:f93gatTEBcb5jjOyQ7J1hiMyhIq6XzMh53rLXsAk-epovakmKrQF9w>
    <xmx:f93gauK8w9iGyqtlxWphUH0-UNZVlWamJyA3RCMG1nrL0NfvjPFAFQ>
    <xmx:f93gajd34HlOnsQaRPQypspHw27-7lKQmy_5Yrq4i0nFCRXTdciQFMCk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 13:21:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com> (Phillip Wood's
	message of "Tue, 27 Oct 2026 17:03:51 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	<xmqq33ttxw9h.fsf@gitster.g>
	<CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
	<xmqqcxswtqd0.fsf@gitster.g>
	<7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
Date: Tue, 27 Oct 2026 10:21:01 -0700
Message-ID: <xmqqbj8fm54y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 26/10/2026 15:48, Junio C Hamano wrote:
>> 
>> I actually do not think we should have master next seen on the same
>> remote.cabal.fetch configuration variable.  It is a multi-valued
>> variable, so it should read more like
>> 
>>           [remote "cabal"]
>>                   fetch = refs/heads/master
>>                   fetch = refs/heads/next
>>                   fetch = refs/heads/seen
>>                   refmap = +refs/heads/*:refs/remotes/cabal/*
>
> Doesn't that cause older versions of git to try and update the local 
> branch when fetching, or is it only when pushing that we'll fill in the 
> right hand side of the refspec with a copy of the left hand side?

"git fetch --help" is fairly clear on what should happen in its
description on <refspec> command line arguments, and 

I meant in the above example that remote.cabal.fetch should be used
as if these three refnames are written on the fetch command line
when nothing is given from the command line.  Now, <refspec> that
does not have :dst side for fetch stores the result nowhere but
FETCH_HEAD, so without remote.cabal.refmap (i.e., older versions of
git), you will get them in FETCH_HEAD, so your "git pull" will still
work to create an octopus merge ;-)

I was hoping that with refmap, the users can tell the system where
to store them.  As specifying a shorthand also works,

           [remote "cabal"]
                   fetch = master
                   fetch = next
                   fetch = seen
                   refmap = +refs/heads/*:refs/remotes/cabal/*

would be an easy layout to allow adding different branches than
having to say

           [remote "cabal"]
                   fetch = +refs/heads/master:refs/remotes/cabal/master
                   fetch = +refs/heads/next:refs/remotes/cabal/next
                   fetch = +refs/heads/seen:refs/remotes/cabal/seen


Thanks.
