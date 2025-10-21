Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36E252906
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040661; cv=pass; b=eGaR5SRHQCmOEBuZOD1jp6ZA59IFTHiIwwpbTxI7ygZVoBL6imeg49JAUcYdU/UcjQEJXyS9QtyoWDqgPuAHDH/bupUqel2kwudtKmY7YP0dhkzp2KHY1dMX/7H7NrisDIyiHTaOZlvdTPmNpWm4OznWN1GBWqIJUXK1VmQlOSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040661; c=relaxed/simple;
	bh=cFjN5GuFEvvSXkFbJ2CC5ux9bOY3GkH4PCGm88NbAB8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Rs6NUxyI97wWstPdoqTGF/kLCQUaZoD9nNgHTKU847sVII9UaMXjdE/dWfGcLoI7T9BYCrYRAyKKaCh68Esj5aPNoHdxoEj/Yju08yELI2JlG/WNjaOXQvsxo+4YkU+UtoYHDQ/9Ta0lCdR980PY2rycsh3ElN++HJSMJzoqIJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=QpEhGUvp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="QpEhGUvp"
ARC-Seal: i=1; a=rsa-sha256; t=1761040647; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S6c9XUxq64NA9E/+XrDLDePy/WTIU1Gn8DbG3iwIXvbhyYNd0piheZ/7VyVRtW6a2VF/QhmhxQHwu7mewMIF5bRK3NjGbPKSK/XJrQxR9JeXT+gUfxfs4wN2BNQpx+JG1PNwFbLwyxUdMH9UnPcsqo1fkaH7LSCbTp1kibuhxs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761040647; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yPaQNLofn7ZiwhrgY5AUShxOJ20X0/ZAqD4z/vAcbXA=; 
	b=Wmi45LKUieKB2N9Rttbp9YVPGPLe8BH1W4YLG3aRNXG+xpbpoqNuH5BXmYeloRhM4QKBO/IeLgdayqncXYlBUAKvsSr4++fNnLrQ4e8XOWfYyrLRVIK58rSfIcnq+maqVlNoIwv303e/2YmVtwNIsGDhD6OTvgIY3ouSsFt/FlE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761040647;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yPaQNLofn7ZiwhrgY5AUShxOJ20X0/ZAqD4z/vAcbXA=;
	b=QpEhGUvpDk+Eiba6ceAcPBNpOmK03cFCKxbWwtCjqEPBRzSaX+m84jLh5Pmf+5DS
	72G2NpfgHJZL5mz02zwC8fkJjQZD+zgIlMvQLcp5/G7CY+RhGa6hKV2ZDdkWXSxjULu
	8E6Tm8Rd+DzcLgJLUeGjrz0FnBXG3H6KTGI0eMzM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1761040643899796.2280346300167; Tue, 21 Oct 2025 02:57:23 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:57:23 +0800
From: Li Chen <me@linux.beauty>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>, "git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Message-ID: <19a0633b726.5e87d7b93115820.5703222217950198481@linux.beauty>
In-Reply-To: <a0fae0cf-a1c0-4086-bcc0-a66f1aedf512@app.fastmail.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-2-me@linux.beauty> <a0fae0cf-a1c0-4086-bcc0-a66f1aedf512@app.fastmail.com>
Subject: Re: [PATCH v4 01/29] trailer: append trailers in-process and drop
 the fork to `interpret-trailers`
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


 ---- On Wed, 15 Oct 2025 04:43:09 +0800  Kristoffer Haugsbakk <kristofferh=
augsbakk@fastmail.com> wrote ---=20
 > On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >
 > > Route all trailer insertion through trailer_process() and make
 > > builtin/interpret-trailers just do file I/O before calling into it.
 > > amend_file_with_trailers() now shares the same code path.
 > >
 > > This removes the fork/exec and tempfile juggling, cutting overhead and
 > > simplifying error handling. No functional change is intended. It also
 >=20
 > Why =E2=80=9Cis intended=E2=80=9D instead of =E2=80=9CNo functional chan=
ge.=E2=80=9D?
 >=20
 > > centralizes logic to prepare for follow-up rebase --trailer patch.
 > >
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > ---
 > >  builtin/interpret-trailers.c | 116 ++++++++------------------------
 > >  trailer.c                    | 125 ++++++++++++++++++++++++++++++++--=
-
 > >  trailer.h                    |  18 ++++-
 > >  3 files changed, 157 insertions(+), 102 deletions(-)
 > >[...]
 > >      new_trailers_clear(&trailers);
 > > diff --git a/trailer.c b/trailer.c
 > > index 911a81ed99..8aec466b5f 100644
 > > --- a/trailer.c
 > > +++ b/trailer.c
 > > @@ -1224,14 +1224,121 @@ void trailer_iterator_release(struct
 > > trailer_iterator *iter)
 > >      strbuf_release(&iter->key);
 > >  }
 > >
 > > -int amend_file_with_trailers(const char *path, const struct strvec
 > > *trailer_args)
 > > +static int amend_strbuf_with_trailers(struct strbuf *buf,
 > > +                                      const struct strvec *trailer_ar=
gs)
 >=20
 > This needs Clang formatting.

I apologize for the 4-space indentation in my previous codes due to my
editor settings, which is not align with this project(treat tab as 8 space)
I will use clang-format in the next version.

Regards,

Li=E2=80=8B

