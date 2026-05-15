Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE93C8C65
	for <git@vger.kernel.org>; Fri, 15 May 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838435; cv=none; b=am/RgKnmoEi08tZK4R9wo/wNhJhuQ1n4yu/TTmQJxtWKbGPwyNNmnj6Ic3MIcRs2A2g2Yqz+rzZ8enMMBBBHZDu1nCm/qO+SbypmF8SyQ3jVNNkYjdWE76vakPGK1L9MukUCxc2Km4me83J6qaCwOhjVz2L0phQx7g1N2+5FZoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838435; c=relaxed/simple;
	bh=JzyjZALqnpN6/za0u5GIdotyUMZxx/6Fijrw9HPV6LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=upTI/79cDMRuyEjn/s/vgHECLJrKnBRkz5iCKy1lPcp/bmcCQHZJ4v3IWLrzDy8AQ/1hYcgGJmudnB5+tC96IkXF7B5KmA6yFkbn2rIXjz8SxWhHnMVLYo+0ZhYz6j4JX6NQK+CL3UItJ3z1LoqHzHSuPUDHX149tJuvGrbHEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=fmIhoaCF; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="fmIhoaCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778838426; x=1779443226; i=tboegi@web.de;
	bh=UNabfz2feOGI+DpFdVJtf9j4l+WrOAv+IkQ2md6dvt0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fmIhoaCFFEZWHmHbiiV/4uPIpTpodS4+b5mmdz3F03Py9Fdlab8sOYmIyMarvgOS
	 aWlQtxr7kIb+UdmJ/Yu1T1QUJg0XilNwdVLVAT7/rVTUlPVpM5KX8wYBHiPKW4cEM
	 /eO+liTWia9D02TeE7mcudbADXlTga35AIOcg6eART1iRaaK+Ibx0WAdkPStRQqw2
	 UGY/Xm2pf6rI0+wx1XT+KpuppsXk46HO4N5pWnKNQv1mhy2pFKrKyDa1EXG6GjG6P
	 E0JJQNtwv61Xzy6+uQ5T8YhUirCC6Ej+Mc46pjyOfKEV1oneh4/dZ+/3O8YvCMvPo
	 FXmskixM8qFPMcevdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1wPSl610bS-00BQYy; Fri, 15
 May 2026 11:47:06 +0200
Message-ID: <a77695ea-ae24-45ca-8c14-966e25bb90ba@web.de>
Date: Fri, 15 May 2026 11:47:05 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: lowercase "head" resolves to wrong commit in linked
 worktrees on case-insensitive filesystems
To: =?UTF-8?Q?Alexander_Sandstr=C3=B6m?= <mail@alexandersandstrom.se>,
 git@vger.kernel.org
References: <95BE8E60-1684-4E0A-9E46-E61E81D06CE1@alexandersandstrom.se>
Content-Language: en-US
From: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
In-Reply-To: <95BE8E60-1684-4E0A-9E46-E61E81D06CE1@alexandersandstrom.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OoovbzHg3k1AsBeEgf4DYOHJXdEiK3cvOOKSV1Dqzbv1kBHY28G
 7g7gykQpkIU1Z1RvIIweDq4Onj3pRyTQwe41SGS2HNhZhF6GFQ1rZTZGQ+NvUndzDyDjxfS
 Qxn28To1Yl91+rBqIuia0dGL0cOgKYcbsYcR5vY00DJ0R/panW3Hmp8zObnfdFRVVLS/fl2
 aOnH8zJvQ41TeJqSAJabg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HjSrjslavhA=;QipzlgdO+tQYFGajWsN/bPNdvbt
 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



On 2026-05-13 10:18, Alexander Sandstr=C3=B6m wrote:
> Hello everyone,
>=20
> I ran into a bug that took me a while to figure out.

Thanks for the report.
>=20
> I'm sadly not a good enough C programmer to submit a proper patch,
> but perhaps this bug report will at least be indexed by search engines
> and help others that might have this issue to understand the cause.
>=20
> My guess is that it will happen much more frequently now that
> worktrees are more popular.
>=20
> **Report**
>=20
> On case-insensitive filesystems (macOS APFS/HFS+), `git rev-parse head`
> (lowercase) in a linked worktree resolves to the main worktree's HEAD
> rather than the current worktree's HEAD. This causes commands like
> `git reset --soft head~1` to silently operate on the wrong commit.
>=20
> **Setup**
>=20
> ```sh
> $ git init main && cd main
> $ git commit --allow-empty -m "base"
> $ git commit --allow-empty -m "main-only"
> $ git worktree add ../linked HEAD~1
> $ cd ../linked
> $ git commit --allow-empty -m "linked-only"
> ```
>=20
> **Expected** `head` and `HEAD` resolve to the same commit in the
> linked worktree (or `head` is rejected as an unknown revision).

This is probably not what you expect.
head should not be used at all, since it is not a valid reference.


When using case-insensitive file systems, head and HEAD may
be the same, but that is not a feature.

In theory, we may be able to refuse head on a case insensitive file system=
.
And Head, hEad, HEad, you got it.

In practice nobody has done that yet.
And a quick search for
git refs case insensitive
shows a lot of reports about the limitations that a
case insensitive file system gives you.

And yes, you can format a partition on MacOs case-insensitive.
Or live with the limitations that arise.
Or send a patch. For the documentation.

HTH


>=20
> **Actual**
>=20
> ```
> $ cd ../linked
> $ git rev-parse HEAD
> <commit: "linked-only">
> $ git rev-parse head
> <commit: "main-only">
> ```
>=20
> `HEAD` (uppercase) correctly resolves via the per-worktree ref at
> `.git/worktrees/linked/HEAD`. But lowercase `head` falls through to
> general ref resolution, which opens a file named `head` on disk. On a
> case-insensitive filesystem, this matches `.git/HEAD`, the main
> worktree's HEAD, instead of the linked worktree's HEAD.
>=20
> Without worktrees the bug is latent: `.git/HEAD` is the only HEAD file,
> so the wrong codepath happens to produce the correct result. The bug
> becomes observable only with linked worktrees, where the main and linked
> worktree HEADs diverge.
>=20
> **Impact** `git reset --soft head~1` in a linked worktree silently
> resets to the wrong commit, staging unexpected changes. This is
> particularly confusing because there is no error or warning. The
> command appears to succeed.
>=20
> I realize one argument might simply be "lower-case head isn't a thing",
> so feel free to disregard if that is the projects stance.
>=20
> **Possible fix** During ref resolution, when the input string matches
> `HEAD` case-insensitively but is not exactly `HEAD`, git could either:
> - reject it with an error (matching Linux behavior, where lowercase
>    `head` fails with "unknown revision"), or
> - normalize it to `HEAD` and route through the per-worktree codepath.
>=20
> **Environment**
> - git 2.53.0
> - macOS 15.6 (APFS, case-insensitive)
>=20
>=20
> Regards,
> Alexander
>=20
>=20

