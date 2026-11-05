Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837341;
	b=OCrsdywMY+M50xBzj+cP0kRNjTL/SXjyjjWfba0+wNpJ7cMyAtTRP7JcFPrbjHXg9cYY
	 yxFXuerPanHPNuRfiauAuhfRT+W1xsF0K9r2GfO0OpWW0i94Yah82TfnVx16TKYBjeuod
	 4NSJfITtgWZ8cosWvC6EZviNTUm7i6eAHuMt0bGe7k1TccFpDBgYP5XP7PcM6kuCe4zn0
	 Aqb9T9DMQ0xKJ3+qcE427NuJnXKgsjHT5FVC1K4/T6kZwoOhmsNqYhGzic2bWq20n0CNh
	 Srdvrf+7neVoflfuduif5sfU2mUubn+f032b3aeRjRuJU4B7rXY7fje8I38voDOCDYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QWXtzS3fxUlyYkBtdyZXGeS5RENbGpdnh6jTFQkbFGg=;
	b=fF5YwxzMW9RKqG90PYChLIbKT3CnLpDOdXuR0b+UXr0QDCJ51vggVCpt3/OmW2DW0eHT
	 Ma4KpN4CCue19xvKe8+7DfS0F+da1uHclFHTVyT8YxgjlkYvny0P7cFY7DP8giYKxRJXy
	 bqDcWEge+jU5kwr1jqip90ukzlnDK0FptM8guGtdPi0Jjzif9IyDtPiFFXM4hUmp39pb1
	 SNHCx0GhcrU/flt5EOYPf0SsN/Te0aaI/dn9+8IsYIVsk6GKNmknxFxenUTSu1sb3o6k1
	 N2uJESedvwcdi7Zy5oldzjsGdd8Sdgog/5h5jzxXCPmDO6ioB7p54kalew3ssev3TMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mu1qvhH8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC7606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0EC7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mu1qvhH8
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4322d310e7so203488766b.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837339; cv=none;
        d=google.com; s=arc-20260327;
        b=baw+8VLkzVFmIaB4KVBcc0fq2LgH7wyzCOwX63RxVCkVYq6cOriQTQoi+DKuJlhhuR
         eR0k1zEHD9jKgkGhI5Dl4Z4nFse+VuLcWrZ4Dy/wIMpFrwGxbMCLt0yr0L/SaG78r1ww
         gQZ9q0qD1YSAx4zxBg2WmCKpqdakOXT0yo+5AGm5ppLaoKHfeI23JYM+CdX2Dp3NjEYM
         Gg1NGYZ26h8JqfsyuSDnxiaS7c1fZXajVUiXq6jbe50ajYdz7RSCbjDv6bWpSVHa7cYB
         qiuYLwQl66We6/EjQS2bm/J9luKBsC70O8Jux8qmnIprvkDxINsW9QolHZ87Y7ARmQCN
         pTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWXtzS3fxUlyYkBtdyZXGeS5RENbGpdnh6jTFQkbFGg=;
        fh=8zZZBqnkl3+1D2FPuLTBPDr+jmxcJij5bDv4oNRh3nc=;
        b=qTlxcCflByQ83dWP8AMOVs6CH1HtnPdqFpy3cmQqgWa/Cm1E+FuN5vp0a5mOpp+b3Y
         HLsIT0QNLjbGNeKlh2OfaS/Eq/OyAW4CybCUnziE7PqPAbRjthXwckokFa5wrspPawCv
         Vdq39vxhx7KRVvEuUlDNbadv0RA1X42py0fIG5/F1hmZYG200bqdIKqWtzj7shsC9hFw
         pa3nMASviSrxTStAcLtxC1d8e0VPiTxC6zxvdx+jC3oHVRlHGLdWEI9zpmbII8Q2wpsY
         SAF4mQUHOJXKDUkOBJL3H4EtNCxwGVr7iVQkUwVW9W8VpUvYdnkilo58uhL+EvjoFD+N
         be2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837339; x=1794442139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWXtzS3fxUlyYkBtdyZXGeS5RENbGpdnh6jTFQkbFGg=;
        b=Mu1qvhH8L9qGHaXiKOI9xSlBjOQhdALlturiT4yAHrcIh56LsGGUd9Z7fYupED2PkL
         h5vw5efDduwefbSmhqH59KJvdv6jGL35kkwfHXyEXMVuFnXqNaEGfTxDbwfY+d4FwQKT
         snfa4KD6gT+ztcCbCqX++guPgq+GjsNvBvuG5tjeWorWHWoKv7MOkyTb59s9FBa0GavS
         bjXSKDNsX1ITMAt7ab3WZwsaFMu7sXnA4wQudAMiVDM5yn/BMJhayatSMLqQjjBw459V
         JhnELdscTz91Ws9lM15eyay5IzaGv+1isGGORWryvXKP8/oiIsCgfld/3LXacZLd64c8
         EX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837339; x=1794442139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWXtzS3fxUlyYkBtdyZXGeS5RENbGpdnh6jTFQkbFGg=;
        b=FKwXkr3sDtEgyzO1tVkv1rSN5Wd9j/h/OoQz6hzclUGfGCdyLfwlBX2Lv8LvXp7fS3
         vzL7ufDRKO1yNq7/hViOFf3bUJP7ZylbJh93cIUfB/1PV6qIUdF3gupRdESyyrsfVhlE
         rwFyTpPtH+ABVpelxJO7BHiM2vujDT81dYUq+FNlEwY9TcbebM9sxJ9CICFLGPAFGXKr
         xdWZ4SoSOtu69Z712vuAsGiEw7lPZ22XDM6fh+JhPe7B4xSS5c4Mq6N29COPQYm29+fU
         4FX/DU0cz4RQBFASE0LNwuDi5TiVoozqLSebu75KfNvHlT3Lk2CgWsg7+xpERnGbIMYB
         oIrA==
X-Gm-Message-State: APuU4Z/eTnzjLKiMeoZWYeJZkSg5LxgxNNF2U0Cg08PunbDS3jKIZ6ZZ
	HFnll9Z0fMUMfMOq/sR69fZMU1sckZx/uKtVCUrTbL2yhHP1T7mmYkTGkBWKeDC/6f3O2JL0OKc
	IgMjaH06F7TfejZFVEV7oP6gM/xfc2c5hqoDg
X-Gm-Gg: AYBFou3HCKCQWp9vOoewCw20j01gZWiiqmCTbMkNiwVCm/JRyL0aRLS3Hzy6aPUn5lX
	7rMosqVfVPr821Nqy1S6rdLXwuOt8HfCIX7M/cw0LA3TytHGr6cniBo9h+hJ249zn9O3kqYZfx1
	BfundP5nhlykUDK94FDWRweNVCXvlNk/GP+BrOM85qJuLjxxFuAQad1u+3IQDmAetFdYFpG/KyE
	pQG6eBAFH028flhNdHKv/bJOooutD59D562Yun6HtWeghzvUBAa3xHUAs/3ZlAWywfFD/ESZFuV
	s2lBqyRLHkaHJGcchheelZIu/swmOTOBHzrad0TTJwyU/9Y/t3kHha8V09KxlXz59c+P0PyTFuh
	YFbmsdlOiIiyU5H3h88HPVbQLjX+MKm84F2La8jBGsX/EJisArseEen3XROK121Vh4XlR2DI=
X-Received: by 2002:a17:906:c156:b0:c49:9383:a28 with SMTP id
 a640c23a62f3a-c4ca7ac537bmr1502800666b.35.1793837339373; Wed, 04 Nov 2026
 16:08:59 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101210623.622-1-herroyalpriestess@gmail.com> <20261104025340.7799-1-herroyalpriestess@gmail.com>
In-Reply-To: <20261104025340.7799-1-herroyalpriestess@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 5 Nov 2026 01:08:47 +0100
X-Gm-Features: AclHuK9Xrcby5jaOWRG2JqprpOYfm35KitcbIQOKtmcYl-weK4XpZ4cKb0aCjWE
Message-ID: <CAPSxiM8E3LrJeba_f1gj3mxRVUYapp-nSgj+++pcgJEUJpxeLQ@mail.gmail.com>
Subject: Re: [Outreachy] Proposal draft v2: Improve how command arguments and
 options are scanned and parsed
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:03=E2=80=AFAM Cynthia Uche <herroyalpriestess@gmai=
l.com> wrote:
>
> Hi team,
>
Hello,

Thanks for your proposal.

Do not forget to submit the application on the Outreachy page.

Thanks.

>
