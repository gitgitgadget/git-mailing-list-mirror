Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207020;
	b=Aif74hnb8LSIEm8toe9S9iO33hUgftZHh7yDeVZ0sX4pnypjGN0jcuuFRAAWVIzaxvjq
	 YhMYtPWDoPTIrNoIN9/R9AiEc+BdWEejXBJac3yynHdu5/enM0ddytx3x3rK/6LduH0TN
	 J3r0SBGbhBCG9Kyn5o4jkx3360pEEXEFdnPv14jmIchLs1BByjuchFSUPWdwbVH3xoQ2a
	 HEonPORNmuvaLPpf2IOsU4yVox+bTjCNoMWkjol/mUSP/W9uwXEuCaWD5Tpc8NYLvJpuI
	 V2JdlvyVT7MioPKI1Q/qPos9heQqAkQto7YOI0O6DIQZcHu+TfOVPN3BYngWxy7WQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207020;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RYg3qjip9zduv+mbRo4Qm6OFpSXOnWKZH8f29ubtZpo=;
	b=DkH73A1bpAUChXCwwB6K32rhPa0SQUEyVKSp7GX3Fcn7Pv8UwBfSI5PC5RRcy4SX1YsA
	 SvXFke9JSfG2ixea3jFEeGMJx7HqVDZw1MkxpnxXUDypCBqD5FXZHkZRZ8+6FC7/ogApX
	 mQ7vS+OaHwY68fx9+9zrgBa59+FkGNaDNVpuJeuHgsXTJVZUtscrJv1UcqxkXvT3YCujr
	 rQ5EEbBGMLLYA2y4Q7j5RFcNv69gkKvAmOn+pJjg8DI5ZmoRqL6k+CgnBTNgneviu7Bnl
	 LkB+c+MyLcen+U1I8/Zp+O7wAx3nKsGo0UMpe4mYPTRW79VXweLPFsqQhUQKUHF/BUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDI224tX;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB06606A6CB
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 20:36:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB06606A6CB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zDI224tX
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8bddb1172a4so80560b3a.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795207018; x=1795811818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RYg3qjip9zduv+mbRo4Qm6OFpSXOnWKZH8f29ubtZpo=;
        b=zDI224tXbsADSOhxaLk7GnQVcIxYbgolwqqKeMVrg/QBqmIbi2HbUUexMvQH6VSzj6
         rB3ZIYRHT9YDNXD+jv8DqN4upkrZ0j7hbhIlzPv+P2roMXS36KJl6t/ayskZ1QTfxNz+
         FGvMpL6LTFB1zZ9oGu+vl2Moob/lm+NJ4CaBZaq0eh1atPmBk54bxCJ9agTUFUGiyXKp
         t0IJwXVvQJFmkZ8aXQNgfnYoLp4Sdc5CopcY6QSNsCDJ1lvUNOtVw6KYAOCVjjiIuPxe
         qbF4G8KJERNugV5+P+Jd4eG0utb9nlVXWu3K5gR/tiLvbA12Sghn1JzC8rl34HoPqJCC
         8pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207018; x=1795811818;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYg3qjip9zduv+mbRo4Qm6OFpSXOnWKZH8f29ubtZpo=;
        b=XppxKFro4rIfF4ZbVzElKcD/tVc4furO2drxLwWFX2XOGIdiYu3cpbd1SoDfkr3V4d
         rGHy/e5N4ThTfHwtAEP3fGx7QrUQGxY1zSY08RTgkhOUflyNFvZyU4kO/vf3sYR47NyG
         yHWX1apcHm0gJeOboZwXQPXJb6gFNOR8W/lxdsR+oAM1yBzZqvC1KSyDjF7O9P4C4zCJ
         3HQzADJtZTUCMyHkkCYYiz/9b6zvc0m2XTBNU/7WNbF85mEDukGKlFI8gpnPXSV6FBGj
         6F4KRgH1NG2ndedgSaZJwoW6TyKMnjMKVFSCOZ/Q/ZybW38rmk/xEy2q8ERfJoujmibx
         PTqA==
X-Gm-Message-State: APuU4Z8s546MOA/v2xUMyQ0MXNTPOsBo+gVBkiIhcDZ0zW/3cLuaao+C
	Wvqx6ioplvJPLWk7yV6t4+GI62QnNaaJS6Y+6gpFn8Q0NxHjFQHJ0qELVCjc4Sck
X-Gm-Gg: AZFdTZd5DlCnrqvdhYcDJVvAG7Jt9exU/yrNgcp2V4Qann22u2vgTTdMGpmcUKl2cnr
	O7iO5A37UtolwmBnIZ3h2MTVnaDoHbEmAo0RcOto/4eis8hhzZkBIAlA+i6i2op28QIDGqNJzyX
	4sf5Ar51Gpp6Fg+Bj7QYsREw/RjfGJ+qBkSS1clmbj0szDhEEDngoHxI082/rXXNnF7tSorWt09
	RO8eJKSH/iWyQIVVpp5VGCmNi3/W6W3QBaqzcXp13xQ9NDix1xvOe46NJr2mc9B/crG55c6EH1C
	prOc/VCg6fFFXQcNA7EFASOkzehy5qtHIfk5CJMog5lz5JkGlAcE5chXs0scwUhCWLZT9avE4kS
	mq3z5c46/BEKRt99Q6tJVt8L9mkPKuSrX/wlQ64u5jFg+wy9Z3yl/oCBHZII7ULd2p3pyaupY23
	cDSFYFwt5xA4Uz19Y/1Foh7pNXP6pWRUDQqDK2on5NcVk9eoGFrVlb9a85hUP8HJreVvpl4YfDt
	r312FdwOgNzjIZ2qEh2s/af2KiQ1zgfBFS6Eamciba2nqN7QEgmsjxoteiJMy5v0qECtrf7DG7T
	gpQCNNjaous92MS/5wvZvEsc8lqPe7S6GFU2HlI47tGAjbV6GwUqmo3Jcw9jAhZ/N+3T3dy9xr/
	D8Uhp+iCwdbs7ms+zHdLVv+O8MvzTRqDxaWNclH7Jb3ftlt/VSGpoDHFwbyHdm95Rx9RZ5h1hdq
	E57JW3lm9l
X-Received: by 2002:aa7:804c:0:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8c87b4f38cbmr4306915b3a.2.1795207018080;
        Fri, 20 Nov 2026 12:36:58 -0800 (PST)
Received: from canneberge (dhcp-206-87-134-18.ubcsecure.wireless.ubc.ca. [206.87.134.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87344184fsm2032029b3a.35.2026.11.20.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:36:57 -0800 (PST)
From: =?utf-8?Q?Andrei_=C8=98ova?= <andreisva2023@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/clone: fix --revision with SHA-256 commits
In-Reply-To: <xmqqv75rqubf.fsf@gitster.g>
References: <87mrr486sg.fsf@gmail.com> <xmqqv75rqubf.fsf@gitster.g>
User-Agent: mu4e 1.14.4; emacs 31.1
Date: Fri, 20 Nov 2026 13:36:35 -0700
Message-ID: <87eccfutnw.fsf@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi! Thanks for the review.

> Having said all that, if the problem is "the refspec item is created
> before we know what algorithm to use", wouldn't that suggest that
> the right conclusion from the observation should be more like "so,
> swap the sequence of initialization, keep the command line argument
> as an array of strings, do the handshake with the other side first
> and *then* finally create the refspec"?

Yea that was what I tried doing initially. Unfortunately it does not
work because the ref prefixes have to be initialized before we can fetch
the remote refs (and thus find out the remote hash algo), and we need
the refspec item to exist before that, so there is a kind of circular
dependency.

> Undoing what was done in an earlier step and recomputing may have
> been possible without losing information in this particular case,
> but that does not look like a good design, just sheer chance.

I agree. I originally did not quite understand the purpose of
refspec_ref_prefixes but I looked into it some more and I think it is OK
to not initialize the ref prefixes when using --revision (IIUC the
prefixes are used just as an optimization?). This also allows to get rid
of the extra case in the if (refs) as it should be non-NULL now
(previously it could be NULL since transport_get_remote_refs would
falsely return nothing because of the incorrectly parsed refspec item).

--=20
Andrei =C8=98ova
