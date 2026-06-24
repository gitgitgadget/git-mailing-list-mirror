Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183181A3165
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317716; cv=none; b=A5a2FSQ/02LxtTpTdGWdonxrplD/RDcR938MYWD42/BYveEqEaWnuV6AXRL/bA6k+5D6zMr7hUKszl6kSERCDWAajsou/AAmk0N74pRqxRM++ZknYtzRPFBwu4D5zCXcHq/LdYtuIy2/uIgU9qQCptJc361KV7X0MBUS8cueaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317716; c=relaxed/simple;
	bh=JzzAQMMtdf5YisQ8Qg69Y+W8hYapld9W3TJnROuMrtk=;
	h=Content-Type:Subject:Mime-Version:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=GdjArtzy9ZxmNy8vIxaLT2kfQ2AFEmVaM5eTUhpP8DpXGjTk3kdvwAkd5TwD96ClaD6+qd+/p02MtDOzDBUPtIzpGfffkA6KPWr1cWqaaEZMROGFuXZucv2v5kb/8OFGDsoyuyIojrvPHChwdSQE0Qzs7FK9SHOtxrceDRLwERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhZj7AXO; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhZj7AXO"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6626cd98209so1203353d50.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782317714; x=1782922514; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzzAQMMtdf5YisQ8Qg69Y+W8hYapld9W3TJnROuMrtk=;
        b=VhZj7AXOh7kbK7TVuavgmUwc7oXQkGgtL11nIUvxkrF4caP19UDer5JrXv+MLjS7Do
         IZVkpYHIliCj/eHypy3I0Jj0u20IBu6olIl17c7y0eNGdrUraIkHAA0dXXwCxwWDp3jS
         68f6uLRJNENWRjYreF7jp1Jyr2E5Q/6sk3vEhf8ECgAwVCXJmJWTOnZBWKJgcTXFllAo
         za8xezJ6AoIJ+xcia+vLhf3WP3Mq/GvyeyI1eTki3FYt929OzcXWkrnMtVs/07q0F1TE
         uLbwFEjGp9Y9MKGFJSuGsoHFvz3JM6jN42EZ2kEbLYS8sAwWOhUQ3+lCqMW4hN2rnPez
         87EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782317714; x=1782922514;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JzzAQMMtdf5YisQ8Qg69Y+W8hYapld9W3TJnROuMrtk=;
        b=TNWFhO87stx3rb7ZiCnXd1ieiP+xb2lOFxHBx7bCedj7cyzoaMEfBnkEs9PYn5rnvS
         KkarTfFjL3u7cv+buNtL/VzeqZAfm5dcSYGoeM3IyaKskzAQGo7wsu1c3xJEmsBvrEVx
         d+z+GSkLXxNgN1bkdtKIBtW+VufeRrbjjS+mDtb93sQa4yjgDTiRm9kgXUmAcEWT1DGS
         pOu0/GzUyfPt/gr7YVQDF8v9DKK/m3WakE5b/QwH/1e/YZinSGykgsVIKX3LdLgW0KJL
         EkaOPNYUq4EfNRnWbNsVuOZ5GcmAdk0oEYaRVSHbYyTPuDxRRs//NQKuGe8xXleR8wRu
         v7eg==
X-Gm-Message-State: AOJu0YwKullKr9dwoiZObv0hOUb5tRwZi0xa3X2ZL3fEoocj3whf6yDH
	NPoeL9VWG/djNjtojWVrrj0wd8vYimYs8lytL83X+thieSrDpjx2SgHvn7PucrA1
X-Gm-Gg: AfdE7ckAChcTIoWxVx0G58/wwyXTTKTYSf7cUXSQHG3G+VFMx7ubyjCGLDS5YiK+ApS
	phynHEflDS7GrJkmOFF0uh97c81wGJG1EzGqLngRnnueUjUcpgecNJRU1k2BBNSIJdF9z/dY4oA
	Rgm3oisWj+EvA/AwRtBVUsj5a/2DpP5/NknkSgSSa4QL4KCs9xmuGPK8kHc5HBDcRDrfSEJP0WC
	407swZf8Z6dDjHaOt5is4zqwZoIWvy0EU3wymWCahEtOysCpfRfqew0Uo54LD97TbLdtP1au/F1
	q6eQyGcrLk2qHpdk+d7y0Ifw5kubLtOXImbh2GMTWBkcMDsWXI3OVWfgJPtmV7waBBQRYFe6moQ
	Ux15D8iEORxnF/PLcFJTsI1zby52lXnbFt5OiqVRif2grjbieZmTsm94g+4Z1zbwsEWVtAP3bKt
	6sLNDS0EJES3HOiVnFiJ7HALd0Ld5n/MWHP9Bn66md7dkJ7kYUAS48TTMCyVXRb9Vf3C9Ev3Gvk
	2XSzCJKE1/LmSQL/l22L2EHAX7x5yUt2vY=
X-Received: by 2002:a53:ac96:0:b0:662:f0e3:cc3e with SMTP id 956f58d0204a3-6636e4d795cmr3583250d50.35.1782317713802;
        Wed, 24 Jun 2026 09:15:13 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:b42e:a656:86f5:91b0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f963737sm107434d50.16.2026.06.24.09.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 09:15:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Fetching missing submodule refs unnecessarily fatal
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: C41878CA-0ECD-4B33-B4DA-2E58211DED99
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <ajvouniXVAPH8nyZ@mcrowe.com>
Cc: Git maillinglist <git@vger.kernel.org>
Date: Wed, 24 Jun 2026 12:15:02 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <BEBEED4A-5677-4B74-9B69-E1614158ECD4@gmail.com>
References: <ajvouniXVAPH8nyZ@mcrowe.com>
To: Mike Crowe <mac@mcrowe.com>
X-Mailer: iPhone Mail (23D8133)

[re adding list, woops!]

> Le 24 juin 2026 =C3=A0 10:24, Mike Crowe <mac@mcrowe.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Wednesday 24 June 2026 at 08:39:39 -0400, Ben Knoble wrote:
>>=20
>>>> Le 23 juin 2026 =C3=A0 11:04, Mike Crowe <mac@mcrowe.com> a =C3=A9crit :=

>>>=20
>>> =EF=BB=BFWhen Git fetches in a superproject with --recurse-submodules, i=
t appears to
>>> try to fetch the corresponding submodule repository commits for every ne=
w
>>> or updated superproject branch. Presumably this is so that everthing is
>>> ready to switch to one of those branches without further fetching.
>>>=20
>>> Developers may create commits that contain submodules that reference
>>> commits in the submodule repository, but those commits may not be pushed=
 to
>>> the submodule's remote repository. When the superproject commits are pus=
hed
>>> to a personal remote branch anyone else's Git fetch cannot find the
>>> corresponding submodule commit and fails.
>>=20
>> This is the part that confuses me: if a (public) commit of history refers=

>> to a submodule at a particular commit, and that commit is not available
>> anywhere, then we won=E2=80=99t be able to properly update submodules whe=
n using
>> that commit. That creates a problem!
>=20
> It does. But only for that user's personal branch. Even though it is
> public, a personal branch is mostly only for the use of that user and it
> doesn't matter to anyone but them. (The user is probably working
> simultaneously on both the superproject and the submodule.)
>=20
>> Why not instead make sure the submodule commit is also available for fetc=
hing?
>=20
> This relies on the user realising what they've done. They might even think=

> that they've made the right submodule commit available but forgot that the=
y
> rebased it before pushing or something changing the commit hash.

Yeah, the recurse-submodules option for pushing makes this easier to notice/=
act on, too.=20

> =46rom a resilience point of view it shouldn't be possible for someone who=

> can push changes to their own personal branch to perform a "denial of
> service" on anyone else fetching from the repository by making that fetch
> fail.
>=20
> I hope this makes it clearer.

That does make some sense: I wouldn=E2=80=99t want to get interrupted by a c=
olleague or collaborator=E2=80=99s bad push of an unrelated branch.=20

> Thanks.
>=20
> Mike.
>=20
> (Was there a reason that you didn't reply to the list?)

Nope, mis-click.=20=
