Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BECB3EE1EF
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528037; cv=pass; b=pKre6cjTT43Hu3VvaFgDgm44Hps6gAEa1tyJOewtxkhHden+X/MKS4gX38KnYpu16wIs2zRDThPcu3aX7pxGji/bw9ZSLbdgRPZUd2uFz+oQ03/ugX2et6t6yEP9WOBCAvUM37d6IwCvjjXplbT73wXyhCe6jbJZymBlt6Sg6LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528037; c=relaxed/simple;
	bh=xhc5aDK7BSTNrHjbRJ/XVmUVcRZDd0Hq3xY/a1cHar0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Rj7E8r/mS93wbmiNGxMLbGLtTIoa8+GZ0Bwm94Ht1h9nmUScay532WNX6APhaxHcE1ZssGE3FyaWmN56dQMcVBChjBQiBWwnVFvek4hJBzR1nGWSuPKUa/ySw3PkaHMn1WRzRHcVJ4B4o3nuqf6EKH43h0rHWKbpViH5Nm5LZYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP9wSlZQ; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP9wSlZQ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9809ce25a29so130511241.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788528032; cv=none;
        d=google.com; s=arc-20260327;
        b=SeP4G6hxLfKup75UHBTcGZLuPMF7xxKcEEHljwXZrP5BHHAcRY07FH1icnrv2M8OTg
         m1CDWvhOzaIi1fGJkv8b8Z2SuuHgKDEDv4ZKfarRn272eVYXp0BGsqlN4WrDi+eL3UwA
         dpQoof0b9QNpryJZCch7WNPcaw4ovxlM/Xfl1hYDmoX2oDMYSw40tm2NAjkSmUN8Beh2
         jDwBfAp6LD0m6R6WdCi+kypBkmOU3xi5P3P2vf+469iTsXybfxryWL4hIHx0oTWOZmP7
         F6vDbAaoJkRCW25mlQpamsAStGfCIUa9tXfF/WTbmJ5dVR69VaSSuVqL6NSR678hQvG0
         1ArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=sVPR+x7jjoWReeOJoqfpJOdGzT6F4zbG0FyRgA579g8=;
        fh=IkKJVvq3HeEkDvPKw++6VxQqn0HVgcIJQHHz0cFPq3g=;
        b=Bexbbb4HqTHaL38lIYGH90kJLwM1o0DlTKkFS6UitXlBOZQ/+7ZYy0RddzOTiTiJ7g
         aevbz8/hFtOcoV46OGVLTUcSYTQ7GHaXTEsfGTY0zC/2i+ORl2Za8B6UFzTIJpAa6S37
         Cgw3c4hTxL/SKVIsgsOaxx2b0yL8dpxl2UxcdM0DkSAHC8z4T5G756a6RXhTwdzkBK+L
         fzoOr1oUimw9X5vsZBRA3bhlPw8bkBYRYzuXzfYXC7v8xj9ATi+ew7ZL04mbcemTXfEQ
         CMXIgJeNVXqIdmggaRausLuuQtEcP3ZukGL0p4yciZHV0pNkvQC9lJHMn1jO4ZJZukrz
         QyfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788528032; x=1789132832; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sVPR+x7jjoWReeOJoqfpJOdGzT6F4zbG0FyRgA579g8=;
        b=YP9wSlZQOOFz08omifZliwWNzt9i2acnbybuAl5eO75YWyADmm19NhnKLgbB+iwIpc
         mlIaIvmFyPdjLQt6Adak+4wE8fWyQPcS1cBa3hnU7a5IENtIW0msL4DhAZM3rGaBK09o
         nHgFuAaudq4kDzGsV4J4NpEiBnrHblSetfS2dEdsUM0CDKAR5r80RS3v926ajLskP8hd
         eLLOxi32mW4Jv0hGCOS7f+lu22GnBG4m1U+TwC+ambpaB+Vfa/4aaJU4ys5R4BNZEKrK
         kaaFd93HWH8JACKTwknJas0CveSz5OrAciSbNKmv+4mBVmHoiyDUCAXsGX+qy0Su1aVS
         cfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528032; x=1789132832;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sVPR+x7jjoWReeOJoqfpJOdGzT6F4zbG0FyRgA579g8=;
        b=b61pRvFrpf2szfmCKBP4lwY1TBIcIjRQ9S7qKTOhh0Y1Sft0sOZ5AYqiS0uIzh35F6
         awSRYtxr9CkJaV+uUCO2zFCtH5o1K6pnOFFVRiNf5AZlbyVv5WGqsHAUlwO57WpFibUZ
         2CCixrtZOaBqvHa3nUSSNaJzutf82FEcE1EDOlo9ajPOqxvwrsJdhpCFIyUC53UCFQHZ
         qhgG0QwR5EtkJz5iJEfDIwzMtXdxTUa7FXs2St2FoPyzTmrV1fwUTYmLhSrKFa/vhLrm
         fai6MisV4GA4KGIpDp8BHIFouqv/gTois3Ch3MkV/pqRa2Yhkl/G6KXvmtM2NewuPjNO
         WCOg==
X-Forwarded-Encrypted: i=1; AKwUvBzHXLKh+o7L3AphMHOjktDnqx3b5v0CqO8L+KP+pz5HZWp+VD0teIE4y4ksGjbwsMyRfYw=@vger.kernel.org
X-Gm-Message-State: AFuF++k5AnLZ4IHumbTrm6piPBGjh6o4E3w+HOIKPzajXG6DAEuKfqNR
	cKlzvNpr2D6gRae3zz7ae2j6YGRupvk05Mg6rGwjUTfS7HTt1EM9b1PfNhH/K3oNxo2kS/Pno8t
	0tP4i1DX8iG6VbMP/ZlDNBAlFHFOwfIg=
X-Gm-Gg: AYBFou3GQdEsrvLaDdjjD+9j4gnL5l9VkDsJvjjTUUwCc+bdGddvSsYPQvJlviUgMvY
	/zp7dpg8Fy9lZ5IRC3eXO20HAJ9DWeBExOjpZa+c7SPZWxpDpxXULwSmh9EmGL65Wg0HH9aQzWr
	geKWwmNFnmhpYYY3QfqzW28BCtX9U9Gyi+CGDWSJLf3vYqoBICCDs49z5nQJVuz2uHpGwXkYvrm
	LwmWrRHImX1veKrKfwF07QITrKa15cLy7QToorYpdcVOYpUStknjXuihvyr2IZvFHL1emYnN9D5
	OyRx5Dkndm/c+8Ryws1vbYJBD9HSMFYYmHYFzNk7uxIbq17KMQPyg2z4oEo39AnKuW8vaiDlArc
	MVcaHlEB7+hnPjgsQnM7V+SHwYt7+gZhTr+U=
X-Received: by 2002:a05:6102:4193:b0:785:8ad4:57f2 with SMTP id
 ada2fe7eead31-78a4a5392f3mr1073221137.2.1788528031673; Fri, 04 Sep 2026
 06:20:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:20:30 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Sep 2026 09:20:30 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-9-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
 <20260904-b4-pks-unify-ref-storage-format-v1-9-08144e5004ff@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Sep 2026 09:20:30 -0400
X-Gm-Features: AcwNN1WzC1fibowLwscDUJvVb-2SZl6WBOtLCOpjyoDhTqoW39Lad41fwy_7yAA
Message-ID: <CAOLa=ZT7WQ-J-i6n_nqm0MtDypm3V=3jyG6y6a8U=EvicMqgow@mail.gmail.com>
Subject: Re: [PATCH 09/11] setup: rename ref storage format environment variables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fffafe065aa821b7"

--000000000000fffafe065aa821b7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> With the same reasoning as for git-init(1), rename the environment
> variables GIT_REFERENCE_BACKEND and GIT_DEFAULT_REF_FORMAT to
> GIT_REF_STORAGE and GIT_DEFAULT_REF_STORAGE, respectively. The old names
> are kept as an alias to retain compatibility.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/config/init.adoc         |  2 +-
>  Documentation/git.adoc                 |  6 ++--
>  environment.h                          |  1 +
>  setup.c                                | 21 ++++++++------
>  t/t0001-init.sh                        | 50 +++++++++++++++++-----------------
>  t/t1419-exclude-refs.sh                | 16 +++++------
>  t/t1423-ref-backend.sh                 | 18 ++++++------
>  t/t7424-submodule-mixed-ref-formats.sh | 14 +++++-----
>  t/test-lib.sh                          |  8 +++---
>  9 files changed, 71 insertions(+), 65 deletions(-)
>
> diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
> index 9c78440192..3098e033ac 100644
> --- a/Documentation/config/init.adoc
> +++ b/Documentation/config/init.adoc
> @@ -16,7 +16,7 @@ endif::[]
>  `init.defaultRefFormat`::
>  	Allows overriding the default ref storage format for new repositories.
>  	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
> -	option and the `GIT_DEFAULT_REF_FORMAT` environment variable take
> +	option and the `GIT_DEFAULT_REF_STORAGE` environment variable take
>  	precedence over this config.
>
>  init.defaultSubmodulePathConfig::
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index e3260fde68..e34c74d995 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -590,13 +590,13 @@ double-quotes and respecting backslash escapes. E.g., the value
>  	is always used. The default is "sha1".
>  	See `--object-format` in linkgit:git-init[1].
>
> -`GIT_DEFAULT_REF_FORMAT`::
> +`GIT_DEFAULT_REF_STORAGE`::
>  	If this variable is set, the default reference backend format for new
>  	repositories will be set to this value. The default is "files".
>  	See `--ref-storage` in linkgit:git-init[1].
>
> -`GIT_REFERENCE_BACKEND`::
> -    Specify which reference backend to be used along with its URI.
> +`GIT_REF_STORAGE`::
> +    Specify which ref storage to be used along with its URI.
>      See `extensions.refStorage` option in linkgit:git-config[1] for more
>      details. Overrides the config variable when used.
>
> diff --git a/environment.h b/environment.h
> index e7ec5b0437..e6b933f8db 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -44,6 +44,7 @@
>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
>  #define GIT_REFERENCE_BACKEND_ENVIRONMENT "GIT_REFERENCE_BACKEND"
> +#define GIT_REF_STORAGE_ENVIRONMENT "GIT_REF_STORAGE"

Shouldn't we also be adding and using
GIT_DEFAULT_REF_STORAGE_ENVIRONMENT? The rest of the changes look to be
in order.

[snip]

--000000000000fffafe065aa821b7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e6dbdc592d72825_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xYXhaMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOU5qQy85RVh3MXNTKzN5ajJ6RFRXeEd4Q3pwM3YySgpJckd3TytyT2kw
Wk5qRWhlQWlSWFlDbGViTlp3U3lyTWJMYnZ4OUdVRExrK3ZoNEU3b1lqSC9GMk85dkRkeGliCkdx
bnRmY1pHbXh6NDdzcjdMdjdCd242dU9rOW9RT2k2dXpCZExJNnRkZ2JvT2lEWWxQS0N4dE8yNHFW
UkNtYTgKekU5OWVjYlpjS1lRbUplVDlGdmtlSU1tS3hsaWUzeHhJZjR2ckJpekpXUzJiZGZ6VFds
RjdCWmo2NWpFWWNtRgpEV01sQVRYS1Rnald3NlJ2NVJ5dHFrRmkrMmhYdERIcS9nOWlJbHB1MHdF
WXZqcDRzYWxjdXI5MHI1R2xTM29kClNmaWNPTThlbGNDUWRiVE50ajBEN1l3S01PRnNESzlCWitC
R25EWVgrck5nWkxzOUpFZlFvTWdFNmorNmVRVEoKNEJ5YnRyZmY0NUhqbFQ0bFhQdGJGcGhBWmlh
cjI4QjN6amJteWpiUFcrLzFTdUVSRTRDVzcxTTdrVjk4UG8xRApwUXFubmQwNUZkcy9qQVZZOUxX
OGlRSWJnUWdyRVlXeENlOC9nMGkwUkpweDhLL0pWSm9FSUhBZUlwVkJUNzhlCmtNamdtTXRWTFU1
VlkrRnZmK2VyVkRnVUxkRy9zdjJ2MzFNa2IyWT0KPXk3ZjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fffafe065aa821b7--
