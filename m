Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB053002A0
	for <git@vger.kernel.org>; Fri, 29 May 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058148; cv=pass; b=Actzc72ZZGb3k0Oc4KdrxVQcQaRSmo/6XZ2QRmSmXOsLoabCaX3ZUfD2d5aGyHrucotp/65Vt0DuijKqROlzWjP0CfWJkzQ43EYK9WMQ/Rb84oQTg1N4sNq3z7QCYYMqLQ6pbzPLXApFprYSA42GimIVNY3RDOMCAnADICAL42I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058148; c=relaxed/simple;
	bh=XQFPW5iUN+G2nYGyk3sse5/HthP2yOzbJI3vGvo4wgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqy/CfLIXPMJ3lx3wzGK7oz/A6fmf2HhYbU436BWHoastKPxCuC478eZ3fj46DUHKzq4amTuFPVp3tYKb9PMtegw1Yj3fty4Cok1XgDGKINO58+BMPznBY3ZfLqH2sV2IGTt8w5V5bhHFyMfoIKvJ1HQlmU5ABdrhHbhtiFYKRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com; spf=pass smtp.mailfrom=eficode.com; dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b=FEaYpQQq; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eficode.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eficode.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eficode.com header.i=@eficode.com header.b="FEaYpQQq"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68b73f1a8ebso2476189a12.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 05:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780058145; cv=none;
        d=google.com; s=arc-20240605;
        b=O/pRYF181qQ7BFtdcYQ5ByzOLFs7B5YjOVKFA9igQf36vExUlQ9WpBMT/sAs9Plpda
         J2LTaBqqemIOUJTGZXd+OxyuUHBCasLBgxd3yo4blZbmSS8AooKL8XyoxCA2LXOotf/a
         lfPIAUc4ghVOrCNXg7ooDS7krESRBZc2oanFJTiDUmrrZXreO1L0woRySvpf0eAwlZJB
         gVYxyDOF+l1pvL3rWbX3ho+YNkjEL/g1xDnaDX/6f4QBGRY9aAKHFC5DolLSJFSP6Sb0
         /kA36eCsSnTkUGEsQjauRkhsi9GlIpxSa5QcjStXLGRh+P/1U6b1bewhj90+xwBsMbzl
         1K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q9fA91Qq2oalofJQpPFZH11up8B90bnA88Q/d4VZRP0=;
        fh=JQCJAUsm3LBOukjBOLJDoNeIpEZQSCmYCzASfNjyl5A=;
        b=Mwxm1ip6Cj6MXnG5xobzDVDFSAFMrH5ZaSFEkQv+cSxHNacGJoXOtB4uX5rdATByqM
         FO42YeZSlKxvoKIsQ9V+lwVWtq5o+6OHsQTqF1EHGXBnUq+lnyZXKGI0dcra6cQim4is
         se4IHfKJaXb6FWfahNZUdpFUeyvl5gffyXVDEHw+OMg1eBB1R9f/0chcj8kCByk8TrSG
         CByeJX5WkgwRrkHAxIrNiedBBfNwge8frlxjXAbupP6nXCr2B8hcsl9SykXBf+hIM0cb
         57gmLgveJTF+hJbXlIkdn639i0f6rsrLaI4GfGHxYdmD06nPpV+HHKKSDAXxqzdcONRw
         ZXzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eficode.com; s=google; t=1780058145; x=1780662945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9fA91Qq2oalofJQpPFZH11up8B90bnA88Q/d4VZRP0=;
        b=FEaYpQQq7mNyUViXpNTDW9ibVzI947dOYqeD/3OLGAD262lwrsxkiirNQQGHHArF0A
         BxrtWYzKL0J5truVIui1tv3f7TmrtICu9SnVMfVGi5vjTo8yxwhR051djPVWyqCMhzWE
         5268lGlQpoVhNkrimmUCNWwVL2O+QUd74c54WVwhNewNNVZeK6uNGBjcduQFJ1VfltfC
         Laij/DdTu/CUZG8J1YQO5sUKZOLfk6lqpFcw7bHldts2KnG4IDWSQoZqLlIq/vF/6vkr
         1udlMiUfc9paFpd9YD3ib6DYip8DOzRHmrf9XjcjbPAJAsvIAfzHE7+Znw9ftr9e3ZnG
         26YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058145; x=1780662945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q9fA91Qq2oalofJQpPFZH11up8B90bnA88Q/d4VZRP0=;
        b=qi8vs9ZojWBoXWIrBqD9lEPVsJSw199XY6bYryXIGY5xdi5M6mwjLnBSr60hgYSx8y
         SII8ULsi8Fis13Q8MQ334q46ZQ7hU//BBeCv50TTt+zN8UVyWIU//TTsdZDKBAu4DFNj
         fHcR4p5cM9ZyCtTc9HcAis4L80y7iurbrCOwhm0yerErBgiRpR+yWYFh3MjKfy/wCanu
         aqLi7A/Auy98wdUjBwKiQ+VVETIxs4arRfwFrDQ6OmXMcwgVHeoI5eoK3Hm7Rz4iR7rZ
         hpRjcLDbvfDMCLAA3JD7OuYbDiJEZ8ejrjlXvjQ7aAALdPh5DBu0h65ddbOuOGViVQII
         KV1g==
X-Forwarded-Encrypted: i=1; AFNElJ8hPBQe3A1VV/lkwu9mnUTzDnPL8mdmH6r+XuPiw4XE2yvA3XM8N3FNcom7riJ54mwebmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkbxluajiUrS9DA5fUAJZaphoAJnB8Th4/Owv7D7VJ4ufSFXdk
	ltK/5mbMDCogTEa3/qgyoqvgeaPb15C4Q0ltiaWXAD/NUrP6YJNiTWF7De+AAEprH/IvZNOEkUQ
	1aMIG8U6UhkIjX+bUr9nwO33iiy9zFtHUpVG40iVxT+IFdFl96ohpjrMt
X-Gm-Gg: Acq92OEYLQRzRVqas7zvN3VP7Z4slbMuOy5qxIub3P8GW9FY4xiPI+qSwdp6Qa7Ul/Y
	oPGeLpAbqXyl/b6Moc/Gr9HElUkPirNunntou+Pk4yo6+ohDubtyIkmQONAlKOL+hiFoSohm49A
	yV8o79HLS5mvq79W9rbc7IY+KFSTP3iGUopM+lMDgNx9fiT6kv1k3uSp3p+is+1+vrFVR7p+3Ql
	aPYWWnoIR4Q03VzTDx0BiwAT85pC7FiqIvaEPlRtk97oEez4Q3zkBpezslupVMFEiAoMtT/T1hO
	NltQ+Xoc6lNcLqVTW7kSAhsX+BMYIlC9Z8VI+6UQa/EnS1XCEFI7v+t3Wtge0rY5kGbYU5n+3h8
	rLDAGr9WGdTYK8n9PVasdulNqAA==
X-Received: by 2002:a17:907:2d0e:b0:bad:92f5:daea with SMTP id
 a640c23a62f3a-be9cb20303fmr147088666b.14.1780058144958; Fri, 29 May 2026
 05:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com> <7377E3A2-C866-4E3D-85FC-BC6E10CBF8FC@gmail.com>
In-Reply-To: <7377E3A2-C866-4E3D-85FC-BC6E10CBF8FC@gmail.com>
From: Claus Schneider <claus.schneider@eficode.com>
Date: Fri, 29 May 2026 14:35:34 +0200
X-Gm-Features: AVHnY4KO0RGHGXUpdsacHu1Nzze9EIUzumqpY2dCX1cqI5ZYvuG8-g7bxZdfpZQ
Message-ID: <CA+GP4bqNrnER14GaxOSPdQCO0HFJzv6Kjo6VVFhr=KredVu0jw@mail.gmail.com>
Subject: Re: [PATCH 0/5] git son: add command to create independent child repositories
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Evan Haque via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Evan Haque <evanhaque1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi ..

I would motivate to fix in git-submodules in stead. I updated the
logic around the ignored setting of a submodule, so it is truly
ignored - both in git status(already) and `git add`, which now
explicitly requires `--force`. It now gives the ability to configure
your submodule as 'loosely' by tracking branches without the friction
of `git add` is staging it all the time and you get conflicts in
PR/integrations. You can use git submodule status to list the sha1 of
the submodule for release etc.

https://github.com/gitgitgadget/git/pull/1987
alias "git-add: Skip submodules with ignore=3Dall unless --force and
explicit path used by bicschneider =C2=B7 Pull Request #1987 =C2=B7
gitgitgadget/git"

Please try this update and then describe what is ( still ) missing as
i am looking into submodules in general and will try to "fix" the
friction points of developers.

Best regards
Claus Schneider

On Tue, May 26, 2026 at 11:29=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> =
wrote:
>
>
> > Le 26 mai 2026 =C3=A0 13:08, Evan Haque via GitGitGadget <gitgitgadget@=
gmail.com> a =C3=A9crit :
> >
> > =EF=BB=BF
> > Motivation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > When spinning off a new project that is related to an existing reposito=
ry,
> > there is no built-in way to create a child repository that maintains a =
link
> > back to its parent without the tight coupling of submodules. Submodules=
 pin
> > the child to a specific commit and require the parent to track the chil=
d in
> > its index, which is too heavyweight when the child is meant to be fully
> > independent.
> >
> > The typical workflow today is manual: git init, git remote add, update
> > .gitignore =E2=80=94 three steps that are easy to forget or get wrong. =
git son
> > automates this and establishes a lightweight convention for the parent-=
child
> > relationship: a remote named parent in the child, and nothing in the pa=
rent
> > except an ignore rule.
>
> I don=E2=80=99t really understand the motivation, but if your goal is to =
create another repo with the current one as a remote, how does something li=
ke
>
>     git clone . child
>
> help you? (I=E2=80=99m pretty sure you can even set the remote name to =
=C2=AB parent =C2=BB if you wish.)
>
> You also didn=E2=80=99t mention worktrees or subtrees, which might be use=
ful for you.
