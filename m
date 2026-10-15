Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB045D903
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094215; cv=pass; b=UjuCoXcRn/C3QX0HhrN8towTXi69VHXC6ZSqyY+3DNjs0cAYFndSv0Xbjduhch/QOj3w6Y7FDYLuh11bKz4exfO0TFkdz5X00I/61UCAqcUFaFElG27HfbdT+H69XHJg+owVRbpDtfcSk9W09G2rxaGStukcEiCdHT/OzhqnQxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094215; c=relaxed/simple;
	bh=XNNTzqx9UggZ62Rp6aptR4R0tkM+JdjAH/9+NiqWW34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpEbc0AXjWCihz5Svvl5WR4pvuvzcpQLnYwP7J8RmyipCdFglSPRUMduw/GZLKmnFLK8yoYYgMch+C2vI9qMyW+1GxuRPvkIXJ13nnCgxb8/8ZhWCSMoijXwdR85IkGbGhQoLSodb4kp3yUtJe5spzYplDzlb+gdz9kWyB1bjIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql1VU/+9; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql1VU/+9"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b09e07e149so25826267b3.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792094213; cv=none;
        d=google.com; s=arc-20260327;
        b=l8LOsvPv86YYoFoDZ2e4EwsR/sUhwQU/F+1KB7Iih0cqHUxyb19goHfvLP7Ce2SfVd
         qNKtBYAV7r9kHzBejTm9KNtkZagliEK98sIGzL4WbKwCqreL/pHFIlrTn2RYLZ8luSmE
         oMAF/7HyLGbMrfRjaUuPwn8zbyVakp1HzexwYWaRSGiPiC5r258/H241on/Ghr3mvJhQ
         JN8PkVSYs6QKDoY1Dw34PPfvxWANbypg6JG7B6Z3a7YOnsFKOLwWu7Zlp3liZrv+8xzi
         NBCxBcT859b2qN7dq3UVBV0RgMwM/wKrbtz/4eC/mmu1bL+Q781PLh2l9QvNQyzMRFKe
         hikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oqzi4UlYLIrjPVG8j64TTybKs1a84neglaT0HAjz2d4=;
        fh=IeFnzBTmwIJp8Dv/+kFoBDJb3gHqZ7ypCOUNkSvfZ40=;
        b=ExlN0TB5F4nvKbzBhtld+Xu2NMas9LCojSgGDn4dDYchFgyQg9u3/JpCBk79BZc6Li
         jily6XkWntH+izjvgyiZn9CldQiG12V/oX3rfbrnbSwLc6BzTcxImCYuSY86yat/e4RC
         ukuA1vtqOhJyvtzPt1c00/ZMGzV+J8BJ8rohTJl5ZyZ0sUKt2qBLwTfDriFlUTfMGiBA
         by0HGGwnafFgMVbEdHp8tK0A1DSu2lK6SfDYDa8U8qJM213TbO3qaQ4YEbJCnBk68EjN
         4lJTLsZG7zRhzcLLpy96RrG7oWdPBgAm01XbWkGkBcyMtotPuVH5Wxwy9u71doTOIiKS
         uUUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094213; x=1792699013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oqzi4UlYLIrjPVG8j64TTybKs1a84neglaT0HAjz2d4=;
        b=Ql1VU/+9O8ZWzbs/VfBoU+wvj/2Bd602hluGi7O9ih3iDb+a8ln5uhszvgwKqh9qQg
         8aJHJPDKRyEPgmy+gCZ+o/yixJmsyzHYlN22HP9uA9oY/JPv2ZoLPpxcugqEbKT7UJBE
         TPbo9VaLSZ3luedMxt0yG1BCO28m0fGJWDO8kMiKQ/QrO0fcQMhztJ98CXLAZLOkHl5y
         4XHLLe5AqYVgF74EqWZrTdb6dvymo0UUXAzRMS1tEaIgRN3SKdxF50J3ZFYfyr9Ojacu
         XOkkds04AGPoxa4x4TcYm6Jz58zCR6UyRGnhwnJQAiBWgDVbh6Anu0CndhFYIcrdzrYX
         qY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094213; x=1792699013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oqzi4UlYLIrjPVG8j64TTybKs1a84neglaT0HAjz2d4=;
        b=B33b9F17HLV8CoKHIqEVvbmqNl0Px6kx2fIYOBmoIeoEU5fEe2SjyoVoeg9mbzZ/r1
         8CTCrgik+m/6aBFO8ABmGMH6EdXnsMoDFubdv52k4ab82aoeWGs4snNp556ZQQbhh5s5
         7WH4lU+metaquPsyKGEf2hfnzcBc6cNilgv7JQ3GbMiuv16BF19wrF6zwzs0NhEjC0AF
         d3VQm2uXAsW5kldGoEDSG5enzkQrfrq9UPux+tzTQzUH5IexindQQX9cCqKr3FfO0LFA
         99vXcACFwN1lVtZR6BbJpVBKSNl++engkHEB3ytgM1nVMUoN09zvtCZP9tSztej8jXnd
         cQIA==
X-Gm-Message-State: AFq9FYJognbpm/h0L5Cxg41AYwr3d9rRwL0N1vCzjtqug+H/+3a4u6hz
	4dEjYJtDHEqDTdN4047z+W/X2G/oXyRk2EHqPZdN6PbLmUe15/hN+yn/YbED8xmmqC55J+gMQwt
	Hf/owOWdS4NmJDJPR4IVETvTBSmRH7tI=
X-Gm-Gg: AYBFou3Okg2GdMVMSL90P7jI9Ahqkn01SGaNMmaytFXsG/WfEa6AeHWn/YuXHshN+i2
	GjYdA0yuCYTRuU2ip7AlHOOFt4w4mLSnlAuNOXVvmj6rfKJ3Kg3c2RD0CtaPKnmYeb+GpDz92UI
	NB4BmnnViNp597G+6kaEebsXuUP9OkArcdBC1XPSyyuc1Xb7LtcbjRnbw4mQVSkshQpRKiVAzqO
	PjqIjRVn3jv+jvaikDCez4eDcGaQX4WJPnhyHlNFU93wTqwH7Ui4tKeRd4Q/AA6Iflk1h7H3m61
	YL9JgXApdJvsVIjH5pXpg0OJPSTQstm1YoH24SzNu5hiMo+z6kpaSEKkURCvr+6Ah74tnYgBLYx
	yviQgPi31hvIzuGJYOsu2IQghW827OEByuu/9pFoR410lKSYTFaHP0Hftt2vBC+ERa5mbqD9MtG
	HzpByPBMHpUJxezTM0lt+a8LP/DbZzZCanEoHS
X-Received: by 2002:a05:690c:fd1:b0:8b0:db26:88be with SMTP id
 00721157ae682-8b0db268d0amr7666377b3.19.1792094213339; Thu, 15 Oct 2026
 12:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com> <xmqqo6cun53j.fsf@gitster.g>
In-Reply-To: <xmqqo6cun53j.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 15 Oct 2026 20:56:41 +0100
X-Gm-Features: AclHuK9smxGh677bEtj5ZjdManma1DXt6t2nwkdLhqNBdZTPAuwRH_h32T7LsJA
Message-ID: <CAFpMFfAg2aMuUsyLz-YZC6T1VXgtBjv75v9hAFzKJVgrBOL2Vw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 8:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> Please do not put me on "To:" alone unless the patch has been fully
> reviewed and reviewered acked it.  Placing reviewers on Cc: line (or
> To: line) as "area experts" asking for review is fine, and if the
> patch is in the area where I happen to be an area expert, my address
> may appear there together with other reviewers, but the default
> "To:" address on this list for a brand new patch should be the list
> address itself.


Thanks for pointing that out, i'll address new patches to the list
from now on , with reviewers on the Cc
