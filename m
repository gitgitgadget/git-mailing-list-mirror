Received: from mail-vs2-f36.google.com (mail-vs2-f36.google.com [74.125.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD34BD7AF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213083; cv=pass; b=LqHzMlppF8SXZiqFAeyrzFzQA/vZFVZMDUXux3RSFXR0p8ykDLdKX5S8q7Tp1A76vQYYnHMahvQTCHMASdIFX/xaxFVi1auTeyBw/bAzGtsZVIUz4sWnd2mlwVWqfjK7uxkK8hMaC7Aw4sWcnXDwCk+7Od9pmzoLZ7fPjx2YKBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213083; c=relaxed/simple;
	bh=wvPzxjf/WJSXYalKDq02ze87IVoMzfuNOCB2LHSbAfg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=T+5CXrXiB1w3N3s2/+IpAlb0psLNbkh04gBwgU7JRJHlQyjNKJHUxlAHhbfkey/7OnjudSrTvlRHpvzYhjrOui+nMapaLfvoajxbKAkSWnQ0I/qoHxIpPydVZ694J/zMlQRbY71j1/KPy3m9GC4Bp+9HwyJedenkInvvwXrXR6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rdmz9yB4; arc=pass smtp.client-ip=74.125.227.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdmz9yB4"
Received: by mail-vs2-f36.google.com with SMTP id ada2fe7eead31-7ba99a2e56dso504233137.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 08:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213081; cv=none;
        d=google.com; s=arc-20260327;
        b=chNNaaWddr4Ql37q3JvUhGFRoBHSqApKgiDpoM9jKy8J9lZVnB3xv+hUfUVc+tobcJ
         +1RY3nnGZmeFUC7gzmddEHwJW04eUagu39laBdClNWfmw+A6WMlRKsN0+G9L6Maxljnj
         C7DYrxlBqudNS+HGLQxjWimV/09kkSb2av3W70fSuT55W+6bzygjaPnJTBkfJJ/CesdA
         1CxTemLC1bE7DxMeaS2oC4g5FJIw0Y3XVP/DmoLxIlolRWIzw9F5LQwVOLOhCbDX6/6F
         7jq5jVsMJZ+DRHc1opw0u3WuO1YB30nJVJFprIfal6wORdL4NsUxctYQXYEW2WD+unoa
         E0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=wvPzxjf/WJSXYalKDq02ze87IVoMzfuNOCB2LHSbAfg=;
        fh=191Zxh1UzBgyIEd/zTWOi8zA7H1cyjWRjxJkDB0CaUg=;
        b=e9ctkyIhOVCjEbI29QxZrfqUmpajlVwSwPq1adOK4o1eXz1kIkjeF+8A5hItf+sWRq
         Qg1lOb1CZxUvJxSAv0Tv9s/gdKSyxxT16Ax7vpONoF2OtqORhRDnY/ytIvSSB1EoqgfH
         t6ZVvh/AnCxuMK2PYyj6/OCwNscTVI+C+VZiKFPu7zCqHLFy1sG9BK+gzhghu/syxHv2
         jldzkAMCKtP8Pgi9s8DokaSajtNrmIGjljSxhRj43GfX6EjUoUzTdaOdyE0tRe8uzkod
         TOrTEo10IhM8bU59O9v25e2zDT2e22B3U1t4oO3JoJrPAuk9ufpoYqd47jRADHz/bMiL
         D3Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213081; x=1791817881; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wvPzxjf/WJSXYalKDq02ze87IVoMzfuNOCB2LHSbAfg=;
        b=rdmz9yB4QNEy7/I5NpfWIAM0X0TkM9OhvLJ8QCXkeuqqwUCbyaGc001aetPbRDJGHQ
         9RMD9cbsICoT9OjdGiQNLnQNiPqTE6ALyxMKUTWhiEzYfJVWRNorXMtb+A7Txv/G03Mh
         17GeMkM1j3C2Nw5hzoktP61SJgLf0jIByUyNgCOxes4D5s4c/Sd1k1wIyGt1tGscJPsL
         hIBbqG3n2yCdSGANWJRDeijHpnego9FEcIp+EeVlESW/y647SpMtxPdob0UKmkUVH+1f
         tLwI8ymMdKC2GYZ7V5bNU4P1iQe8jfaMEXpA4as08DhIgqcapM6mH5gcfiENjFw/Ng2U
         nzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213081; x=1791817881;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wvPzxjf/WJSXYalKDq02ze87IVoMzfuNOCB2LHSbAfg=;
        b=T/MXJzTjBWE5/yjbrawXNJHG6TB2ZJXY824ajNFq2lHHfBZ1GbDADRw/shOdiASqxb
         ZgBUnXYpAte/mdCQaf68sEF3VsBUeeXHZ32nS/kZywJPUqMTY+Wal5ic3OGIZxGCH/6w
         AsvaMhjZ56uXWGR9M1QRKXVcAQ++iP8Hzw1cQ+8rgfLxK9pPWV1MYUbGnsj/1KeQP4pp
         ZS+l6iMJwWvuMdkKdyv5/m9ng/N31y0/YOkZR5KmnwznVHEQ08KaWpNMtz3xeikbSeN0
         A+O5Ot1MVZMTvIqUTxlSpyFMpPBv7UVGELhKekl9VIcJ2kDJXu1IHjADhGy0hHVAZUg7
         s3zg==
X-Forwarded-Encrypted: i=1; AKwUvBw+CocVxMnYXEkwTCNFfsmqeUzf3yAqXqvZR+voeUfYjl/L0BQHMArYSsVlGJaAHTp2p/A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYGUNENEEChZfJMbLcbCZtQWXRSYIK5NZAkVYurp8a+X7BM8Cp
	Oku+vypsgPTYen6wy0cVk1Uauj8wep1CASEsN4IMIqqtT1Ea7uoyFvXZGkIyR3bXebwsdP2c0t4
	EI1D/8E0RjBSO5gsJlqSV81n+Ob4dbWfvFA==
X-Gm-Gg: AYBFou2piJoGQJVCI6Ctql4JMJ/qk6SKmhM1kue6wkikE1+gZXb3SwmfbY8fYj7bTE9
	eKYWsGYeWL0NQWpUObKlgvCVJVjJYi3iWLQ36pGJagj/S1HBTkpOIbLKY1Qx1bxU7dip7z0eEJQ
	C9PqwIZH8huBflT2xni7zlJlUyPDz2CxTA9YtKdwrg/+hN+wqkfhpunq6PZIkSv+7azXPDvhwt9
	/QBmvCRhx4idg8+emFhC/V6qH+/s2TtzH3fvjs+0mRkFq6CFu1oTmdpMu+LCbk4Qx7gbRyBjQQR
	yNDM8Cizoa776fonSyXda5DxOY4HbYLZ+o9SJt2nghtpLm74IfEucs6GwgpLjxLnVR/OVhIfYPc
	rSj6+RSFAYSVecIj7TAy3D4yo1LOvF9GudFzXu409Tozq
X-Received: by 2002:a05:6102:4bc8:b0:7c2:635a:4f4b with SMTP id
 ada2fe7eead31-7c2635a52edmr1347919137.29.1791213080816; Mon, 05 Oct 2026
 08:11:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:11:19 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Oct 2026 15:11:19 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
References: <20261005-pks-repo-ref-storage-format-v1-1-819a181572a9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Oct 2026 15:11:19 +0000
X-Gm-Features: AclHuK-oNii1WSZy8iMfmgzrQlb-xjhT99UWQfPkR2GMBCbgGZsBIwkyA8lVvaE
Message-ID: <CAOLa=ZTNNY_XuixqZ96TK0zFfDpWvxSupxVGOnH1VGXK4KF_0w@mail.gmail.com>
Subject: Re: [PATCH] builtin/repo: rename "references.format" to "references.storageFormat"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000006675c8065d194bc2"

--0000000000006675c8065d194bc2
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> As part of 2f28db44d5 (Merge branch 'ps/ref-storage-format', 2026-10-01)
> we have adapt all sites that used to say "reference format" to instead
> say "reference storage format".
>
> One missed spot though was in git-repo(1), where we still print the
> "references.format" key. Fix that oversight by renaming the key to
> "references.storageFormat".

The patch looks good, but this does break backward compatibility. But
since the command it marked as experimental, this should be okay.

[snip]

--0000000000006675c8065d194bc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c8a246a2564ab73c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRHZoWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0lBQy85L3U3UEprazZ4azdaNlVZV2w2NWc3L3R2QQpZRU1uWVFoVDRt
VUY4TDc5c09zdldKdWt6YWRMQ0VLd3JKeUE2YUtJL3JWa1FwL3A2WlZTWURGVVNvak9QQnMrCkxh
UEVucDBrV09NaGFGOGkwRVpjQ0NHbmNhdmxpdGtqSDFsRHgzaWRBbGZWZ21YZXhEbGlkMEtZWC9I
WHdxRnkKMXhQNVp6a1FOWnFBTGd2Um5HT2kxMmRYWDJXaXhEdXl3bHpQUGYzcGNsb21zck5qMlY2
dUFzNDNvYXdwRUVKWAphVndyRktaRWlqWURod0krYU8xRWZtRktjb0lFSENVbFVXTVdEVmR4QmtH
d2Y4ODFvakllTlowMlhjb0ttRWVGCnN0NGRSYkdCczhJNVp2Qk55emN3TzgxczB5MFoyam92RWU3
aTFEOGk0SzRxUWR3WVBBb2Ird2ZBVS92TzVDVmoKOCtlRjBlUnN0L00yMjlHUlkrblVnNEQ3NUs2
ZmtmZDZtOWhwckZKdjc5THE5T3B3T3JmQ2FDV005a2NrYVJneQo1QmMyK0ZULzBjTjBNRjJlWERF
S1NxRmVoNTBFbEpwNncyRlE3akt4SnFjR3QvK0RBK1FQcXdLQUJPbHR6RW9kClc4Q095WW9WdWJs
L2paaThBcXlOTDJxci9uYk9HdHNoM0FDRDVzYz0KPWdKYysKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006675c8065d194bc2--
