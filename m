Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D64BB5D2
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446794; cv=pass; b=W+UZvrm1X/JYDdhHQ71EO/1r0GyuUyyxXHJhH3mG7QKjxEGQmZIl7fM77FtKXya123qtzIVhGnMx62Pe7mszZAbeERfCihCpYr0JrjGYKVgUeNx6g4+qF5r6UN7IkWKPyuoCGOZXnPjYRacKMA6cFqqKz/4No2G68bCr0whwd6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446794; c=relaxed/simple;
	bh=AvArDL/fm/1I38e40j4eEIOKjaIlBpw5FSM5kF2Vgf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0SkUYvqlE2EdRt9lqIzViKUjQsWeAk/c1Rpg736/48r9tPOytk0VYjBV3vyK7aUCVHSbZW2x7NPLwcu02LiNlnje2NiYoTcWZyeIQ2GaCpqrhNEuCivMgDHjMnfzeeylrTVNHs2ImVuDEU7gwpeqpF4gS94MmsXIWDxZ3IXuzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHIt1z5z; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHIt1z5z"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2569aa5116so180610066b.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 07:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788446790; cv=none;
        d=google.com; s=arc-20260327;
        b=bF7MNqsBQKNMfuzWjOhddhp3u/6KIm5pNzGUXFK/kyBsm6MaiEOSYt+TLo+Agtzd6p
         pSubP+JGVCI0uyf+nKtAvxjP2ujB8WGrTYnd9FTfcvNVtwYUeO7GOwlqYigJJGwcCtlF
         8kdkmQAU19XN0fVosA4pNA5QWQK3Aazip7p7hBt1r3lOpQL+IdmxeGtOQzTLc9VScyBK
         XbMpYzes4pkEbJwVcb48ZhrSuFG7ERwJUUqFktEL5hVq3u4uWRgMVWkEMYgpoSGLPsgn
         H0ZI6igpVoNJfNQQXSMp8Kd9HAJHC86VlJ1TPXSwsIFFTrGltggehIeXLTPWtitYIjZ9
         qlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P2ZdjE56cz5x1ltbIAyVJdY8EZtxTdU/AYMCcp1c1KU=;
        fh=TtoUQLhUD8soeSUcAnBmMc98gIphRxg39eyGPyFpqoM=;
        b=UOCJc1R43YuZijRbIPqICTl/7P+mTM8ORMVn5FbD4B1qcChqRPHabSN3N3RsID1pdT
         EDzcnE3CQdJhzIjt0X77sbpLVA7/qWaVV5ruj3dGQP+9wxwflte889Y3lPE+bMmn7tHz
         DHiYcczaKiyyhSKrR7/14G6iN8ZViynhdThCNi8CF9iLmSwUBnH7Qs2QcRie6WFzlNBs
         LubfIDK6ff0ZLhnujUoxl7lEtpuDW/YE4Ymz3YeCMriYXlDeKcpOOGm6rqyMDjdcuAOE
         uwyEka0lBM5rma/TOuLzCY388sz8aCSk+ZcCjUO1EF6y3AAIuhke7VwMUK1p/MNeD3fR
         eKnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788446790; x=1789051590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2ZdjE56cz5x1ltbIAyVJdY8EZtxTdU/AYMCcp1c1KU=;
        b=dHIt1z5zqs7MxAB4UEsoggXVzNucKXRUlGgTm321bU57uG/pX/FsAQim08mt+IEASW
         6JH7K/OD292TizuWI+jMCcquTojmcJJ7Hs1jsSL6OqEfXvRnPy02Rf4eLfa1F+psRvoz
         AHYuNEBtdk025g+IedmfvKUnMZou0qcCr3WO4zKTgEBelnWX6Nm1djmeWWxHPig0zeYG
         gp0MHHeLa8eLyqEFhnVb4ZzfOsNy3Mr+oBCaLVnjcXKy/q1K4k8ACJFfAInQcd3az08+
         ZHmVnvIakAQb+4/RIDQNkeGTyqBTLVA3sFAYV1CrXA6dC/obxN7fPjsIRC5iGBp6tLk4
         sbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446790; x=1789051590;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P2ZdjE56cz5x1ltbIAyVJdY8EZtxTdU/AYMCcp1c1KU=;
        b=QFUM0Z43UBozuFgdB1vhzfd7MutoRJUVRlxfBg1IHB9+xQhE3PBd0q1Pp88P8hSBTU
         i2kYObZgfF+aY93loNZORn0A3yv1oLdVOhj7ucBSmlPthVzPbYg2dKcURQUyyJ6iBqqT
         l5kwx/HLDvMY6FIq4SPXSwAYe1p5c4R6XAgirxpq48FlmDtIP2asxGxlHt5pP5+/Z3kq
         GbczV4qclVslNeC5Kw+l9ib88DekpPtj/RBCatAAyDrBphD7KOBL3ln58S7NmBPlbLNW
         ykFsf/+8Z7JCV2nNGN7oGM9ezpyFIG0UV4kjIb6/Z4hVSrtITHge04fFfwleOx2sw6EZ
         PK8w==
X-Forwarded-Encrypted: i=1; AKwUvBxZkXYISobhPm1TX+LH4GL+xszseodPoTYzJQttr1wRYI3uvQNLejiR6sq1GDml1g0Rak4=@vger.kernel.org
X-Gm-Message-State: AFuF++kFIAMcj4QGoQu9liSkRo7lDgyVMCEo4t9e0twbSrPh475VL2wc
	eti/AV6v7q551EGx591G2IhGV3KuR+RaYUnmS5JjG5PbQxEYHHns/iQEiqx0tz23PiCN+IO0gAV
	6vwirIev0FnnwJFtZPKHBtKj7i7pr1MLgr0kI2YY=
X-Gm-Gg: AYBFou2xTBUexHX3Kn6YmA7DUiSPU4AMiXDXvMT2XUtUIOQxJgwc147kfQVBy37+KSU
	GMtoawrkXSSQ2ObrgUQ1tTa7nIeqezMNQ2SeYz/EIhHvxTUaK84IBETPwR2q5BCfC2uSO9oahUO
	vtFEaf6G0CXeMWEOwyVgQ8vWVCMtJNozm1jUb3GfEI+V4eDD9ykK/XrHL91Ae0/roO4shtYCCcm
	vM/lyPBfOOpKfUwX2vsGFGu1UbXpuWBzX9jdoF3d70oMYvNKrwty7ciu8FCMhX0elThpuju7qNo
	0a+YpgVs//EhnVVjguRnW88877oW+w==
X-Received: by 2002:a17:907:9288:b0:c25:3e36:acc8 with SMTP id
 a640c23a62f3a-c25efbe1685mr325653766b.4.1788446790399; Thu, 03 Sep 2026
 07:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com> <ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
 <xmqqwlt3h1oc.fsf@gitster.g> <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
In-Reply-To: <002b1324-0f7f-45ec-9f67-624a41801ff7@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 3 Sep 2026 16:45:53 +0200
X-Gm-Features: AcwNN1UYz10vFwH0WaCvbkDU8jyWpCbpzSpSrQnb4_YYGIqzGdMMYSRbTN09AG4
Message-ID: <CAHwyqnVp6BVGx3+UCqBC_gOCuyq1c62uNi1f7Wyfpxd1KdyM9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >> +    if (fn) {
> >> +            ret = fn(argc, argv, prefix, repo);
> >> +
> >> +            /*
> >> +             * The subcommand implementations return 0 on success, a
> >> +             * negative value on failure, and STASH_APPLY_CONFLICT
> >> +             * when applying a stash entry resulted in conflicts.
> >> +             * Map failures to 128, the status die() uses, so that
> >> +             * exit status 1 unambiguously indicates conflicts.
> >> +             */
> >> +            if (ret < 0)
> >> +                    return 128;
> >> +            return ret;
> >> +    } else if (!argc)
> >>              return !!push_stash_unassumed(0, NULL, prefix, repo);
> >
> > Style.  Once one of "if", "else if" and "else" cascade gains
> > {braches}, others should do so as well.

I would love to have a linter rule for this, since I keep forgetting
and it's a waste of time for others to remind me.

Maybe we should copy this over from Linux?
https://github.com/torvalds/linux/blob/v7.2/scripts/checkpatch.pl#L6270


Harald
