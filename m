Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689529;
	b=SyvS0H8GnuFIxpWRyZ0QHsCzgrHEvZMkCzxu0VcjQvngbOQmSXfKGkJl9T7uja3FQe8f
	 60CanzzI+00hDeT7GEc4Shy9rBYth7VINsK3urPgyt3fEJGE2h3oym/GX7uaVL5K7S9GR
	 g0b2vryyh8hgJOItKmEPSv96j1DMWnABqcpYkV3QeAL+HeoubiphmAJIJeqEj1d8DvtLV
	 T7Y6cz+a4us7ITjUaYZRY5KQfhgM2Bv827D8+C2WbbK+/CDXbuzlrbw3EJpi+JddEfgwo
	 ctIHEFTLd3t7UOXTKLV3Uzk8+ph5U7iSU+l9LUKURXMIXwHb0Fso5QNjZa38OWgwbJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689529;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bGdD5Dr17X8p3xrhBEgoK7bhLX+Hzbv/TtlB3YYncHI=;
	b=g9Ee3t25E2+5C/cGkHXoYhwaxQvsiJKGabv2/rk8vf0NwcZyfSAaSfQWc+Cgo65ePRYe
	 FL3+B0IlLC1aiqwi0SAmsMOqjR17ooNMMJMA4QVRqO6PaFg2Jt82R3bkRCFuPkWZ+RmpK
	 fe/fYIWizGVuG4qoqrK+E1bcoBhFxQIHUXj00MhL2hKGPORd2eCNFM08Hkwm3/6xY3Agk
	 oi+1ypCsM0xQYn7VofnlR/q18d8lYFEqmP3Qi62HBx9v2bO9Q6NfZpVrazblZ0yTcU8Ni
	 Jkz5B4CiwfY+V5T3V2itM5ZQqx91a5jAXrytSyRZXK3ne7qEicgqhqtGG6zVSiyG/vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=tNBxDRu5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="01b9M/Tm";
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930A6606A329
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930A6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=tNBxDRu5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=01b9M/Tm
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DADAB1D00123
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:05:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Nov 2026 02:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793689527; x=1793775927; bh=bGdD5Dr17X
	8p3xrhBEgoK7bhLX+Hzbv/TtlB3YYncHI=; b=tNBxDRu5h056mEYIIC2Xi59w4I
	B1BW8kmYzOcyl7I1HReikEdOD1PQnDNvLpYKoxeIb9Ocb3L0KqMIn5tvTn5bLifB
	gijyTpEck00a3uAWUwpTQ4XCtbMuVbJ1Oot7ACGMBauBHLmbWnGrDsk89LOYGqv9
	73fnuoixAQ5XE8OMjiAwDbdXqPEi3c5qiuJSl1yE8OARDWcRqzerZJO2Ygz3yROm
	fSyNCgrkx5GgXUHF+0/JG+acmwShfW2LgkDd7ehjbYzxeBfrO+kY2BkF5whBJmPL
	j/bFwKpVifkU8RR8U1cUyeQ4CUzEvAA+JyV9FlgWrn/dNDlrfLQsklX0+OmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793689527; x=1793775927; bh=bGdD5Dr17X8p3xrhBEgoK7bhLX+Hzbv/Ttl
	B3YYncHI=; b=01b9M/TmL6wHClLOPw3g3O8zr4Vzzef70g26uJOofcofSNq09Kg
	yNj0fvrLW69jR0zJDbNBeHhu9kwfmd8sgrNYFx43uoyWOtTnnUn+P7/D8nCcKlB3
	mYEQN8VTdOqwwTTPlpN6O1AulsjR02fCLkRNkfNgOrl89L2xm1+ErDA37Cy2hxzu
	6HXwusYV9wzm2yBQpFSf1frhEtW9odwmyYfLHSrmTgHzbs6yPIq1EfDMjZjXI1VZ
	BesJvM6broun5DoZayOhYKepns8nJ7IJQNv32wJ3vT8xdeRnfSQo0FhGacaCyyg0
	wZ3a2n65dd5pZN6wNClqn7h8DDRbXplBWAw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793689527; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:rgnM30MMBgSqt+Iw136RKIS7XZdnYTY6mHSytv6V9z6RR8x
	Csra5eD2T3xKrhqy8P1rFE20aP95xuffvuUX/6RLjQwxzkn3mfY+1wztTBwlWhEn
	jAl1MvBNnGX1rK5Zghq0tE3Qlj1zm0Lkex9qY6VJXSMeJCuNyhoINUX0gf1jbhwG
	F55dNFF2YUaf1uPtLmVY5Xa8hoXmwVxN9XUDDljLkgg0Da9BU6TF/YusDAQcw9S+
	cp/yWSVydpLtCioXl2AgX+F1jPltT67mQPfxW2LvmHUanil2oi/TQiP88ibMjfcA
	T402oQkPiGRsrpAhqfpOtpoORUZAvgAmrDeAfCw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:R5X1tb89glYzPmH7okH7AobdLfDCcXQVZ+adSItBETE=:5sX9U+zgiHDJoPt4XQ6ZZu78ACgFF9Yq7UiC1s9IAHg=;
X-ME-Sender: <xms:t4fpalqeClmMeUDdLcjnpz5TfrVPZEtrCZBNKxG22E2JZKIo7BU9eQ>
    <xme:t4fpavE_lCxJhC4iKufNsRrICOUNk24VDcIzEcDBez3IscdNfIuR7cIHlkOKqy_aT
    75Gy7ve3P2vDkhwrfRjOSVNpZNw17TsiH3KzxbP29UNuRk540UtGqBC>
X-ME-Received: <xmr:t4fpavnHO1G2HPCsqmu0690aKMwTiPFKTjecROxBzrsYFje-YavQnw>
X-ME-Proxy-Cause: dmFkZTFbrXS5JHaqcN8lzRSjjeSOnQX96EbJdEFXWrM0igtMp66p/cyHaaUdmh6tVAIs2h
    qqTQSzWgu+xydy+ItEveSI81yhJJTRgmp2IcjiqO/Hrtm/BAE2d6LUo5Lsac0CRXr+z9+f
    M4mJpWBDorLUduo0OxZ3KnwGATnSaP3GPvxAoENBpjb7/UP2OOHSGaXX5ry+oNifubQatI
    x0NxAjrfWqFbDhIJNXoQvYnqXgHO6a61emGNm7TykKl21dNqJzGpMt0w86b19081Xcopu6
    fHa/7T+7llHNSxDRrt2DqITQ5CgJ0nBiH655jLODfcYDXOj7/jPAS/+dDSZ8tsKvIlqTUf
    vQ1/xVc3IwpKtinWc/YYHQj9WvEn/c7rlN9eTu0JbIryL5EJHffXoR6m8c9R1b6hVdELwK
    u8mOoeHuuB71FyFfOtJYaBi8urvr5P1iyDblhz9uqbqtKxUKPLMbE1DMN/FJgOMXCh5S1R
    97RS7ENlv7Pz9UJQgvwFqjeOZdtNVmsy2/zuevZ05UAMGP2TG9BcR2osyJGjYyei3rIyew
    vGLLLE9raDrX0OBjzSieB0MfEIB/SQS8+FaHMSbZ2VZSF7QD1WXcVqo7KDydoD21Msab1E
    UQoEwjEQbC66r/PhmroGxiaMBmrn9io7k1dq94G2JogLQlJxAsdTOdGOcxxg
X-ME-Proxy: <xmx:t4fpaqledHwLDnf7fUYaXnmeU864abaJR-eg-fa-Y_5ZMZg5enKbCw>
    <xmx:t4fpaoufxcbomddsnP4DUgurNV33XIB5UeLRiZutGeOHRpzPFz9_1A>
    <xmx:t4fpallRMdhLJJAWlnFknTpqg6SOTNjMaNS8UXmaHNW2-daJon4d_g>
    <xmx:t4fparui9PWxOYNrGh_gVOYPTZ4FOQRJUGvtt1RsZDwSH_VeeboCmg>
    <xmx:t4fpaqQgZwSQW7d4pcR8l_8LVJFM_UaEKjsJcraq6ZBMLU7SqnPmJyWx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 02:05:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30f38683 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 07:05:25 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:05:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org
Subject: Re: Re*: [PATCH v3 0/3] environment: clean up repository config
 handling
Message-ID: <aumHsqTV61ryUJYv@pks.im>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260807085932.3958759-1-cat@malon.dev>
 <anW7wHfUxYj9cj0P@pks.im>
 <xmqq1pc9eivn.fsf@gitster.g>
 <anlmwaEtwcCPse1N@pks.im>
 <xmqqh5hzjdwr.fsf_-_@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5hzjdwr.fsf_-_@gitster.g>

On Mon, Nov 02, 2026 at 10:17:56AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Aug 07, 2026 at 02:11:08PM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >> > On Fri, Aug 07, 2026 at 04:59:29PM +0800, Tian Yuchen wrote:
> >> > Somewhat unrelated to this patch series, but I was wondering whether you
> >> > plan to drop the limitation in `repo_config_values()` that requires that
> >> > the passed-in repository is `the_repository`. ...
> >>
> >> Hmph, that is an interesting point.  What is our plan to really
> >> enable the use of repository instances other than 'the_repository'
> >> here?  They of course need to be initialized with repo_init(),
> >> but is that enough to sensibly use the embedded 'repo_settings'
> >> and 'repo_config_values' structures?  (By the way, it is not
> >> entirely clear to me why we need both and how we sift variables
> >> between them.)
> >
> > Yeah, this split is adding to the confusion indeed. I think that we
> > should make it a goal to unify those going forward.
> > ...
> > I've been wondering for a while whether we're operating at the wrong
> > level here. Both `repo_settings` and `repo_config_values` indicates that
> > we're operating in the context of a repository, but as you mention that
> > may not even be the case.
> >
> > I don't think the approach is inherently flawed though. From my point
> > of view, the best way forward is to merge those two and then generalize
> > them into something like `git_config_values` or `git_settings`,
> > depending on which of both variants we want to retain. We would then
> > have two levels:
> >
> >   - One on the repository level as we have it today.
> >
> >   - One truly global variable, because that stuff in fact _is_ global.
> >
> > We'd then adapt `repo_config_values()` so that it knows to populate
> > either of those variables depending on whether or not the user passes a
> > valid repository, and returns a constant pointer to the respective
> > structure. Callers MUST NOT modify that structure -- if they want to,
> > they'll have to make a copy and pass it down the calling stack.
> >
> > The last part about not modifying that structure could be quite a bit
> > painful though, as it would mean that we might have to adapt call chains
> > to pass down a `struct git_config_values` instead of a `struct
> > repository`. But arguably, that's the right thing to do anyway for at
> > least some subsystems that are independent of repositories.
> >
> > As you say though, none of this is really related to this patch series
> > at hand, and I don't think we need to resolve this discussion before we
> > can merge it. I just want to make sure that we have a plan for how to
> > get rid of `the_repository` instead of only shuffling stuff around.
> 
> Even after we punted on this and stopped the side discussion in
> early August, there still are topics that want to move things into
> repo_settings, or even worse, repo_config_values.  Until we have a
> plan to fix repo_config_values() to take an arbitrary repository,
> should we freeze this part of the code, perhaps like this?

Ah, thanks for tackling this. I had it on my todo list but didn't get to
it yet.

> ----- >8 -----
> Subject: repo_config_values: freeze the structure for now
> 
> The configuration and settings per repository is currently in an
> unfortunate mess.  Especially given that repo_config_values() cannot
> work on any repository instance other than the_repository, moving
> more members into this structure is unwelcome.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  environment.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git c/environment.h w/environment.h
> index 9e175e410e..03b1b35d6a 100644
> --- c/environment.h
> +++ w/environment.h
> @@ -124,6 +124,13 @@ enum object_creation_mode {
>  	OBJECT_CREATION_USES_RENAMES = 1
>  };
>  
> +/*
> + * See https://lore.kernel.org/git/anlmwaEtwcCPse1N@pks.im/ and later
> + * discussions.  Until we figure out what to do with this and
> + * repo_settings, and allow them to be truly usable on a repository
> + * instance that is not the_repository, do *NOT* add any new members
> + * to this structure.
> + */
>  struct repo_config_values {
>  	/* section "core" config values */
>  	char *attributes_file;

Thanks, this looks good to me as-is. I'm very much in favor of merging
this so that we don't need to push back so often, and so that newcomers
don't waste their time and get frustrated because of it.

Patrick
