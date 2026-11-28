Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795824866;
	b=NNlX/hrYHh6vuYeVrYkLngQJecgNKET1xwlYle+4b9GpumMhgYb6TuhVno5D+IYBV2+h
	 qZmO844BWb24faArOMvKYIjtE4IR7jE5h/kNgu4lT7cwYkKIRIa/cWig7gQW4gcF308n5
	 RpfNVs0t6mteZF/otgdxYD9G2KcDS6X/qHUZb+pAVjIAPMUWsZlZKcsvH8g1GXpEVjTQH
	 mZES7dCzWRgLUzDOMoKC9r0Nsiq9/21MGD7er2jje1LOoagPETM6WUDWr2c7G3a1Qwshf
	 ymTRP2/6LXkdz4FNGJOxlb8KMl3NOmB51sEmBlh+s+B2o2UBNl5InseIb5+7kBo7JJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795824866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HoGlIapNJUOmtvqRjQyCjSZS/2QI3q1pBZemg42xTTM=;
	b=CHhKv1pPZIRKqlYc72ijHLHF3gmlc9fVbNuB9QC30Wi0xDIKMmEJgcVKZ346StdFxX/1
	 dQZuErIPKO98b4NH+s7iIpN23Wg5CA31SKaatciAxRLCwvrWbgFPV3YBHp4B3qzDBhOHG
	 eVlMf/n+AXtwm5/JBiHhXIl6qQbTJ0DKI2r5j2F3zg3P2FcULj0H3MW3KPTNoZLkKNFej
	 Tayo+4wgs3wCUwGBFl57Jc5iuxz+O4iqugCAIfbbG+q4Srw8gVJYYtkMMlElCvxxXivzE
	 6Rqt/6vSBCDvLoZ5p2kBIYxsLqs+dAGAnigimk9knZyzRJ516GeIvn79FVXPL7I+9Yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ce400Hm8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFA606A31C
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 00:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69DFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ce400Hm8
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ebf4cd218so73605356d6.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 16:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795824865; cv=none;
        d=google.com; s=arc-20260327;
        b=gi+nkewWYkNLGeAKfCt1v8VrYPQGfQO8N8thgi3snOBm/zaIPaUaAhnF6E0qOx4ubn
         C2uJhScGoG6ZmONNmz1DsXdy5nhvwq6IMPgwu7pnN8bz2tc2sXTKCEZRw7inI3g35834
         PreaRcZgRHuxBS34vjtysTiLPzw7NOuy4h529RcK4AH7rRZc/fhhTb6zAEnY3jxZcv1R
         3DrKn9DSJVZZMPqHSu69nLAoOsdeyLXLZvSyrRO07yCHTt0vh2YX6UuJyUvkbRQkSPht
         3J2YNswyr4+UoPW8CdnJrX6m2ux4ar7KUpPrrkLCXQtdXdvtnsrhNK8Dvzc415fojeLH
         sH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HoGlIapNJUOmtvqRjQyCjSZS/2QI3q1pBZemg42xTTM=;
        fh=DnqUOzRubCUxttdvH9EZNo0Km0pH8FnKRUDIhQ0cGOE=;
        b=RgLM3O10x+cJ5NRuQfikb3FgmgrJqxKxeyz5bckK6oIYu7CFZVpKN+SoECH0/yxxYq
         GtqZEmaKGO4z0BHzMODose1AYyTrjRta6eNen8CimrHYdvbVk79Tuui+61G0BRnJsNU6
         3ZOpLCCNtwDW4MKkxGDcZvv0+29tcoKblSJRdWJ80Qq/Ma87fWqjs/z6/VhfDRVs95mE
         LOAFAi5gYGoe4zG4huhwoOA2G3diGzwGTKO6YaW1uGxZG68VGFZ6TJtlRBoTad81Is72
         A7nrjdKAA5IKxBoysUZH5fyr2G/W2Dy72xmAqR3aMjYrW1xK3K/lD2rWMhShNlPhrqiO
         CYGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795824865; x=1796429665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HoGlIapNJUOmtvqRjQyCjSZS/2QI3q1pBZemg42xTTM=;
        b=ce400Hm81rwLgVtziCnLOUTEDZn+3wlwkAnQ2vxCI3zy7V39mD0M8iRsbrpwtFqIVt
         DNF8KLuns4foIAPPOJ43bZeyLptkpvXWua+Epyp0sGKrClduyfeGpJnIRfXTDN+kbHlX
         8owqAqRD70SnLZ2OJPvCrDLzdkJ1PNtNkOMPGF75N3emLRZQEBc6emPYnLN3wSjRRHFc
         QcveNly5TbWWCKVjwCgZRRSB+kCCzVNlG+p2v9Do2PWO5x7Wz0OnEqfLXqhIs+DbyUdb
         wEjApHOoUyiEVrPGXehJzMXlW4rTz++TMQQXBJolKqrvojXgMUdGqNmr+Ov70rxLjr/1
         ZhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795824865; x=1796429665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HoGlIapNJUOmtvqRjQyCjSZS/2QI3q1pBZemg42xTTM=;
        b=X+Nw+9L8cL9V2bg7tAC6FKPxhzJ2ZJ2Mm40smbH+dEMN0B33mxavrNNstNvvRktaTT
         rSM+nLlGwFQt/09o/UGH0aw1EmNgIDUPrB4SUWLjiq85lDBiBxvd8xkhqxRYaQjcnKVW
         /IlYCIYiM/Oqms0vwtb0rgeHWWCOcpuQ9lfPEpIx34F3+VK3/58P9LW0IA9/zo++AijR
         KPEh4kWA+4cp70JfHKSCS+owiA9dktDQB/YiXZSMMM+602VMQcEre4ivwqMj6xXngq1o
         SDaqpNlGcMDLumItfw0vJ1ERxjzg7eV4ayqVzvoGRJsGsXuBELujag7NiTejv4/Cs3oJ
         /Y/g==
X-Forwarded-Encrypted: i=1; AL+hErHE12Uu8EvoK8H8cRsD6x5LNxZ0SZWmP5hFBThdPkF48MCj/OOkRrLzUqmojN8Tm61dsXk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7YVaJKYJn9LO6Ogf9MSIf4lcsTFHlzVBGzrUs6YpVQEe72nh9
	oPhC2bziXxf8JcLkLSdyUqOETswoTco79+WXm1QBrZJ3ZVuvDk8bMjLSpZLPWZYF9XTzttwACKY
	rvgj2R+eYPV73vQdlbEXOd2TbIZ8Fat8=
X-Gm-Gg: AZFdTZecGIKtnAUl3pdIGnWyI/ibiEqUjqIljrePs+wYykxr4Lh2+Hgsal9kByyDVoO
	rI0rrniJ5yMylIkSe4QGZANw99nomT9vMgL4UqW2uGMT82UUa0GEtid0hxvfaccbMnJ3dZG423X
	lYnxk7W2BO7xXaB4TDF9k6dsRw4Jr4ZyJ6t8bSdTll7poBVXoVYUjOnAWfWq6/5OBFwNOEgpdBr
	mfoO8zY/RxAMan1QXP9zuPzSaA8yWk/XI6LXRwRw+wKjrtvyi/95WcYKYg6G3kGP4Ck/y86eHOq
	dIR15u/MS2HBpjlB1+WHpdMaXxhWeI0J5tnef5fCUx0RMz7amp1yP3Nlegosr/Epia1OI2RuzlM
	Fhfb5eIH3OC8kTw3lvpShFEEcid4UoFsdHav2ziMSWF4RexpdgyYLQpAeVKHo/XpBl5WcBBI0ng
	a0es3ztHD6bkOSvIo=
X-Received: by 2002:a05:6214:c69:b0:921:404d:f45e with SMTP id
 6a1803df08f44-921404df536mr444215886d6.22.1795824865245; Fri, 27 Nov 2026
 16:14:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
 <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com> <b5d203d0147715dc2b38f13be427ef8d2138321d.1795273853.git.gitgitgadget@gmail.com>
 <xmqqo6benenh.fsf@gitster.g>
In-Reply-To: <xmqqo6benenh.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Sat, 28 Nov 2026 09:14:14 +0900
X-Gm-Features: Aa3M54ogz0SR6m28rGywlngVnqZG1UtmX8c82mryg5Ojyp-6wpbO7Aazc7rftIA
Message-ID: <CAF5D8-usJCwT74COmpEW7Xh5zxzCrb8XSjwz79w2VCon0PqSLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] submodule init: copy submodule.<name>.gitdir to config.worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 5:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static bool submodule_git_dir_matches_current_worktree(const char *git=
dir)
> > +{
> > +     struct strbuf tmp =3D STRBUF_INIT;
> > +     struct strbuf submodule =3D STRBUF_INIT;
> > +     char *super;
> > +     bool matches;
> > +
> > +     if (is_absolute_path(gitdir))
> > +             strbuf_addstr(&submodule, gitdir);
> > +     else if (!repo_worktree_path_append(the_repository, &submodule,
> > +                                         "%s", gitdir))
> > +             return false;
> > +
> > +     if (strbuf_normalize_path(&submodule)) {
> > +             strbuf_release(&submodule);
> > +             return false;
> > +     }
> > +
> > +     super =3D absolute_pathdup(repo_get_git_dir(the_repository));
> > +     matches =3D starts_with(relative_path(submodule.buf, super, &tmp)=
,
> > +                           "modules/");
>
> Isn't there a subtle symlink / normalization mismatch here?
>
> repo_worktree_path_append() uses 'the_repository->worktree', which is
> canonicalized via real_pathdup() during repository setup.  In contrast,
> absolute_pathdup(repo_get_git_dir(the_repository)) uses 'PWD' (if
> matching 'getcwd()') without resolving symlinks when the gitdir is
> relative, and copies an explicit absolute GIT_DIR verbatim without
> resolving symlinks or normalizing '.' / '..'.
>
> While 'git submodule' normally runs cd_to_toplevel() (resetting PWD)
> when GIT_DIR is unset, running 'GIT_DIR=3D.git git submodule init' from a
> symlinked path to the worktree (or 'GIT_DIR=3D.git/../.git', or invoking
> 'git submodule--helper init' directly via a symlink) causes 'super' and
> 'submodule' to diverge, triggering a false mismatch warning and
> generating a new gitdir instead of copying the existing one, no?
>
> Using real_pathdup(repo_get_git_dir(the_repository), 1) for 'super' (and
> strbuf_realpath_forgiving() for 'submodule' in case an existing absolute
> 'gitdir' config contains symlinks) keeps both sides canonicalized, which
> might make it safer (though the resulting path may become uglier, as it
> often is the reason why people use symlinks that are more comfortable to
> the eyes and "cd" to a directory through them).

I have confirmed that issues arise when a path containing a symbolic link i=
s
specified for `GIT_DIR`. Furthermore, I have discovered that symbolic links
are not being resolved within the value of `submodule.<name>.gitdir`. I wil=
l
address this by adding a new commit, and I will also update
`submodule_git_dir_matches_current_worktree()` to use
`real_pathdup(repo_get_git_dir(the_repository), 1)`.

Thanks,
--=20
Yoichi NAKAYAMA
