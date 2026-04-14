Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896A9286D70
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130114; cv=pass; b=j9w6b1ZFQA2+MyNm7fETKI8vYNGj1SnDpnH3td09qx7i6M7ud2ucs4gq3eQ40oLv4F+SrTTW3wMnBrhneMZJUV4ingK600liESumbrEQJGT0UrlP/QrFCEv2UwnmKxSAqXQpY4Nm7UQ6S7r+b94W7NBVUM/3aIw5Qk4+tx/0D34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130114; c=relaxed/simple;
	bh=3pBl+gwBtf/ZtqBcLEQ+wbN3aCsWzoqCvL7giGns6nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haA9A+byF7HGWIp0s8PxUg3GeETveyWkNbKOEuDxczmFEi+82+29+PSPKG7GKD77BSdzoFxL6gDpSMlrTpHvS6yZ5FDzM47KmSlFbeiy+eE/xw4zFoMSFQLDdrE1KiiXsRKGO6rz9hodD7Adzx9ucsPdHZ0cHd7KDCXXbGawKE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpgUHcTp; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpgUHcTp"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506aa68065eso39557621cf.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2026 18:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776130112; cv=none;
        d=google.com; s=arc-20240605;
        b=M4KdEgJ6naRGmZS8hbnnWOEMcU9eayUxZvH7i+qhOZGZcKc1YQIjTt9SN52LdtrMWK
         TCYRPHfVXQTOV8ulOY01OITM7sShYkxt7rtk7kct70VyP8UEfJzsCPLuj0UOSEhABp/5
         QGEFHUC6sHN1chlBhUmhMg/c2oxyGca/ClQ2x0XW+oNnoodvvWbM1MkIAkbHP3i3CCTs
         Y8kEnFJFXMMcIF9+S/T0zJeqU2t79RVBCMtow6/n1EeIe5yC7d/gZ88Mc2ONLLjQFDYN
         Ue1YYyMacpgBS6YoVrrJFbnOOv0ji4xeuz82sqHeTwN9pW7CiCGUXyxbaJ7/b9zYSyqa
         tJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iCqGGmDkIIZxBcY+dwNAZy7tRMfQtl2ULZDZE1+AvE4=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=HtG+k0R9PSaJsQ5JWuHNeRHdEP5PSV8gQR2klQ50o7h4T8aSFFAvvbED4E6HZ2fuAM
         TxukRn1xKHq/aV4Zjq4pwShH82s8sQ/YqERNG0UG7Xo6H7+noSKnaLvPYEWn4bm87oP7
         UqQnwltG981Zt4Bh/0aSi0bsxV0pvu3PjhW8g2pXMlx4zy5NGTnq+bJGOX6TaqwYJa0e
         hEW8u7BGFbZ+jillvO1J9lKGHnh0nlCZKxoW7uzIkz5jslV10rz4tapJrao1LKV5kMqr
         feIpMEMBL6xaoe/UDDVrb3vBGknAA30y+dtUbZYMGbh/DzvM2D9oGWkPSJPrNwQBthTG
         Pivg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776130112; x=1776734912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCqGGmDkIIZxBcY+dwNAZy7tRMfQtl2ULZDZE1+AvE4=;
        b=ZpgUHcTpJcdLmI5knsVn+3BE4kofX3cCx/sJjHX7uyDiJOX5AGUTLZ0olXhd3MUSGn
         WUirQgrLtDMA2lWqgE6j/9XC2WHgbds41A1M8JSRo7dES324EWyzNjKvvaq18nNb7xwx
         d6Uv2Isk+RPHF+2j4ntjti/yDgN1CbNle5zBsGrEZcb7MoqDBCMUYQ8w74CwWp8Ut8sM
         VyqPbIfKRF0xt0J26bRAuEAJn/yss5D4DssKEPX78XrZKILk264pgql3zCL0wuwTbfxY
         2laP415H0p89SwPi8Xju18imH0/k2cI9qWnIwgP6eaF4RxhC/uHjWYqGo9ZL+CSMAF49
         jd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776130112; x=1776734912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCqGGmDkIIZxBcY+dwNAZy7tRMfQtl2ULZDZE1+AvE4=;
        b=Qi0R8Wh7rX6gW63ySGR70lsJa+oxL1xKNtyGAn/nEcWFfrdJW+vNZ1LjgVQetYNhW5
         YEIgnyXIGdrGnb+zMVFc7Z393zpasKQVtrmg3RnjTE5lVMp3ANcyNhV/lXxt1aGkzdJg
         LE9Xm2910IOUxA5XNEgLjdbUtcKFM1gDTenY0KG/ePKK2T1PO+VAs7i3BcZiO3Z9bTqJ
         FUuHnWIrgFXi9xCiLtc/NZSKZ0xJFLlGr0WDR17pcad2L4iK9USAFabrLYT+BhJfjoTb
         WykT3NCxH7kDOX6C0jV/6hAaMzmpmVQ90KGYqtnTHLI9yEIEK+ylzKfL+aXaed8qyTy+
         jldw==
X-Gm-Message-State: AOJu0YwxrwGsTNLGvFEwaH1M4yWEMUFkqv1n6hSBU7IeGQlecYgCBmbR
	Pqavik07JlZpgYtmCv4Y+p5PPDgqAOUJIGS7isUkaMJQ0J+TdCPzoJ9bkxcBZwZk+Qm01dQc+o8
	7+1Cu0EZ9Quv7DKQCsaSsZkKlIZuaK0w=
X-Gm-Gg: AeBDieu7RxcnNCBulPFOU2lVYAuhxrjSY+3uTqVd1vw2KQ9JS9dWF/PHl9xVXx/vVJj
	hLla1RWuqZvVSz/tDzfQM4La3+o5ao92BDARDeBcVlLcT9uSy1HpKm4EAy5kcwtBXQfMLFxQUVn
	x25sOC1akTpdbyCyRMg/dRRYy7TGG3grw9JruELosF+kT9G3PcswA/7G8DXK4h5QHFjq0+2y5P4
	oI/JaZ0QYh79WoBV7hmJ2j8JugusqWbPG2S8Dy9VObtTOVcZoJv4qn3BKBjNakHnJ3rHcHGCTRc
	XVkpgZwWPvvdY07z7S5qsCCotkIPUXtP
X-Received: by 2002:a05:622a:1189:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50dd5bcf32emr221011221cf.31.1776130112434; Mon, 13 Apr 2026
 18:28:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAC4ekqE0rGTeZA3fPKYePr3=J8pHe-KORgn5W026J8AAhRRHw@mail.gmail.com>
 <xmqq1pgilufr.fsf@gitster.g>
In-Reply-To: <xmqq1pgilufr.fsf@gitster.g>
From: Shibo Xia <sbxia25@gmail.com>
Date: Tue, 14 Apr 2026 09:28:20 +0800
X-Gm-Features: AQROBzClJdBWd3SlvuHrsTJaYosUAAK3z-ytthnavtZ9vHj0pVbMbpqQk1deS8g
Message-ID: <CAAC4ekquR+eCxTWifOR-X5hgd+rSen8eAUy8cxukouUE57xaoA@mail.gmail.com>
Subject: Re: How should submodules use different sshCommand during initial update?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yes, that would help as a workaround.

If I understand correctly, the idea would be to run:

git submodule init

then adjust submodule.<name>.url entries in the superproject config before
the actual clone happens, and only then run:

git submodule update

That does seem workable.

My concern is that this still solves the problem indirectly through URL
rewriting / SSH host aliasing, rather than allowing the submodule's SSH
behavior itself to be configured more directly.

So I think this answers the practical "how can this be done today?" part,
but I am still wondering whether there is a reason Git should not support a
more direct per-submodule sshCommand-style configuration.

Thanks,
Shibo Xia

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Shibo Xia <sbxia25@gmail.com> writes:
>
> > My use case is that different submodules may need different SSH identit=
ies or
> > different SSH command settings.
>
> Would it help to do "submodule init" separately from "submodule
> update"?  Then you have a chance to tweak the submodule.*.url
> configuration items in the superproject repository before the clone
> actually happens, I would imagine?
