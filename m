Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792848930;
	b=HC0zj1J14ik8QB7tcxUd5g+Lxyo5QF2fGPXz3lbsoAt/89vsLnbnodvNSOKhQU7eDiBY
	 LzPCMkxXLig+P/pxBPVo0WNNJGLilxAjMgVLAHebIoVXPtNbZuO+fgFaJtkSR4WqkRNaZ
	 TvdGxgpAosAb+ecsaIr1XDCWX9IzLnyuds8C6JJFhm7oAXMdCPtnaXA1852VzG/KkmwkK
	 toZgsHNlP5391MoDB2xl1VsNvMUGgVXFLurYROkW2u1fKhe+04VpDR5OfWcv/qcqjF532
	 nWYmew/FPGdfTandhwNx4qk9kR8DJU+nxUUWqo8YTlV27BrMbrD5SU1HTr5tdIvs/zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=O57GTRhyk6DCa/lVJZ47TmHUbFr4PSZltrAaz5/4RmI=;
	b=sUl58z9uDaSjWDYZDOr7hFuM7w8jpE2cb+fFYBEvds0tfkphahhZKxbN1JhRUUwmgDcu
	 pfWRgDPACSbT6W4uF5bOYieAD0AVvjvMmSXjaFgIXvlgwL/t82jo5tWjoxvenSWBSaaG4
	 eGku8Z0tmkNjkbM+JX0fQBXLMsBAXv0ab/HdAaoOLHy2UylL0FuT0mqznB5SQdV8QY25L
	 ChpZm6oOacDO4OdF7DX7K4UzqDSEmi0ntVAY2rm5JnU2c441LvvQSNlGSLgnU1ivdt0aS
	 sQ9/x9h+9N7PPmIcYBUPDKJR9u36WB/eJpogDOH+AD6Rew2yoofUfAe77KVUk+OXrvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NfXnPiw6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D8606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 13:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 113D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NfXnPiw6
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a058f74a54so620047b3a.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 06:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792848929; cv=none;
        d=google.com; s=arc-20260327;
        b=WDo3nfUGtXUJ+sQoKizhRKq+wCrgGmqbvhzfsnXVqeY0qIQjCiaZWtjG+i2P3jbgKB
         vlOdcC0aqWGm4IV8JlUKo0YPJ/eM83zzco/23X1WoZkz+0Q81XtQXJd5pG0ZjIfyGb8r
         kAWthtlDV2rme4q8Hiaavia6y4nz8lrV6dsfBhm6MxR2rP4nQXIL//c4H3j5Ow6E7qeT
         PpGPdHmdzL2tZz4kQH5eFD/N2VJ4TJnILQQxKbSKbo/xMIIymKfI2WBQc9n5LBCJw4i7
         MaJLXWhjR7WWDHQyvte7gb+kKjUpk5e4uDmHWhV1p5VD2CiLv6YDZ6+KhWAj+JWXDomq
         wTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O57GTRhyk6DCa/lVJZ47TmHUbFr4PSZltrAaz5/4RmI=;
        fh=pi2Wn4eMF18KpPpJZodM6+VLGdc65sqepg/FFrVG8hI=;
        b=GVMCYnjKo8Qbx0sJumrnAR76ARuOuw26p0zo9L6NBBRhNne3Hiq014dZlo1JcoW3jp
         4V4VyorXPzH81Cp2dn/5wNOIt1qw72G7/ua/6J4Z3eXmiBsy5bujcH14yRs6Ep7pwEm+
         vuU7nvyBaYobjACLq/koowYcmEK+5gv8C0W4gvT+pE9t9pMpHQi0SwNvGDYASbVTP34C
         1JOFtcTu+znta/HVQHmogjX2DVm2f9UvlBe7IIcsL1zAdOBNHnCOVcXrZK8oWMOIByRY
         b4eKdrKVlUgZWdi/o3wSIpIIKefNWM8aN8VLjer+q1sJQ6Kpn6TdjvAyknwVdvQSdltT
         BLig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792848929; x=1793453729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O57GTRhyk6DCa/lVJZ47TmHUbFr4PSZltrAaz5/4RmI=;
        b=NfXnPiw6NT5dlDtErNrz0yKl387iHW4djI2krit5CSY49VhdFPHHrgnNf0Tz+5ZK0g
         X4un7NaqMU+iyc5mitji6ausHIDajd1R7AjT0kNd1c66IxLFnVzXZ5Ao2bDHVdnf7dto
         GuSadAV4dU7ZzD98UKiuBuhv2eVeiSS7u1O+nmZbNwq1XMXW3/1teumTpR4B6mPI3dKM
         cGGwf0z+R6cLcCC0X/1M9cz0KY3pLl5v7/fhGofjRRHYecyLYV1IcHnPHyVlBFzAxRE6
         rTT0UG/yMdPTgqz9wvlV2Rvc4Z3NA6SfspxLPMnXL/OoT5z4MlrXKPGG7HMxclpiULkX
         Ywdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792848929; x=1793453729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O57GTRhyk6DCa/lVJZ47TmHUbFr4PSZltrAaz5/4RmI=;
        b=cHqxJbDIfmFq0WPV7DjFAZOa+Mr6Ohuooef/uX+C/IaLtP3A7i0YTuvxPdnWH/TVXG
         ArpClCT5OnmPmzYop+tn1S/zMexeZaUQHyNKdUg8WQvsHrLQAipyerCACNFZBQQf3/Rn
         B21r+8GMoYP3SmWhVhCBnff/TUJgVzANlvAGPXbAwgBgESXj3nW9r6SUcE5CnbYAciib
         furSWHB7BIyYFdylWsBjawzsoJmciWtdYuK1f5+K0jk3gstky+zTnE0AzraYt5vKn7Mz
         GCaFEH8b7MsunDFT1l0ttnFmCNVPN347bMT3aJWB0EnDOxKxE4+SG7U/HQr5yob+UEy6
         7pkA==
X-Forwarded-Encrypted: i=1; AKwUvBwBIw9kkefAi+uTavFhay1d+FSDgQra3QwAyUPMsd9bbUc+ivxCLEnBHRHCvcxRu+KPMpg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2RPZO0yxb0sQ231Po7XEB7aaaEaZB7LYGCd7qxu25Rphn24BV
	Y75wCyRWBss7Kt7v1clYAW6dp981x8Z+ZxF2PYeE4V0J5EmvuwJByjOHkuwKrojwkg4QZZ688Uv
	FO4z0eAYJ0bxWR+yxD7bW5Vcj/wLgJCY=
X-Gm-Gg: AYBFou2VzlYKYKQUlcl7Tgy9bVm68Xb+M/QRvO3qhCe53oJOkSm5iWL76OhfMnD5eDu
	Z4j3QHFQYVCDZEYW8XL034Y+GvuINq0hmIhBrP10ExWbyBl+/8dccMoPHfAx77N7c2iq7mkG0dt
	UMLM5moMWcJGgD++thzu2LMoeEAVP2cPqGGQiK8BPUPGMhxtU7B3DLoyXZAlbB4iS+bj5RqMsxC
	l609FLaragnKO/OcWvksx5EbXNpSEDT8McRzJL7Ob3Joy/aNt9e2XfbQs/Nx0yds3+G4pRkWHii
	oGuywi8KXDhU0AXCIBxT7xTTYUwiMaXcuts5JWcWwelxmeq4QFKkCbKuh7dB0V0Cl0BCCGTAetL
	90iF0J/rTCTugIKYNe0ob4y5VRt5nXM33rMtC+Iu+Ehk7GW5zjE+mg6RYRzr6sWw7tLu2Zi4K4f
	4oASPGpJ9iyBnpF5U+37fYRblblbqWthfI1NciJDUI1dTaBphj3Ejm
X-Received: by 2002:a05:6a00:2e21:b0:89e:89f5:18eb with SMTP id
 d2e1a72fcca58-8a3661c522bmr1640799b3a.15.1792848929383; Sat, 24 Oct 2026
 06:35:29 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
 <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com> <CAHwyqnWJOk9FCGkPi8yWOFq5vr-CMWNhn=wBAifx9Gfn+1bMzA@mail.gmail.com>
 <CAHwyqnWi6E=idoP2+1FdeEE4-o3D20xJfsc4Dutt6R30c===xQ@mail.gmail.com>
In-Reply-To: <CAHwyqnWi6E=idoP2+1FdeEE4-o3D20xJfsc4Dutt6R30c===xQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 24 Oct 2026 09:35:17 -0400
X-Gm-Features: AclHuK_yFmgP7jg0na4sBh3GIgkXECKFIdP9fUAHbvHa53_YJNTSRAp_lAjwHpI
Message-ID: <CALnO6CAAoMLZP4MBzgBa96RYMMReyxKXObb2JELqkBe=LBUVLg@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 1:54=E2=80=AFPM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> Why do we need the `--into` at all?

This message trimmed so much context that I had to visit lore to see
what it replied to=E2=80=A6

=E2=80=A6but I think you'll find the answer in the original mail, which
discusses how --delete-merged works when the upstream branch is
deleted (e.g., via GitHub's "automatically delete head branches"
setting, which is useful to enable IMO). In that case, even though the
branch was merged, the local topic is not a candidate for deletion
(because we can't be sure about what happened to its upstream).

So the proposal is originally either

* add a modifier to --delete-merged that allows considering such topics
* add a modifier to "git branch --delete" for the same

To which I've suggested that either

* delete-merged should be allowed to work in this case, possibly via a
special syntax, modifier option, etc.
* branch --delete should be allowed to filter branches, in which case
we could even migrate some of --delete-merged into that form

In hindsight, an *even more composable* interface would have been to
teach --list mode how to filter the appropriate merged branches (which
we could then add to for this RFC) and encourage

    git branch --list [filters] | xargs git branch -d

possibly adding a -z option if needed (which my read of
git-check-ref-format(1) suggests is unnecessary)? In which case
--delete-merged could be something like

    git branch --list --merged-upstream=3Dorigin/main | xargs git branch -d

where --merged-upstream=3D<commit> lists all branches whose upstream
configuration is reachable from <commit> (and I suppose you might need
"-D" in some cases, hence the --delete-merged --dry-run form today,
which would be "just omit the pipe to xargs" in this version). And the
delete-merged branch filter would still work, since --list takes
pattern arguments! Hm. I'm starting more and more to feel like this is
a missed opportunity.

Rereading our docs for git-branch(1), I think what this RFC is looking for =
is

    git branch --list --merged=3Dorigin/main | xargs git branch -d

which should already list (and then delete) local branches whose tip
is reachable from origin/main. And it would be sure nice if that
combined with --delete-merged, but since they are separate forms, more
work is needed. If we had the --merged-upstream filter, we'd simply do

    git branch --list --merged{,-upstream}=3Dorigin/main | xargs git branch=
 -d

:)

--=20
D. Ben Knoble
