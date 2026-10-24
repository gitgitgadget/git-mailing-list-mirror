Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792866267;
	b=gs0E4/9bQXDxx1RVTUVOIVyLia74Iearei3wrJ12uvd3SzzPsQ9Ff6ehXMIVFm2YL8pc
	 wCok3sNfLvYPcZTgP6xm8u1v2paKQQyNjpsOjgXf4uSw2WuSnC7YureGVABp8hMi4So2P
	 XXxHJKHYG1FJz3OWkOYQdh6Pi0ICGCsLv+Rg89NkPA4AIjw9c+UQcpwzrMBf/lqtS2gK1
	 JNswLRhnixFvjLsps8CkKwqyncl60tMGNoKWIeVcrTIstQmiX8Qx48k674JXJDwJGCjWf
	 Ej6jOgO7TIEwSaS5Cs6eIYzKrFEirWE9vi+p1CrzMcr4yWP0IVSU9bo8F+6hQKWmbzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792866267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=w8adlKZ2DmHYB/dDodC1lqOFye12/l4k2rSZBEyqrvU=;
	b=icIxi31u5K7LTUPDaPvLZV9g32NXL6+DQX/Jpm8Rc8tdwjZdz+ORBdgjacsAnXHnb2hY
	 6Zdcf/YIymkNXARSNx7Lc2btZagWzXSsmny6jAF4r0pqTnhE+J7TPM7CSPShtoZhiPUNH
	 8OHdh3qk6mg/rw2grjGfSe0Ts8xpfR8VPKvbQDMdwhSPoeO801TycrtMTiwo+WwbF1wO4
	 9kstN3u5q5PqeLuAbkZ+2xxh7HQ5MFgsosy3cxrzdCVG1BQvnpw18ls4bqOw6nFjF5lTg
	 1MIrudQQf+xWtx8Bkaz6K2iSKguHjHGce3qQURiTZc2NDSIp1i0WQBoO3bsrmdy0Ugg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7MmL+8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E2E606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 18:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E2E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j7MmL+8a
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso2556801a12.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792866265; cv=none;
        d=google.com; s=arc-20260327;
        b=KIi2gHJ8zrB1xMXC+2OoR/uGqTWcabCoIN7i4wIdF+ZPzwySx9kUXRugk724eDYnlZ
         Q3yXIrm9cyigglmXalUECdFZDcG77Ym367S6lmNS9MaG8Q0a0jRy+d8LTTSqb3JYzUAK
         9ESkPta7bkgj8rbCEKtr5L54Qkp4LzBcV76EcZH95YVo2ihhwLQ+FjmWDSTgk20g51QW
         cAIf1dK8E2xie+nsBF+Ys4d+m5t+MIE4DjMtRg0AYgzg8FzPr/HTAGSkcy7hmhY3xKEz
         0jOzjszp53QbKBFKTH3m2WMZ23fjpAxfsnZS0WxMu7Zu+x+I3B94RkbDT31PGLJ/UAAF
         1Udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w8adlKZ2DmHYB/dDodC1lqOFye12/l4k2rSZBEyqrvU=;
        fh=IEwjONyf5aiviRGScAZxem6Ac0lAUD4MJc7n49tnIMs=;
        b=gCIOvITbWdRbW2goN4DFeDd7dxTbOBJ5hdBzaNIXxhMcSP1zsLf8xZet0urKs00qKd
         GDeUS4+OhF2o7/KzeCCe1TMwt54tiq46KpeVn/fqEJZEoDeEpDiYMy/bB8WaWCMKVrVg
         9UrBmBjaUSxjgjL8m+NVn/nP5QdSxcH9AjJ3AMqTg4Kvb6lmm667awN2EbH67cW6pKWU
         avYLOXKGX3kSluFqp8F5+1BA6xwVd3I0hKAr4xd54lCXbyz0qFBVbBD/7STIvZOEmbrY
         WdA2Mf6/wAXHbVXF4MMhbF13kch3i4v4M/vpvs9hvhUk0jEaOMq04WcAry5OgvdxLaV1
         Yayg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792866265; x=1793471065; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8adlKZ2DmHYB/dDodC1lqOFye12/l4k2rSZBEyqrvU=;
        b=j7MmL+8ae1fbSpldeO0YIPWqWFm6UCyKNTSyYBggvJdtjx6JCr95RRgsTB1bst9FrZ
         awIl6JR7IhkhcM7xYqFAYFxwU4+PY9bjwjwddGxgRohDA4VOC80+0L5HjsBcdz5ZETyK
         +75SJBNVTUZhT/oVV+BIm+H5KHaQkFcd9KloLbgvjTqipaa50jW3bikgfdeVwi1pf7I+
         uo4m6FSmz5lS/+qbU2K5SLbks47J1al1VaRbPsrV4u178U7ZMTO+fJWyXwKGlg1B3CRd
         fbmdP/83qZJLNNZyLjIV/yv4fn++ecClN9QML3nI0OpVP2IZsLzfgGpMf+x3Cp1keH8A
         yQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792866265; x=1793471065;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w8adlKZ2DmHYB/dDodC1lqOFye12/l4k2rSZBEyqrvU=;
        b=1mwzGifYItt4AtnEzoAn4rtYb6ORVlBahSFuKuMpK44O2KYzpmUFs4wicqHkzbLimx
         im2pgTR45r/FNFKWx/bMrlZg9vH5w6HcsJhmyecBUDIOVYdcCb/I9y5WEe0FYw6/tCNy
         waTofVEA2qyhr2XgmszqYL0HEnoMAQP0CHFS9x+Vu0dCfvHr+XnMU0jLJ6Fq05tztT6E
         T8MB3yG2R8IVw9ueB38cYiXRyHduUDr822F7QgDqB0FT5GEzCP2llmKUDmOhNyi1mXfm
         UCyYwfdglwIuIUIivX6ixqZiEdjvVy0SlrwGe7ZK2uOaABizgdi6hK4hNawkyCrt+3Y1
         NURA==
X-Forwarded-Encrypted: i=1; AKwUvBztNfNGHNAS/a2+6CMAFVZOCTPf/DY1Xa1TuafgHiEAPGSRqToYT66SO8OLwfpn5jVxO3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhfBp1GBlpJGFFIdh5Lte+x7HoDL+WL75qzPuDg3noljFtx+fv
	vxgyldJXZpbHBAMUrbZuMc4qOqc5SYFomE91u/OOZkE4VyCSrOyf10DRLPLUqsG5QUYqRAGl9sT
	RiUmhM0/2CfTqlDjg4pyGre1qNrc0tck=
X-Gm-Gg: AYBFou3aKQpjSNDZDbgwCwf5D+wT0UeQDYt1hZZR/+vJq6ndVfUjTy/wxYn7q18mCIT
	wfsEqNGmtywDRAA7/7sAM+TtchJOHjt3mKa3JZo/Ea3bAwN3O0XEmKsfNWEtc/qSu+JDa+uv7SG
	ECLNSBrTCVoBlg4Z0IC254TP0hQ2dSAlxt7tgrw7TM3gGZutQ6h9q/H9VE2FCZpAJtJ8PW9zHyd
	ASV7UnyrtlJH0NWHx63TFagYGPxa+5qaEoyt5iBv26QC6p/BKi23WbMNbk5iTzV4XXBAZd7wlfV
	4lACQ+wnqq18kMVqgWwZN+r3Mr8mRobTf5WTQGQcDreRxXc41+NpRi/hTvaT+e4EcjVnfbx4mUj
	80ChMbuBHTU1iWVBlUN3yKh5urMo1zzJ4OEJCYxU=
X-Received: by 2002:a05:6402:1568:b0:6b3:b0b2:6e7 with SMTP id
 4fb4d7f45d1cf-6b442fe888amr2087557a12.18.1792866265005; Sat, 24 Oct 2026
 11:24:25 -0700 (PDT)
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
 <CALnO6CAAoMLZP4MBzgBa96RYMMReyxKXObb2JELqkBe=LBUVLg@mail.gmail.com> <ba149000e13634ffcc5dc51e4d584a56@donquinleone.com>
In-Reply-To: <ba149000e13634ffcc5dc51e4d584a56@donquinleone.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 20:23:48 +0200
X-Gm-Features: AclHuK-jGd6rZ1DhUKYPj_WmyqFX05zwjns1neIjkZoznsFkTNK346PouL7SBok
Message-ID: <CAHwyqnU5abc_KL-R__7G=PU8hGAaRGrXwZLuCkMJE0qoEFfKUQ@mail.gmail.com>
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven
 merged into a named ref
To: DonQuinleone <don@donquinleone.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> D. Ben Knoble wrote:
> > In this case, if "topic@{upstream}" was "origin/master", though,
> > "--delete-merged=origin/*" would work, no?
>
> Yes. With push.default=current, "git switch -c topic origin/master"
> and a plain "git push origin topic", the dry run offers to delete topic
> once the pull request is merged, with no code change at all. So the gap
> is only for people who follow the hosting services' advice and run
> "git push -u", which points @{upstream} at the topic's own remote
> branch. That's the setup I'd hoped to help, and I suspect it's a common
> one, but I agree the better long-term fix there is teaching the
> triangular setup. A document like the one you mentioned would be very
> welcome.

FWIW, I still regard "squash merge" as part of a triangular workflow,
since GitHub's PRs are inherently triangular.


Harald
