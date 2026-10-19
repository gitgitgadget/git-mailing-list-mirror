Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439916;
	b=Gbo+Cmror3lBpbUIQFSFV6U5fbHi9L08D0v82rtV2MsEg5Krlx+j9Mdk5yELpMupJp0l
	 G0X1fKVTcwRoWNdIvGijx7ps/3vsx/9IhWfJKPME/JsAqg6cm2OaOYDyzEYuSrgU3Vvfd
	 XPhxRpCvuKeOlad+Zj5/p+M7phj3dDJlDWW0mqQL1TR4wnLWFrRut7wtsrYRYE+z4VNU0
	 Yqj5VJSAF85jRYfdH3CaPsD7rXUtPKg/ZLmb+HvM9lbw+3HSALk0taFGuTEMTOfMnPJU1
	 c4b/MwBN6Q1+z2m4Q3JvCtV2e/XMTNgGDt3QW+EzNN0Gdo+CgNneMj+wyKR6+/D6skQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=T/GM0MLhhlzByFqWhBVX9n0NC74cZvDh3TR5nOp8L2c=;
	b=nnrJigPXivI/ZwPS+r0C8CZ02R45q+RVDPd5QLKdBfpoaEGEfNQESHMnZu2F9siKlCSe
	 VRgcp9i/60rPIS7xLPr7jc1TXxyjH8L5Vfsu78JjPGcKNbcur/4kxZ5XsEwmK4h1i71gu
	 x4sHK03pD/Itv+5YbwI1OaZ7K7EF3yRP50hxGQ64A3Pn0psZdsYR8AcxdkdMKheRo5gfT
	 Xgtqnpmsz3OPPZ4oNsxFlkc8TkexXQC/kWrS0RhEW+L41gGIeFPXfxwxnq3N7HOXhZoPv
	 wKhif06m9sJEkRPLNgoGlfu2QeyeXglNOBAkITB/vbk9V/V0oezziuvW/+fwoB6qt8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVAXfN9b;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B08606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B08606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aVAXfN9b
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0cf2c0785so19635937b3.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792439915; x=1793044715; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/GM0MLhhlzByFqWhBVX9n0NC74cZvDh3TR5nOp8L2c=;
        b=aVAXfN9bjrCztspShIkEmz5p9av9DqwZphEslXTVb946h/A2Bu30v+dRjVTJuQ0DAH
         1ItWYcEEbmxL0D+ocGiN81qYt0ixYc25LbcksqbKgPDg+DQ0kMkIZrqoTxr4e8vYfXxp
         7/wDdWaRoSew3iqv4rVBgtfvKJFYsUWLRH+zVzK/w1Nst0dQ2NxK55e2fS4p5n6kUE8S
         nz+0GJppcyKLKQ8K32c9942M/Jh4npbe4tEnJe3NrZ7KaDFowr1GgzQXmu/Aeu+U5yS/
         cabVIwAzwNwyL2ImhNmT+ETkFUVm0lzvJt7tAnr1IvY1+5LaGAm/22cFgxqQEwlx2rLU
         FeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792439915; x=1793044715;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/GM0MLhhlzByFqWhBVX9n0NC74cZvDh3TR5nOp8L2c=;
        b=tIfbA7b/UosbGhlxIYt8sNVW8h80yYkfYVI7DwkaIyHDhfv8n7nD65zMTDouf+Zyr8
         IK/Nj8hRJJbc+xlLcaQ20ppmccFsKPpPVQOXX4k5p2AUzMJi+NvNMGnejPerlPiB0lOT
         PBbUsezhhffcuH2TteFs/XT63NDnbOzy3TvACtK0NzLfw/+feZkxu4LN0Rxsp5qdG52m
         nDD3V7pD09EKHuHIPCKg6hd06yI6oGv6cUQFUhbn/Xt7oHeJWxtD761Se9nZjt8Hwh/p
         NA7Gw5SvbZ1WA5syw6MhWBEPBMtA0LZ8xKlyIdedZNciLnm2RKPnC3XkJP4RYimCS6re
         sEPQ==
X-Gm-Message-State: AFq9FYKZ0CLk+gICEWLiArrSky/0D8rHuf/Rw16qE6wmgkYqEf0emEmX
	G1sfiXBIc5YEsVXVQnM6KHtbmeJ7w89AE81MqqxWS60NNaQ4E8P2+3d8lLa2Eqj6
X-Gm-Gg: AYBFou2TCMU0jqCRoXzmVcCYdVrQJHScfFhShvJLW/scErJOZDBBiRgNUJKOiS5fvS2
	PxoojaWrIXkdxfyhJpVYEv0fmn18leLgwuZYrtDuIj9bCJPMFupn3Xp4OdtcaMvzfwLaO0PaTL2
	S7/ZtnmB8IgvZ2k4mtfpvS2iHqzV/nwil8lAAW9nRPvMmej2wE/XEziwECq331KErkIEX1CAmCl
	KHPeaOkAbo/R5hY2EJgF1bRYxeZIbaFqqUsaG1aUChz6xC3fWIsBwLxc421lh8aqM2WBX1kAovV
	mO3qB1nEn5qz3za+KhsvQY/bYwbiM9Uf8aAleEItgrgvQ/l0vw6RWDTL45ibWYuFBP2ku5oqATK
	M9J3Xh4Q+gdgo6J8dpeZ13hfTLP3WHe5NjCypPj8fCx8lElQ+DahuYISacb5UohG9BiNQoLmdqV
	hLvpm7QB5VIJR6cnDnU+Q82p5gtRcw5ScqyKHH4aUCcKZR30DDo/xsfFW3gRftRmOLJDo9IhnsB
	15/pxasUFgXmpD1tYZ7W3KbkKTCB5vWvYtSdSKury4q7kZywHy0tXM9ODZtbrBgjDBn3A9rfSjy
	4M0W6R4xZgV7/bQoqX84k/EANfvfWEZ1JuEhQK5lcOVF2Ok=
X-Received: by 2002:a05:690c:399:b0:8b0:effc:5d92 with SMTP id 00721157ae682-8b0f21b0201mr26391527b3.29.1792439915296;
        Mon, 19 Oct 2026 12:58:35 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:a9b4:ceb5:f03c:386b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b7d8e36sm4484487b3.15.2026.10.19.12.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:58:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/5] completion: simplify stash subcommand completion
Date: Mon, 19 Oct 2026 15:58:24 -0400
Message-Id: <2076548D-473E-4EC7-AE92-3DCBF1D3A4F1@gmail.com>
References: <atHZzrybhYzMVGbQ@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
In-Reply-To: <atHZzrybhYzMVGbQ@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (23D8133)


> Le 16 oct. 2026 =C3=A0 04:01, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Mon, Oct 12, 2026 at 01:48:27PM -0400, D. Ben Knoble wrote:
>> The stash completion helper contains a hard-coded list of commands, but
>> git-stash provides a mechanism to list such commands
>> (--git-completion-helper). The pattern for using it is wrapped by
>> __git_resolve_builtins, so use it, bring _git_stash closer in line with
>=20
> s/bring/bringing/?

Will fix!

>> other completion helpers.
>>=20
>> Note that we maintain the "save" special case, since it was removed from
>> default completion in 0eb5a4f911 (completion: stop showing 'save' for
>> stash by default, 2018-04-20). We don't have to do anything special with
>> the exclude (3rd) argument to __git_resolve_builtins, though, because
>> save is already marked PARSE_OPT_NOCOMPLETE.
>=20
> I didn't understand the last sentence without going into the code.
>=20
> I assume what you want to say is that we don't have to explicitly
> exclude it when completing the subcommand because it's already marked as
> NOCOMPLETE. But we don't want to fully ignore it, either, because we
> want to be able to complete that subcommand if the user explicitly wrote
> it?
>=20
> So basically: we're not completing it if the user writes "git stash
> sa<TAB>", but we then know to complete its options if the user writes
> "git stash save --<TAB>". Which I guess makes sense for a deprecated
> subcommand.

Correct. I got a little too familiar with the completion guts
while working on this. I=E2=80=99ll try reworking it when I get back to v2.

>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
>> index c3a49e2e22..d60e85479c 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -3553,8 +3553,12 @@ _git_sparse_checkout ()
>>=20
>> _git_stash ()
>> {
>> -    local subcommands=3D'push list show apply clear drop pop create bran=
ch import export'
>> -    local subcommand=3D"$(__git_find_on_cmdline "$subcommands save")"
>> +    local subcommands subcommand
>> +
>> +    __git_resolve_builtins stash
>> +
>> +    subcommands=3D"$___git_resolved_builtins"
>> +    subcommand=3D"$(__git_find_on_cmdline "$subcommands save")"
>=20
> More plumbing, but less stuff that we need to keep up-to-date.

And more aligned with other helpers, yep.

> This also
> fixes that the "store" subcommand wasn't completed, which should
> probably be pointed out in the commit message.

I missed that, will add. Thanks!=
