Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECAB652
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040926; cv=pass; b=RrbPJ/fEW6R0AYnCboNs5tsV7388r6Y0TtdwRa0RH+aausbo6FW6rdA4XgyFImkvwK+CDvMfA7wcL6DLJJbj3RfgoTPgBiJQVc4UKFv3rynWnTFMdHTYrsI4XfFgoBs8HHIDyvwaGIUjO7QbrUmVlv7FJTcxshGRnx1QrkQXytk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040926; c=relaxed/simple;
	bh=ME12BYtGS5eoJLiBRxGaC1v/PgIMnNQYvkt07mim6Kk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=X2LmC6Yt+/YBiiuqPT+Tvwl4aQIYKpqW4qVmA7jdlRbJ6aXZV+QVc4zHJTrxsHlgFe7TsuUec72Nk4nPah3EeaaBCvLyvfU+gnoCZIu8641D65BQj2s4A8avQ6zfwSa4sh9Ej7/Gwl2Fwseo1DrPGZEn1Ks3xKICCVV4LomsrWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=V5wJ0LQD; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="V5wJ0LQD"
ARC-Seal: i=1; a=rsa-sha256; t=1761040916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AHteNICLKnXjveS2ir3fA9fcydm5TD6+F7f0i752IwSsweRZUhfh+gmnkAIRchDMcPsMs0G+wHmn8LH7W5OWKgPSLBSdeV665GHMY072SUbXC3jVv7ULRSUX4748H/+DJChSQLtliEcqRT29RMCzTv0rjWzqvUBgpuO6GLu0dDc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761040916; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gx/4ifxX80kc7KPLS/H6ae2xR0uRyfXPIZ8+TYYsVwA=; 
	b=D4zxc6J95ilveML6GayT6Q/v2bYZk5s2ujx2fcIz/ovdSy71rIpx1yy1ZWt4YsMFw3o9e6sTfKXuyA0PV+S5ZSyxqnObZxfZdUErznmCBClC2QFp/huCgID2mCrHjpVC7opp83v0zx07GzCpu3+qLV4S1KQ+/iiXkHHDQvlQtCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761040916;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gx/4ifxX80kc7KPLS/H6ae2xR0uRyfXPIZ8+TYYsVwA=;
	b=V5wJ0LQDLVuP1kyxvw0U/sfMxnP8ozEGLgG332cckUHpUiOBsdjR0hFhG7tc1h1K
	KXWPs/y5lzVh/pCFDJ0dTYJlzr8aH2SuFMbK0mPWsrcIqEm9hS4GeQflb91r1lDSYpz
	xvOZfoA2WUH/4LIICrpDUEOxz6mplV5OsjbEI06Y=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1761040914393434.93977213917333; Tue, 21 Oct 2025 03:01:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 18:01:54 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-ID: <19a0637d7c6.56c0ee933118113.6864199134170276242@linux.beauty>
In-Reply-To: <d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-2-me@linux.beauty> <d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com>
Subject: Re: [PATCH v3 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
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

Hi Phillip,

 > >       new_trailers_clear(&trailers);
 > > diff --git a/trailer.c b/trailer.c
 > > index 310cf582dc..03814443c3 100644
 > > --- a/trailer.c
 > > +++ b/trailer.c
 > > @@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct trailer_=
iterator *iter)
 > >       strbuf_release(&iter->key);
 > >   }
 > >  =20
 > > -int amend_file_with_trailers(const char *path, const struct strvec *t=
railer_args)
 > > +static int amend_strbuf_with_trailers(struct strbuf *buf,
 > > +                   const struct strvec *trailer_args)
 >=20
 > Function argument declarations should be aligned
=20
My editor uses a 4-space tab width, but the project view displays tabs as 8=
 spaces wide.
This discrepancy caused the same errors in v4, which I plan to correct with=
 clang-format in v5.

Regards,

Li=E2=80=8B

