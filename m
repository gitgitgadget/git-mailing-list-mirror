Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B82386568
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791662067; cv=pass; b=thoyk7ByEJ9Pqgg+7fzoOtQEKnzhOa4Zy2myurq/cvvAFnrp3Fhxw2ep0msZ/BO89qIlj2xEEnvA6LRba2xrZrvWPCxSwtOJcYDnqoznTeeOHAVGakKsgpR436cZZr/TlSafk2qa792fy9xuN/pvP0GwcwyzxtR2Fvvi3OQ5Vds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791662067; c=relaxed/simple;
	bh=wGr2vDfoAwBPeI9U0VMr7ruvofqS937cJ1wvnJWRAy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scYPjls/r/7bUNaupMOpPATioRGHP03WSH+SHfisOy6+PuuoPOm3tI+/Llc7fHmz8raJYF/AiX3p6g3fCCZ2J+xXGqqFoHPSXxW664FoA3B9p3+zSjdArUcnL7ZVYbLT7m510i15n6z4E0ASuPwF1j7cVQs103UA6LDzMPEJDwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRvwZmkh; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRvwZmkh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-88b7d853b11so331668b3a.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 12:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791662065; cv=none;
        d=google.com; s=arc-20260327;
        b=nppCRC+jalEl5y7KnZkrnbZ9vAM2AWHxfDz4271Tydz3yI99xOJaQiMCFLN9iKlNK+
         LvT1rTMfFl5F9kzQcXNM9Cx01b/gCo/yzxirZNpAP7TJuum1ZGwIMtnlQrbTBejTyXXq
         1GiHlZF2fcIJOUNyAOeC99y8j8urbZJUVUIpP8IDSpisFSq3Xr57kYnoY0+H0TkHJopw
         cCjt6LnQBoPeO9/z7wOFo+wV7nnaj7h/9TGqlMfmMuWa179BJUrTaUwKFYUlsfLzIRXI
         L4iiviZkYLKc0M6ld8EB+AWfJRFaw4HyGaeDdhQCowLtUYkr/B023t6ZLof+q76/zCeu
         N51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ibE9Pj8klcFekAzacejAInQ8segxDCo4aGMnTc89aaE=;
        fh=fyacn1kw0wgXorI5Qbe03yjprcbLT9H4aJmv52JUVhA=;
        b=HWM2Z5uMpW2kCd41/7W4KAJ/IL7OwVFTNFdBCoszWMjlC0DSydRcK4Udro+5GOkTit
         YD4QX+Mj03Z2OQ8erkn+MLogzfSVjg/WSp5BAo2bAvwaSzlqNZtf0C9n+zKmVF9LGz4I
         sST8mA8g/FF5GNDhEDqU5Oz16I/gl5V2PofGF6lfp/3x6M567X/Eieyl+Nuif8ORmbrZ
         uQYOFn+yp/Ju+0rFAtnSi9esv5wy7zoQ7rSJpvytFIzwZzjtDBZgnGK7euAdedjGnMlG
         RZDrbNrLiVW2x4e4mWcW+eYq9wGtVLJVT8TGHRXngTWcmx5vqzMr7NY0ETP4s8xuNMid
         6+vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791662065; x=1792266865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibE9Pj8klcFekAzacejAInQ8segxDCo4aGMnTc89aaE=;
        b=dRvwZmkh9vl5f+CL1ai1prrV2pU+zQ4uMX+ZSHI2tV+5w9nor8uTgTSSCAb9XELzM2
         7DnW7JyJ7Dvwt67SsYcykejwEU2zyuYMRDHaIhFZdiKCHYSAsKBYS6z0aNcNrdMfrK/+
         3LNnbLstmX84JjpnxEvbtohY9rTCJvn6i5ETBX6xb02jypcmugXz2m1XMEHXf9XTI/3j
         7C2MGLZ9Z3Rz4GB0rsphu14/85AY5UJZ9OSH6kX+l4HVWxHtXrdAW6VVL5x0Fqt5Ofwb
         s6GJny/OhTQXG2UUdF6ADH473oEPM6QwUKoAs2kDQxuMqlYpNLdHuc+jev7xHKuHUQoS
         0vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791662065; x=1792266865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibE9Pj8klcFekAzacejAInQ8segxDCo4aGMnTc89aaE=;
        b=MaHs1hzXXoqFA0m/USex6RoyHWGezipaUPwzaOJatl+XjYMIKvGnIzKpD6vQImX0eu
         gbvMvGfi6A4NcGaV7Ai/pwj0bNrQ0t9FJ/aV1CX93Afu08Vc1CooekiyaTLfxrgaXsoM
         I7TeNgSvy5JJs/pO4CjaSQPWYcTWjIuhAf263PIZLD6/OA5fN1XqI4SCqlj95NfJLs0X
         mST9UEwfug1IceRxdq/gWycnHFzuboKv7BJjW/jXDsuJKumqUTOeuitR84xtr5oydH8c
         8cpTyBR4Tfc9smPMrjm3vptBpkOrcOA2jQu/R9bDpGHuVrl/QGgXrBrVqwZMwOABVWp3
         LZKg==
X-Gm-Message-State: AFq9FYK3Ai9nlYf6t/2Dqt5gGGC0v+OilrFt1NLUGqsKT31JGsTJh2ms
	pUMXk5RXMNXi4QuKCDXXSnBVt1BQllrWsDG+SjtQpVTu9qjwA4vS68Fg2fA4eErY+nQDagV+uYT
	uUydepS7t9HRkRAicq8tRLJpiE0gcP1g=
X-Gm-Gg: AYBFou1CkfK5n1tkItAjKgnNSTZaS+U3gIhzsTtXn0if9QSupAdQw4Ufrcumv6pDIfl
	fdPG97UBrs0vZgz2movanczhLC5W6YqaKojU9K94m2KwdePK7fNruDEWtUly1i81r+hgheNIyI8
	dU7zN4FcXzgm4VZvrQRZUaoOgqfaEwkOXh5BZXFgWX9bwP8uzZo2hHAShH7zOW3VGlH1Hd0FnW2
	31bTOZqsxGYJjkICuDMxN7gaQrcVej95BWjqv3FvkwbKtYlDS9dRtiX8dg3RdvK3rcNyQV5KF2J
	r2MxWtswe8a4ZhACupdyVOjvurgTN8+G6gU8vfepscIn14GftB1F+Ho6L/z/Ki2SWQS82gIv9g2
	Ro2gW/5IXscqA4ZNJDFpBNhYycUoZWYXXgDHW5F83n24txvad/uelKr6cgU4PzayoNB47h+JG5o
	U=
X-Received: by 2002:a05:6a00:1a8d:b0:88b:72d6:b4e7 with SMTP id
 d2e1a72fcca58-897c7add519mr4659733b3a.35.1791662064656; Sat, 10 Oct 2026
 12:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008062521.25505-1-r.siddharth.shrimali@gmail.com> <CALnO6CD9roPhKsYRVXRuZXQckTmbCskKmvxiUyxp6vkJ03S8rQ@mail.gmail.com>
In-Reply-To: <CALnO6CD9roPhKsYRVXRuZXQckTmbCskKmvxiUyxp6vkJ03S8rQ@mail.gmail.com>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 11 Oct 2026 01:23:48 +0530
X-Gm-Features: AclHuK8n3crsi8X_67rUIr6lhFruhLpdaSYrfFH5vcgfupdrbvkYMSmyQUcP7yA
Message-ID: <CAGWgyh9Qo9J6A+PWpwiZoZPQXDv+fgwRkPKT-bZbywWZgjO9sg@mail.gmail.com>
Subject: Re: [PATCH] repack: do not rebuild packs on --dry-run
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, coygeek@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 8 Oct 2026 at 18:26, D. Ben Knoble <ben.knoble@gmail.com> wrote:
> Just outside the patch context is the "if (dry_run)" conditional, so
> this is the right place. (In this case, formatting with a larger "-U"
> value might help.)
Thanks, Ben! I will do that in v2

> > +
> > +                       /*
> > +                        * add an exit here, so that dry run does not
> > +                        * go on to rebuild any pack or delete anything=
, even
> > +                        * if the user explicitly asked for -d
> > +                        */
>
> 2 notes:
>
> 1. "add an exit" will stop making sense as soon as the patch becomes a
> commit; that is, it only makes sense in the context of proposed
> changes. Once those changes are part of the code base, the comment and
> code are not adding anything. They simply are. So, if we need a
> comment (see 2), it might be best phrased as "exit here so that [=E2=80=
=A6]",
> keeping some of your original wording. Or we could be more terse:
> "skip non-dry-run operations" or something.
> 2. Do we need such a comment, I wonder? git-blame will point folks
> towards this commit :)
>
Oh yeah right, it will stop making sense without any context.
Yeah git blame does the thing, but I feel like adding a short comment for t=
hat

Will send a v2 soon

Thanks,
Siddharth
