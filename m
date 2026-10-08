Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E22497399
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456226; cv=pass; b=GRlcfG09fJqeFQjqmDzxYcr5ZnflNSFT5lTyVYVbzh498kKaOTBlTIyIqm67NjcubGlQrcx85Zg0wtW9Dd4M+OmA0DM/hxOB5XJX68AHYftdvqlrY0qzTDE91mWWUdiDNWMSxAzQULOD3JsGdHJj3KAY9DtAobp8LpGp74UOUSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456226; c=relaxed/simple;
	bh=C55UahpGmgP3FSsbOZldGmTRzUdaQ/10Vh5WP5T1n3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyqKJnNuJsOE2EeV2zKLLoFTe7xBOWnVHR5bH9cc7dtXYtnHkQ1sklJ3h+k0WIhf1jRgPAZbge82fSBu6VSEYBrJmJu8yW2PwcVF/lPikdM6YjG16xKacOvWmnguVE+wsztERD7BB0iFgXGiJt9rrTO/FXwwaWXU8Lp8cihtzng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjBnJQiU; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjBnJQiU"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so7986791fa.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 03:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791456223; cv=none;
        d=google.com; s=arc-20260327;
        b=MoxPEVgNFEUzUHu7VutrATFLAsuksItfvi56pMc51Gal4LyGsJo4v+jo+Qmns02xbH
         Qwb1Mjx8RsVZvw38qKqaR+w/esLtVIn/MIGUmudiT/reU+ePOwtmz+CA98YNCNX4Sjyv
         nvPRfQrDVS5UcSM9nJR1h7iZCvDzGBLPlObBLTrztTfgjxn+d9is+UmcZAb8F18apsQO
         29lz/BRCgdPNh0R470QI7W/SJByl5HrYi/dRX96nZHA2H3X6TCKl8nHUlD0dGnttSWUW
         oLqBmcryW213Cg0YJDyK8OUUfLM5TdqW4sZWZ/ixo/GdMc85z/hdqQMInHJeO4M6qq6I
         Nr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C55UahpGmgP3FSsbOZldGmTRzUdaQ/10Vh5WP5T1n3c=;
        fh=5iQ5cD2wfd98w3FaoBVZZ/h/CpFdpbVM7J2dJKYKXoA=;
        b=gdsQ1/sXUStEbhFO2YxGEY72YsMpBc4xBlHQvVLYFdeHXAYe8EEh9lShICkQibqAn8
         uESttNu5pKiB+ey4xchyNprp/Zn8z5BtD2XR655Yo23C2VZeov/oH6ZgFSvTN5nhZ2hN
         N5l3udAj6dWw/JHToN4D3MWsr9sMCkUTYO5Sx74sw4WBkIDOiKd0B3uKE21ab/iaY7eB
         0cAP1CTSyNi71tBY3de4BZx5nJgUEWeK1QoST/+3xOr0gD9esSwvx4P035gEz/R1J3yp
         xenqqXOiaAqMuvY30WiFM7i40CDsLEwQvdb5voJInZOl07KS/T22BwzZj22Hfqs/Ep/F
         Cz3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456223; x=1792061023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C55UahpGmgP3FSsbOZldGmTRzUdaQ/10Vh5WP5T1n3c=;
        b=JjBnJQiUyf3GheQLRZPgkp19mwtRUrLpHGfo0U+o/L8U4f0pwevrOXoObjN1PYjuR0
         CIbx7k1g+yP+4zm+r7gLqyOXXatBhXwJQYdjJlw6V1cBMllu5KyEFAuI8SIECUvm9O5u
         FvZPH78QeSHVBSSTAYDskx9Saa7EBh03wkp7L+/wU9CJ5UPjSQa9RFdY2VWbzewX9ed1
         XE61yYDVZ3WjsTLMXFLaBy+hluCsRCLRrs/u7MO+L4/17TueEvxCI9yqmsLe8uk9j52f
         YHiDTOtdRL/rsv2KgP0MmNveBh6oCGiWzB3lK7SyoCD+el5yKhEPSfcosPoCGZVnr0y0
         97Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456223; x=1792061023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C55UahpGmgP3FSsbOZldGmTRzUdaQ/10Vh5WP5T1n3c=;
        b=WqEm3oaShOBRygHJejDoEp3HEgGdfMoHYowdFqGlwEMCn+qo1htXq4b+Odza8VO63V
         L5v2uKMHVzJ9zIug4HRLWbn3Axl0xLJz5r7E0O7NnWTHsFoj3VXkz9IO1tHlac2DtG2a
         FW9sS/N2j8OxQEiTOLFupmTqdXowcRa86GWt3rpKDQFkMmhG+iL+CA1fkvKAcnbwXbbo
         hu05xtb3mJ3CiNQoVK7nJFMQRssCGfTrHMTWusNTMO5OjLFwwz7tFjOc6bueeFXZgs2G
         vXdwZ8D0ifPCA/xVOctlQSVkcygvFnAcPWiD80ovK0+AwjEQMeTAdkW8IajaLsU6y/Gu
         DrVg==
X-Gm-Message-State: AFq9FYJppb7wW6q0vLBzEmpG5HZwF17pQk2G7BOMN8BWaInhcfSDjZ/B
	ITZvmPwKJ6JslX9Sf/8/HT/FWzQ+hO1oZch9TPKIbNnlyEYq+J6ARzNlwP9O2RS9mR3eKR0zDNy
	G8NarY6TOZgmUHCg0omnlQ7hWtFZpNDo=
X-Gm-Gg: AYBFou0urT+XAVTNQjMJ9udyreilDOB/8MnKI+UtDzitYvyxadZK8t04l8iUtuTI/30
	F0yTvKodKFnIdkpIs0HtjHaxCiz5UTjG2NUJ10eQxOhFDNfOwB601QVu4mG8gYpOgkQexLAqmLi
	K+sFT6/tjyDBTy+7vtPGKJxwpdfdMdTiNhVmQrbWwfmLsTgRmXTGVhQp11ge7l9QySUMyuTENGf
	TrIhaO7ZavIz0pN/941LKBxZiuLxIDIPhkPrY/3eJFLcA0iee1HIKqrIyDu8w4hedO9dVdA4kvJ
	xSGBYklyJI5tVWqZjLPGQgBSKeu86vSDPPlCEi74KVkha0ySCm33rgDI8Mg/glW2jCf/Wgkw6KZ
	ywaIMkNrpWCw52mbJU04l/Hf8FO4mNlTglqoS78EK2IXmoC9ORuFny1pskkuFBk3hkd0P81sfGZ
	HCvhW+qJ2+
X-Received: by 2002:a2e:be83:0:b0:3a9:9eb0:de86 with SMTP id
 38308e7fff4ca-3a9ae5aaa41mr3996611fa.16.1791456223166; Thu, 08 Oct 2026
 03:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920165037.88524-1-maciej.ciemborowicz@gmail.com>
 <cover.1791452597.git.maciej.ciemborowicz@gmail.com> <asdsIjNEUOpaAnX5@pks.im>
In-Reply-To: <asdsIjNEUOpaAnX5@pks.im>
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Date: Thu, 8 Oct 2026 12:43:31 +0200
X-Gm-Features: AclHuK8c4jCc0ahVh1bV1obFPFjIGyLirdXXxg85QjJVHvOHAVGPURIa2A7dTOs
Message-ID: <CACQ=SRGtpYLCcAaJz+yUR564wTm8wsMy1qn7hZ_iJfDTc_KTeQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] refs: run copy and rename through transactions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 12:10=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:

> Please engage with the reviewers. Just posting new versions without
> replying to them at all will very likely not get you anywhere. This kind
> of behaviour is nowadays a red flag and often hints at contributors who
> are basically just a meat proxy. And as a consequence, reviewers are
> very likely to disengage and stop reviewing your patch series
> altogether, which is frustrating to everyone involved.

I reproduced both failures. In v3, preparing the reflogs overwrote an
earlier packed-refs preparation error with success. V4 jumps to
cleanup on that error.
I had not run t0600 or t5510 before submitting v3. Both now pass
unchanged, and the full standard test suite passes on macOS with both
files and reftable, based on 6de20f6092. Sorry for missing this before
submission.

Thanks,
Maciej
