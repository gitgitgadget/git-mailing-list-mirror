Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726F47ACE2
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792385231; cv=pass; b=P44UNzHFMZNzlT392Oj4Dmmmvt+fehZdhZidaqPxsW5BtEWLNMOMRwXk7tFbJJkY1ixQkC4NndQXxaWnahf6UW+wfQpiHOK2HgGF5tToT5TbBRHC9NTvnjne5LuMWI7ifx+FORqfP8fN/D4VLnK5JzTeYv7FoOTfNhnoy9CduQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792385231; c=relaxed/simple;
	bh=xs37MB2qLERyCQq8ftvFqDtr2W81YACIZy3HZGG36bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsnK/af2ywhvk5HpzG7NEIaHNvYoxGPE3rA6H1zewU+lOqqzCP0X1xZqXYX1BEzfs2T0RUvVWRQCt7IIwVYVltqME7K2zb9kRHrqYKjra2S1v6N+h3CF6KXfCCA82RH74V+1fVRiujoYgkh7fLcIGnRwn2yhC12zn9IgPzfhhyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI8943My; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI8943My"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93ece7a73b9so245808285a.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 21:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792385227; cv=none;
        d=google.com; s=arc-20260327;
        b=cw+HsenmMiLBv9Rqc/uwadtK4L/es4+sXW2ybYGaHtc+yUFeafVUf0Iax1PZB4ex4f
         BukGZdKI8If4/JImGFlt01CZ5nwubDC+cE6+LTjvO3l11TC+B7S+jc/LUmVLbS2jNWKA
         m+Bue2q1qwSyW9qu34qFCl5BNNp4eOuVFv54w5JgmFe4MiL5GWioWB09F/cV0iucj77f
         IgfQQtB93Xb5urz4VGqguIU5LbUWpXR9tZIKPqycxkA7h46RRDjzRhC6Pm4wV9WETRBx
         yd3/hGd+PzLRtyvBzhzsQKNYGhl0fVh9uqL8diAJ2GfbhVc2VS7qfc1/RJ+mHTmFfs/m
         SWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xs37MB2qLERyCQq8ftvFqDtr2W81YACIZy3HZGG36bY=;
        fh=c6C7IoZt+oAUsUvQz4w59Dx0i40c77KuK7zgJ0PLprI=;
        b=KD3p5LmnWUetGl7r9QyNI+MPePsnODQabGyxyw6xG3sgj4o9EgJjiVkfMBBMud+Wuf
         L81c8uOu+GCO2xlqAh/lov9mPtVws5Li1iN4qyaGzLL7YyeckIIUcHf0F9TTHgv7UZAq
         jVLpyxxuzY26j5gyr7KeiOemNRaULsz6ihCqpInm+UYddqzVC1IqZmxQpLSs360p3k6L
         09hMj4vdY0bKuxohHr9UIYLqNxY2MUXXdiTX2BXaKCK72O+CXe71VTqDzTU+NujP7l8G
         JAlAlCI9E3UMD7Ej0vLi0QKxbcOT9Ao3P3rZ3iFlwNRB405r89GpdO2kelSmZY5VqASK
         yxbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792385227; x=1792990027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xs37MB2qLERyCQq8ftvFqDtr2W81YACIZy3HZGG36bY=;
        b=nI8943Myz/tFiD4QNdImeulXB/nGS2ZhkCGvHPOSFYwFXM1aTC+7MQi3fjHOllS07J
         MQ0arXC+LxjZUkUlRuEIy1rE1RfrMrOfGS6Ke6WGKZlqd1qgSwbhFx8784cqC7fp9rIR
         o1O70sjaifBimG1Zc7Nk258BOeWmrC71mC9KakPc3tS1Wb6toC87sCXiHgxGHj/en/+n
         e9eFNb+ilTRklZRWNVXSvEIsnmpDF0n3v1B0wefDa05ZcN+WIu0ZKBQ3kWGg2RH2Ojj+
         O6hemV6zJAN0u8i/CzvfOMj3dCbVbpcZlH6eL8AaBF+LMZ3fo+DP7I04/CEql5M8e3tT
         cvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792385227; x=1792990027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xs37MB2qLERyCQq8ftvFqDtr2W81YACIZy3HZGG36bY=;
        b=HYc1t/nPkgko79I38JV96WX7WU0IuTSEdZAikdr9sNQ4/cVStgkRp/JuTVWnj13J21
         T7pDmQLUYW6fYo+6N1Zngruc6joOSAE/Qq1g9Q3MAM9ZOFL80ZYqbzLca70e10DXB1gA
         IrgH+dnuBeHvc6cedFqwhsGwFwL5qIb0bvKMJIA0nIST2yk9BJwOir2zcNnVGTx/Ay5t
         W/ogRjwg2xTr6bTjElG2nINAwghgxywRsV1AlbTun8F4ay087dxAmcGkBLHV8RlBLHAj
         nx/n2hCc1mnw7p1NyiqbLIdIvwRswb22jHt9N+HwHrQfpwO2a0Ow7c2tbxkx3va2L1Pv
         2YOA==
X-Forwarded-Encrypted: i=1; AKwUvBxB3/kCHMbZSeQVCzSQ/fZrzBSnckHgEWo4dD8jkX74qR8fu9u/aRyAbftuKkDh/0rk5Ng=@vger.kernel.org
X-Gm-Message-State: AFq9FYITYKQFI4B7ghSO5cwcxCyBKERaAnMJum2dXHFl3AhxCzdoBciy
	9Zmkon6unjW/n7PFU8Mc7dSfr+JhB4eVM+RinMB2awKUHE6sTnbTawTdOgBUjHefPSbJlIfb4Vg
	QyRGt/kdBS6WmmlgndsAz1SKGT4D/Fqw=
X-Gm-Gg: AYBFou0En4Ku8kxbhajmm8fyBU4X5FoWsu/hHB10s5wnT6HOO9Pe1hrVda9rPCn6Dqd
	hvPbAvk4HTgiCLRofcVpBQT6KxT45Wxx5tIIJMMl2q3G2lsUOiUgtndGq/iajtkuT4m1V6+fHQa
	I4BiAZQGq8O2JKoffaqGV3WM6p7YrOuWGmw14HbgV8KR4YiPRF58yPqHab/bKzr1MYOLVZzSMdQ
	OnSKlGr9HBLUsHWZWgS52v28hPZqh5GJ4UyldjFo+OyNWbFTTcJeCBVuUqB7PacpOlHaRDw9iVZ
	ZBz9a1pxQQF0XnjXpLMDu1fSwZQs5bNcecZvdsy9+jQrjh+xanC2giFmLskBCarS6k59Of7rKZ9
	WcTxXqYxhGxsL
X-Received: by 2002:a05:620a:258e:b0:93e:c6ff:b787 with SMTP id
 af79cd13be357-93f29d0ea06mr1113506885a.13.1792385226949; Sun, 18 Oct 2026
 21:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABh_KWhR+g7Fi=JOEvyBS_BCfmuA7_HKtcFeOR7fCpiQv+nmPQ@mail.gmail.com>
 <CAPSxiM8ktKrJBK2otqHM4XMX+RhAvJadNcQFQySCu=C+e6fKZQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8ktKrJBK2otqHM4XMX+RhAvJadNcQFQySCu=C+e6fKZQ@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Mon, 19 Oct 2026 10:16:56 +0530
X-Gm-Features: AclHuK8CWUowBndXioj-m_Wca_OyXEb_qDuDV7hQO3CX_YqCkM6kKhl47TLQ6ng
Message-ID: <CABh_KWjeU4j563JUz5Vhk-M8izuMhoXirwQpHH3KFVUBVLfxkQ@mail.gmail.com>
Subject: Re: Update on microprojects t2030 and t0001
To: Usman Akinyemi <usmanakinyemi202@gmail.com>, git@vger.kernel.org, 
	Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: haraldnordgren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Usman,

Thanks for the update! I have submitted both patch series (t0001 and
t2030 v3) to the mailing list via GitGitGadget.

Best regards,
Srujith


On Mon, Oct 19, 2026 at 2:54=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 12:30=E2=80=AFPM Srujith Poojary
> <poojarysrujith@gmail.com> wrote:
> >
> > Hi Usman and Harald,
> Hello Srujith,
> >
> > Just wanted to give a quick update on my microprojects:
> >
> > 1. t2030: Replaced the path checks with test_path_is_file and test_path=
_is_missing, cleaned up the commit message, and force-pushed v3.
> > 2. t0001-init.sh: Fixed the pipe by writing to build-options first. Ver=
ified that all 104 tests pass locally and fixed the author name for the DCO=
 check.
> Thanks for the update.
> >
> > Both branches are updated on my GitHub now. Thanks for the help!
> Good, do send it to the mailing list.
>
> Usman Akinyemi
> Thanks.
