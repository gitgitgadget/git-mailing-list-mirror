Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC017E017
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057040; cv=none; b=lgsNYf2rBkOxsw5DnfxZJ9iuTuu//1UCkWI7aQatkJtr8mVqYzKAaFZstmKnINVut5kD1uj9fK4HlfALTwQn2cvmRrLRFFJS541DDekdhwsSRunQXRc0Ttp/JA5aBKCzJYvCivM2r0C8IgEbP61OrhyrhtXSEgofAQP3brZvLbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057040; c=relaxed/simple;
	bh=oHI/3sqLu1NPj54w6QpI+FaM8SaO0GlNRp7TTqtKQdg=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=CFbXHWiR6hTkZEw0qGMfi/CZUOpOzQ75LE5VyxAeLMXNWxP1kHoJVB4IeuLmV8VXugIHAlob4/nSIFGBc7Fh0VvLYFSdu0dq9Wg6U9Mdnq/eYxH2PzjQbZLcvMPW3i4gg3dH0sgMW7dsiRTzbE+3YV4e7aPgCJ98stD3MCv9kwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=ZMStHm2p; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="ZMStHm2p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=c9BlMoo32H5Fv8LXhvg8Z4AUAO229AWZ7YAdaLkKbFk=;
 b=ZMStHm2pJtNEpC3Q+sLHmparLljkGxi74Pq1b5/3KASHStpzSAJWuULHAkVRJLD7FtSz3/t9Motg
   ejRQYBUWDtLOWY2wz4h6LATaMr1sj9+m2vVCwIwZPOiV9lyeb0v7Pcdb/tjO7LtzvRRSYKuwOnik
   KDjQkHJqJdwy6peMXmkHXsrvpdr/ZG31+sYPXz0qgImNW8QC0zOXK7wh/x88hK1JVB8R0hnnIuJ6
   l1DXP1uAwmbXCVW8G4cRZopUFASXWvExGAk/gDSauSojCRaS/bkMFAUJH8DLT9LO32AF2eqJxhef
   nqiMm0ShqqurBysjD/Px7co/3IlL6iEd5g07JQ==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJN00F3BE4S96D0@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Sep 2024 12:17:16 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 14:16:39 +0200
Message-id: <D43G52W1ZPWU.2HPFFSQEM3WGV@ferdinandy.com>
To: "Jeff King" <peff@peff.net>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [RFC PATCH 1/2] fetch: set-head with --set-head option
Cc: <git@vger.kernel.org>
References: <20240910203129.2251090-1-bence@ferdinandy.com>
 <20240910203129.2251090-2-bence@ferdinandy.com>
 <20240911065406.GC1538586@coredump.intra.peff.net>
In-reply-to: <20240911065406.GC1538586@coredump.intra.peff.net>
Reporting-Meta:
 AAHBw3gR7SKEuVSaCj4IIMiHYIjgXeumVbnS+L5vBjbVex8nHwBHtsj5gikslSm8
 3u2oZ/bgIsTM0vEFTajim4nyewXaWESMBNMb9a1yLvJ7RCBJo6Ujn/CWHA48+uzJ
 8SHCjTqzLKpnUEBs0i7wayR9iJ2pTu38YBtQC5ZV+JIhL10IX977Qh5QD8sBzo/T
 kKU3Ny930ZdNswAD+RiLNuZbnR9Gk7FAQ8+f59Yv/yEuJa8WU8jrwUbNvTaD5sgd
 Q/ABxhKhqyFQBQ7AOjSaFTE6KaUUq2pQnsbPoRYLzMUsQdfZ2D8tQuBw9mEUJGFB
 XE0VgSN4vPgBu3cBmpvpHEkGdwAYzkD/+JD1txE6LsDJ4DBBdZWg1oAQsDD7v2Df
 tVRy37JhsHZq1yoxwsWZIn2pee1qeA0Tsm58P0dCRaIKzLCxtLaJORo1R4ateyKI
 rfQeDIezLNTD34EFX5195bGOEi8My251xc8b6SZvODlKnNlUEdIoAhI=


On Wed Sep 11, 2024 at 08:54, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 10, 2024 at 10:24:58PM +0200, Bence Ferdinandy wrote:
>
> > When cloning a repository refs/remotes/origin/HEAD is set automatically=
.
> > In contrast, when using init, remote add and fetch to set a remote, one
> > needs to call remote set-head --auto to achieve the same result.
>
> Yes, I think this is a good goal, but...
>
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index b2b5aee5bf..6392314c6a 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1961,8 +1961,19 @@ static int fetch_finished(int result, struct str=
buf *out,
> >  	return 0;
> >  }
> > =20
> > -static int fetch_multiple(struct string_list *list, int max_children,
> > -			  const struct fetch_config *config)
> > +static int run_set_head(const char *name)
> > +{
> > +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> > +	strvec_push(&cmd.args, "remote");
> > +	strvec_push(&cmd.args, "set-head");
> > +	strvec_push(&cmd.args, "--auto");
> > +	strvec_push(&cmd.args, name);
> > +	cmd.git_cmd =3D 1;
> > +	return run_command(&cmd);
> > +}
>
> ...this is just calling "git remote" to do the real work. Which means
> that git-remote is going to make its own separate connection to the
> server (so slow, but may also require the user to reauthenticate, etc).

And indeed it does authenticate the user twice. I'll change this in a v3 (s=
ee
the discussion on v2, I royally messed up CC address on this one :) ).

>
> I think the intent of your patch 2 is that we'd only invoke this when we
> saw a change, which mitigates the impact, but it still seems somewhat
> hacky to me. We already have all of the information we need to do the
> update inside fetch itself.

It was more about not printing slightly misleading information, it did stil=
l
always try to get the new information with --auto. With the changes mention=
ed
in the other thread I'll also rework this a bit.

Best,
Bence
