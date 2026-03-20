Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3126344030
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001046; cv=pass; b=Oq6cd+6Y9V2bmFK5y9a1CRcu0YH0DLyLycsnJ0kuafjszF41b61c8FdJW1NGcVI4WlQPd1wHYTU9ZjNWGNXlS7D6TWqGFqB5bgHOcrLt/DfrZNhckV3yau9J8GLz/ktIP3pRA9cDea0KrfyvAsOdqcFwXJ96IyK/Hi5RXJfJ+eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001046; c=relaxed/simple;
	bh=MsgpUYtMTFZILAktmKEgvg9omU2XCm9NrZHhqNgY7MM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUR5n1ZZ1vp/1dy/TJS+IPux2pL34jx2GsnDtG3sP2YAPjbA/cjBkFVbEMlsQ13yZiVEWbTW+kLuohiO4qI4Ocef6FepyNinzNE4emsHelSUwD0yvHD/+fi9HH25sFV2P94aI8bSgUqq7l/qBXkYn5VqkALPhb/nZ14zHKlxzS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOF0pnn8; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOF0pnn8"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5ffc6a96602so366236137.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 03:04:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774001044; cv=none;
        d=google.com; s=arc-20240605;
        b=M3H5WTsA9DY2cgO7yH/gQo2ykTXvhPVemb2NVcwD/754EbW8ofHKUndcFrWQa5E4o5
         WgMjUmKIGlcJIJmDzUwM69y+EOJJtq1AMjb8jSABf2XDUZdUUuX0ZJXjdOkZzKvFxH4e
         xnHg83czym3l/3sFd7jOvYXZ7UPmOWOoWtD8gawRSHfcJH3GS0QwPAw2PnA1+g+cxS0H
         uHg1GybODteSVaB3ex2BqDhZtBjEHQIWV9VVOGRqmDMmttnSgJ27KuBYhai52SM+aUfc
         QpP40VbkT+gkHs4RhT1HwbyRZ+LAPaM+8y1mZcWTQtKvHl/zonAOG7tO96vrqobwbbao
         60+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LmOwJqEc4j5fedDX+FOWw858q5Kucqx5I4glC5H8ypc=;
        fh=88UPYidh17ichdsvKFWFekT+/lWWan1nlXG0JDPSDYE=;
        b=ViYRf90cdgjI8LCjAWLQNaskK8FFlzF2h/7ADjcm5vUOXa4KVAQf3eLrmxmV6eQ4kX
         Zz6lgSQjJt3CMME4KKXkd0q/d9iJcU7eQU1BWN/AtmuNxqqXnThToEo4xsj09b3PSB+p
         Pse9ZJ20rOk7Ha8Ulzu1IenSYR4EGpH6FvlrJoQHut4BrHSYr/Q0P/CIGLZb3OMLXNJr
         D9z9xoMoaR8PWDlPLScZe0jt2uEgpiQObyJF7dqmtGX+7Cor4GfE4LLWzsXZx6+AMCxb
         duylVscNIRmJ/9bmcLO1I1JQA1qk9CjHrDqq6PYEAiqasHrQ/ssN24m7U40ZBlq5S3yY
         8G/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774001044; x=1774605844; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmOwJqEc4j5fedDX+FOWw858q5Kucqx5I4glC5H8ypc=;
        b=iOF0pnn8zmlyNPGCsITfOAEMaUH+nDWecTMSsMKRabr6QZ9IDpS+H19ZoS9QwakNb1
         Z2pvJZJAOkuf8skun3AejImbBN5kO1sfoptzZ+r2s6Li8xrJSSBmMNoGaO+9me0kGtZx
         vg2bSy1kWkS/wVcGZrm9gLIM5274aQifl8945QHlMgDeqMfThE4vHCR7C9IVU5BjAPYw
         p7Y9fe89Jaa32oMpXWk8q1RQmcjzK7daTt8BW1QBrQx1Nw+E2wTAuPOWx3KN855Nuh6N
         tf70D3zthqZEF8fSy1xuYzrV957rXR6rNsLOHUPDSn6W8ObIqT5WiqVsCMB32nlyhtZF
         6ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774001044; x=1774605844;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmOwJqEc4j5fedDX+FOWw858q5Kucqx5I4glC5H8ypc=;
        b=jBausLD6frkx+JU3c9BdGmtSTWB7yhgyL83Kqyk76/XMM+H2t/AQ6zj2BnDlsExcHq
         zXuYWHKdW7x17eQs8W+Io3iJuIt1UJHk+2COwIqBjB3s0gGCGHf97hKK27zOYH3MAMp9
         CHkMBaw0m989KFwyjBDHgCsGpaQDab1x/MUezK36FzAQY20jJn4c6X6DyNz0T1PWBdJP
         R0Bdd+0mfgHfrQqkhdgkpT1iqH6BsU4lKGVwVxFA04Mawn9Ric0uJlTcF9p1LcE7M4fY
         nc4K7QktFtlrQGNOsrFp6TS4zNPie1mhKgR4gAORr95mUORwjc6O9BhkVFvzStVitxXB
         7mIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfcOgdj/gyKoZQffk8di3JjJTaR4TYa/9SPC7vf+YYkDWRXyHmETMnkYOnfPsYD76EMIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWORRqK8fdvvf6US48JiFWonL038BllLVeUpya0F6trnlLf1qD
	NlYUiTYFZK4CEgKI+5gEfjyNusz84iRUjau4DwKPRc5IUYQ+q9vnQwq9/4H0Mvn4UeKw4VXTS1e
	wnX0OkVsMf/Il7jf3qeVU10+juASbysY=
X-Gm-Gg: ATEYQzztc2/8ed93igxTa4gf2lFOMKKPj22JGoR+1hOYOzDEJDq+zourtA0gS6QVJ9L
	oR76ZAjhKFGOt9YsPjjUsg3iBMmkbwPv5fbtZMd+k5IzeN1SyxarBiu2rLj6v4s4fGuaXgFZGGv
	0UAOI6U5N82Mva7AbfPk0jb8sO1fomikFtXeSLAAOficNQrGEhSML6e+A727INSfLaVYmEiOYPN
	aD4Nfol2eD0HSvqm5Vnee/XPgwSjiaVBRadq/SqVLgzLMmMBkHupd25F7J36DALaSnYyZf5bFMv
	AM7mfmm3
X-Received: by 2002:a05:6102:3f49:b0:5ff:be25:8934 with SMTP id
 ada2fe7eead31-602aea92a0bmr1018836137.8.1774001043765; Fri, 20 Mar 2026
 03:04:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:04:02 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Mar 2026 03:04:02 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im> <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Mar 2026 03:04:02 -0700
X-Gm-Features: AaiRm51DrfZvxbVLcS2oeiO6loyF-Wvs4iIrUsbCM0b2hTSRv_DgSLYH2nWX1Aw
Message-ID: <CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] odb: generic object name handling
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000b9ca3064d71ce6e"

--0000000000000b9ca3064d71ce6e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series refactors handling of object names to become pluggable
> and thus generic. This includes:
>
>   - Disambiguation of object names with a common prefix. This is
>     required to list candidate objects in case the user has passed a
>     non-unique prefix.
>
>   - Abbreviating an object ID to the shortest prefix required while
>     staying unique.
>
> The logic to compute these operations is specific to the backend, but
> not generic. This patch series fixes that by moving the functionality
> into the respective backends.
>
> This patch series may feel somewhat unexiting, but it's not. Especially
> abbreviating object IDs is done in lots of places, so this functionality
> is overall quite critical. So starting with this series, it is now
> possible to do all kinds of local work with an alternative backend:
> git-commit(1), git-log(1), git-rev-parse(1), git-merge(1) and many other
> commands now work as expected. My MongoDB proof of concept [1] only
> requires two commits (the object format extension) on top. And no, I
> don't endorse MongoDB or propose it as a future potential backend. It
> simply had a good C API that was easy to use.
>
> Of course, other functionality, especially everything that involves
> packfiles, doesn't yet work.
>
> This patch series is built on top of ca1db8a0f7 (The 17th batch,
> 2026-03-16) with ps/object-counting at 6801ffd37d (odb: introduce
> generic object counting, 2026-03-12) merged into it.
>
> Changes in v2:
>   - Document `cb_iter` callback.
>   - Fix left-over conversion of `odb_source_loose_for_each_object()`.
>   - commit message typo fixes.
>   - Link to v1: https://lore.kernel.org/r/20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im

I only got around to reviewing v1 now, but the range-diff here looks
good.

- Karthik

[snip]

--0000000000000b9ca3064d71ce6e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 805883b93d5d255e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tOUc1RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUUvREFDU0lOdGYzaVhEdkI4eEs5VjhzR3ZBckIrWQpOSVhNVC92bGFs
bjhaTFk1Z3JSVTlmMGNyVlVQaGUwc2xXT2JTb0NzMCtXRVhudnZTRHhRaVZTa3VXL1hmMjZECko1
ZVhBbUNta0htTUtqQTZ1NVFjQklNWFEyQzhsMkduamtQa24zaDV0UkFteWpYSjZyTmlSQnpuZlBO
aWRXU2sKcC82SXBuZS9LU3BibHZUejlpVkVaVDR4OWtaQTNIRTdpWGg4cVN3cFNhL0ZiSVM0L0Jh
NXZDbUhucGxsSFI0VgphUXZvc1JrQ0RDNzI4andTVFAzMnUvLytGaWFTUEI4QmVOekwwcEJZQnFr
cmZFa1RUSTlUc2NuQjFmR2crN1kwCnY5bnFxTzZQVHMxczlzalg1UDVqMDA2b09wdEcxTlFhY3Ru
a2ZqUStLUWlWSmFlMUNuVUsvR0hKUGJxZ3Vld2wKYXNGWEM5UTU5Tk1icEpjWU5XSEg1aE43Ky91
MXZGMCt3dXRLS3JyRlJuWWZUSkZFMmtZTmxEc3NvVDJobURNUQpPS205cnQ1NTVKREdFYWV5c0xv
SE9DV2dPaFkzMnk4L2I0WmYxUkYrcGJUOUp0bXVqamFKd3VsdEdvYlloZDNuCm1sMWtDN0FHcjVp
SUZvZjZIV2kxdlUySXBqYlBGMHdaUy9qSDVjUT0KPW5jOE8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000b9ca3064d71ce6e--
