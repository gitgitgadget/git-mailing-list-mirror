Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185265;
	b=dAXdJEZIKw2lwFz1zk7p42WrIm/xEfzjzXmL9EpwhHa6KUGt4fd8LmvmJCB54qMzEvv7
	 Sro3UGjpXLV3iIuRYAvVfeSMAJasoItWRJDOZ2djAy7C/M3ZRlp2uCS9wl7lbIu6Ty1Fm
	 Ga5ZHbm/yG8IJ0hMihs4HhMr8Ht+OeiAK4Knv854Cii61XcDutFzSXFEjWXJyA27p2MrT
	 CU1N25UaMXfe45nldXzmO4i8E53Q7L3yEYSR0DaycvYLYdGS+usEVw18CEE0w0ckjWAjI
	 bJc7G4vuKAMXPrzC3YetsnAjLsUrCICWQbeSXZZN1JoOBWi1VWxVD6EezP7EbWDgqHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185265;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=GkK8bLPfK/RslSgpn4kP9N4zGLTway/Ke4mJi2DZEzQ=;
	b=hnszO7dxB3TwAi+/2YdBQpK2by0pwdGajqX6M53qUTkR3FwWiKuqzUKoaHK6TGO4yjO+
	 ALLpKcCo5C2SGkvHepZ/39bmaWxWzCflBrhHYBTDwZ+AiEDnBPj8X+EIJLLHPZ8IUmtnt
	 EwO/IOzaMKfy0ppjzW8XKLb1yYSoqBUEjaB3XMzwHpzIML0sv3DtZNIhMXbCqWc0bNHJL
	 snAgDHDjD/5/ph/CfoM4OD9VOthsM+VGFfsloCooMuFwKKX4vjK7MUaD6sFIYa2vXjkLM
	 cU1EbUCqQSsh81KryTtoyoBb+olcYtpexHLuFXn3Ho0ehP8nBfQ7+RmznDkMFSexYeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=BcfxicE4;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sIf1LesS;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC1606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ABC1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=BcfxicE4;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sIf1LesS
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D5E281400261
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:34:23 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 20 Nov 2026 09:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795185262;
	 x=1795271662; bh=GkK8bLPfK/RslSgpn4kP9N4zGLTway/Ke4mJi2DZEzQ=; b=
	BcfxicE4rcDJfAuEHDn1cafsHJYpSU3jJJ+X8jfunOTjTKg/rEtTAgck/3MdcZjr
	wUZYGn/65Lp9Dwv+6APBb7DDGgojfrv87BLrbUqkdNEnOOQL896wyTJcQL9UfwTo
	A7bqB3RZUt4/GlusRphXKdz8C3C6nRH2MmucuQObKpUCd3EhqaHGwJnMnDfhMSQ8
	Lune3E3zJDZrcW8AqKG2a2brj8viQwQ5h1LBl+XF1MNAzAgqh/UGhch+dH1QT9df
	S55DVmCb5m6cL94PDboikflYg/6q9GAb6qQXNwinboSGzUEY+4La1jHxfMPO7tNq
	LpkM1EX1toPPp2ZfhyAd4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795185262; x=
	1795271662; bh=GkK8bLPfK/RslSgpn4kP9N4zGLTway/Ke4mJi2DZEzQ=; b=s
	If1LesSWNbpkVlo3ayXDaIyhASQ6W6YNwmj6xqXjE+5tLuUkSRZo7Ae/QaCGiKkV
	sAW2Js/UsH2UiJknehWC89ZrjkQBHCmUhRHSe3tAWBpCqxm7kxqyFGGWgOc6gdI/
	wv34fuhymCfr1h4N5aOMq7MtcEyZ04Brutz8HDfaovLcLNJkm1PglACFIJwu+q5K
	hot1hQHjM5fxAStVNy3tai9sT05LB7Zk3Kk7Y7umwybPBV9+2bGXKsm6S6UTq73R
	JH/e7F7UE3U5Y61IM25clBXogNmKlZzWmiTgTLVDKtJP6fjvGP5HVQ+xx51uzqs1
	do7PkQ7WK3JfHduWQPIKg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795185262; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gxdQuNAXwL98Jowy6ht0wvY97xRplaXT7WldoRlyycXokCF
	F3lPU2U4UPWXK7dRcRJeo2QPDbM4tK12mRs9imKR2p9qLIQlwtGx9d9ii3Azu0Sy
	GaR29K4e2/XA441FDItAOFhDF+j6KWXcvXX84P1wKTUoNNgxm3gFROc1QIMLYXm3
	2nM92hqlUF6wtbGhDHPfE/TdD3/Stn+x3ESmY//n3iKc2nIiuZntfAs9XlJeAqaD
	CaYY05CiweEAHjwRPNJe7iG8E7uxqFfjUaLLg4DuEnhBjnZaj9N/JsRmFk38OwOO
	hyzE/mcwDFHuaiw41rvNXDyJo3ODf4ycaVqgBTA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6ftP+7v7qWxlUJfdUCbkiSk0QWU7P6qXsXaMRH58KdE=:Qjr9z5nbVj085RO3d0MlNDWvypZStnDelsAK+gmfg1E=;
X-ME-Sender: <xms:bVoAa0lez0KMLGqvlFycHaOntpZFd_bWvam_FzOIhmZ_cxRWGEoGHVQ>
    <xme:bVoAa-qO29VMdVeQ9bdy3dumUnc5X7FdeMXRXbuXTTsH2Zv-ZNJ9oSYyhEcWE17hj
    B-V7uJ46HwyT1xsk79yyMhdWLpfD2eomBlHLn46RKPXi7L40qeHEQ>
X-ME-Proxy-Cause: dmFkZTFXtixRc0g8XrXTBjamv/5sc7nPD/3kxghQf5ytZAkaYwjNJFsvian+1dzs9OSmjO
    I5ezuD0PpP78W6CAvtzSesF74MuZVtO76Jd5jnpJnCMQF8Sz4vGx7L5aNVs2NlXqchVPgx
    Avc8O4D7hyFSm0KzoZYb4fAiLiRr85KfzrQu0yw65u74iV0flVeoEIGU5NP0iAOk+Zeoo9
    3rZwaFKUsu0OHTNqYQeLH/+2TCIvPHX/toO1QjKjZYuQc1EMjpsM5E6GcZ1gdhaYGWJMPy
    tSDsyGqQEloRpMEtM8h9mUSlhU8WDJ+/MbQgnYfNtynqZtBrwUwIRaCLEzseGNy0Y4+Bjh
    4IXgBlJBovNADwzfW+9GE9Q4bB0YkTz07lOxt1MqSP+dZvP44AOVFwwnQ0ndFnvygxFFL4
    KCWr9h+SDnBUlYhYarYchatWfDk7doEPZIaN8pSS6UFMJYnGPZTxHUtThz2+I/HsG/jZO/
    wk+xuunl/B914Babwmh9nrvMHzPCW5pKlPsz9lU32Y6NdXWeesB9BNxbBzBn3R+xnl0J1R
    GuBNiRRHVcEzvSKUzS4rM5WEdiu+j92lJlvjcghgFKnwKYFyFPZT/ab4XuCNx0Ptd5SNxZ
    W+WfmiQRQUIzG6/+KH7APTtIEop5cSQitNlFlD7ecDDtn9iPbdM8UUPokENA
X-ME-Proxy: <xmx:bVoAa5jD2lnPm5FFzI7-F5QdZQL-9DYfVvYg8SybcHKt1Nk5-of3Og>
    <xmx:bVoAa1xbytY8SxWSC2Ptw8QEfAaWdm4Dndb3WNoaWuHdYdnRGtmldw>
    <xmx:bVoAa8IJb60jCzVTOaOiRY5yD533eZZyBamroniflve9xuVjiPJI1g>
    <xmx:bVoAa8T0dOAymjdoywK8Bf1puLZhh6Pl7cPu9PpX0JBsBsFCNooDQg>
    <xmx:bloAa5faHDUx7_B2f2KMoMmXRSxcz_OD9tSyUgLufFfDJj-JeDZbaLNw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F16B222C00A0; Fri, 20 Nov 2026 09:34:20 -0500 (EST)
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
X-ThreadId: AA0Zomq0_rWw
Date: Fri, 20 Nov 2026 15:34:00 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <e6debee7-8645-43c3-b556-b39da7df6b64@app.fastmail.com>
In-Reply-To: 
 <CALnO6CB9LKjJ+NeSacJCUNrhWLNj6CM2Oo+JR9c7ZdohQPJWow@mail.gmail.com>
References: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
 <2A1E1423-8C1B-48FA-B1BD-DBD422748623@gmail.com>
 <528139f6-db92-4061-be0a-88d4c376d252@app.fastmail.com>
 <CALnO6CB9LKjJ+NeSacJCUNrhWLNj6CM2Oo+JR9c7ZdohQPJWow@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026, at 21:22, D. Ben Knoble wrote:
> On Tue, Nov 3, 2026 at 5:46=E2=80=AFAM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
>>
>> On Mon, Nov 2, 2026, at 17:49, Ben Knoble wrote:
>> >> Le 2 nov. 2026 =C3=A0 05:51, Kristoffer Haugsbakk <kristofferhaugs=
bakk@fastmail.com> a =C3=A9crit :
>> >>
>> >> =EF=BB=BFOn Mon, Nov 2, 2026, at 09:51, Junio C Hamano wrote:
>> >>> Junio C Hamano <gitster@pobox.com> writes:
>
>> >> For you all=E2=80=99s information, what was originally totally unr=
elated
>> >> research has made me doubt whether this command is needed.[1]
>> >> git-diff-tree(1) cannot do what this command does right out of the=
 box,
>> >> but it looks like some modifications can make it a replacement for=
 `git
>> >> format-rev --stdin-mode=3Drevs`.[2]
>> >
>> > I saw these come through, and I=E2=80=99m not sure where you landed.
>>
>> That git-diff-tree(1) just needs to learn to optionally NUL-terminate
>> diff and log output.[1]
>>
>> I looked into it after that and the code has turned out to be too
>> difficult for me to make sense of.
>>
>> [1] <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
>>     https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@=
app.fastmail.com/
>>
>> > I was mostly interested in the stdin filter mode that turns hashes
>> > into references; is that supported by your alternative?
>>
>> No it=E2=80=99s not. `git format-rev --stdin-mode=3Dtext` still has i=
ts niche.
>>
>> >> [1]: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>;
>> >>    https://lore.kernel.org/git/ce69d94e-7329-449d-b3c3-47d4f3aa608=
c@app.fastmail.com/
>> >> [2]: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
>> >>    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f=
0@app.fastmail.com/
>
> Hm. In that case, what if we made diff-tree do the things you want
> from, IIUC, the "revs" mode, and made format-rev work only in "text"
> mode? That would make invoking it [say, from an editor ;)] nicer, and
> also cut down its scope a bit.

Oh, yeah. I=E2=80=99m fine with keeping `format-rev --stdin-mode=3Dtext`=
. And we
should of course simplify it to just `format-rev` if we remove `revs`.

So command removal or option removal: could go either way as far as I am
concerned.

> Or would you still want the somewhat higher-level interface of revs
> mode to be an option?

Being able to either do `revs` or `text` doesn=E2=80=99t seem to buy us =
much in
itself.

The only thing that I don=E2=80=99t like about the git-diff-tree(1) appr=
oach is
that it is completely undiscoverable. At least to me. I was only able to
find it by happenstance. It makes no sense to be to use git-diff-tree(1)
as a commit log plumber.

1. You need `-v` or `--format=3D...` to get a commit
2. But you also need `--always` in order to countermand the =E2=80=9Cno =
diff so
   no output=E2=80=9D for *merge* commits

So this:

    git diff-tree -v --always --no-patch

Reads like: do a diff verbosely, always, without a diff. Huh?

But again, I am totally fine with removing the command. It would depend
on if anyone else would, perhaps, want to keep it as a wrapper/skin
around these options. For me, I know now, so using the above or making
wrappers is fine.
