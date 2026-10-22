Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792690342;
	b=WeELN7vkOSsuW30QcXJ41whjX1zsqj0n1/3HXDBCmswfhNM4NURNWh+MIAER/KPn8F0w
	 C6HYTsMbC1cgSdgIYRTdedPmrhdrU+p62CgpE2Gj3qFf7aOJ+hDpeOd+MhjgDtH9RAN2z
	 4tGw1rwVrqohn06xS3FIqqtcKd2j1Xnk3qWxFLTKJBOt4LiD0JzyPdyUNrdqVPFe0CPLD
	 Gu+HIDaiA270WlvTu8x6gpmoaD5o/oy6Y89lLpt1wWaXXdPVzyq37M/7qr3g1/MJ8CfIB
	 fHLMs3QmzHWGMglFsBb9tN/5AoByI7ifSu6/5IGIx+dDpACEigIbenlXRGPh3cxKwJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RLqGDfzTyoS7vPtYbJ32mDHonnGDnc0eJLOfBTvGwDU=;
	b=HPHMrcxk8z5gGLHdiutk3Flvn/CoHXz67x/rlOxV9oLfYqXrvfIogqFPIGTK9hUjVIUY
	 kvZkamla+mzbmE73CGn++6+r0XkwLqfSw71WmWmZOkjiB22h5l9zhIX6e8IY8ww9DAY+l
	 35TJfQvUpeVvPZx8GMgwZex5A3E1Of7jc9wCQ1HGqbZVG7l/2RKyvLPSZO3OnpAmrD3al
	 fYRhFsyG0PZkM+GeUYnuwUQKJNyZImOVQz6eDM02PWHKw6673kkaSeeOWI0CTjYkmE8cH
	 rpGEdzFIsg586M72JlybffmKJ6KYGogsLmwG+ycq+SmMMAov/YIqerv0FTj92MKF4Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0oWhO45;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C9606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A2C9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0oWhO45
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so2974140a12.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792690341; cv=none;
        d=google.com; s=arc-20260327;
        b=KablRD1bBll/VUIn+Ws6aur9rC7la7oharhDjuuYFI+HY0dl5iGGlaIv6gXIVHcM29
         8FhC30BHFoSqQrH7/nQi1EvSoKFcMdSMb81hC33F+N6LgRuljzsmMpnq9cb/Lo9fzY7/
         UC91936Ddrt8W23HGV/KMxBPi37/w/Ca1gAmtwV8YpYHwrlMF6pHRXJFlPxdw//tngfp
         bEKp72qzhcYzePVgfY5tYdk9fUfCuOlXsGdFkVpNtzbgMXyMF/WrqeVPS592NC4H2eXM
         K0cqwOGj4oPwOMwR5cx/Ab+zTNUqn/GO8wVD1yb4wztEe4KZDyXjvzHHFMwDqjCsT47R
         qjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RLqGDfzTyoS7vPtYbJ32mDHonnGDnc0eJLOfBTvGwDU=;
        fh=uDTW2a18HGAlxr8DtrrSc799wZwrtvx8vhevY9vm2sA=;
        b=Gqt2iHOtlj5vZhXFa0SprKCKQI8uEYkAXyfpcGuKR4bvc5KXLALEjX/Lgt+hyufry2
         AvDIyhs2IaSoXgfiVg+lertV9JVSWCTSev7C+9jAc86n4D7DCs41fezyw1MjE18beRAC
         9lW98ozh07ITlJxSfXr7KSQPmqmkUm8AbMr9sJYwk04x7eqRnRuhikpLSAG2/bbL20Cn
         YzQuj/uwyMphuYtmEWSau1W3bPX3he/yb5v57wETv70evANnSBcoOqq2gHJu/qvJhN0E
         N5cGWL3tHlRd7ldatkeEbHFAYTUuUXN6wwz+1snVXG+4ScIngGQl32cTZXRIf8xnaVMP
         MRCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792690341; x=1793295141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RLqGDfzTyoS7vPtYbJ32mDHonnGDnc0eJLOfBTvGwDU=;
        b=R0oWhO45MsIlFTFkRMEg6VRc73Nk7tLVSGB1ZEaBZM1CfpyGrDOZF/dqLFNTt212gQ
         IWnxfzIV0iTCyXh43zNH3zTCI6E9mcr235YeRwVoC6XDwrnFftyVhzn7Z8mCj0R7wA2/
         YrDNnTR/XMIt6s960eJYuNDEijjc6KgK93mOa4vPIWP9Cg8r34ei+OdUWbSkCtrrrIh/
         LaXjpUEKkDKw+vYv67ybnK2N+VPACdP6tKeVBYc++UHHnP1FpMv2I85WrCzfX64oKfQp
         r04isrV0orrTvnmED/5nlZXOmcWxOtzTn9aEgZjIxwe3rbiFrkJi6mnwIGP4Q8dSQ4jf
         rZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792690341; x=1793295141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLqGDfzTyoS7vPtYbJ32mDHonnGDnc0eJLOfBTvGwDU=;
        b=D+GL7e/yFV9c/MMtZcgNNRXUl+5GseEBTYWKhO0PlIFaomO5YRJ5a0GsRMkQgTF4yQ
         zwtGoTnGsXV5qy+1fIjKnDQ1CT3ukUkI3hWSRdcA9emEeQ8GSREk2iWFjb0JqqGKzWYi
         pIEnqdOpYzRm+ZxiEaIAgTWuNA5okQWkAH7kfV/DCVpqg210htUxZczExFFOakUf434N
         mLfqcU6OykrvZD5Hw8QV9MTYlipJoW6JP3mmYYGNdYF3nSHLDO+ZZ/iHX5DPfsfgygC2
         a+6BRL/CGW+0BYt3Cl718GkYf+pLiqw8/NaJXqj/WF+S/fjRkSjvBQm5rNPwpk2d/xSW
         il2A==
X-Forwarded-Encrypted: i=1; AKwUvBz87+bfvgGRpcMPHbDo/uFIbNst+RB5eAvAOll20NJLmmUhicLe9FHoBs/PKj0CKzFL3Pg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIc2LDMumTqEWXDA0JHPB30v6ssayCyKnB6BlKgn+HtJnxMzd5
	J0CK1lsaLCovdjxd9snFB2EVi1djV23KjNKBcv5oJrGfVNcf02CEcUHVqfo+35zfiNjEQLk+9Pn
	r4I247UmZUMfbKgDXIb9r2W72mLTvFqc=
X-Gm-Gg: AYBFou2nefu+eNSUD+VTEJ0+dXcI4ONwj8w37F1pL2hCkNLHPGxXdsckt5XVFrH4cJT
	BxZsRAviHDcKgN3bcpTAmcewGbUBQ+/52nTYMsrFllxkNzqfeIo70N9jXK47zM53trEgP3OwP/q
	amDipVR029FPntZr+UReHSHCgkS71Pla6G5Ix3SH27vErxM57RTrDLhSAQ06VlddUn7Tu+hO17v
	GQMj+hegYT69q5cFIxiXYyJJT389JmtVuU0oARjlTnw91gIwfyy8SQSIpDMYV1t3j8IdlRGcSdS
	WlSD8Dk/9enj/+mBMwslbEu7yphoBIcz2xsnNy8icVJmbWwDpMwhuiWe4RvhXdqNrBncpxvBgQD
	oq/FMuModUKzJ5TJyEW6nO3kuTZC9IKMY0eN+
X-Received: by 2002:a05:6402:4593:b0:6b1:d344:c62a with SMTP id
 4fb4d7f45d1cf-6b432c544e4mr103202a12.30.1792690340734; Thu, 22 Oct 2026
 10:32:20 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v3.git.git.1792585717.gitgitgadget@gmail.com> <xmqqjynajndt.fsf@gitster.g>
 <CAHwyqnXcdgzRnFgFhTfhQFFOgDxUUKoPf2sGViBTiXMK1aNttw@mail.gmail.com>
 <xmqqa4o5itkc.fsf@gitster.g> <xmqqv76thdvs.fsf@gitster.g>
In-Reply-To: <xmqqv76thdvs.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 22 Oct 2026 19:31:44 +0200
X-Gm-Features: AclHuK9YWD71NTtg1I2st1ydNmREjr2C5Xe9V8U3VRQSINenoCLlItB_Da7Vb-o
Message-ID: <CAHwyqnUWab7AhqJtWkPQzw_dh+OwxiZxt2+1TTC-r+VPx+20Tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 6:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I would avoid a negative-sounding word like "irrelevant".  Your work
> > is almost always relevant, at least to you.
> >
> > The purpose of the new feature is to find branches that the user no
> > longer needs to keep because they have been practically merged.
> > Perhaps --delete-integrated?  I do not know.  The naming matters,
> > and I hope somebody watching from the sidelines can suggest a better
> > alternative.
> >
> > For lack of a better alternative that I can suggest, I will use
> > "--delete-foo" for the remainder of this message.
>
> Here is a short list of candidates for "foo" I came up with.
>
>     merged
>     integrated
>     subsumed
>     absorbed
>     included
>     done


> Reusing the existing --delete-merged option by extending it as
> --delete-merged[=3D<level>] is somewhat tempting.  However, we frown
> upon options with optional values because our options by default
> allow option-arguments to be given as separate arguments.  If we
> can, I would prefer to avoid doing so.

I'm leaning toward `--delete-merged[=3D<level>]`. But it's good that you
are pointing this out. It's tempting to unify it like that.

> Our documentation uses "integrated" to describe practically merging
> your work upstream, whether by merging, rebasing, or squash-merging.
> However, that word is a tad too long.  "subsumed", "absorbed", and
> "included" are shorter alternatives, but none of them is familiar
> in our parlance.

I like `integrated` a lot.

> The word "done" may be a direct match to the mindset of our users.
> Once your branch is integrated upstream and you no longer need to
> keep pushing for its inclusion, you are "done" with it.

`done` sounds like something else, like some script that finished. Not
clear to me that it will be removed.

Whereas `integrated` is non-ambiguous, and it's a beautiful word.
Getting your work integrated is the goal.




Harald
