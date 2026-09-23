Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561A5208B1
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188655; cv=pass; b=e6ZU9/+i1J5T9J4WyiOxgK8EUqdPy1rp2+rRjTedG36ErpQnjDbeDzRpHI7SFnzxirv5OPM59nAHzA8syLo8D6z6KZA7XIE3k3EoHaB8Liw8Jxm39KdKoPoy2cbqbA0/RmvS7QqKQ7t9J8cTs5Bl0V0Xyv6zBLJmOqQAZB4/WTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188655; c=relaxed/simple;
	bh=46Oa1+qJ7W9K/im/nHGpM2n63nGoT/VJQ4txgA0Bs9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1/ETteUcTrAjasqkcnC/jJ59mE8E9FTYzI8AlPCe9Vh07oqYHoq5DxG58ZZqHyKb2EmZllE9I4khSK3/MTICE58WvMqWGH1WIpfxX+1+OhQjeTxagdjBa4QmCzDDZbr/+1wfGMdw3VLpm1t+r8Bne4dlv0aKhsPhTDzYAxpZ8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqjfPMNB; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqjfPMNB"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302c06eceso10852501fa.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 11:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790188651; cv=none;
        d=google.com; s=arc-20260327;
        b=dv27pY36PVA4TXslWq8dvCYiamiE49FdJPzn7s9Bmu/xGrf2KLmf+qeDUYUSvbgvKz
         Md6/+c69Iv2XrO6p9TCvAzfkiRQUC6NCuC/RYATR+AgoaWdwqNMHAEfvMNI62S3SylXy
         asK4lMLuUD2vHWT5fYunIzy5YTpP1wbYCPzfi/gN02OEwFLWXpxYQVkynZf5mAGG6T0E
         2MkSyCcXjvV7qxqI68DyFrl6hjaK1FCKHtWaXdln85VsPnor0jErjT4lFt1kKeDb/lPx
         4l4xy/kvqq9Dh6CkcS/uaCqhCMilYvqKQfNeeO0utAzDHEr+Ls+r9oQtTTqL5uZUGQMt
         UV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46Oa1+qJ7W9K/im/nHGpM2n63nGoT/VJQ4txgA0Bs9Y=;
        fh=/cp4q5tOt3ufGjrK2jY8A541h20rW1mBHOu73owcvig=;
        b=qmN+Gvq+bls/q+W0X2FIIgjrDi8hYv+aDIugvZhTz7nW6l/ScuBjg9e2BZvkBGKQBo
         uJR07BDiRbdjarHOkVDnRD5bPGAnjKB8KDbAakVc5Mdpj6F874WkKrs/yzxTr9j1sed5
         hr4I9SmKsHDUsyj8WPsue3fgPa9MO8pNV5j19PIL8uIs0fHtovBTRDPLj2e/rWizhyxs
         auTWAOYVVR9acEvCByF9CidO6zDsSTpuI5rLGPnynhkJ1vzKJweza9Oyn7upEAQ8+Vqe
         GEcPMRP9ZarWb+ICoy3CrI3yUdjoSOGQp/6u3E8g7V6/b3fs0qXrZ/dpvwsiBexPunPk
         hfEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790188651; x=1790793451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46Oa1+qJ7W9K/im/nHGpM2n63nGoT/VJQ4txgA0Bs9Y=;
        b=OqjfPMNBZmkPeeTsNac46D82G6m0pgZUkOvonQ3yUDgu6hKGZgrsGC54fdy9yBFbdW
         5vGzKUWiSTFLWcH+Dyb+qIVAjsw9OVgmjKut1QjpfxIjhs+vDr5ru1e9JZ1G3eNnexwf
         tImtJNVv5Owo9jUDIf/YesXMTBOLOtNP++Vu3SEEjI82kuQt4UVlod9dfFzIKA+wrBNy
         w9NNiXmh9iWDKqvPNp1BIMl2MHQkWgOiv/zC9KgXOyuUOPH5pRoexGk+VjfgxM7AQa+X
         0/nIaT9tmjqYvKH7ORzvSiIC2MYSibVUetwzyS7/cYJ+BufyDlHu/JPLKRtr1InkyXTM
         FfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790188651; x=1790793451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46Oa1+qJ7W9K/im/nHGpM2n63nGoT/VJQ4txgA0Bs9Y=;
        b=ahidkFjYJ7fXnsWfkMU1vPaEJHORZsDIXUIQz3OHmK1Fy/67HCCJdz52IwxieezoUa
         Ipc8dAsIwGMoIWaEIJwRENiThSAJO8MyD/7uZbyebIrkx3GQOvKzfbmhrgyFoceM0mnP
         arvE+kF8kZ56hyaYsQtuVoDP+3lBWzgL5xa1datbkW5ruS8+elrpf94xFtdVQksiZxmN
         iO1EudP0IHpMmpb4PtzEosa5MlJ7TS/6PAKpTcmKc7nVHfmhxk1QSVoq+Gr0AQaVYGM5
         uzUBEuRIz8jgM8L0+MEFfE8j0RcLLxciVzGtBAzWDq1mmuB4/RY4yMEzmPIn9Ls9Jppz
         5aCQ==
X-Gm-Message-State: AFuF++nFLA17w5Tm3lIJL9jtz3pddWowU/poUnBEnwd+coJAYdHOzlLQ
	/JRMvxuTpVYHHE9NR39qoglC/V0QKXc1mb03D0UpurWsNpqWdIOblSG7kgC8V/756c+26QC02Vm
	bNLNQSBSb63fMM9LtDvV5EJqz1Vv/wGGEkHaW
X-Gm-Gg: AYBFou148jPVYFICbuowyDu2WHe/3jyG/M2vaPVKvBES4JXGwzcHZoggQcbw6V9QWkX
	DUAuBIcVhPoWYOB+vS3wTQj3zi+witf7I5hLeShH65CFoGO4GORKcaChXEilTD0ptb+7kyhSFZD
	wIhi7IbFVqijfAuFmQ6S3EuUkYVHnGyTyfnKCEFBHGEimZtZTz/iLFKiH4nvMyEgb/dgAwCSTOI
	V75K+lLtAu5WNNjrEZiCFi9dMfGLSFcUvBnbDMhzljIw7INHpgkRrRYnpcBcso+JdJZdR+ucp8f
	sAB/8xv9IWnBlunJdaD+W4gEeWUXZ5XxIbVTv68okWBbZfRwRZstdx/Ksk5ymwyd8p+GaZh0UKm
	xetPmydZ0K1PnmMW9PPwquSR0Ajto328veGxjuksn2ytGEKEkDv7/sbXulKOy1aZy2I7jC4N5Fw
	EUwA==
X-Received: by 2002:a05:651c:1990:b0:3a6:3074:122c with SMTP id
 38308e7fff4ca-3a63c0b0092mr195571fa.17.1790188650747; Wed, 23 Sep 2026
 11:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
In-Reply-To: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 14:36:53 -0400
X-Gm-Features: AclHuK-mxVivcRCpJdB9NnCs1esrJ9Jz94QJTOwpLWC2QuT354JOyNDnogwh0NE
Message-ID: <CAJ-ks9kuQSfxnb8v9pVOkdzkydTjhJchXzxk17SpMF7SJiwcyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ci: reduce pressure from large test fixtures
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Prepared with Codex, including review by a separate Codex agent.

Apologies for this inclusion, won't happen again.
