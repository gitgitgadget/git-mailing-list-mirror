Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733603;
	b=m7lqETdPEWMTxSfMUb38vzKIdMg0mlDIZ0QXdP+OJEJyMZc9nsgRcKMJOvDtUeCuWnvr
	 EAYx2nyB/31LBh4FsxxD8Oy6OdKcZTkyfa12oCV70sa2ZcKct1JttJMnMmne4Q4Uz71mo
	 IBOsSeBuqxqv0c9LUgdyN5S416wpo3tgmO/X7BysMFpSTA1qfYqVCN/hQIF8xP1uKNn/0
	 3SLvkQLOvaphIVYW2q/rcvfhg5U8CPb/5agw+7dM7noikeZcUtE4W+bqVIX2T6y6bUtvC
	 ojLu1tqOluN21DRjselPkyB+WSXMlR0MpiCmCLcatcvI1Goa6N8l/qfQrPZN9sEVVYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733603;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lgGOlnmgYqAyfj2Uc/gokBVJMJC82+8zD1alsINQ6YY=;
	b=BykZx+D9xhnbv3nz1R77JhAqz8kwQ0Xs6oBOkWL/DBEkM86bgzVi8aLSpICEgRWbjhJn
	 RQh1mpdsvJGVXhYMeM6yMJQq1E0Lnhe5l+8/kv/tqLyBKwiPacmglW5PNA/PldmzCBdHk
	 JVQG/rspuQUQ3wxrhHVnt21afttPr/Ru4KcLvT/ypPi4t8ID0ywWapK0HRgmVUkXzGhUg
	 j7bAiFT+8/BsBveUpng/aSPCictNFXPGxoAI1H1+ajIpL9LZRRbxlj/cyhgtRwBqFs/DL
	 N5XtTP5FyLqapm82P7tABo4VUH8/uqbzhfiL2AuiFbuxedk7cB35lfraICbwWNv8mgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=C5KAzmYs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="p/hxPZLx";
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C9606A319
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E3C9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=C5KAzmYs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=p/hxPZLx
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87B0F1400080
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 01:33:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 01:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792733601; x=1792820001; bh=lgGOlnmgYq
	Ayfj2Uc/gokBVJMJC82+8zD1alsINQ6YY=; b=C5KAzmYsvdsVV2XtKlJmJ6Yebu
	MWvgYgyGYuGP9WEdVUsFRRgpEa8Ba/KG5Ny5CVCPYNqoqBEnJH6fgzPwBR19tEca
	sj1jtdHlCpz9P33N0dnS6yBCpAd8xsnAjAafWWPGQuOwtEwoLTqROmyEkxLtfBCW
	p/gMAAvctAoD4r9GE6b08tsTGwXLOoU8rRWSQ9isxSuKm7tyUZoGgldoRzpPgb7V
	kFnnv97tTTfYIc750WVmpMOw9wNTl0a2FUlBNugdExVVOXjWP/cEUGkh703jxiQS
	cXepEhNmyfxovvb6TiG1UQVzlRntaKU0kE9s3mHCXpoBKPDUYDTm0ekQTfug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792733601; x=1792820001; bh=lgGOlnmgYqAyfj2Uc/gokBVJMJC82+8zD1a
	lsINQ6YY=; b=p/hxPZLxK4IXHmIa5gzpclxgvFu5/RjSGrMI7ORmBS589Nsxhds
	Tx9XfvXHcABDVno7n4dnPMYAzIeKue8+uNlZ2fDbtUK+Uues3Llm4v/ErCzrcpaA
	6lHXiBluvUSSy9lShuYjap3G/AKeLo4PRU1FDanIpPShqMgO2BKbhUfDp1gK9DU2
	IP6oZhCM4xguxB/mcZme26tBlfLZ1lRXGv9PvgR3s9n3EhKhhq2ygw+5GcH45bFa
	ulisiAI3OWLA/BXc42FFCKN7WYowOPCe4YyLixQB+3uKx+4uvKp2CgMeMgzzS4yL
	WLmpIqGX+/Wwx8Mi7b54Ib/x4I2quBe+Ygw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792733601; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ECMrMB8VY3ZHWKEYafLhpZ/+k1EQoodOLGflexpIl5+UB+i
	R2cji1FXcis3Eywn9CNREl1GSylCbwPJncXuAwKMTP8oDP0Z5H1b0puPteRBxZap
	OI1miR8BjYdP0kC/CEWLQgMzlbt75EpaW2nfBACpu1LtYAUWoaeGcV980UfkUu/3
	5Gr8Xazpb3BCo+kO7Bo/WZbYJEsGVGJdZmhSa06mcgNG5rwXblNSYErWFyMJYbSH
	MK1sYYuxZ2GGXq6TfHK167TYwGufcjph/xiiF5mFNVE68jA9pyTBLrmBw+/efHrM
	n1gOR21vNr0R5hc5q8J3lh/tlYPOHPVNRAy9gyQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:52X8ORW+k38PPCnnPo3RzRWlmdppyTKIJRf7zAgdgXo=:c46/vOSaxellJumwNpA5UoDtXf8V++8tjZm6Gf1EP0Q=;
X-ME-Sender: <xms:ofHaarSFGyrxGNQuS5FLNIYUF35D8av3EYL0Wq5bJuBKSe20aEhtDg>
    <xme:ofHaaixFW9o6KgLlQGeeiMyDfAz-WAlfi2qwpvldimvdns95xQ6f35Ys0uLln2GJX
    qriGh7zZdZOsqPwjHaXRY8W5ppU4hHngFFZjteTJY6f7BTx2K47LIs>
X-ME-Received: <xmr:ofHaaufx2hn5d_SOajt9jQoKE8UhKrNRLQ3xN4pEUdFdUn5fs_kMZfGE1FoYQBLvABQGPA>
X-ME-Proxy-Cause: dmFkZTFSsqJU8DDkBhz7h30NZPbisMw+bzBsrap1/uNFiVEeSdFJl67xSABCvCEG5/wI6B
    gyv0bOxlEDiQzwOwpcE27MtgA3YF15sopaGR3gUk5Rc40oqJq9h0HLd7y7qrSyEw2fTZgh
    wEIT2tAfXxHFQbzxyKs96TsBbcCmjiRfdqKdSDP9dHLz5Pm2V3/ZRoJRB4mHtPDOftjS1b
    ZcO2ftO4i1U+3jR5YkHvHSzpZa0UbKh1MQxS9i5/peTk6YVCsHfT1gKNONvNP9jZJdWgWs
    hFGtuVW/hic2ea2WJKXgb1FWu1CfaXJV/2zRA+gbGtG8HvFmybS6slTY1MuDQhvP716ab9
    x0tha2BXDHkgGULnm9brs8KnzwC6W00P4h6GMxUYHGWbAw3MsPf5Qc0mL6xThriXLOYX74
    3eMmx3A5GaGKsqHCr5M4P0QMAPaMsjB0nkZSQGE7FLlbyPNAPcLYuZtdfPLky/O5UxACIO
    N8ENWb0rmPKwSPhVEGLHsyDct9L96pRMWrorlL1M6v09fbfhnX2GdeU5GOEJtXhK4uAJJU
    dwRV/BwDj3typeRqkzH4tzT9GIFUscuorQSD/7uqND/Ya8ubfCT+yhvn0iSVimbSLY+27l
    5VzYKnRaD6ofWIwK2GtCGuyGnCe+m2sSvM4BCLYSZQCw9k/ZzVer5VUAO+SQ
X-ME-Proxy: <xmx:ofHaamLSXDKkWaNXM5FXj_olzYkK96AvtaDsFjPsdNKIhFOpyRd8zw>
    <xmx:ofHaanEdqK5wH75Af4OQS5AP2qwOdXR3yDO34ZehVxr8Y7OtAcrigw>
    <xmx:ofHaaor6yydhqIhQ7mDN-Q-Xu3MAInHiiIsk5U8o-CluDgrG5iSh6Q>
    <xmx:ofHaaoRbvrPCcyTHduI0KS3HJzs5m7IJOhySeNVsnqof7sC6cYvZyA>
    <xmx:ofHaasBEV2rNd_nj4_iSBuzrjJbEa3c8-lW0nz6sG5HYrq50wcNJX-u3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 01:33:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 889c56ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 05:33:18 +0000 (UTC)
Date: Fri, 23 Oct 2026 07:33:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] builtin/init: introduce handling of object
 storage format
Message-ID: <atrxjqESUSunxsqU@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
 <20261021-b4-pks-odb-extension-v2-5-8cf11b65eda8@pks.im>
 <CAOLa=ZRzu_7No085hEHnULo0L50y=ntx3MSkb-VbcywChdOPZA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZRzu_7No085hEHnULo0L50y=ntx3MSkb-VbcywChdOPZA@mail.gmail.com>

On Wed, Oct 21, 2026 at 10:23:17AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/setup.c b/setup.c
> > index 98140a7641..3d74f8eeed 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -2466,7 +2466,8 @@ void initialize_repository_version(struct repository *repo,
> >  	 */
> >  	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
> >  	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
> > -	    repo->ref_storage_payload)
> > +	    repo->ref_storage_payload ||
> > +	    strcmp(repo->object_storage_format, "files"))
> >  		target_version = GIT_REPO_VERSION_READ;
> >
> 
> Okay so this is what also sets the 'core.repositoryformatversion'
> config. I was specifically looking for that.
> 
> Does this mean that even for the files odb with a payload we need v1 of
> 'core.repositoryformatversion'?

Yes. Repository extensions aren't read in the case where we have a v0
repository, so we cannot make use of any non-default object storage
format there.

> > @@ -2490,6 +2491,12 @@ void initialize_repository_version(struct repository *repo,
> >  		repo_config_set_gently(repo, "extensions.refstorage", NULL);
> >  	}
> >
> > +	if (strcmp(repo->object_storage_format, "files"))
> > +		repo_config_set(repo, "extensions.objectstorage",
> > +				repo->object_storage_format);
> > +	else if (reinit)
> > +		repo_config_set_gently(repo, "extensions.objectstorage", NULL);
> > +
> 
> So this handled reinitializing the same repo. If there was a previously
> set object storage format, we unset it gently.
> 
> But, we already catch and error out if the extension before and after
> reinit differ, so this `else` block is not needed, no? Removing it
> passes all the tests in this patch.

This is a slightly different case: if you have a repository that uses
the default storage format, but that explicitly configures the "files"
format, then we downgrade the repository format version to 0 and unset
the extension again. This logic basically matches what we do with the
ref backend, too.

I noticed there's no test for this though. And that then led me down the
rabbit hole, because I'm not particularly happy with some of the logic
here. For example, I was doing normalization of "files" vs "files://"
somewhat inconsistently.

So I've redone some of the infrastructure here to be much closer to what
we do with the ref backend. Currently we track the object storage format
as a single URI that we pass around, whereas for the ref storage format
we pass around a backend type and payload. And that makes normalization
a lot easier, and we don't have to re-parse the URI in a lot of places.

So I've adapted the series now to use the same approach. It also makes
stuff easier to reason about, as we basically have the exact same logic
for both storage types in most places.

I'll send that later today.

Patrick
