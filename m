Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124025;
	b=vqZBkZ3XkgwuAqJG9YOtFx4sTbxZh2qs7WWWhsDLVN4hrXMJt9gPUeMVawjYlXioTF/C
	 hsUYZZvPWpvnqLg0NjsZLiYzAig62pjcwqVEUu31ttUeHKycobB24GGWgtuQEhcBVQDhU
	 Yjku7n9NEx9APGqp/QNXxzKSJV8t3rX6DrHGFj1mccmDF5Ekt7Oa1FN6KWw/skKDniMi+
	 dChhyJtvp2htIAx/X5XlF+ueXunCzWb20tpNncDduyB82Z2kMD5Q2uuRaKycf83FEeVsU
	 HxYN1A4JaqtFGV2x1dJLu5uvBMJiaNVv/yx3hV6JQ2xW72DGhkYDv9fcp50m521L8WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124025;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nI0A08HM2YvCD5lk2EDKdkeeeky6CExN90uc3wcckOQ=;
	b=m0vt91lhivrL5Q/Tm5IbA+h27cMp34qViEDVTvarAwrXkpnexvqsMo4ekfNY5ROkg/pZ
	 DG94c9k+8BhucXQAzqNuDFGZKDSC39xnLNxoZdPCh/WKaGRj0pKWyAItXlkMIhdMV6OjS
	 BAAhRw6ro4RQLaRTrZBZHKLO/qCX6gw8x+v+ScenDAtCuKIuXj+7lnbbiLKD2qvHCvbnd
	 shYnVkGFhJ1OTIDSW9jKj0bDtl5nt9zdYw+BHIruTAZ9okw45xmDANIqvF0V/ijEG2Haw
	 q4+JozzEn+6y44Ia2SAclR9Ay0Fr8P3Ma41aRf7A+nw8K+tsAyiXHnqKbjf7x0Tezdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNIfLZjB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E4606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9E4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNIfLZjB
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e9d7791b00so563925ad.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124024; cv=none;
        d=google.com; s=arc-20260327;
        b=PGsPoP7ipReXqshZ3NTEgVCEKC8cHVEXzBYie8xDgkxpRchnUZ0cllUJ1rFIck99nK
         pgN+gYIr8JENYu9UZpnBpau/qIQ6t5R7BvC/LPcezPMu+jQmeSM71c+pZUsZ+7HbJRxG
         gk3r/6S4Fx5Ws2Fc5EhaiPw/s7BhtzK3hoEZ/L0NRAMIQJ2Xlc9lgMoMOL6qhkpPKpoq
         +M3Tqicqmmna2TfX9HvZxrHgGJpMWOKN4xaIcS1/6euWuOB/kleLpqxQCiwW6UHobykn
         2g1hHOzSArTQN4f3evIq76QFPNYNt/lMiSEQBh4A+Iohg3/zEkq85RTjuNWXIhATUjEO
         20Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nI0A08HM2YvCD5lk2EDKdkeeeky6CExN90uc3wcckOQ=;
        fh=27F4pdCR8kIM2oIwT3BYaRVFGlGlyjY4bsfPMNxoesw=;
        b=nUO9zOdNyt93CeBHNowaImQZx36dnh6uPgYANFJg2b15Oq42/noZzl+6ONaxM0oCJZ
         P5FPbiiz1wQtUyB5wAFGds1cDaqFMhNELXb6lcnemrgZvcyC5VcXCEqzfur9bKXFper4
         upXEzH8TpHIaTwxxMambDoeYzgBp0gBpj5DBqGqrLsqLgV5INpCPLuemcvIJ3V1FNhou
         +ArNITJ0/E5R3jKyKgm/ORbgysVMM6EcPYKr8RJJxGDn/bW11d+LhFeZN9J4b/X/qvyx
         UcRFIQXolsj0q/vYAWk1QWStHB5mAfbeLOMHVyPoA3dNj56c6sg4iw/REqMKHThl3XqF
         i2hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124024; x=1793728824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nI0A08HM2YvCD5lk2EDKdkeeeky6CExN90uc3wcckOQ=;
        b=WNIfLZjBCCLsr5C+31Bl5zqzA1HhAfrdZU+1zoUaZeE5IeoE7RdpOoR5at2u6DGVKe
         C/29dy2XhrcWCDqxOsfHp5Q0g5YMbFW+8dyudCub8Y5skdQYMrUdTPkcBgYZEVxy6a/J
         4Xvq5WcODf33+VzijaPcKvdDs1SHtp4eLeUmAriAAhkMbyxNEFV/WHQSGkUM+HQAgIM/
         Zn3VLiJ/rg8KAUGni4MtoIbvCdgTJRFRSJ1dA4B2VXiZdfjEmBGRLmlzVwIAiSgpUYs9
         IrtXZ+P6dT6D9999TXUleWzU03YzHs2QcVoFvVtJIFqlFGWuri4GIZeXB6WEpfbwGdUp
         P3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124024; x=1793728824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI0A08HM2YvCD5lk2EDKdkeeeky6CExN90uc3wcckOQ=;
        b=IYLG59FTPu2T8HOpUTela/iaGZhskOInBdlPhLbSNZ1q6MhOQIda+Pn3nnItB3R3D2
         RQgUixYizQ6SRpDdhGyD0+mVC+9TezVEhIs1PDt0SNen/NmsBi79Mnui2Z6HN+7b49vY
         axpvZTE6L3yBBiGdA18IWVE+9yEr1+wR9kKSDYvk6rCW/SM2kkKG6sAqp6VlaGh3B8zS
         T43V9F5FDB61z5RRGnpCVivCyeNhSblrAWLx4sjIjIiskFKSiKJ+mMsleRIZXmPc9NTo
         iaWspVE8Lc5RnDk65NGbxJ/wLKvHD/D9bJQXYvEOggIkWyUq17jQXlO5/SvZcJf+fQc6
         Pt3Q==
X-Forwarded-Encrypted: i=1; AKwUvBw+Qdeezu2R++pfGbxmwzKqDuPRHa/rfQ1lK4JWlAf2CH4BaRe2uUUoQo7a4E5NCvrTKlg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7Z7v8Tgwz8C8OfJARbkVyFY19IC7VJHsEpiQvwvqEu9WnkscT
	O1CL9bobCLIgT+oq75vfsG2c1qm/NTgDeCAQC+1jDVPE44sfuOdmI0SADBQy/J/np9EPxH9Tql3
	iJwv03rixFFmtbSo6c9WbiikokAUhNHM=
X-Gm-Gg: AYBFou36GBSuUZjvzL/l9MrPmLqoRCAdjNNRxHQn56I1U+BUO8skj0r2O3E4bV4UEHP
	N1yw/AZGsJ26YzNcOBXTxEp+MruVU9vNj13MQpMhOHwF/eI4+S16XjYDLt7l8xyoethxxqvZOio
	q9/Z+Ko0qyiEMaaRE7WqucHsKN4Y5ritowNt4XYEIeKGkuAHSMq28WIWane4spXB/L9DJGLPC7F
	MUGavtPymm5Nu6UFjftPi1jcpgw+y4fXQ2ppRtkUOasFH5E/CkAgBaqxrKP42Apvy4IeTwHQWZ1
	yNHuMDz60ikmNCL2PfCZBTnC9L5nw7T1ZQ4OBTBcLdmqw/K+gr6JIz9aYaennWieIW/m6mgquPC
	t1ynU2mYxPgSUlSzGx11S3a9IbW5hQeTGHNfZK4qdxbQh+3KRq0Nc3Kaa2y0VGf5aYrwksCwMr5
	tdDv9eQf4kYqACMpKmv8UeojBS1JA4wZEMWdh5f0+ZoZExSf8gq1KahTzxIncIfqGegZHibxSW8
	E1lqvGAhYv2nAAX/LGhHLM05ldsccePRXN+
X-Received: by 2002:a17:903:3c43:b0:2e2:c55c:90c with SMTP id
 d9443c01a7336-2eb0052f293mr1038125ad.64.1793124023751; Tue, 27 Oct 2026
 11:00:23 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
 <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com> <xmqqh5i7kpc0.fsf@gitster.g>
In-Reply-To: <xmqqh5i7kpc0.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 14:00:12 -0400
X-Gm-Features: AclHuK8tNCMWRkhBRYG51cGzNKACYUFhvrkyu8nOQMeyafdGX0Jmm4EPlt0W6OM
Message-ID: <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> >> from gitrevisions.adoc:
> >>   Here are various ways to spell object names.
> >>   (lists <refname>, HEAD, etc)
> >
> > Perhaps =C2=AB notation =C2=BB
> > would be the better word here, if one is needed.
> >
> > [Let me just use =C2=AB 40 =C2=BB as a magic number for the below,
> > even though we know there might be other lengths.]
> >
> > I think Junio misunderstood your comment on this? Or perhaps
> > the intent is overly-pedantic: =C2=AB spell an object name =C2=BB might
> > mean =C2=AB these things all represent the 40-digit object ID and
> > are thus interchangeable =C2=BB, but I do think I find that interpretat=
ion confusing.
>
> Think of a blob object, say a sequence of 6 bytes 'h', 'e', 'l',
> 'l', 'o', '\n'.  It is stored securely somewhere in Git's storage
> system.  You can call it up whenever you need it.
>
> But how do you call it up?  By specifying its name.  The name of
> that blob is ce013625030ba8dba906f756967f9e9ca394464a in your SHA-1
> repository, or 2cf8d83d9ee29543...b7e3f3a183d337639025de576db9ebb4
> in your SHA-256 repository.  It is like a fruit is called orange in
> one language while laranja in another language.  Different names in
> repositories with different hashes, but in repositories with the
> same hash, a name identifies the object uniquely.  We give names to
> tree objects and commit objects in a similar way.  For example, a
> commit object whose name is e83c5163316f89bfbde7d9ab23ca2e25604af290
> is what everybody with a full clone of our project has.
>
> Since it is so cumbersome to write an object name, we provide many
> shorthand ways.  Perhaps e83c51633 may be a unique prefix among the
> names of objects the repository knows about, in which case, you can
> use that shorter hexadecimal string as if you are giving the full
> object name.  Or a reference whose refname is 'refs/heads/main' may
> record the object name of that commit, and you can use 'main' where
> a command expects a commit object name.  Or that reference may be
> recorded in HEAD (i.e., 'main' branch is checked out), and you can
> say "HEAD".  Your HEAD may even record the commit's object name
> directly (i.e., a detached HEAD that checks out the "Initial
> revision of 'git', the information manager from hell").
>
> In many (but not necessarily all) situations, refnames, branch
> names, unique prefixes of object names, etc., can be used where
> object names are expected to identify the object you want to name.
>
>     Side note.  You cannot necessarily go in the other direction.
>     When a command expects a branch name 'main', you cannot
>     necessarily feed it the refname 'refs/heads/main' of the
>     reference that is used to store the 'main' branch, or the object
>     name that the reference 'refs/heads/main' records, and expect it
>     to behave as if you gave 'main' to the command.

I'm with you so far!

> By the way, the story does not change if you forced people to use
> "object identifier" instead of "object name".  If "Here are various
> ways to spell object names" is wrong, then "Here are various ways to
> spell object identifiers" is wrong in exactly the same way.  The
> badness does not lie in "object <name|identifier>" in that sentence.
> It is that the sentence does not say "Here are various things that
> can be used in place of", and that is what needs to be corrected.

I suppose where we diverge is that (partly due to datamodel) I think
of "ID" as "only the cryptographic hash of its contents"---everything
else is a name or notation that Git eventually resolves to such a
hash. (Well, it may not operationally, but in a mental model of how
Git operates, that will do.)

> Long ago before we standardized on the phrase "object name", we had
> mixture of phrases in our documentation and it was chaotic.  We
> seemed to have big discussion about the terminology back then, and
> with f1671ecbfa ([PATCH] Assorted changes to glossary, 2005-08-18),
> we finally got it sorted out after having a firm description that
> "object name" is the canonical word to use in the glossary, with all
> other "identifier", "hash", and "SHA-1" as colloquial or historical
> synonyms.
>
> The patch rubbed it in the wrong way without appreciating the effort
> that went into the current set of descriptions.  I would not be
> surprised if there are pieces of documentation that use "hash" to
> mean the name given to objects, either leftover from olden days or
> newly written without paying close attention to what the official
> terminology is (the recent "gitdatamodel" documentation also commits
> this sin).  But I'd prefer to fix them to continue the effort
> started at f1671ecbfa, not the other way around.
>
> There may have been other discussions, but the discussion thread
> that directly led to the said commit is:
>
> https://lore.kernel.org/git/Pine.LNX.4.63.0508051655480.8418@wgmdd8.bioze=
ntrum.uni-wuerzburg.de/

That historical context is certainly useful, and definitely explains
that any work in this area is fraught. Still, absorbing a discussion
from 2005 as a requirement for making improvements might be creating
too much of a barrier to entry? idk.

I can't speak for Julia, but I read her attempt here to clarify things
in line with the ways folks usually use "ID" vs. "name." Of course we
don't always want to let what other people say dictate our
terminology, but in cases where we can make things easier for folks to
understand by using vocabulary in line with their expectations rather
than subverting it, I think that's a worthy goal.

I still find it strange to call "main" an object ID ;) even if our
current terminology says that's fine. Heck, the glossary says a name
is a "unique" identifier=E2=80=A6 so there ought not to be more than one wa=
y
to spell it, even if there are many notations to refer to it? Alas=E2=80=A6

--=20
D. Ben Knoble
