Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70911D9346
	for <git@vger.kernel.org>; Wed,  7 May 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600423; cv=pass; b=uxYKJmBucuUWRyl7QgRH8bKb1ur8jGhQVxll1k5ZRiUzXMHV17bDwPfBbGgSaqEXced68eiWx9ESpZnSyInzJH9NZRUDUvRKmht8uWwovMneh8CcQhzI9nXjp2Z0hLRWCCzJsXDRE9M222tadI3RpayauVpSPMOmCHBz7NDt5L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600423; c=relaxed/simple;
	bh=41yVXUnbndmXsCgawKq2LIDyU9MSql9iSlXToqf0+lY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LE2tWci83Wedt6N2dGwI1mh4UOZ5g/MWpyuoDjanYO2l4JHAXdnPnbD0KndPfaiBcdOQfD0QupwuGZxhLGRx0DITeuNEB4PP4i6SihQtBzHtRzbtR7+fNz01UR2c8PuMq/CcaAtc9IJaTB6PORkvz+M7OEPYL78rLMQzxnA6iwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Exa9mQP3; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Exa9mQP3"
ARC-Seal: i=1; a=rsa-sha256; t=1746600414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ch43to1/kgD77n007NgLgOu1ApIBpDkFV7DVVQd30524s7T8Pum8exp5KmSEljV2BFZpWwm1iguLJ0A0267++qk+v6EG9tPmmq3dUo5rWl86MMNk4j7XANpz4L3SDooODY6qRLk5jmEKz9QYW/Nu5OzXbhRL2Kl1In2GrIJnrVw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746600414; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cdvj1uGE6eJfp76wBEW85KDx3SvW/dovrkFwvkvMVJY=; 
	b=ZqFWGgrBDdgxWmFr8hmhl4LRKiyxXC3FGWxGQb06Fz/TQUCNeO+vzcGqoKmQWHBcBxv35kLM5sgSFtQDrqWUYaRSv81Sf3PMstki7bU+ezqwo7aOhHm6YSfNi+L/k5EQY4MFuhgsM4FzPh1BZZ515f6GQktBh+uciuBET14xzXQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746600414;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cdvj1uGE6eJfp76wBEW85KDx3SvW/dovrkFwvkvMVJY=;
	b=Exa9mQP3mHIB2ND7HFs/7RcrxK90S5vf42cGFVWlIeU+xVJjmVuvVHIZ+AAd8Eio
	4qV5f/nXxiMVAeJuxH7Y9jsjWTktvLoQgb8VD0F25olh8mJPnTJqFyqwxHfqrpdmqDn
	nnxK5c38jcMp0UZ5ueEBM6C5HHPoSBoh2a7rbylI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746600412672252.3307613535202; Tue, 6 May 2025 23:46:52 -0700 (PDT)
Date: Wed, 07 May 2025 14:46:52 +0800
From: Li Chen <me@linux.beauty>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "git" <git@vger.kernel.org>
Message-ID: <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
In-Reply-To: <xmqqv7qdk3yl.fsf@gitster.g>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
	<196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty> <xmqqv7qdk3yl.fsf@gitster.g>
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
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

Hi Junio,

Thank you for the feedback. My current understanding is as below, please co=
rrect me if I am mistaken

---- On Wed, 07 May 2025 02:07:46 +0800  Junio C Hamano <gitster@pobox.com>=
 wrote ---=20
 > Li Chen <me@linux.beauty> writes:
 >=20
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > Introduce a new `--reviewby` flag to `git rebase` and `git am` that ap=
pends a
 >=20
 > Shouldn't this (and possibly the other one, I didn't look at the
 > patch text) be using the internal machinery used by interpret-trailers
 > so that we can do the usual "do not duplicated existing ones",
 > "append only at the last one is different" etc.?
=20
At the moment, git-interpret=E2=80=91trailers only works on a file or on
stdin. During an interactive/merge rebase we change it on the fly
without format-patch && am, which  is very convenient.

The new --trailer option already re=E2=80=91uses amend_file_with_trailers()
from trailer.c, so there is very little trailer=E2=80=91specific code of my=
 own.

Right now --reviewby mirrors the existing --signoff implementation,
and append_signoff() itself does not use the trailer library. If you are
open to keeping a dedicated --reviewby, I can send  a follow=E2=80=91up
(or roll it into this series) that moves both sign=E2=80=91off and review=
=E2=80=91by to
the common trailer helpers.

 > I also do not think we want to see one option (like the above) for
 > each trailer elements (like "Reviewed-by") that is commonly used,
 > which would lead us to adding "--helped-by", "--acked-by", etc. to
 > complement this one.
 >=20

Some projects require every commit to carry a Reviewed-by: line
for accountability, much like the kernel requires Signed-off-by:.
A first=E2=80=91class option keeps that workflow =E2=80=9Cout of the box=E2=
=80=9D; otherwise
people need to define an alias such as

[alias]
    rbr =3D rebase --trailer "Reviewed-by: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EM=
AIL>"

which is functional but less convenient.

I would appreciate your further thoughts on whether a dedicated
flag(--reviewby) is acceptable, or whether we should drop it and rely solel=
y on
the generic --trailer interface.

Thanks again for the review.

Regards,
Li
