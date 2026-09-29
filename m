Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FF3515EB
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695782; cv=pass; b=B2ZPSgEWpQ/N2aKOmSCtAw6lyy2w375mt+gmvDoCRdQzBuSMNMhlaS/hGRNc3v305vTKIMPKmaWivbeXKZV1kqUdKeNqUvNep04gAZk1lEvFo0ipXgtPtStoYZfZgMLWlNEFyv2EEr1VyTMsWvTNFViCaaEl+DRbZTZPqTPCZ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695782; c=relaxed/simple;
	bh=525d3MMsTPl4WnZnVSLc74Fa4GQQttBKRe4CfMR7dNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6Vl7DSKAS/+dEy3rXU0GMboDK0uJPgKtgnMc8+3NYAJv5Jc7Yw7G2ZzWieJp1EINvzAxxLoUWE6F+B6ag8Ad7iHqwXphwm5y4ZyOqElCo/dMGk2QWb+smxp29lU2TSWXNOG0Y2MysHBsP6itXLhb/WDUNJFBs1C/hIaSB+hqiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8hFqzB+; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8hFqzB+"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so1897482a12.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 08:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790695781; cv=none;
        d=google.com; s=arc-20260327;
        b=qWr7LodiarMlcjJKmK/usywtx0njTsFoCsWpUOgIk8IuEROZHB+WaVEcrgkqRgjIXs
         cfegVMtGJR3uEVTv0Pn67V48VF2Snkc5MJ4vhQH/OjW9up1MRBlpUIcP7PVzqXzzz+A6
         NcG/85rE+GBzoM6eSo0Knw4u2ghiSsjjeS46O+o9DMrt50paTEgT5/ev1QykMZFA7HsS
         aoOKwnjx5ToxEq5NoYRbo1X4HRx+Yw6EAEVd/nsqnY/mQP5ZUOYToPQds846+XUBCrch
         CS9QFLEynAD9OoYkR2oxsNS+57QPCEh2iObmA/oSZ0V8SVroGAJrBtPG2hoU+IYoRjAD
         mDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XFu49txLZ/QuNiX8bgnit2paU4goTD5H9k/PW/ze5rw=;
        fh=RSj3hG9dGVMqrRdGTcNXHMDg/DJuaXpFWRZOmnoml/s=;
        b=hD24v4QQinJ/DTBLhyiQQ4PkahZeU/c1EMZVg6QVGncRv7tEQilNgNP/ish4hjHnME
         3TdyhXVE46lBxT7sbaorErFT1nEgTNiG1dnM6bfQE+Ucpd1rrwwCR17WVoVVBL1rqd6G
         7uClmozQiF+uLHANPdv2maHuoEL0eVyRe6oSsCTfpyJ/dIIA4f5NcA30PR7g0ufEXIbU
         kvNNgXsE2yFGmP5YdURZLLnBoA+uX+6gsgWK+wK4cULbic7g9c8M+yyVx8sESXjlHmZb
         QVIWOMdjtM6gxYo/0r4WC58ttP8zEHv2Tr4BtwERa1nAiQRi+j56ctTKkGhiMfXXS2hX
         DH/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790695781; x=1791300581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFu49txLZ/QuNiX8bgnit2paU4goTD5H9k/PW/ze5rw=;
        b=f8hFqzB+SrUMiEUE0cvNnapRwOKm8cXJbBXe9csSlDky43TLOznoSW90nETC9a17OL
         g9SN1VHcqwTmlH+rIEqbKtTn59UGwqlWGj7+wyr/kSwOB4VOlwMslSy6B6XdHijC1vYD
         KabB4nbUTAhyF6c3C0tSiY80noBS4sgmS1sD1BB9tCvfdQkrzUsub3lxC/Q7kgq5ROgl
         ruMpgXlBqiBIYQUXMxMTQsXHP/5+Oxy+r6QXnRFJCnm6xEnoE9sJHs2IJwtyB4bNs0oT
         GhdYOTGsMc/FQzyIzaCixnOMa+I6rQSmzYPhLwaMtG4Qy2laz4DXvkwm8QWShT1WNC2z
         44AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695781; x=1791300581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFu49txLZ/QuNiX8bgnit2paU4goTD5H9k/PW/ze5rw=;
        b=rmf1q268KA/c7pX01mtENhXCesU62xnIvyVEciIr+k18oEFUhyiEAUB6M6qUTl+0yM
         CYszV61HfEWS5NcZdeA6ZSYJFLbw4oaCXj3taxrArCEQfFHAeIPcKODIhA9o5o5cg/9h
         GrmD6W3EWnO6fLAhvT0XdZ/IhQecaXQ+bqY9LQ4OG+DYpLNtprchMlC6b87pdXXd+/y8
         d+vFWzcOl8dUXLz303q2iC/NERBBVdYF4nKUpl6qXsnOxKB6xfvHZ02lRRKONBiqySPL
         LxC0EU+mh5SBvGpre322NyefnpmXuN+aU/IzQ6jmTYE8pEoJaXtE3/YOqBBochsbakNc
         yqQA==
X-Gm-Message-State: AFuF++kdKzZ/NMiC+gto9zQTmnzARu5nsn4xM0zCVBkrXtBj4R8OXXms
	bqnyjwZiAtfN1ZfHWghnMfK0U9hOo/cYmJl9nrS8ekM0jwFyveaN0FhN3hikLzOVe7ycRrvv7CH
	lx08xdm4cCb2mJlsuqasyEGR4YLXpe0I=
X-Gm-Gg: AYBFou3VNdI08evkswA8/Qngd6r42+Jw4k8Qm7PxBNMAEj1woG++l4G4dsC51hMPo4K
	aZLg41caFofcAJuOWjBTqjOzZw3efeUQ1cuess6xo2zajUJTZxhm26DArTQvjoHwBFokxXsNdOB
	jVJA57WfKy0/cUyTlvlfabT/kG/Xh4AdUbDmfgxxKAPHE4kMD9F5HBTSnoGgK5qFKZhysBSdy/L
	svxaNimP+aoTo1ndrdomWAKtL68NilTSvPpn0rQM9QTj2LPM1Rm+eCw1zt0VRkTwNLr8Z/+X8ES
	8d08IWO/FWMxuLCO30Okut4kUyDRPV+uOUJx9S/RbHoNx+tJ6XUhIGF5yH+Vn5FJH/Xr8U9YMYH
	FbWdAJVp5cIIWc0wxPucY8qvUu4TdOb9ilwNXWYhVvjoBi9T+NNmAjQU4qFGX1JVHQBLHqAiMaw
	==
X-Received: by 2002:a05:6a21:6089:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3de0e6f07edmr15237582637.3.1790695780847; Tue, 29 Sep 2026
 08:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
 <89E3CD2E-8366-4C5A-B3A4-8F44AC5F89DF@gmail.com> <xmqqzex0hzhf.fsf@gitster.g>
In-Reply-To: <xmqqzex0hzhf.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 11:29:29 -0400
X-Gm-Features: AclHuK9khUZW6cJ4YtKDSEUT1nnaCTWCXNU4tRWvOMgYmIAKGC_tPiyBiMmzMNk
Message-ID: <CALnO6CD9SPARnfFY3VUELN4FqmVrus2qPLg_6nPNLtFY95Nkaw@mail.gmail.com>
Subject: Re: [PATCH] t5520: don't expire reflogs where it matters
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Thomas Bachem <mail@thomasbachem.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 11:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Ben Knoble <ben.knoble@gmail.com> writes:
>
> >>    t5520: don't expire reflogs where it matters
> >>
> >>    The t5520 failure Junio saw in 'seen' with Ben Knoble's stash serie=
s,
> >>    bisected by Ben to tb/rerere-lock-grace and taken apart in the thre=
ad:
> >>    https://lore.kernel.org/git/a59c4225-f093-4001-b77a-2083dfecce6e@gm=
ail.com/
> >
> > Junio, if it=E2=80=99s simpler for you this way: I=E2=80=99ll just pick=
 this patch
> > into my series rather than wait for it to appear in seen and
> > recreate my topic on master + it.
>
> Either would work for me, but I created a synthetic base that
> includes this patch and queued your last iteration on top of it,
> before merging the result to 'seen' .
>
> When you reroll, I'd reuse this synthetic base 4d7270214a (Merge
> branch 'tb/t5520-reflog-expire' into dk/stash-apply-index-incore,
> 2026-09-28)
>
> Thanks.

Noted, will account for this in any further iterations.

--=20
D. Ben Knoble
