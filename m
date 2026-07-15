Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F322F616B
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096513; cv=pass; b=Fv6+hH3MZJUpYsoas6fXwaC1QkZqh0WcfYqSI0wRFs07CG1C3QmIP25KkeUXJ7s1VYtxhb+sI6AxkynxcQ0QDoxjaWdQT9QU6QjQ6qeZUsWX2DrAy+XkM20uOpEvXBvLRQ0ZJyWOR8ixg7cjht0tebKg98HyfZX5GJhZ/UGAYZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096513; c=relaxed/simple;
	bh=4/kzTBwHihsynJ95AxD1yIQO1RcBHY2ecdi0nicmB7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYfGCBkUG3WV87TWFZa02wJrvzz+BTuiiJMf0/Qs+XoXRqyNSyKzRACcvC4gCqo5jsUtc/Sx8nlBBPKjV3+8j6eGK3m5zJ0eydbohJJZ9mvfGeQP0r4n6EmlJHF3CzG7ungp8rRfDgtq4oyODFTTDq7ivkmjGGOUTOrZEbOPxd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+k+kCs5; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+k+kCs5"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca913a601fbso3570924a12.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 23:21:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784096512; cv=none;
        d=google.com; s=arc-20260327;
        b=qD/WaZSsAOdDDlITT/Wm/b7kkwpH62LKnKpNAaxr5ViIA08YWd0mqOKGzvMr3jw3Iu
         P40RxTaTEewDQ5baJ7/h/M218SVJB43yBndPPKT7SeIwQMUyZlPLUwR8iChgn9f7BnmG
         967oE0AtSLn9hS0rYB6kMMPWPkehlJtr+31+nJomNF/daOAdkv51On8mDN+YF5O01zsj
         oEdKC8dQTWgCwtdzdU5/vxP6xBeLtnb1lJtbRiGWqHJkuQoMgPkYNz3L/dzQL0QejXh1
         TjXG6DWFvqMff2V20xhPeHSmcuijdFq2z7xTo59wMpyslAdKnYTv3kono7FGpf4zhw4O
         WCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4/kzTBwHihsynJ95AxD1yIQO1RcBHY2ecdi0nicmB7w=;
        fh=Tvs0ahFb//Xsx8i0PmWtUZX+CoNvl7c1xpDc4NgL7HE=;
        b=gQEmcdkRN/QOKguMxxiytTETRmHhxCnrFjGfSVsOcJXBbNk5Vszizg9okkARwu7j8d
         sXnvpB6jSLCiWgRFfindUGEOq9WyCRH9F4g2t76S5nnRSjknAB41bcDmoR5lP2m57XLk
         ZQ/bOMQUh+n7rFReLBl4auRaMnBZbUZCFy0i6XCyWAIi9oAgSuUCOzvI8IMh5M0zo14I
         GEqPypw5moOu4dtWev9QX+RpA+Z/GhQphD17zxXTssAeyTKFM/6sU6hRacuTDCFo+YBF
         V5E8Hnj+fddiQWN8/XF3cRqfZQZeIkd4ApnwzH8SIVp7MTeO0A4hTLhueCE81+asseyB
         4G1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784096512; x=1784701312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4/kzTBwHihsynJ95AxD1yIQO1RcBHY2ecdi0nicmB7w=;
        b=B+k+kCs5vHGwoAPKTD/adosDygCalh8zou4ajeasbwcMUtZJMx7xrMeEePEhKrlzdR
         DBbgID9Xs/mJaYSp3gHy2Sne0+N/U4TutB+H5w8tT5F5KJZSmscLKeO4F3reFraKkRj3
         M9vKPvRBJXdihWygXtgxv00uGze5ceU9YV/xq0lKyHU4pPutYpHMscfiEW4Z7OKgdmR9
         rtY3BIK9Vd63hDuZaFCtMunNIoNkigomDYYfBemG9w+9GFjn9CuhY52MO6OmFBXJS17s
         /El296S66213ymDngYSAqlKWFHaSUu/EKbVAQpEFngto674WcHcXvax4wSUietgVcPZT
         6EUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784096512; x=1784701312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/kzTBwHihsynJ95AxD1yIQO1RcBHY2ecdi0nicmB7w=;
        b=KzLT+zQLXtpO6wEDw4LsytWF+NF7UVekSkSKpxz9JHYBBG/hGUfAJNimTMihiJktLM
         CSo06grjRPB5z614PQG+IUfCo48Hf1U9daFt6sfzmaHZGk1sutztuKez7w4rQe70sjb8
         GF3T7W/rJ7Prpif7cfDFhxADBRyHyltB2QJzoD11toNchA/0zRgE4TQfXyvDXQXHc3Xs
         w9Ly4ZNaFQrB2XSs1LVKK9vr1ndsWcvrfTWvHXHHmem+nYxHEjxrcjZbOKx3yKzI1Lu7
         TAIRR8MijW0XBui+1wVqGZA4CZsY70Vnb2cwgZSzFwWZM+lmvXUJ2CuBQF0+7YuwhmXq
         vfNQ==
X-Gm-Message-State: AOJu0YzUnMWWz2Wx1+rGwmQ5vjYaz2CQ3kIEoMkh7NzAWpXdEp1ZdJBY
	sE1cGGfYaUPd7zLDMWn8HjBxTPTFQRHHbGEfm67NndGCDK85mu89DkunEynbf6X0pN14v9bvgEW
	LxhUdErgj2hwLvDpHRNvCK2aR0joAZtY=
X-Gm-Gg: AfdE7cm8/gpyfrIx1vX72PWxj/RktwBjz98CfTW1Li0PEtHDBru6G6Bo9eRIkO5NoG4
	KwGBdIUPtVWxYSc0z9ztZTnM3GtotoaslL4vrfVpLj2bqx85WkcpakHDCrUmzC5DcVtORfZX+VR
	vHJLoqOzm9NDqHvAPRR5Cyc00f+AMyXpQey9CYvdG2coOoQ/AcUbDlQTyGbr558uKK0MTslOBgD
	ApKrLYrcBbhxFJ/ZwjymjBUFM5WRDxl81w0h7uzRrQ21FvdeufMNR+bOzDuUuDChZB7aCf9WtBh
	CSk0axOKbuLTn6NrgjILSTYfRZvMGowtqJ210ODl3l+xKcLD1trfPTfAxQ==
X-Received: by 2002:a05:6a21:608a:b0:3b2:8675:4866 with SMTP id
 adf61e73a8af0-3c35741c148mr5469099637.31.1784096511663; Tue, 14 Jul 2026
 23:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619162105.648495-1-cat@malon.dev> <20260715035501.48271-1-cat@malon.dev>
 <20260715035501.48271-5-cat@malon.dev>
In-Reply-To: <20260715035501.48271-5-cat@malon.dev>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 15 Jul 2026 08:21:40 +0200
X-Gm-Features: AUfX_mzTmLXESsa7uBTqjAzJjygRDcl5uIxlFyTSGqLdkE9YM1mRTBdgz2uEB04
Message-ID: <CAP8UFD2=FbbnCqWkTLEGBpz=90sh=j_70h2UJR=p4uj6u3tqMQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] environment: move has_symlinks into repo_config_values
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, ps@pks.im, cirnovskyv@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:55=E2=80=AFAM Tian Yuchen <cat@malon.dev> wrote:
>
> Move the global 'has_symlinks' configuration into the
> repository-specific 'repo_config_values' struct.
>
> To ensure code readability, the getter function
> 'repo_has_symlinks()' has been introduced. Callers access
> this configuration by passing in 'repo' when possible,
> and explicitly fall back to 'the_repository' the rest
> of the time.
>
> Note:
> To support early platform-specific (MinGW) overrides
> before repository initialization, a global variable
> 'default_has_symlinks' fallback is introduced as a fallback

It seems a bit redundant to use "fallback" twice in the above sentence.

> in environment.h. The *writer* in compat/mingw.c can only
> access this variable.

Otherwise this series looks good to me.

Thanks.
