Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553042765ED
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865341; cv=none; b=aft+HmLBqZCvPLulKGZfQj7FgHFJeO9teYEYwEqT6QPVnpDSv+RYzpEtQW/ZT4xsBSvxZ9OVQ7rFju0aFNiD0pLFqZ4nSQW6LK9lbPmeueFAGxNm7Ap3+1/g550Lz2QWPaqNtSg1xuCvOOcNaLskf27VVbQD/uiv08pRCadApR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865341; c=relaxed/simple;
	bh=or9IWd8CWtjOIWYa5VEB7vXX+C1GaVO4GJ6nYkSsRZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM4QdNBq5CRsPYu32/0PQyTsYtLDpkhGDGzoVNe9NiOfw6pMdLERiAkeVUZMJ1RO4QKuc8W9asEuLOQY05qXkeT6SFXBc8ILBMGcDxxreUBlm96QUCH3f2KdmHDkfMLj8BSJ52EeYBy5HZgAz4ZKEckWpiAO8QoiXYIAnIIrZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ol5XkYYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWD1FLmH; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ol5XkYYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWD1FLmH"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 58384EC00CE;
	Fri, 22 Aug 2025 08:22:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 22 Aug 2025 08:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755865338;
	 x=1755951738; bh=QReALSWvnt441DBDfYSqpMFcplt3D0Wdao9pEQu3W7g=; b=
	Ol5XkYYYOo3VjXPFj2RDVFP6d0iAzG/KWumlXQOY3HJi5pEBTqXhwYiR3Dx7UNU/
	Mm+GhEy7AAVP4rM6GBkqcyCgQ5wCtXT829KOpWL24SBLZMn6Q467YsEXN8fXIR+P
	Opl+Phbg+cEGGVHHLLdC6oY6TQFkXtvoll5+v9+goEBtTGMjrrBSTpHDGmnDNkf4
	vOYko2AEB13nPUHGsnjKfvLfQhfE5gLtjx0t54ozGWlKDlwfi+6VdMTYi95SqQXE
	Htf4ryl/KCdDGQiiVQBzITPAWVv5pksXrdPEX3/zcWE+1IDt/7KLyDlouUCre71R
	6b6UsruZH6iq2g8S67Oe3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865338; x=
	1755951738; bh=QReALSWvnt441DBDfYSqpMFcplt3D0Wdao9pEQu3W7g=; b=b
	WD1FLmHP9hy1rlPDFJyQwk+1DVXBPDNtlofAX0E8ZHKaPiZHu5zqyU3G8rE3ycw2
	nlaSs38G9vfWfQpBSUVd2tOT8nuh3FM7cblFcOCwJiVLkf/UiX+gw5kumTvk2kNn
	TRJ9yJkmD/VbElFma1Ozh4ohpbUHSrzJGJaMdj7kXqmrBOah0lUQm+veAb9+Hh2M
	GEG75q04Wu4dCuL07L5ZFTTcQuvrK23JV17ynPrYVch/tj61jpoZ8PyOBLaIKalq
	Sa169pKF/C/zBpFyGWiRWGkAsFOik2ghZhe95q257cd3dLKMoZk2PiC1OzUM+SSj
	476jGEH/05OV72NVKSYGw==
X-ME-Sender: <xms:-mCoaG1RSKEyKLOG4HDKCyBb9Q6LphfG_VstCzcte77p0ubkaYliHQ>
    <xme:-mCoaJSPt2_8Mb5_S8y8sGtLf2ZShJX3rOLQiHAlc4Z9YDz7SSSJc8kUDJWyXjUAk
    SOKA5iX6nPLiBicZg>
X-ME-Received: <xmr:-mCoaAtjcViqcSFbayvo5cYtnd3r-pZt-k-owsUjb55ElbGGjFG5sDHQuKoD4dFFYXLL-EXmW4bJM1q77KkQ0X_C71gGuCR_lB6YQ8CE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-mCoaGaLLUmYSEWkVdtcqmsbycDmmTD2VASBeF0q9StfqLtvwshjeg>
    <xmx:-mCoaNvpQaf6mcbKwFaTkBfeD5eLdVHHfQbA16kv1Uo89cRWFBnIXg>
    <xmx:-mCoaAEHpMp2_xbj8d8CKO0QpwpgIwddqHEYThoUfGLpUSxMqWOCEg>
    <xmx:-mCoaAzZ36q_WP6ZN-Iup7KIZybHoRQ6XO3O3a1FYZKLmU-CxWA2MQ>
    <xmx:-mCoaAbBmDYdAigexW-Tkw_W_d0yYofJHzfrvB7uLQxA5JE3AqL1FDdC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:22:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecf7f131 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 22 Aug 2025 12:22:16 +0000 (UTC)
Date: Fri, 22 Aug 2025 14:22:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
Message-ID: <aKhg8q-AAlsGDvFS@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
 <CALnO6CBuwDVMZ-QTay+PUiXKsWMsABJcs1pAB=uUXf7-DJ4Mnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBuwDVMZ-QTay+PUiXKsWMsABJcs1pAB=uUXf7-DJ4Mnw@mail.gmail.com>

On Wed, Aug 20, 2025 at 05:27:32PM -0400, D. Ben Knoble wrote:
> On Wed, Aug 20, 2025 at 5:05 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 6e8b4e1326..f0f1f2a093 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -47,6 +48,26 @@ reorder <revision> (--before=<revision>|--after=<revision>)::
> >         commit. The commits must be related to one another and must be
> >         reachable from the current `HEAD` commit.
> >
> > +split <revision> [--message=<message>] [--] [<pathspec>...]::
> > +       Interactively split up the commit into two commits by choosing
> > +       hunks introduced by it that will be moved into the new split-out
> > +       commit. These hunks will then be written into a new commit that
> > +       becomes the parent of the previous commit. The original commit
> > +       stays intact, except that its parent will be the newly split-out
> > +       commit.
> > ++
> > +The commit message of the new commit will be asked for by launching the
> > +configured editor. Authorship of the commit will be the same as for the
> > +original commit.
> > ++
> > +If passed, _<pathspec>_ can be used to limit which changes shall be split out
> > +of the original commit. Files not matching any of the pathspecs will remain
> > +part of the original commit. For more details about the _<pathspec>_ syntax,
> > +see the 'pathspec' entry.
> 
> Glossary entry?

Yup.

> > +       /*
> > +        * But we do ask the user for a new commit message. This is in contrast
> > +        * to the second commit, where we'll retain the original commit
> > +        * message.
> > +        */
> 
> Interesting. I can see using the original as the template for _both_,
> or the first instead of the second. jj's split works a little
> differently (especially with their notion of descriptions), so I can't
> use them as a reference for the behavior.
> 
> I suppose this is one of those "everybody has their preference"
> things, but I think giving the message in both new commits as the
> template gives splitters the most information available when writing
> the message. (Of course, in my editor, I can presumably do something
> like ":Git show -s <split-commit-ish>" if I want.)

I think giving only the split-out changes is a reasonable default, but I
can totally see that we might eventually want to add a command line
option to change the behaviour.

> > +       if (!commit_message) {
> > +               split_message_path = repo_git_path(repo, "SPLIT_MSG");
> > +               strbuf_addch(&split_message, '\n');
> > +               strbuf_commented_addf(&split_message, comment_line_str,
> > +                                     _("Please enter a commit message for the split-out changes."));
> > +               write_file_buf(split_message_path, split_message.buf, split_message.len);
> 
> I also noticed the commented template differs substantially from the
> regular commit template, and my editor doesn't recognize "SPLIT_MSG"
> as a commit message file.
> 
> The latter can be fixed elsewhere, but for the former: perhaps it's
> worth using the usual template with the wording here prepended?
> Respecting commit.verbose / commit.status, too.

Yeah, that's something I wanted to get around to, but haven't yet. I
also noticed that it's not exactly easy to figure out what you're
currently editing without that lack of context.

I'll include that in v2.

> BTW, if I quit the editor with an error here, I'm left back where I
> started. So I'd have to re-stage changes if I wanted to split again,
> which is a bit different from how interactive rebase will leave me
> with the partially staged changes. Obviously that's harder to do with
> the in-memory index + automatic re-application of remaining patch when
> finished, so maybe a note in the docs about this being "all or
> nothing"?

Yeah, fair. I guess adding a note for now is the best way to go about
it, but this is certainly something we can and should iterate on in the
future.

Patrick
