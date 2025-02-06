Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5390214209
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842843; cv=none; b=AtyWSM78IkFu41UgZdNAo/uotb8v36GIkmEx3zT/mttqWA+F13qzGcqh6zw9OTiqNnmMc3/jV45CTfUXlMWtXQ9aU8FT9Qsn0jOuoAN2Mb3G3Tvuj5seDdIdAO1tXBPcLbmYe/sq23ugalUl+MaO1ePZCUedCQST/FU04ZwNHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842843; c=relaxed/simple;
	bh=oFHTEnPZd/uV4aYctD90K6uJLPl02cN25YpdP4dRJ7Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=JCwLoBUX4mLlJmyy6MT4w5ToDBohM0xCuGZbySMBOVV76jXphY8ULW6nemyngczoo9Y9nS/RyUt+ns/4Pfq/pmT2527kakOhP/knvb1ggu9johje/ValaGzhoKN3JjWysSpvuj0HZClEsUGAZZuA1EnNU0DgSrHOejOu9+E6D74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0ursg87; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0ursg87"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4ba7d7aa995so83951137.2
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 03:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738842841; x=1739447641; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFsU9NwGCg4NoGXBQe+LwF6baBxqHHwq7ApooxxS3Cs=;
        b=g0ursg87VLkuWVcliULiAJP/AQJkRiizX2P0VgK2CsZHPfsRfZYig0Yo2ALOXVdlhA
         kbVnPyBG4PxGIkDVV6y667iuqXLzuD1NHxiQ3ud4WUSroj9gBF3qm9s7mzULPox36ZLc
         PIwl88jssMWtWzVND786r5iKt/vz3MgTS3ExB0u8aPC7Vc5GrphpBywOBLv0Ggi+esHQ
         e7kD3SwinVgBvFIcoaaEU+bR4MvsnKLdgq839huTbdQgGebE5BEyraS4JIICuiUANqnk
         MvuvC0i6wcAZRN2PQ8lThY7kcvxu1R1oFG2O+JccfCszv+OeEC/PkJaiw+lBzSGu5fKw
         nhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738842841; x=1739447641;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFsU9NwGCg4NoGXBQe+LwF6baBxqHHwq7ApooxxS3Cs=;
        b=f+bvYi72ktlld9E/lFDzIUtVae5q3YxmWhjmfYbw+YBlfbFuivg+zehzwUu0j/Q9R1
         e9M/krZJYWpdl3A9Us1iZ00DC73BWplHwEihf2pjL/5ieskIZ4y4jCQEwxeZCY52NFFy
         D7s2O1G5exvdhMIwlYGBAxO2syVrTWpj10HVPnkBMX1iKrVGtzGu8GXZyLj/73UHN37G
         4POlAPxAyYQxkUfBf2v5xng/2mZ0Yg6szkw4Hcjtx5e0WAd6meA9V0rkxWJKyzxfuzWF
         BTnuzVSvxX/TkP6HRHeOzgofnwfaEI6qvb04fNDOv9jwgZqAOZHZSJLFiVEyt70d//wR
         zY2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJA6JswNIxhUKp/TpiL/rDEirpf/eU+L+8/slyrRiDVfnNGpTndla7hH5mRzIJgHDWDjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHFDTh1dUIdi/yWqIGSoY/M734WI9DEAE1atTu40WLd3TgrBT
	pPEIgAQw9ueMGUAGpl76X94S6A8JbpD8KKuE3nkqsvokNecOVxbX8EP/DYWNlPpJJvgOVAeZ9EF
	hOI1uSSxLtjhrv7HLeHS6cvim15w=
X-Gm-Gg: ASbGncvIkKNx1sxPwILIkAruTU/URtWMt+6k6m6yzh2YX8KzZSblp+k6+Q/vmOLs0YZ
	mtADLcaYi8DkTqgYxkH1uMC5dNQvH9yq4sc3Z/nDx30Wg13kLS2Kqb9fVaDHsq60rU4bybIAC5X
	t9SIcYupYSlJUu+oANpII7RPRECb/pNwQ=
X-Google-Smtp-Source: AGHT+IFRR553MY8ld00muQPEWzvUeXkOO8ptxKr5xca+ZErY8lqq95O2DTu3uNelMFRGB0dC+AS6OKHgN8L+5VbUdZI=
X-Received: by 2002:a05:6102:548e:b0:4b1:3709:9361 with SMTP id
 ada2fe7eead31-4ba47a6b495mr4083768137.19.1738842840699; Thu, 06 Feb 2025
 03:54:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 03:54:00 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-2-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-2-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 03:53:59 -0800
X-Gm-Features: AWEUYZlWJogBfo5QELeZI8MywUrPkLOWaFpjpjsF_XMlGmiToTVccTYKXLcQCe4
Message-ID: <CAOLa=ZT8CrZA7Se98XBwS1CZjgvFFtKj5SBQfJNkG48QCvB=JQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] path: refactor `repo_git_path()` family of functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d73700062d77e529"

--000000000000d73700062d77e529
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -241,11 +228,14 @@ struct strbuf *get_pathname(void);
>  #  include "strbuf.h"
>  #  include "repository.h"
>
> -/* Internal implementation detail that should not be used. */
> +/* Internal implementation details that should not be used. */
>  void repo_common_pathv(const struct repository *repo,
>  		       struct strbuf *buf,
>  		       const char *fmt,
>  		       va_list args);
> +void repo_git_pathv(struct repository *repo,
> +		    const struct worktree *wt, struct strbuf *buf,
> +		    const char *fmt, va_list args);
>

The only thing that stood out to me was that we loose the `const` here
for `repository`, I couldn't really find a reason why we do that,
especially since `repo_common_pathv()` right above still has it.
Everything else looks good in this patch.

[snip]

--000000000000d73700062d77e529
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e729377023f75b19_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1la290VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG94Qy85Y3A5NjZmWm5adys3bWVUNlU2Q2NhbnJZNQpyODJtb2p0Yytz
VTBVYnhRalIzNThEWG5KQzNiWHcwK1cxTjJ0NXl6YU5tM2lFZTBrR3ZISWtJZkFHK0VId1dhCmpm
U0crVDNyRHNhcmFSaHdNaFRWK0Q2THBBeVNMM3FwNHd1VkFxdTJPblJZOWhhcXNOeWVPV3VZSnJY
dWlsbFMKVm83VlVVZ3B0YU9FN0JKRU03VUxqa0VOT0Yzek1OeVhvWmJXT2FDeENrR0c1bWZhQkIr
ZTErSG1rQ09nSWFPagpnMTUwenA2Tkx5WXJ0a1ROckJydzhCNjloa2RDNmlzei9ib0JZTWthNlhB
T1BnRWtRUUVXMWh5azVlTFh6eWdNCldvRVd0VTE3MEx1UTFjQmxSNWRDSkZjMkNzWXJ3RTBFN1o0
N2dtZDZyTWdkME1wUEJlaXUydzBwOXROU1BFcFEKQUpwV2xLN1N1QWZNV3VyV3hzWmRNVC96dmlB
ZWxBUWxnK3JaRWRTOTVWRVY5VUhEYUd3TjhxcXdYeFJ5eEhqMQpXT1B0ODV6R29yOGZPbVdUbi9Z
dVkxSFl4NzhRVkxOS2x6RDRZblRqUy93RVlvb2JhWUNmVDh0NVp3em9ONnV3CnpNWndDMXRuU1RS
ZUhMQTRrVlZaT3d0dmFpSmNlL3Vsbnp1bHJ0RT0KPU44cjMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d73700062d77e529--
