Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B02D5A0C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105351; cv=pass; b=NnIvEnMTKg1ncpMW4QyjK/lxru8Lr/oTwxt7RA+CHF94w6cqD1qrYeXw6nO1hqz8hxAyHBNkRz6Vzm9gBAy03WVu2vpWyBSVKny+DqiFntkpNw9YD1S1GgSEwA6JRm8RD8MbyKm6E2SYdUwgXqjWVcc3u3fyB1V0tsuS9ZZ7mcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105351; c=relaxed/simple;
	bh=Mapj/cf2WkY5UUMdNVk6iKHL01/L63g+TnNaLD2tpug=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ltF3UNkla6U5CyFE6Ru7jDd+UdOyvu4TyRrsUrEbr9rMGV1hbIWr1Kg2AIisbDnr7WBi+d105QP3c4eijZxrzPSW3GrwTLzHx7Z3L/Dq7ehUM+d1tC7EG6X5KJocT5cjGFbuweRelhUiD1B1QCIjS8Zwc9GN7krItf6/y/6Dshw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=T2N35Yky; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="T2N35Yky"
ARC-Seal: i=1; a=rsa-sha256; t=1761105338; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ea4qVBXyPho46niz1hCBG5AyOqbd5Fa68Vcj2YVODTgPwG40YF8ekmWkqD9X3j2nWsoBmDQzO3vFMOxMtaQIwtXoxAtVqfrZk4yLGfbAfEDgcD8QmCgmftqCq+QIGbmnl6r4X6JyR9nCnJYesPj54gqgnl0QMtEaCnbAXYjyOds=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761105338; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gbx3wk3FzJhEuUrXqXbOdR6KFd7jPODf3RzTOrDOjtY=; 
	b=e/pZXGbj47qyCJWdi3l7DvBPB7uC9eWCxwZ+zWbq3v5GrVlCL/YpAlSQeDkp0n5VDvt4hDG5BIFU017EBCaVCSwu3CVhUL5S0gen3MAX/YKpg1mzBMotXytI9kJofXRArbJLQHsO9BzkDsWcFzgI2sbwmEyJ3VAoljQ5cM8wel0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761105338;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gbx3wk3FzJhEuUrXqXbOdR6KFd7jPODf3RzTOrDOjtY=;
	b=T2N35Ykyz1ChKeMVGXteqg3iGl9PVhZudgn0V1iIiM8NNTYSZ62HDoxllhjw1bJU
	GcTiIBqiKyOgOlEMMOgQbeLvbqZ0NmRe2JUhDV5F8hRSd6mj69xuvbTPYEpBc+h2d8L
	ddpGwojN0aTl+NdnrMX676cpHIlxIEMIUHTxvjeQ=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1761105335898682.3760518910244; Tue, 21 Oct 2025 20:55:35 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:55:35 +0800
From: Li Chen <me@linux.beauty>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Message-ID: <19a0a0ed648.8a2243b33661009.8946324448572979174@linux.beauty>
In-Reply-To: <cbe93380-e145-4ebd-a213-928b8c3ba085@app.fastmail.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-10-me@linux.beauty> <cbe93380-e145-4ebd-a213-928b8c3ba085@app.fastmail.com>
Subject: Re: [PATCH v4 09/29] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Kristoffer


 ---- On Wed, 15 Oct 2025 04:43:33 +0800  Kristoffer Haugsbakk <kristofferh=
augsbakk@fastmail.com> wrote ---=20
 > On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > Implement a new `--trailer <text>` option for `git rebase`
 > > (support merge backend only now), which appends arbitrary
 > > trailer lines to each rebased commit message.
 > >
 > > Reject it if the user passes an option that requires the
 > > apply backend (git am) since it lacks message=E2=80=91filter/trailer
 > > hook. otherwise we can just use the merge backend.
 > >
 > > Automatically set REBASE_FORCE when any trailer is supplied.
 > >
 > > And reject invalid input before user edit the interactive file.
 >=20
 > s/edit/edits/
 >=20
 > >
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >  Documentation/git-rebase.adoc |  7 +++
 > >  builtin/rebase.c              | 89 +++++++++++++++++++++++++++++++++
 > >  sequencer.c                   | 13 +++++
 > >  sequencer.h                   |  4 +-
 > >  t/meson.build                 |  1 +
 > >  t/t3440-rebase-trailer.sh     | 94 ++++++++++++++++++++++++++++++++++=
+
 > >  6 files changed, 207 insertions(+), 1 deletion(-)
 > >  create mode 100755 t/t3440-rebase-trailer.sh
 > >
 > > diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.=
adoc
 > > index 005caf6164..b2003b70d7 100644
 > > --- a/Documentation/git-rebase.adoc
 > > +++ b/Documentation/git-rebase.adoc
 > > @@ -488,6 +488,13 @@ See also INCOMPATIBLE OPTIONS below.
 > >      that if `--interactive` is given then only commits marked to be
 > >      picked, edited or reworded will have the trailer added.
 > >  +
 > > +--trailer <trailer>::
 > > +       Append the given trailer line(s) to every rebased commit
 > > +       message, processed via linkgit:git-interpret-trailers[1].
 > > +       When this option is present *rebase automatically implies*
 > > +       `--force-rebase` so that fast=E2=80=91forwarded commits are al=
so
 > > +       rewritten.
 > > +
 >=20
 > You=E2=80=99ve cut off the second paragraph of `--signoff`.  This should=
 be
 > added after `See also` below.
=20
Thanks for catching this.

 > Probably also with an `=3D`:
 >=20
 >     --trailer=3D<trailer>::
 >=20

It would be added in v6; but both =3D and should work.

Regards,

Li=E2=80=8B

