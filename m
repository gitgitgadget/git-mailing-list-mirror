Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DD4B515E
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544339; cv=pass; b=JR+M6B95DRCsbvourNecVI2KIA1qLz1T3QUFjkKGRMbNwkvIeeDJK0mAg1OX7+vgp6N9qakLiKQIrxGnzwzcro7He5a6BN6lcdKARagiTU/7c+Du/BgIrs5lNTzHJ8pJArxMYvfM+jbql9I5xA5M1q+pVNx+iGxDUw+yz53sadQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544339; c=relaxed/simple;
	bh=WPovS6IovpAUabyPlRfOmKLdmRiwxdn0vU2VWP9V8S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bb1DHZFOTbhP5WT9L92AhpZdnPLNZ6ZCqyx6ZNWT8EmGKDnSpZwgeAtdeRdhWP8n/PVyE8LORnon0rrCFakJZJee1Brcsnkq20H1/v1v6MCa8V6H5qq7qbcCciMpAQk5fh2wTAMcBlK08TD32BLm4kN+hgROeVEj4HBvHQO2E50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ2ccVn2; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ2ccVn2"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6acba4bf65eso3347301a12.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 04:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791544327; cv=none;
        d=google.com; s=arc-20260327;
        b=fxTwSs48fIBS5+MDwG4/T/5/6u1DdfS0EpaU2AlOAw/2g3f/aCBu2qpIP5xyB1Ny3w
         ukaHI0GrQYQyDMu8ObeahSHF6T6xLRbjxa16m+sIzeoUQnWIJzXzMOS9RDH67d4ir72E
         P77m55mYWTjlesQuBgy9Oto78sq0dEdztfJc7zuqdZhGTpwyTyitHopTwL3D/Mzxq67J
         GWQK50nuSa8bShpvkjCLGs1V6gBW9O3SUyDefW9mbUF4s+1G0tn0r0P95zRouKfZ0Fep
         2QjsD9lsSQdSuBNO8urAh5JXLyYPGTFadmu/s6FM4sUvG1HCAUI2t1aTQNv3PGCHTHNA
         rvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WPovS6IovpAUabyPlRfOmKLdmRiwxdn0vU2VWP9V8S4=;
        fh=9aZ4rtxikRH+34ywZE67YMTEO5YbQEEntenyDxOnC3A=;
        b=L9r9HC5ues+M92Tr8Bl65YabJkWzgTQ/jMDUzDhRnoMyYdvK4BnF9KCrM8LaH1GJma
         4kAy52VkEqtdzDInHKYZujXK7hU23cv4FSPQebBgXkwHVJs2TylyEbQhpo2Adeo2Kw2R
         rgkkHKnY1oqRhHgEsTnygVDYgpn1731xlYsDEqgKv2uXRAZLuEnuGXq9UW0kjRrGIlnu
         a/axi/IebGaxsjoqTl0f62I7DzLYxJvAxddoWfe3GCbXRpCcTKRrB9Xj4CsIJ6/YCIuP
         HFKyVMUdiiZucW/Xtn1CKxXx7bLLQ3HBbDPUM4jiTmZnmsomCmz/fOOelFLYk34mjpxK
         kh9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544327; x=1792149127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPovS6IovpAUabyPlRfOmKLdmRiwxdn0vU2VWP9V8S4=;
        b=lZ2ccVn2gnGvq2dDxGkMtnsHW0s/7TRbKX1/NlO70A5fN3lEqyHqyJHJc1MvJsH+WZ
         VSlg/n43H8/8tJZY/dnZE0R55UY2sPnZ6v4F0Xp6fU3To5x4+eDtT0UPvP0vGPil9ZrV
         JGHSOKsEIvk3TjtDzgnL2R13nH0s0ls4prg6t+yj9qJFqz8wd7ML+rXhwZNqaf544Hre
         sdaoyvoe/V8mUhpdIDA4MdtokUHgUMiEFxaM7nQWPylsYF4Je7nPHwCL+Z4iuew+73Ze
         G7N92LVFuLwnl8OHVvIcrHYJMGzhwKq2Fp+pS+oPjSbvmQ3PahhqJyQOBBUNudIGfMNC
         2MbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544327; x=1792149127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPovS6IovpAUabyPlRfOmKLdmRiwxdn0vU2VWP9V8S4=;
        b=Tk1g1+VybhCInL6CrVjjn0JjBEzmuIrBSrpuXtzKQUTZQyiRmhFYFE3PWEgBxiUnxi
         g/pOp3N9IBqMnAQ/GVZDtToSZSpU8ej0vzfeFrSRqvWsOq14t+1g2JKoVBQdPss7tJUA
         +qZOwOh8e7Ge+LkD+38LSNwFJzvfKB2O5h1yKcdx1mrlZgGFxP7IySUpdjLB7RLJmPzR
         DQS0c6xnRcc5O1ghzixRWWHjEyLvFNqCqvb5Q6ZTmWtwDOzD11DCputDSPYFZ5IZtxOe
         UL5nqwUhAJWSExufbFdsFCSFYaZC6YzKejOp1pB1TEtH4iXyc1YUw+qxcq0y/wPGX440
         Dczg==
X-Forwarded-Encrypted: i=1; AKwUvBz6ytqPYnImfAoIBwqVS9iBYEbHlCj8g+paaOmS58NUY8+bsGShGMHcpF1RKpEDwXoL2U4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/UrB5sKyppmFUIKXmEITLPKi6hu6HaPSZcVKRU6PkNEVM29ZF
	QIHxmF4jMT+hHeN+1qUVz0iOX+FbZmGiRqp/srLRfDSXp6XeehQn3KpALiZJz6giX1kljFTf6a+
	8QEIPa8qKdFwdxH6j2PCiQahSkFklfws=
X-Gm-Gg: AYBFou3I5M1yrfjOM99b7NnsDa7IqhO+ElH9hqnFukohpiNPYkvUz5toLscBy+lRF/W
	YP73SvKmUeLIqVNDR7dfDWNbIWYEbfHmVpVpHA6lBTaGg7g0JcUm+0MmDI0iEjxT+kh+5Y/0w+m
	ndLj+1RauUoyqVKkrKZTxJx/FE68vR5zIqFUoHaJdYoNhVubIyE6PAtVxmti4ZwLJwEJlaU3ate
	NuAgFJujceP6PuAQkZkLtJTbK6Rmi5orATSxtzUxFr9+XaIbx3rFxOqcpyDPQ5tE0UrsKI1v/0b
	JCGx8it8Y+MG/Vu4oLg0m2Eo4HhvLdUVLy7wZ9hxg6cSyAi4CEfgtdM=
X-Received: by 2002:a05:6402:501e:b0:6af:dc4c:5f23 with SMTP id
 4fb4d7f45d1cf-6b17c23c67fmr1276749a12.13.1791544327356; Fri, 09 Oct 2026
 04:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com> <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com> <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
 <cf3bb2a4-5956-4ba5-9957-b0598f22a122@app.fastmail.com>
In-Reply-To: <cf3bb2a4-5956-4ba5-9957-b0598f22a122@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 13:11:30 +0200
X-Gm-Features: AclHuK-GtKfIr38lBIKpxB2DRLYntp3JY7PYzP7wk7TOay9GQqti7iUFM8j4hqc
Message-ID: <CAHwyqnWpWbeknZhaOzWfAmvQVQkDmKKmVYV-p_Zu-z7t3FA5+g@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:16=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Thu, Oct 8, 2026, at 20:42, Harald Nordgren wrote:
> >> Even an efficient implementation is going to be a lot slower when it i=
s
> >> trying to find branches that have been squashed, so I think we probabl=
y
> >> do want a way to turn it off. That's especially true in partial clones
> >> where we'll have to download a bunch of blobs to do the squash
> >> detection. So long as it isn't diabolically slow enabling it by defaul=
t
> >> is probably fine.
> >
> > A bit slower (depends on how much!) could be worth it for improved
> > usability. This is not a command that users will run multiple times a
> > day.
>
> I would really like a solid delete operation that I can run, say,
> overnight. I have better hygiene practices today but I didn=E2=80=99t bac=
k then,
> so things have piled up.
>
> One big cleanup is worth a nightly run. So I don=E2=80=99t care about how=
 slow
> it is.

I would love to have a `full-clean` command that bundles
`deleted-merged` and all `prune` commands, and uses sensible defaults
for each one. (I have a hard time believing that it would need to run
overnight anyway).

I have known people who just delete the whole repo on any signs of
trouble. People out there are so scared of Git, so let's give them
sensible defaults to work with.


Harald
