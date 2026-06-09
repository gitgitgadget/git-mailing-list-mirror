Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773F3F4117
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000058; cv=pass; b=c1uj/MRSsdQcrSMJ1GWRB85bC/95aDBdedzDMZYwDrhe8OKk25EI6vujYRFsRxx9oa+LbS6R3SMaQfu9E5adS/qJXWw2qCYsEupM88vyflVaNeh5CHE1cNjAmcbiR3qRyp8L1QWGTL6ilaJs4dvKdA164hU5t4waY8B8MhQWMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000058; c=relaxed/simple;
	bh=QhrA6ujAXFq/62kaUHBc35NwNOGM/F3/IcVKkv+iF9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th1J0cETcBFN+ezhR6JBKNmYue2taXrslEjREE8G3bwmtH2IMZJk46/SlvKS1yyGvvT5NFr0+bkFJFnYi4DDayZutA/KGn6t57EifCT4LrWKmgo2oRNw9UPwLO/o+hJtNI4mn/qSJsYEBcCRNymu16tPt8ZPTFudSp84k9xAsEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Biujew2m; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Biujew2m"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ddd3d67084so58140917b3.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781000056; cv=none;
        d=google.com; s=arc-20240605;
        b=ArueoIeVWXcssCFF1oxV7iRnBhZb4IZ2tWNPABkgGKyS5ne7retULBboHRuacB+DL6
         6WMHWjnnGL8lZg1heQiepZbDAwnQvdyUaiZcnfNkABVRfXf5hMAxcX6FCZ85lZuw2JJ6
         E/tNk/R1lewJuUC1CGFH8Uktpa2xBu2IIUgaII6V7tLfcLxmdKLG51Aydv6PL30RVhoy
         +knoapPlrdNT0esNZjWxe/GYZAxlnB5Oe3iZ9JY/CcpwOgASYbmGT0O01QWdXHaDDrn/
         9VZxBNcRzcyQ6TS9FmNorJG64eBWTZcpoPHaXHlPCwk0lP0nV9g33lfoXowM8wy/QFym
         84zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0aPjIeZel158zYoRVe+JyDNJ+vg5CwT4JEq5G3C7FaQ=;
        fh=m8B/XNuaTqYsNUOoywnyMFBQHQdEKktYU2HE5XqewuY=;
        b=LUT3khlyL7TfhZUYJ9sF9IsIYilE09NxVfcediSrIwjTXbgL6e3M7Y7DAA2AYhPsbb
         wYb0go5rsHEgeFbdc0vDU4kzsQ3PuznNkTSXjg7WaEF5/SRew9r2Rszu9x/fsJVBvsTu
         z5n9oEaQAPf2qzQgXU4+rKe0I0SZujE4o8ofXCwjjFYw9fix+iPTvk2/6G6MgZrjOkUF
         7AqZZgH9ySnY8ebkl+jpI04EJHyz9uHHXSh9Jk5/UJ/rdYWnpcmbxZm0SC/+InM70cAN
         PDsmvAgPSef/62TeCSdIpn4o9nUQ5cxvgXa6JUSmXtu1lggq0SBbkudYqZ7GQeUKaCZ9
         f8hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000056; x=1781604856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aPjIeZel158zYoRVe+JyDNJ+vg5CwT4JEq5G3C7FaQ=;
        b=Biujew2mfQE95Z1mZNlzecMapW07vlBocK5WtncthaJg/0gapQbJjcBz3ksvR3lYE6
         65hezCJkjJmfhi5zuyapU5WVBzAMMkrUof0cdG9uiSYer8J1613EL2H4+wABrcwrzoDH
         fN4Q199AySRo/c1ANj39OJOl0xd990KiEADUmCJLsdOSUx5IyLKAt4qzyk7VNOntAujl
         8DnZfxtZXH55WBMoExs0/Qi6uYn4cme5Me3xuGk4t25GGOcVToBaGuBN9Jvr/4ICUCoK
         jdvTbzKHOj03ZpnGfskITbXZrk7I+yV4lg3Mre67BhFwMJ5ZgFev8m4XDbhkjQEgl1//
         JvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000056; x=1781604856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aPjIeZel158zYoRVe+JyDNJ+vg5CwT4JEq5G3C7FaQ=;
        b=GVSSV//rtcriELTNU+UmxyP+THEexsJseowC1T1d7Ap06b0jYo+YfTmreeO737bKAI
         2SaFAwJK1HYphtRPjtwMb7NvCE6E+3TDEPoiOAqKlYDJWlulnrasoynLWIap9GJrG6qW
         zecRRzaa0NLWpUhkRhfTjXP2n2FiNNglMScwUgeEeKQcnq2PabxmMWgXMS9H6QQMiWe+
         A/+euAqkBIuzPQNFQp2ErxykxyZSxyp0FW7nZcfizrTKNOyswQ/z2vVTH0gfx9e8//o1
         7RGArQIa61QiXyIz125vwnWcFL4vaXH8w3JujzMEicT8HlieF6JPrJmEz2QqrSyZsiwL
         EMSA==
X-Gm-Message-State: AOJu0Yz0gaQ3C1ttIEEA3mhxM/Y7uO7PjN2vohBdT7r1Ds3uFaA3meux
	BaHxm1fahXD1EpRjSeoGpU7z6OMx6eKySlXQoQMSCJwzWtHxDI6twK72CKCEKqVUWjE84sxz6jt
	NiLstl2R/ub2QqhKJd7zE9jgv7lwHzbc=
X-Gm-Gg: Acq92OHHm6sBjogtjJx9QrceWym6Vxx4LozKB8cwRWPLCPjQfA5YD6zvX6DrMG2AHmP
	jmEGv3OX7CMD09f4NsCvzpes8NfCR3GRylr7GnZJuB/CXXLOpRI12h/9u0I7NdUzdu/dKmg+NHO
	ccglbDLpGoJL5VOzN3KGmKAXKzXtL+rSZ0OZQVPPQhQ2UdWqvPqRYqoLeJseYKzjzSF+M0atnat
	N/R5AdPAepeICGDJM5utMhsJ9p6y9lzxwbIOxxhfdA36IYaBSSQ8c9XFNWsROyTh1F0YCKvxh/4
	BfsKUwjQoXIyhSol3FAjLtK1z6tE2THlclxUisT4AXAEr5D7BSsTjRhPtJxd0uZlvXso2hzhtRx
	i5xOn3m7hwvz1YdDE9w4MIMyArcMc54bLs/ht9dAaf1IDA7bFDhBcFKbaxvCvXvbJgwU7LWTign
	9JsJPn1hdjfsG0
X-Received: by 2002:a53:ac87:0:b0:661:1307:3d59 with SMTP id
 956f58d0204a3-66113074162mr15806542d50.42.1781000056095; Tue, 09 Jun 2026
 03:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com> <xmqqmrx5z0po.fsf@gitster.g>
In-Reply-To: <xmqqmrx5z0po.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 12:14:05 +0200
X-Gm-Features: AVVi8Cc36Q2qm0vHN0Kdvoa1sXgZon_61BVTO1_7S0DaT9bU_0H-DnnYUUCQuB8
Message-ID: <CAN5EUNRW3gyLKGC7x5BBMTNKtunoQks9AaXJse4PHvCziRF87A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 14:16, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
[snip]
>
> `git rebase -i` may have an excuse that because it, unlike "git
> commit --amend", operates on multiple commits by design.  A single
> "--force" option given to the command would not have worked as an
> escape hatch to allow the user to tell the command "in this reword
> of this particular commit, I ended up doing nothing, but I still
> want an updated committer log timestamp".  Perhaps giving the
> "--force" (or --force-rewrite") option at "rebase --continue" time
> may work, but in any case, unless we plan to transition to these
> "better" default behaviour at a big version boundary, speculating
> what a "better" behaviour would have been may be fun but not very
> productive.
>
>
> [Footnote]
>
>  *1* Besides, doesn't "--update-refs" in "rebase -i" allow you to
>      adjust the branches?
>
>  *2* But it is an established behaviour people _rely_ on, so even
>      though it may have been better if these commands behaved
>      differently, it probably is a bit too late to change it now.
>
>  *3* This includes the case where the original author is especially
>      difficult to work with and would complain any change to their
>      commits, even if the only change you made for them is a
>      typofix.  Fixing a small typo/grammo may not be worth your time
>      and unpleasant exchanges with them after touching their commit.

True, after reading it, history being more costly or the in memory are
not good args.
I do agree that these commands that do reword should check if the
reword ends up being the same message, given that history is a new
command we can have it from the start so users do not really expect
other behavior.
About the --force sounds good to me. I could seek to implement it in
this series if it's ok.
The footnote 3 is indeed a good example haha, but yeah, why rewrite
the history unnecessarily.

Thanks,
Pablo
