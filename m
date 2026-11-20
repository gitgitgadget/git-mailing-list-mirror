Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184710;
	b=KiTrFT3GutAhaVK0L6RzHEE4qw1EuyDP44wKT9JftVdZtpFTpd+iliYPgHBGoL423DOj
	 MUSFsPSG74PBOy30/GAyPMzSVgZ+JjqOoP1rqFmT68gJcvLIevbly7KnAUULul4Bi6zYw
	 ObpuAqNxydGQv1misj89hUyFUshEtL8bMk5tSx/7aLtrSGr1b/X2EfagyNdGM96RoVGvW
	 tQQ5LY9iPcJ56JfMP3g712P4C1eERizJyC1z0trcQ8rhmxHx2KFz2sbCCkbX6vDLPBPyF
	 ZlwfnLixcAs0Bg/ykUC2BRdg8/bPLdj0zJq8fy9o5nptgawcksOQvI6x0hRnP2J7Hvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184710;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=wn/vpoXwQ8SIUpZ+FySeJbl3rD5izd7q1WlM4dBokRM=;
	b=m2xez90lhvUDv5a9CX5gCD6FydwA9gl1EQy/uBALUml+CG6gYzxSeKlhxcuqwebMcQm7
	 PK6C+dYNhNl0QuCQ+SUAAzWvrFqvSAn2Yn/dKdUuA92+WLBX+U5ks5XTIq7LwTtQ07wtm
	 46NZvyUSaWhxFSImW0MSzVOXh8J310kRQme0DEnosrJHpDPRWmAEDoZ1c6O/M2d0a+DF/
	 6gNOTDWFHEYSc+48oxCvnw70aum7qN1lr+r6qLLR++3xRXaxkZdchKUOvktFCS0b8a9S/
	 qsmLcgNvPKjUEM8RA8JHy8nce7DF4cpZQ0QkCbT8WAw52+ZdGh5SQSoh8imC2UwGoEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=iZ20l2zC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="f/yUNE5L";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613E1606A33A
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613E1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=iZ20l2zC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=f/yUNE5L
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 43B8BEC09E5
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:25:08 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 20 Nov 2026 09:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795184705;
	 x=1795271105; bh=wn/vpoXwQ8SIUpZ+FySeJbl3rD5izd7q1WlM4dBokRM=; b=
	iZ20l2zCO7cTltdbVeeeneb5MzNPHW7tKVAEBTaQUZt92kWtbR2S6JLjZ67t3xVp
	83xfcHSKf/sshF65kJ/s7L0LvWX+aIxFL2k4RHvn/xOqzRqt8k22AdgsFBUtCs8i
	5hPEylsdXuPAp9kpRVl6ykDBp/MyJW6iI05yLKBYF4FqDOsIpROfprxm5J2CWUjx
	SglYJ1BqMPuE1NnFWG6uv9yG9fb/TA8Xm4jgcn1gy7YnS1tOBtzNnnFfA4KZaHTr
	FmPGr/V++L5eVkdm4DCshPPzI7AN03FSKo4WkO4z9rgpKis5B7FYXNytpt79BEm0
	51tsd/esMFczX4DIoxBCNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795184705; x=
	1795271105; bh=wn/vpoXwQ8SIUpZ+FySeJbl3rD5izd7q1WlM4dBokRM=; b=f
	/yUNE5L5EAhNgNrw/bEZ8w+Bv4wHdbeYP1Ln6xNincSgPGn4aDCDcqopNFmVrVgX
	uZmEHmgqNJn43Yy9ukMuV678brsI59UPxkNmlY164ylNPiCeOVTMwa7p5wdHaOGl
	EPXK4NX6Ga8mrHn/28gjojbk7qN/KRBva5A6OBjEsCCNlmSEwlpKRPZmU7qwfy4u
	jdd/dWb3XaUS18g4MxvICzdgM/w9fTK/FTbhfWFd+3zfEXeImMRXnpdhhaiuAq/d
	VjBga7z503zcaJ2SA3Yze5hHpHQwWsyccmIpusp64bJ2l1Jq5z7Aqrfv1foGlUGY
	hFLNXmISxZNaC+mHENbnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795184705; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:G8AGH/lbv1TxILVvBOaDpSpptERgE/32ChVNtbSEopK5zOl
	cQoBttjlomfVlE6KcIB+f9cXIk42w+1G+cInRvM++APptcUt+/8RB0gVV7iZtP72
	s02CFeurb39n2Tg1+968QoqzO/27OXT3Pp4h4qM6OyHVs4G5r2Kz5eG3QLZ3biuL
	6UEcbnmNG5eUpEOn/vJbk9UmlRo7d8sidLYk2Oi17CQgPyAxp3edTJs9q+scAYIN
	IDYCDoogDMk2JEt+rsuF934lxVBwtHWocURtIzILS6tzG0a5p3VFEod+LVYNbYQ3
	/hGWMagvQSw3K7Rp44k9YEJhHC9HTTi+mDpHpyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xaeXrgoXwEH6UHQts/Y4p9KzttAWljdoYzC9k8v25vY=:0m8DvkStWhvfqIT+AsTqO9HCGqHu5ALea9J4G56QCWU=;
X-ME-Sender: <xms:PlgAa2X3mXJNjaBZ4mH-bqH6aLI8_OHHtN4yYSnnC6wWDtAXSQVFsZ0>
    <xme:PlgAa9bnfaJWyJMb-9OAC3WLvjEjWs9c_enFkaURNOeHUPdgGffyoLGDUyMELxW8t
    F61Qu8urr5sjC7gn0q7D1P0hOxw1hky6LD2KZ_8HKdVyvKS5q_r7Ug>
X-ME-Proxy-Cause: dmFkZTFWioBsIBpDOutJEWDZ0k3XKmYoVj4+GjxF2x20wiZ856wkgKeUrbPIlyOeAYT2Ck
    h8mH/7ODGeZenPWipTmFTP2OFe/tKgWwDJEoN4AIvKsr6KFN9k7dP2NELDaZT0fu88j2SA
    nHq5NdqDlD2lPP/4KqkGbs4eTC4fWRBJp197DzlKIdwvx0F7qFy+TyJ1OwNiUC1Fv6n+0g
    hXWdPo1WmXd0vNigvMnCRRfrzr9pgSdBC0CSPZtf9EE3DHKrkaz9/V0rCjB6w7NrteMctp
    f6Wb/0gXe+QFoR5o3Ziwg3Qsx3y+BJSuvz5V/NwcuhWBvPmwfeol9ThxZEyjptJk0uvgiK
    4Ck6O6teLdRCpZOwcpmYGDbhoyothQ74W/UUKtQoKVyuVKvr9gjjSw0Op5DypCoAkou5DG
    jlbivs966BYkTniLuDeVw1RG2IlDTaMHJfgN3nNQOlQiKN8KbZpJGkDOS8gP+VVVP/USd0
    8NvUNjXuqlChYV+aX+mCNiM1yyDjDehnIFeOO3AKTMmUd1wOZQdyyQjw0PvublIbJXsn6b
    2+LRgPOxfptXmFmmbjHPEAmCI/DhjQQH2y4g2o1gFiljFRBGARNs6TmaNb0llH9WwTnYtY
    jcAjzYmcl7svrc3JjRMwHErNFIqHMGTzrpmc+q9X+19gr8WPdP1ZWDPp9F+Q
X-ME-Proxy: <xmx:QFgAa-0ESBy4c2gHUGVWeCEaEgwaU0fam8ZUA3uDxkCSFCtTarUoxQ>
    <xmx:QFgAa8Alw15OmyFYhQkrhkw0Cq0gTVQTArAaMlO4d-9gkIsddj9mSQ>
    <xmx:QFgAa14JCgi2TG3cMCSSZXsC_Tndtxrv82ONm_90rZ3Oy0WWagsviw>
    <xmx:QFgAa1J1JpYwrs9X1ZFKS5IDruUO_K-779jTcwgtfJelLs1TrUTmDA>
    <xmx:QVgAaxAdZURy2K_M28r8iF8cDBj_7t4QzlS7M3Tn9bU3KsaKDkOwt8GU>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CE95122C00A1; Fri, 20 Nov 2026 09:25:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AJccvP-DtkM7
Date: Fri, 20 Nov 2026 15:24:42 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Thomas Bachem" <gitgitgadget@gmail.com>, Git <git@vger.kernel.org>,
 "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <f0dd8e55-5165-4a28-a623-748bf6c86d76@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB5uqHpeJm9QUC-J7n=RBVB+0pXRuMfaSQZt7mHoZbasg@mail.gmail.com>
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com>
 <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com> <xmqqmrrwywq8.fsf@gitster.g>
 <CALnO6CB5uqHpeJm9QUC-J7n=RBVB+0pXRuMfaSQZt7mHoZbasg@mail.gmail.com>
Subject: Re: Notes, refs, etc. (was: Re: [PATCH v10 1/5] fetch: add
 remote.<name>.refmap)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026, at 21:20, D. Ben Knoble wrote:
>[snip]
>> Ben Knoble <ben.knoble@gmail.com> writes:
>>
>> > Yes, I would love to add pushRefmap atop later! It would
>> > ease my working with notes, I think.
>>
>> > Yes, I would love to add pushRefmap atop later! It would
>> > ease my working with notes, I think.
>>
>> Tell us more when you are off mobile ;-).
>>
>> I do not think I planned to add '--refmap' support on the push side,
>> even from the command line, but I can imagine there would be
>> reasonable workflows that benefit from having one.
>
> In my local copy of git.git, I want to have both Junio's amlog for
> spelunking and my own notes for patches. I only want to push out my
> notes + topics to my remote, though (I work on Git from different
> machines and it's nice to have the notes sync'd on both). Here's the
> hack I ended up with, and it has some downsides.
>
> In particular, "git push" in this configuration does too much, so I
> usually have to think about whether that's ok. A pushRefmap would let
> me separate what to push by default (push.default!) from how to map
> pushing when I want to push, say, notes or other things. I have to be
> especially careful with a "git pf" (push, force-with-lease,
> force-if-includes), since I usually do *not* want to forcibly
> overwrite the remote notes---instead I should pull those down and
> merge them=E2=80=A0.
>
> So, here's the relevant config (I have a remote "benknoble" and a
> remote "origin", among others):
>
> [core]
>         notesRef =3D refs/notes/benknoble/commits
> [notes]
>         rewriteRef =3D refs/notes/benknoble/commits
>         displayRef =3D refs/notes/origin/amlog
> [remote "origin"]
>         fetch =3D +refs/notes/amlog:refs/notes/origin/amlog

I don=E2=80=99t use multiple computers right now. But I do have both pri=
vate and
public Git notes. In the work repository I have this

    [remote "o"]
            [...]
            # NOTE =E2=80=9Ctracking=E2=80=9D idea came from the Git mai=
ling list
            # NOTE We cannot use a negative refspec to exclude branch th=
ings here
            #     (what I wanted) because neg. refspecs cannot have
            #     the destination part
            fetch =3D +refs/*:refs/tracking/o/refs/*

This is from some email thread(s) about using a namespace for tracking
all remote refs instead of just branches. Now I have the state of the
remote notes in case there is a divergence.

(Realistically this would only check my own mistakes since no one else
seems to use these Notes.)

There=E2=80=99s even a comment there about negative refspecs. I think so=
mething
like that got mentioned here in this thread or some months ago? I didn=E2=
=80=99t
have the opportunity to engage then.

>
> The "usual" stuff to make my notes important, but still show amlog
> notes when browsing history. (The origin remote section is in addition
> to the normal remote section with it's url and heads->origin/
> mapping.)
>
> [remote]
>         pushDefault =3D benknoble
>
> Push to my remote.
>
> [remote "benknoble"]
>         fetch =3D refs/notes/*:refs/notes/benknoble/*
>         push =3D refs/heads/*:refs/heads/*
>         push =3D refs/notes/benknoble/*:refs/notes/*
>         push =3D ^refs/notes/origin/amlog
>
> In addition to the usual config added by "git remote add", fetch
> remote notes into a local hierarchy, and push them out, but ignore
> amlog, and don't forget to also be able to push heads. Without the
> heads map, "git push" will not push branches!
>
> Now, maybe I'm holding something in a way it wasn't intended and
> that's made my life harder, I dunno.

I haven=E2=80=99t tried the above but it doesn=E2=80=99t look like you h=
ave made it
harder for yourself than you need to, considering your needs. ;)

>
> =E2=80=A0: There isn't a great story for that, either :/ When "git fet=
ch"
> fails to fetch notes because of divergence with local, I end up saying
>
>     git fetch benknoble refs/notes/commits
>     git range-diff refs/notes/benknoble/commits...FETCH_HEAD
>     git notes merge FETCH_HEAD
>
> or something.
>
> It's *almost* like we need remote-tracking branches for notes, ahaha=E2=
=80=A6
> at that point, Scott's git-meta work becomes possibly more appealing
> to me, even if a part of me wants to "fix" notes so everyone can use
> them easily.

I don=E2=80=99t know what git-meta is. But in any case, I haven=E2=80=99=
t seen a
forcing-use case for making Notes simpler to use. Right now they are
okay-enough for the simple needs that I have seen, which is
single-author (program or person) or automatic-merge (git-appraise(1)
uses json-lines so that cat-sort-uniq merge strategy works).

But imagine some kind of collaborative Notes usage, like multiple people
posting commentaries on commits. In that case one would need better
tooling, for sure. But collaborative metadata on commits is a bit like
the ideas like =E2=80=9Chistory of history=E2=80=9D.[1] It=E2=80=99s pro=
bably not going to
happen.

[1] https://lwn.net/Articles/914041/
