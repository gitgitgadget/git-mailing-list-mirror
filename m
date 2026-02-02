Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FB3064AF
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061251; cv=pass; b=fC7TKiz0lfA6dhhH5fi2JV6UgBTzpk+EHanTkYKMK70gKV+pXAjVTi4t8Pq9bXu6viC5W8+gaV11ky6u6DqZtJr6SyX8pS30JCNHqo0U9dhJKU+q+dx3PBOT+8niSguYbJPX+02cazTVIzlqL39piUh7lz9UgauNTNOSI9JMufc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061251; c=relaxed/simple;
	bh=sln3pPNDQnIUIQqA4f4AYjGfBZDiM3Me87M0C4ZGZc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGVm44jJlqDpFGLGWwSdUbkdGG4+NYfuZHca9Z9qfcbPKxUrFy9OluYto05sOrZwkenR5MasfB69IrZdYGPDPzzrhSueQkev1NFVylFRO8hIVusQdARbnxBcMjV9doIfQE5MQTekdMgmFfSHSQA52mxdox3bbEcNMoO5kjb+H+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zb7G8dai; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zb7G8dai"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7bced39cfso50957725ad.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 11:40:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770061249; cv=none;
        d=google.com; s=arc-20240605;
        b=YBXAXObUofkhYp4wjQG8sR3ZJlc0NT6jltL8YN+s/jX2lyi//LRcvP6eq3xF6JFc6N
         EkNlg4umc/4IVPwb2rUQo+gs5DYlcLJgX9z980wi3H83J0ICod1tsDCUVkl5/od0pw10
         qNgudeUlXtZQZmdAuW32uVHOBa08mceeLgq7oBPVpaktAmjSXZvPko/gbYbD5zvgV/fj
         mQ/3ZLyyfu4YdXnn96FOFCoZTQX9TepG2hV7x9Xqp5IaDiEWx+ZNAgew5Rvuvu/dsvVm
         +kznMHaTDqn380nPuCL9r+JIAQox2QjHKb4mTk6DkneEPrKCR+nqi01WQGwD4DEtIzlU
         kOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jpwKNyPgybAuFwBCFWg6bvtwxQ1OMxo2cVMCqd224Tc=;
        fh=GZJZlaK26en7z8MdQHh+sFxrYOuYIPrApJ85JxJpF1I=;
        b=XlqpmSMXgJUG23+Rdnw4FYcZqXEv/Goe701s1WiB6xTJ+G7Nj4I7rMcZ7yEp14CR3/
         hGDFvUY8Q46ySiN2M4/C2p5GbkmNihnIejxaapcCpEyUDdMFTTRK5UUh0AwQdMcdPh2F
         F3vEYy7Qs4EOTuudtKeacsGSfKkC6pQl/dIXDkkTDDNttUDX4umLJYhy3f4aukj+xPNs
         OzKbKQfvg91DNln8InivK29BMjgww56fLhEys3ESid6TGBpllHEvENqEOprc7UjNOnrn
         k1NNAg8PG6CVdZC+4DRelfCXSmzrWILDbBvC2J2aufBpsakSM6JHzVj9mCD0OBJG4U0Q
         I0kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770061249; x=1770666049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwKNyPgybAuFwBCFWg6bvtwxQ1OMxo2cVMCqd224Tc=;
        b=Zb7G8daiyYoYwUs4Dst8sMD14m1qr4ynpsvMRU4yECQmthQbVTq2keeIfLDp7tOq2q
         0SJF5s5INfwsk05WA5GysRVvQQfdTlQhkegHwzQNTEtlN4VlpXYc3J3uPNTtyasFgI+X
         YxZUL8KjNrKg7VMW44ue7W6ngdjBjWL4g+iRWn5OqUeg1RoMF+SSC7mH6y5HBnzyfMdN
         T+EP+T1EXMIHtTtRDj8vCpRo8h3E/4r4QKJSctMS2gLEHxGUKQv4Hz8oM9ddKb/bTy5A
         JQpq0kk6Hoxnot6q09uSw2/1Jrs6o+0EpsSMIzVAXUXCsfLcN46kWsr5os+wz769VPJL
         Ys5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061249; x=1770666049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jpwKNyPgybAuFwBCFWg6bvtwxQ1OMxo2cVMCqd224Tc=;
        b=JWFRA3PIx8hrWIHXECOufAZU5tBPGhyT5LHK6gSXk43XX3kMEr2pma4usxL2F6Vfyp
         f71Q0KXZOYDLg96+kbtn074mWd6+KjOOjdfLsS94GRygR01WDk60j6a0/G2oanwSpKaP
         EsGbsDExUW12ujsswRUPK+zPMcMLHPUdSr08Kr4tTPB6qjfpUOtqEJC5RWAbGCwX3BVr
         BmgSD/KIbdqmBNcJ2uGTSlHdEgyS7xcpyMwZ76H1flJr363AGGm7/JuFkEhc2mvdpNt7
         BktLSDHPHe48274EFpZfFLG5its9BiPZ0WMh9beKw4G4fk5VaL5WWfPGYBYOXg1dBpuN
         M/cg==
X-Forwarded-Encrypted: i=1; AJvYcCXAMTSlbQCQRcI9lwS9WRb6PoY9fperJqn0rczP9XZpxaDndyolW7cDRUIcANRA+T04sDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLM+qAj8VBJbGbzAja7P/vDNJTCjbn6TRiCmSbfryjR7jJ71H
	3oQU0p671oGh6ZLYtoG0An5+9IP9XvjR+zcFDIb7EPaQ26E0RQ/2jrEP/ehCmkLYVl6tAmTWxXJ
	u8ss+QYP1pd0Y/Ux07VFAdQ6y5rmPL6c=
X-Gm-Gg: AZuq6aIuRj+m8tLVSt5njTMkZhIJ6NHhOnVXwDzocucpniR3p15ocr/aP6BEzXUGGb6
	PKeA0tLIF0GYyBBfwPk1Zc0oRN+8VaN/T4K0rE8txmbKh/8JaJYFS3bJ/oNVdcR7GK71kx6rmd0
	2d1Ahu34XtiUmhlRsUdS0ye4FUOG01r6VCnr2RYmsKXbZxRE0vzrrDY0KMlTaSaMlL2+7KuX/4i
	C6V+A+87dmo8m2hY9Sjiw+QCyjNZyuh9Z1KVLfaSXiVwFAINY5GYNjGRkxli4T7cC+D/cyqEI6q
	n5ZO5LHeS8KfAe8zfE3rPA3MGyGvT0KEcs+68mXYh9n+xjb+zZvRoma5fEX6epYeDGSp
X-Received: by 2002:a17:903:2f86:b0:2a1:10f7:9718 with SMTP id
 d9443c01a7336-2a8d9937435mr118134345ad.30.1770061249493; Mon, 02 Feb 2026
 11:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com> <20260202101445.13790-1-haraldnordgren@gmail.com>
In-Reply-To: <20260202101445.13790-1-haraldnordgren@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 2 Feb 2026 14:40:38 -0500
X-Gm-Features: AZwV_QjQcmyrRUYfdT52k_lOsjOu_gM-fmhn1cpCqS1wVg3j5WuKXy8pWHQUfhQ
Message-ID: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com, 
	gitster@pobox.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:19=E2=80=AFAM Harald Nordgren <haraldnordgren@gmai=
l.com> wrote:
>
> > I don't really understand what you're trying to achieve and I'm not sur=
e
> > if the suggestion above is a good idea but it might help understand wha=
t
> > it is you're trying to do.
> I didn't realize I was so bad at explaining =F0=9F=98=85
>
> What I want is a shorthand for switching to the local version of the
> default branch of the repo. This but with less voodoo:
>
>     git switch $(git rev-parse --abbrev-ref $(git remote | rg '^(origin|u=
pstream)$' | tail -n1) | sed 's@.*/@@')
>
>
> > you say you don't work directly on the main branch but then later on
> > you're then creating a release from it. Is  "main" just a mirror of
> > "origin/main" or are you merging local work into it as well?
>
> My main is a mirror of upstream/main. I never commit to it, just do
> 'git pull' to create releases.
>
> Also, I switch to it when I discover a bug on my branch, to try to
> understand if the bug is already on main or not. It's the baseline all wo=
rk
> is compared against.
>
> >>      99designs/gqlgen
> >>      refs/remotes/upstream/master
> >>
> >>      amplitude/experiment-react-native-client
> >>      refs/remotes/upstream/main
> >>
> >>      Antonboom/testifylint
> >>      refs/remotes/upstream/master
> >>
> >>      cli/cli
> >>      refs/remotes/upstream/trunk
>
> I want a shorthand so that when in any of these repos, I'm switching to t=
he
> default branch, I simply have to run
>
>     git switch @{primary}
>
> and I would end up with
>
>       99designs/gqlgen
>       Switched to branch 'master'
>
>       amplitude/experiment-react-native-client
>       Switched to branch 'main'
>
>       Antonboom/testifylint
>       Switched to branch 'main'
>
>       cli/cli
>       Switched to branch 'trunk'
>
>
> Harald

If you don't need to be on a branch, then "git switch -d origin" (or
upstream, or whatever your remote is) should work just fine.

That just makes discovering the name of the remote the "interesting" part=
=E2=80=A6

--=20
D. Ben Knoble
