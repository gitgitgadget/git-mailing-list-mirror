Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3C36D
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983921; cv=none; b=ng6Yzb83JQaNTWHagI+n3vSrHE94F8svd2C3t8wG4NyLL9h8J9VVKLrDe/7D0IBmfctDTKPMsPzy83LyCvCcfF0/MZYYxl1bpk+e/lEPaXJQcSt2cPTA+W8CzBCojyCdSTk+sw+4TaYZieZcUzJz9v52/+EC/B4JIHpc8W7GPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983921; c=relaxed/simple;
	bh=dESTIx3MLksOEyHuSc+qPIloOKzhssyTbNw5r5rdc+Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa5NL6oTTTESQqTuQIa6UOShNM9vS6VX8nbGVWutZaeSTzotVPnAjOMFuEqdft9R+vuOnaJmizw1w4IwiM8x9Sbg4euP8B/HVF31LqTApC2HOh3dO4vMim05y34qxkBp7hVyPoQ7zBj1wuW+axNfSbaIkn2I+PR7A1fIaOInhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fw2FjiGT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fw2FjiGT"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-703ba2477bdso409728a34.2
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 01:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721983918; x=1722588718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R7mqTztJ130mB+U7m5DKTZMIVCIobo9+g8+Meh+dmCc=;
        b=Fw2FjiGT3Xakurqpx2Y65L4lHVcZLe96x5hra+ih6xQilTduabPpVN9sNSvf2x/tIf
         ruPVMb3KjA+bboWsiHplzNjj3AUVMd7RZdI8ljqTHuhyx0F8b6cUJQMu38XcO8vyCOA4
         dBTjsOrzzubhwyKbJbxxo+Goa4YyA9VUiLllVprXVssERRP3clVhcQT3wgkcwAAiudgp
         4V53fj0XUF60fMyYl2o6exHRGh/hjKQ6tI+GqN8liyKQnR6CUJhWEQG+LKEO49ifo2eJ
         NoMtdEPXJPAaB7UsSCYhKPW63oaxv5TtO4QYz6uDu7UtiRaIzcY6aHjGOoWjaTEk5uDb
         hFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983918; x=1722588718;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7mqTztJ130mB+U7m5DKTZMIVCIobo9+g8+Meh+dmCc=;
        b=D9I4Wf3pFQQSwLvyXtF5IJUm1ttwmIMtRK8AL5f0mVIHCqvy9kDm/dDNen+kN25lUl
         zz+WNwkst0iTwVdRWW/hIl1VOKqhjkXvUuGID+ySMa3dSBA9+rNN3KUqcxY37dRCj7m/
         vHqEX7WgBVFmesT0jjFZdb3UYZjqRkN6NY2RqflplvApp7BCncdvJ8gzS3bAy83D/5hq
         45PHrjWwgOIXhyf3bUDTqpYji4xh1Inb5ZS6zettdyuABBswZQggSErH2jcUG3i+r6dD
         ZLIgn7yBJOK3im2X/GyUzpQwtnxemLk1wLsNxDjQofn64P8M5jUaYpJshI/AMnF2zp2I
         UMWA==
X-Forwarded-Encrypted: i=1; AJvYcCUtF5ze3fsUf/j3bur9F2+A021GIVm/MbNLRBRu384wy0NMPu0EhBCZDsy4+tjYp9IbSGwlEBc6ENoEgjbzmU3BX7KE
X-Gm-Message-State: AOJu0Yz9ne6m6vWqE3O3Nd04YaGiABKH/KQeO4TvzK1nuBzWHul8eMAn
	k0cswpwrE5bLQELA2Zg3DLveMNQoLZCuotIqaL+WF+cDIkBQwCtmakQstPoreyP/9aTJe3AkRCs
	72L6e76w9KhRfRSmmxl5js79nMwEMc90b
X-Google-Smtp-Source: AGHT+IHY9fsWarS8qPRds189rGzFoDsltcnPjD5c8oQvxRZHFMR40rDI8vChGRa90YNds3gR9icjgULSE1ohxoylr/s=
X-Received: by 2002:a05:6870:d889:b0:260:efec:57a2 with SMTP id
 586e51a60fabf-266cc326348mr4801987fac.15.1721983918456; Fri, 26 Jul 2024
 01:51:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 01:51:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240724144957.3033840-2-toon@iotcl.com>
References: <20240722080705.2614195-1-toon@iotcl.com> <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-2-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jul 2024 01:51:57 -0700
Message-ID: <CAOLa=ZRJDoy=n=ZTULc9rBT=mQPyWRUBW7E5-JeQsPUYaDV0=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clone: remove double bundle list clear code
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000c4db25061e229f42"

--000000000000c4db25061e229f42
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> The bundle list transport->bundles is filled by
> transport_get_remote_bundle_uri(). Only when the list is not used, it is
> cleared right away by calling clear_bundle_list().
>
> This looks like we leak memory allocated for the list when
> transport->bundles *is* used. But in fact, transport->bundles is cleaned
> up in transport_disconnect() near the end of cmd_clone().
>
> Remove the double clean up of transport->bundles, and depend solely on
> transport_disconnect() to take care of it.
>
> Also add a test case that hits this code, but due to other leaks we
> cannot mark it as leak-free.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/clone.c             |  3 ---
>  t/t5558-clone-bundle-uri.sh | 28 +++++++++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index af6017d41a..aa507395a0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1419,9 +1419,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			else if (fetch_bundle_list(the_repository,
>  						   transport->bundles))
>  				warning(_("failed to fetch advertised bundles"));
> -		} else {
> -			clear_bundle_list(transport->bundles);
> -			FREE_AND_NULL(transport->bundles);
>

There is a small difference that here we also set `transport->bundles`
to NULL, whereas in `transport_disconnect()` we only do `free(...)`. I
don't see any issues because of it though. This cleanup looks good.

[snip]

--000000000000c4db25061e229f42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 97747ea468748d18_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1halk2Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG9hQy8wU01SZzNUZlJUVDNqVFI4ZFlCOGpkVVZwYgo1azNld3QvcU13
NHY0TnBuU2hia2o2ZlZpS3BTY1dVTkhNWUlsTDRGcDhsbHVpTmpncW1lbmlGeTUwNDV0Y1VkCk1s
SjdjYW9NKzMrWHBkalQ0SkZtVUNVOHN1V2JFTUovUXBibTNTZnlZa25pQmk4bUJTUE9YN2RtZ0wv
c09LWU4KdUQ5WkhsM29PVWdWb3dqVkJPNUgxb2J2VzVma1lBZnlwZUZrZlJ1YlhXTUpxUmhxSmVF
YmdhcHBkejh0bXB6cApSOUV0OUpFaXBTc3FML3NpWEczS3pjci92cjBaZGFxZHJTbW9oaGRsSTAv
MVArWmx6bHdTVXNvcmh3dXU5YTZRCjh1S3FjSXlCWWR6NmN6dk4ySzk1WTYyajZicnk5K1NYNVhk
TnhVTGVSVEZqUm55SGk2am10UFoyTkNmamZYaHcKQ1krbVBnMXpkNmh2YVhRYTFqSzFIZ2ZTTFVr
MXNZMCs5OUFKWkcxamhsamxiOG14UXJ4czZpMHZqeUhWR0hlVQpMUkxKTk5RejJyeHNWS1RsSDlI
ajZmWDB3QU9hWEJZVkE0QS9sblUxa0F3WUx4djlQcHZ4L0pSSGtiZnhodHhGClphbFhaOXlGeHVZ
NUdNR05UN2pTK2VsMlZtYVdSandybGVrOVY3WT0KPXRmUUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c4db25061e229f42--
