Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996751;
	b=w83/dzajtSHVjzcyrGiiXiW+hEvWBVukbG+Xu+KsMhS1JuWExAN7HjBfkXZn3fs1NF+H
	 ktB3gORSOKnqywPcGfaDPFnIFGOYVxV5tz40mkjDTTQ2dphLv8WkBPxS/gynKgVfoCv8E
	 EWINqGja0rMPUsg3EmNZC1WhMtVyM13Yyghwt5bqhi9/iMm4I+gxg0PyipGvuiaa6XxJf
	 PXkwJ0Ho7jdvkuDhrJDIWfdaYM3SNCZtHI/8/h4zo/3SY2la2iAn1iKdpPfmrHHq7M//Z
	 jJ0SAw/fgjLLYE7uyFmcSYRuGyKam0MfvSKwJik9vyU+TormyzZcQhkQv0ZGxy6uNcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hU5E0FtLuuSJdPXPuzpmpNf2uMFRLXM3aJF1iJhHEM0=;
	b=TimyZuUApNdUMpU7p2TWbfXsrZ/31QH1aPwJoM/RK9Clxxd5xS3z9HBcCGlS7qFbA5Ws
	 ojJNJzQsOxqnCfQsnmb+k6w+Eq1JaXGVi+BqCOOtWslSpvfjKW3RFpvbsDAVZO/ubqj4W
	 1B+bsBkdvXU4Kwr2LAyP8yMz7H2LVfXgASdPnJcY6r5bTJiX1r0aE7HfY99UcFXAs0BxY
	 NQ3Yi9kS6u0nO3U55/YocWUZDblXznzrJBOf0XwtbjP8Fp9MDvG7KQ04BcJUba/bzeO97
	 I5+tJCumEXXTbYN1aP7l3qOv8QWtVnAO9Air0WtlGu1c5Pts008jm7Fjd5WbFLQiOnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PlpJH1Hk;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=S1egU5Lw;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7816606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 06:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7816606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=PlpJH1Hk;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=S1egU5Lw
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD73E7A0351
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:39:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 26 Oct 2026 02:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792996749; x=1793083149; bh=hU5E0FtLuu
	SJdPXPuzpmpNf2uMFRLXM3aJF1iJhHEM0=; b=PlpJH1HkNWk8O6kgzX6XPMTnN1
	Xseeb/lalDqoM1rs+W8WeBRP4pTkvByWlnA2wLGeA8bZ5EhTCF1NSnNNs5G0YDaA
	856AAGaNOlDSdJnF9xLB7ZfCj4fC56Xubw6IRUF8PFddHdcg2PrZx37T7mCPG3g4
	Px/deUi14k+c+hjuJnu5bY8bBeUZFHYf1tQBA3tAHSUQEzCbseJ/O6g4l52fKopO
	pNeqBGwMKFFjTc39AYrXmLbPuNf8qDW59OWJKwy4VieHHskEWbAa+GTrd6fwKIwJ
	QA5KCV35w0qqej4s23D/AuLFk2BW8kQJqPpYn+YM0rlVJWtS7wfYzJY0fBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792996749; x=1793083149; bh=hU5E0FtLuuSJdPXPuzpmpNf2uMFRLXM3aJF
	1iJhHEM0=; b=S1egU5LwZrgK5abN5PKz8yDoTCZH6y8fBKMc9R7lKVcqlAukaT0
	P5r2MRG/BJVkp8APSdOB3Q5mELJMK9/8HT6URljQCATHW+YcHrx93AFdi7lXnv0O
	6MEmJsgONn2rFy+nkltKwVs4QnSCbpxuKpIJeyHXvhcPsb6LWxJsSCvSLKGC/e4U
	HU1N5JkBdkzGCkaW8BDDA901gppSj8aEk0Yl1KahmMmgptq9OBYCmHnTA9f7nGy5
	LmbMUvgKswubwVtQxyPfiMOiOeO3iZDoUGmJkmkPZOQsVA457eFYTj2VLPSDv2yC
	LJC7z+frvDqf8N62Q2rtn56+qy8aYevNI+A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792996749; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:E3LWD9Ft7iD784DSE5YWZxDm9x6P8F0Cf1wkQQ462rdKKdw
	foW9p4hf2X3rUKkhUASip0zk5TeTh4ldL4mf1KQNPJ2KHueuPGH4rruedIUx1kSz
	PydtjY8aNbm7PFhm8xiT7PG8UfuxEfYX0MdBJ6INffQTSQmv28Bods+pVZz5Q+Pt
	yOOrCbNESg5E2qPag+Ej6161dUJ5qHvAGDbeNeviHdN5JopGs4r1734igq/06+OJ
	3ALsSttL4mVBawvo8gFWl1AaymNHYkObtj/lzjhhQ3IQOR5CPu4dNdQ4F62WZhqb
	S2xJo2r535nEXA+TvXzENN2/Nx/57jRgaAlZL8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6itwM8+jPS9W6pK3HEiybKPovQgo+cdwlH+527xi/WY=:/GDEuHOKKKRXeR65xQmv3qfhauM2I64rQlymFyMRmXs=;
X-ME-Sender: <xms:jfXeahloVYMSHx5dauGVAv54MVbUkfoMWLctQrWA96KKOsY07uphiQ>
    <xme:jfXeai1ogyR9qpHCOWb0Sp2vj4UNF5JuPjUo_iBF_xTnSbvYhgSQaABAICCPz6DMg
    1juaHHWson3HUuB5Rj7CskvLAWGtc-RwRrZwIIK9Xs0fXPfxFDGVjg>
X-ME-Received: <xmr:jfXealS_UN9-RQ8sYSoatfixwoSvLvufQ7TvU1L3go5jw69uf5RVjw>
X-ME-Proxy-Cause: dmFkZTGlOV+yCsHDdg3Vc0FufeqrNgdYxH8XaxPwJ5XqfFH+J/Zj3+9PRuo33Izex+bnR/
    sI1Q/o5cpkIlzRU8CTHXAZV/e9J0pMqb7wHipis/aKduiIq6xsMOY6j+we93M6C58AiggW
    MyoEbA4fa1U0spQX7M+/9eipgeCB2aP6CQqlpOK4muhPcWhGSXhflg/hSqvxoEOJRike2i
    9Bsx0Og96H0yehs1FjBk6KXDkSwIu7lGS89noq9YpbYy8TVBOy/Toy0nWI0IfINv9wfSJM
    mPMMuGMfvslkkbAamg707UffpAty/4DW/LMCzWQF6tyaEMOI/L6hhFEdbAm86EW2T9fXWs
    wGDKluRQUKTBiw6XyLa3Dz86L5Oa57VGIvcYFsdP/Q6Tk8r5iW9CLpyt9ew3JUI2A8rdEv
    wbgUVCAcyEvZoe5+zDzQN55ZBKJfn8k9vs/WhVxp9d/ndNbK2PJImPBCVxqAVealpDVHGO
    9aUlKv1puLBaxdg7yp9syRYtD+ks0N05IcJrAN8fin41xKu8Y0zBiTk7DJTEYsu1b47YSW
    NQJioXF+/sVFng3yWRvhzPFdQMGOlZCxqJjXd+VAOEGQCOaAmoTataHUjeePT+DEedxR0g
    taTf8icsB/JQO23G/1XnmPjPRSZFBRlJzNB4AmKVNIx6DiF3ASB+xcauW4tg
X-ME-Proxy: <xmx:jfXeass3kQJMsBC0nmgh4Zx8JeGbMsD-fnVHxpF6EtsR4_Dkm1cvxQ>
    <xmx:jfXeaiah3_L0cw30vjMLde-PZlzqGzOlwKaBt5XUZ5lZD_sR90qLPQ>
    <xmx:jfXeapusn3RHLesV41DQmrHpXzAJj3Ww3-IhOtJZ-W_ZFm7nU6GSjw>
    <xmx:jfXeasFyiIGWAIkfq1Tkf1H7MXiVvLYTMZ7GFLoNpc1zQ4qKorYOhg>
    <xmx:jfXeaqV80yyW6NrkRvdZZKRwGTILJa4HOvmpmwjpZ1MviXc49kg4BrTX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 02:39:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c48388c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 06:39:05 +0000 (UTC)
Date: Mon, 26 Oct 2026 07:39:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: merge loose object index when migrating
 tmpdir
Message-ID: <at71hkqG7AbVCdnK@pks.im>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <attQtZ1dVoAnQznP@pks.im>
 <atufODWNPJMbvMZu@denethor>
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
In-Reply-To: <atufODWNPJMbvMZu@denethor>

On Fri, Oct 23, 2026 at 04:25:12PM -0500, Justin Tobler wrote:
> On 26/10/23 02:19PM, Patrick Steinhardt wrote:
> > On Thu, Oct 22, 2026 at 06:40:07PM -0500, Justin Tobler wrote:
[snip]
> > > diff --git a/loose.c b/loose.c
> > > index d6a2bb5ba3..79d4c256e0 100644
> > > --- a/loose.c
> > > +++ b/loose.c
> > > @@ -265,3 +265,75 @@ void loose_object_map_clear(struct loose_object_map **map)
> > >  	free(m);
> > >  	*map = NULL;
> > >  }
> > > +
> > > +int loose_object_idx_merge(struct repository *repo, const char *src,
> > > +			   const char *dst)
> > > +{
> > > +	struct lock_file lock = LOCK_INIT;
> > > +	struct strbuf buf = STRBUF_INIT;
> > > +	struct stat st;
> > > +	FILE *fp;
> > > +	int fd = -1;
> > > +	int ret;
> > > +
> > > +	fp = fopen(src, "r");
> > > +	if (!fp) {
> > > +		ret = error_errno(_("unable to open %s"), src);
> > > +		goto out;
> > > +	}
> > > +	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
> > > +		ret = error(_("invalid loose object index %s"), src);
> > > +		goto out;
> > > +	}
> > 
> > Curious. Why do we even expect that this file may be broken?
> 
> For our intended use case of reading the "loose-object-idx" file from
> the quarantine directory and merging its entries to the mapping file in
> the primary object directory, I wouldn't expect it to ever be broken.
> That is because realistically only a "loose-object-idx" that we create
> during the transaction should be written into the quarantine directory.
> 
> I chose to be more defensive here because the `loose_object_idx_merge()`
> function itself isn't aware of the circumstances regarding its use case.
> In theory, another caller could use any mapping file as the source.
> Ultimately though I don't feel too strongly either way and am happy to
> remove it if we don't like it.

Ah. You mean because we're called with arbitrary paths we want to verify
whether our callers know what they're doing, and consequently we check
whether the files look like a mapping file? Still a bit funny, but with
that context it at least doesn't feel too unreasonable.

> > > +	if (repo_hold_lock_file_for_update_timeout(repo, &lock, dst, 0, -1) < 0) {
> > > +		ret = error_errno(_("unable to lock %s"), dst);
> > > +		goto out;
> > > +	}
> > 
> > With a timeout of -1 we'll block indefinitely. That doesn't feel like
> > the best option to me, as the lockfile may be left over from a previous
> > process. And Git locking up indefinitely feels suboptimal to me.
> 
> That's fair. I picked this value purely because I was closely following
> how `write_one_object()` implements its logic to update the
> "loose-object-idx" file.
> 
> Would it make sense to make this value configurable? Or would it be fine
> to just set it to 1000ms? If we change this here, maybe we should also
> change it for `write_one_object()` to match?

Yeah, I think that'd be a good idea.

> > > +	fd = open(dst, O_WRONLY | O_CREAT | O_APPEND, 0666);
> > 
> > I don't think it's a good idea to append data under the lock. It may
> > easily cause us to corrupt the file in case the write succeeds
> > partially, only.
> > 
> > Our usual pattern here is to create the lockfile, write all data into
> > the new file and then rename it into place.
> 
> So here I was also following how `write_one_object()` handles writing
> its mapping entries. I was trying to keep the `loose_object_idx_merge()`
> and `write_one_object()` approaches similar. If this really isn't the
> write approach though, I can explore adapting the patch to follow our
> more typical pattern.

I think this is quite broken. Right now nobody would care because we
don't really use the compatibility hash algorithm yet. But once it
starts becoming useful this _will_ lead to corrupted files. So I'd
prefer to fix it rather than doubling down on the broken pattern.

> > I'm also a bit surprised that the file isn't sorted. Is a reader
> > expected to always read _all_ mappings?
> 
> I was surprised by this too. From my understanding, readers are not
> expected to consult the "loose-object-idx" file directly, but instead
> consult an in-memory hash map that is loaded from the file. When an
> entry is not found in map, the file is reloaded to try to pick up any
> missing entries.

Sure. But that'd still require a linear scan through all mappings in
here.

> I see this a preexisting quirk though and am not sure it is something
> that needs to be addressed as part of this change.

Yeah, I think it's fine to ignore this for now. This part here is
certainly outside the scope of the patch series.

> > > +	if (fd < 0) {
> > > +		ret = error_errno(_("unable to open %s"), dst);
> > > +		goto out;
> > > +	}
> > > +	if (fstat(fd, &st) < 0) {
> > > +		ret = error_errno(_("unable to stat %s"), dst);
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* Create the loose-object-idx if one does not already exist. */
> > > +	if (!st.st_size && write_in_full(fd, loose_object_header,
> > > +					 strlen(loose_object_header)) < 0) {
> > > +		ret = error_errno(_("failed to write loose object index header"));
> > > +		goto out;
> > > +	}
> > > +
> > > +	while (!strbuf_getwholeline(&buf, fp, '\n')) {
> > > +		if (write_in_full(fd, buf.buf, buf.len) < 0) {
> > > +			ret = error_errno(_("failed to write loose object index %s"),
> > > +					  dst);
> > > +			goto out;
> > > +		}
> > > +	}
> > 
> > When merging, wouldn't we have to verify that the object IDs that we're
> > adding don't already exist?
> 
> So typically a loose object doesn't get written to the object directory
> at all if it already exists and thus doesn't create a new mapping entry.
> There is a race though where concurrent writes of the same object could
> cause the same entry to be appended twice. This is already an existing
> problem though as `write_one_object()` also doesn't verify whether the
> object is already in the file.
> 
> With this patch, I mostly avoided many of these preexisting quirks and
> just focused on addressing the underlying bug. If we feel strongly about
> it though, I can change the approach.

I feel strongly that this mechanism is quite broken in its current form:

  - The file is unsorted, making lookups inefficient.

  - We don't deduplicate at all.

  - We never prune entries.

  - Writes are not atomic.

The first three are conceptual issues that we'd have to fix to ever make
this feature usable. But that certainly doesn't have to happen as part
of this patch series.

The last part though shouldn't be too hard to fix, and you make the
problem worse because you add a second writer that uses the same broken
pattern. So that's a part I'd like to see fixd as part of this series,
but I won't insist on it.

Thanks!

Patrick
