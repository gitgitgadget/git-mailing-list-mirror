Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411776;
	b=pNrpCNensjlJBKvoVfpZfbO1WoZaeEI1VzyyuiGcrlyaidmEfg2ze6LR4DaYhX2rrKSs
	 Y0pLUTgMCVQklQAf3WLDwlKQgZiseA8Ac19fvG8Bi4M3c7t1ID38szhtEWHTETDkud9cp
	 bqueyH34u7krYnf6z2PsR+IuK+zezPXh3V8+9u0LnDXQnj4DlAtmtFmvbYNOaTv9q4/Pr
	 5KsyTBy3Aet5zZLZrxGBghqaW/yHMm/CTNn3FvdNJKTF7CAZnd72znALyZXiskY8wXfDk
	 7MQxNF065gqpzFQ7REGQtwZuS0MH7qIIhXk++hSTg57QAL1UI3c3Yu+5o2Bcdpe0LAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=RnCPGcN0kpGQQbRNh4n6MPmLluN5tT0ZtOOWOJpMEec=;
	b=F+fD7N2MykYeSB4QSpH0AmYq1UABvhmWwAfmdEXx6aUDKA/hzkjlNLfir+VvFnOdsjEo
	 Slvq7wd2Y2Z9j3qqKOegr0Mjk/G+O0J9kIUq/l2cWMYS76b3TtNYF1304VFB/cbqgCYwB
	 gnWuagu3PVi/e0tbHsKiAuVZkJ20iJyXcQmrEb2DXdDjF6uLXMDAVnbVC8WyKjTkUND0d
	 YyrPMbvW3yMN2TeQUu+z3HZYQ/yuzRvrbK739QC1FMfTRQL8bu4prbOMVUHs5BOHMeMeu
	 Lluo/flyFs59LKIlRvWyzIskagMdmBtSJRiIqviRmTK4el4GsXWUS4NKg2ZHU6jxVLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KTmgTt7c;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA9606A32E
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ADA9606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KTmgTt7c
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b3653df740so11176907b3.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794411775; x=1795016575; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnCPGcN0kpGQQbRNh4n6MPmLluN5tT0ZtOOWOJpMEec=;
        b=KTmgTt7cyirUUX/kSYlQMDrPcQyX1PuCh0JzJ3tyYyKiHaqzM/jzeKgXzY4JmgCuLq
         1++Vwk8c+JkxJeNTV9auFZlHANI2IgXtBaxuhzCgHSj6ShKSP3buxOCn1ufvHWWnC22I
         LHCcl6ARd6RlzGbSse7cSu8ffUE8NtWBlVuUv1GF5BhToFSQCEpKVA+CoyuXJT9tx9WI
         cfvEhIh5Mwx3aSb9faDvSaPylj3N+faAbzt995xX6J5yFSlZDeJvsl2NVBNPK2wcy7eZ
         AvVniGk31mJ0DBGKcn3pzjpGBrKIEthtd8Ozbw7hxvxN6gpoFMVvkqinVWUKZl1zDO+o
         JYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794411775; x=1795016575;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnCPGcN0kpGQQbRNh4n6MPmLluN5tT0ZtOOWOJpMEec=;
        b=sxqulk90CL3FZeCY2v+XtlPqh6qYkawfYAdmbjusLNSoEy0XAVgeUfslkcQ8BHzX/G
         xnTpR4eVpcIGSEFirtpujaSU4Yag8iBH0RNlALhSbGW1g8oOkVla9PbSozcMjkTyG1xn
         BSlpkllWg8jUmFzObKIUdt6XqqPZKPGv2uxCBdkHySsG0A95fmvuxTWvY8SEFzCfloIS
         YIrpTW7oyh9LFr0qGhOHGsx7FnbTNXsfh+usAIuCmM8oPvuL4BF5xQmVYE1NrjtFDdi/
         6j1y9Idu8Q7WONBxnDDyRmAxU5LhIOgEuVhtlGQhpq72HmU4vzgY4NO2cZhexnooZsv4
         2c/A==
X-Gm-Message-State: APuU4Z8WxM/1C3+kESBBgle7QFqzDy4WsGFST+hCis8E+1wdr/hgAvPN
	BkMsn/bfO9OJGPo9jWaV/Oi2pns5lywL7YZZHyoH8bD3SgNPoUAnVcFt
X-Gm-Gg: AYBFou199PiYVibVcRc+qu3ESjXht/9lJkl6HSLeMs3b7OQlm09HTtHy+B/cEBZnM6x
	eKQoWyoWBxX54xkaC9KMFAQ7cpoF9pG1DdQN5hdZ1xo4uZS8U4iuuP7FsQ8On93YxikxYNg/tAz
	VFitRFWIkBTYHhulacK2Htn0sJqPmDm1VL9QhQQb5O6XtNQRSq3eGlmDOjP1GzkvtzkuRdazFNr
	CB/eP310Er7vUnCDygtI5mNWWHj7P0fnXTRd74DdRX8WPaBZtxiykVAz9YI3hJ5nqtBBgaxpq9/
	upms1BwgU/kuhPBV3/LGl+e5StZaBgqEX4hgn7f7JU2LLkujzFzoiz05ihSpsCqVRPVW+CrxPk3
	eNUOKDQtziXiCLxStIRau/Tt/Teeje2gJOPI2ZO21VLkf2377Vne10JQ5kqcYsVR668batRinzq
	uytx7a6k/MfqJMEzjeBy1OuQ1i9iXYlo41ksW7LCueO7Q/ZUc8YDee8iiwuIKpY/c/hbFH6Szpx
	zuRXYoqciyBs6+dqBfZ0hGiqrC9aEEnciE7Ako/7QghgSGsL9HhVJtKFO8fq3Y1ROJ53fp0s7K0
	AzlKZIywZvzeqHX55LIfkwx+/kLv6eke5INyEaqF5Fvg3Al+7khhrUo1/xLtITDKMO3rNOY+4JG
	tSsy3BwwbNAfLKsuP6Q4hsTgI6DvUH3/u/y+2Up1oYJgi2hStQORwkl8OQz3D2OyEfZ9m41v7eI
	egamw=
X-Received: by 2002:a05:690c:4:b0:8b3:549:b097 with SMTP id 00721157ae682-8b3a81c5b94mr20403297b3.60.1794411774519;
        Wed, 11 Nov 2026 07:42:54 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b092:7eb8:5dfc:125f:18b7:8759])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393415af1sm46704247b3.30.2026.11.11.07.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:42:54 -0800 (PST)
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
Subject: Re: [PATCH v5 0/5] worktree: treat a branch being rebased or bisected as checked out
Date: Wed, 11 Nov 2026 10:42:42 -0500
Message-Id: <B5975BB7-698B-4431-9A17-B6BB79559A95@gmail.com>
References: <20261111152811.99986-1-me@jaspermayone.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
 sunshine@sunshineco.com, kristofferhaugsbakk@fastmail.com,
 haraldnordgren@gmail.com, Jasper Mayone <me@jaspermayone.com>
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
To: Jasper Mayone <me@jaspermayone.com>
X-Mailer: iPhone Mail (23D8133)


> Le 11 nov. 2026 =C3=A0 10:28, Jasper Mayone <me@jaspermayone.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFWhile a worktree is rebasing or bisecting a branch, its HEAD is
> detached. "git worktree add" and "git branch -d" already treat the
> branch as checked out there, but "git worktree remove" deletes such a
> worktree when its files are clean, and %(worktreepath) and "git
> branch" do not show which worktree has the branch.
>=20
> Patch 1 makes "git worktree remove" refuse a worktree in the middle of
> an operation unless --force is given. Patch 2 documents how to read
> %(worktreepath) safely. Patch 3 makes %(worktreepath) name the
> worktree that is rebasing or bisecting a branch. Patch 4 adds
> %(currentworktree), and patch 5 uses it so that "git branch" does not
> mark that branch with "+" in the worktree that is rebasing it.
>=20
> Changes since v4 [1]:
>=20
> * Patch 1: each item in the list of cases that need --force is now a
>   complete sentence, and all the commands are in the same font, as
>   Phillip asked. Ben was happy with the old wording, and I hope this
>   suits both of you.

It was a tiny nit (for me at least) to begin with, but the new version is
also OK by me.
