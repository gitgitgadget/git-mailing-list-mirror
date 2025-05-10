Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6912ABA27
	for <git@vger.kernel.org>; Sat, 10 May 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746905552; cv=none; b=IbgTR5F2/j9o8mDJ7oh641Bmz+Qqv2Mb6cblUUJrPKTQGyvznHlJpoCQPbhln3M/TXTq05bYgoeIrTEglPIAIEtbWS3HhRLWOMsPiEPGq56XDtR/+5qTVPTCupIvWtRg3MbzUK7WDhFIR40onr7Ol2QPY/IOLrB5EF5kDGXIgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746905552; c=relaxed/simple;
	bh=3S+wOD16MpY/smNp9WVSO+869MR2iTN5RPe9TxrkGSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnFVi+lTUNbKU5T78EsKp4zGUVgV2lNam8w5nSrZbe/QLL9ZOnXUtpB13CH5IhnIxvaK4acIM2O9poNgA0Ks4zeYIjVIwpVyet/Z4agBlpwkk0o4Xzux1vU+bVl6BhDlDQJyFuCDTLIhMUn8XNAUHmnll3To5eMoMvd4DbggLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6+n6Cnj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6+n6Cnj"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad216a5a59cso300187066b.3
        for <git@vger.kernel.org>; Sat, 10 May 2025 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746905548; x=1747510348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55tfwiHoTB+Ufi1kg/ow9VmLo/5guJ7j7d5XMwrOjsc=;
        b=H6+n6CnjgM1/7NwKWiYGC1QVQ/4hTOYI+kQmY8damJqtNO+c7DScjkQ971UM+wd55x
         ES55eTNxniHynPQOexdsX3s3RehxRCbElPJmOQHjhB2hZb4nICaJ8MAAHDuoi/gpWdGA
         /47wfiFJ/5IYTqGyeJ2cTeZpzh1YdDyAen29q2WJ6RM6j+Ymyh5IznfzqUw0rZVPXDtl
         0K66Lfxp16j1cM1DPuxP7t9YVYpq6iyLe/JKv/HbAJJkp69k9ZMY8Tjn7a6afr9U3R/d
         wYsPtbgxOp1g4FhFCXEKWFxh8gOLAWroYXSt16CsCGjOLmc32t/KoXogeZBtNuYdtKKp
         Mr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746905548; x=1747510348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55tfwiHoTB+Ufi1kg/ow9VmLo/5guJ7j7d5XMwrOjsc=;
        b=vH4HJGN2QewTtL3QkJ6vg2+QIkLLEq9U0QXdTgN3bsQTMsNNdqUainqYOGgEMRU9+2
         K/72JxPe4AD5wPhQIE0ZTFDP2pfyy3I17Y0TZ1pJWY8WxwFfSxD21lwn4+IBvY9lGUBu
         kq1IuonLGPjAYHcFsEcucsLFWmksp6z4i03qTOwkx/KdtmuloSVBj3dZ2lFGFpy+H9Jk
         RmpmKZpbzzgYAoTUJ/uJv28dliPEY+oCAdJ35BCQdS9eTlPC4oH9JWTL3JcdLoDnlDoa
         j549KXDM2qcs8gH5Fyx+V7KLOB0BCm3oKfVhwT0I4XAu4J+F5WsDX6hY8s5ovcrzNPwb
         xggQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmtbvwY1WLaAEC/dJqJbB1TyksB+DYP8qJJK56b/w0pd4xSPourJtltdWtOC8FV7Bkkn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8NP3a1nXJXa1EWESaxEP2SCpsAzm5jc5PUKgphPMR9X7XkOZT
	989o7FiIHWS6iv4M4wOq3ftuoDYTZX+UmFLJSEYAMS1Fql5z94A4a6XvSkCS8GNIbw7ZJ2OyzyF
	evM8+2r61WTTRd4Yv8H2sM35+LqM=
X-Gm-Gg: ASbGncv3a2pgxuVzmMbFcgzh+/in/z9LSM3HLdOQsDB6tgMXCuWKSn4duvASJniHSP6
	tQPmEOQpKmn/Sea0XrA5rjRP8N2Dq1Q875Go5Pvgnn8fQPnp+2uprerRwqIrvwPPjzTzC0ylKDM
	QRqgvUiNDLuXVPbmNkZg7MRZ1kztg4g/+9FAj1pWjH5wCJkJ96vY2BXQzgXd381rghvw==
X-Google-Smtp-Source: AGHT+IF3oZxaA0ySjzz+gGprjLY1ob1tY6j98gj4fbWXJaCFIoaJZIu3R8yYf56L3ZYK5tgTIbIH3A2plz1odarM1+o=
X-Received: by 2002:a17:906:cc5c:b0:ad2:1a60:f83b with SMTP id
 a640c23a62f3a-ad21a60fbd5mr587617966b.11.1746905548437; Sat, 10 May 2025
 12:32:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby>
In-Reply-To: <aAgWytQNqtLzg2TU@ubby>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 May 2025 15:32:17 -0400
X-Gm-Features: AX0GCFt86MN0bH9JwxAid2F408_IctZrwedgD7r-OQ7tIouByI3RzEb-DGW_VE4
Message-ID: <CALnO6CBq2cqBAhzMh8rnXzc8cPTsB4hz98YVn3B4+PGdiyn9_A@mail.gmail.com>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
To: Nico Williams <nico@cryptonector.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>, "Theodore Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>, 
	Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:23=E2=80=AFPM Nico Williams <nico@cryptonector.co=
m> wrote:
>
> On Tue, Apr 22, 2025 at 04:17:03PM -0400, D. Ben Knoble wrote:
> > On Wed, Apr 16, 2025 at 7:36=E2=80=AFAM Remo Senekowitsch <remo@buenzli=
.dev> wrote:
> > > On Mon Apr 14, 2025 at 9:54 PM CEST, D. Ben Knoble wrote:
>
> [Responding out of order.]
>
> > > I think it's the other way around: Building a code review UI built on
> > > git and centered around interdiffs today is _hard_, that's why we don=
't
> > > have it yet. Adding change-ids to commits will make it much easier,
> > > paving the way for these tools to be implemented.
> >
> > Fair point, although GitHub's detection of force-pushes makes me think
> > it could split a PR into versions at that point, cross-link backwards
> > and forwards by one version (from the force-push detection), show
> > range-diffs between versions based on the target branch of the merge,
> > and even follow the cross-links to show an overall sequence of
> > versions.
>
> GitLab does something like this for review comments where the author
> updates the commented you get a link you can click on that shows you the
> differences between version n-1 and version n.  GitLab does this without
> change IDs.

Does GitLab's output resemble that of git-range-diff? If not, it's not
quite what I had in mind ;)

GitHub's "compare versions" button (after a force-push) is more like
"git diff" on the 2 trees, which is only a fraction of the relevant
information.

[=E2=80=A6]

> > But the treatment below is something I agree with and failed to
> > convey, I think: namely, URIs seem to encode too much
> > "unportable"/"specific" information in Git. I feel like the current
> > design is not really "tool-agnostic" as much as "built on a universal
> > core." That seems valuable and prone to more longevity.
>
> On the other hand URIs can easily be dereferenced, as long as they are
> not rotted.

Rot happens, though=E2=80=A6 your point is well-taken! Most of Git seems to=
 be
valuable in the presence of linkrot, though, and I don't see how
adding URIs keeps that principle alive.

> > > > Which begs another question: what/who applies the initial change ID=
 to
> > > > a commit and when?
> > >
> > > These are all great questions, which the originally proposed format
> > > (fixed-width reverse-hex) has answers to. I think a URI would be
> > > strictly worse.
> >
> > Well, I think we still missed "what/who applies the initial change ID
> > to a commit and when."
>
> Some possible answers:
>
>  - The user constructs the change ID from other things like
>    bugzilla/jira/... ticket IDs.
>
>    This is OK, but probably not what OP had in mind.
>
>    If the user needs additional sub-IDs just add a -{N} suffix.
>
>    It's on the user and utilities to keep usage consistent.  CR tooling
>    could refuse to allow reuse of change IDs after a CR is merged.

Yep; I think trailers are the common version of this today. And ofc,
see linkrot.

>  - CR tooling edits your history to add that change ID when you create a
>    CR
>
>    This feels wrong.

Yep.

>  - CR tooling creates an 'empty' CR just to acquire a change ID that the
>    user can then add to their commits, either manually or with utility
>    that does it for them (but which they invoke).
>
>    This is alright, though a bit annoying.  If the user fails to set the
>    change ID, then it's no worse than today.
>
>  - The user adds it when they update an existing CR by manually editing
>    their history or invoking a utility that does it for them.  The
>    change ID comes from the CR.
>
>    This is alright, though a bit annoying.  If the user fails to set the
>    change ID, then it's no worse than today.
>
>  - The CR tooling adds an empty commit at the head just to hold the
>    change ID and any additional metadata for each of the commits in the
>    series.
>
>    The user has to remember to fetch this commit, unless it's generated
>    locally, but they're going to fetch anyways so this is ok.
>
>    IMO empty commits are annoying.  (That includes merge commits, but
>    then I'm a rebase workflow / linear history zealot, so merge commits
>    are also annoying because merge workflows are annoying.)  But I would
>    think that empty commits that include metadata about code review are
>    reasonable and tolerable, especially if their subject lines are
>    descriptive, like "CR: {cr title here}" or "CR {ID}: {title}", say.
>
> I think I'd only really like the first and last of the above.
>
> Nico
> --

Thanks for thinking out some concrete options on where IDs come from!
I think I've gotten even more confused on how they are supposed to be
used (which should probably inform the implementation), but hopefully
we're getting somewhere :)

--=20
D. Ben Knoble
