Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F81429D
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863136; cv=pass; b=d1d7kQW/x/rbPgHrpbbm0D2EnqDkLVRGE2/QNcEtD6mloX0Wq2bMVtNRRlnlbiMJmBlGr4DjJHu9OZu+OOetIyS+7rKrXYPJGqZhtcUNO/n1AEkwPERLU6hvRwCOYcanY0jpyO9wYvNxqqTXeNTnzOb5Jcyc84crqmYRlYKZTS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863136; c=relaxed/simple;
	bh=LmVYXazjD/ASnECSIBlJY7P0rFqwT+3wT/X66CuT8TU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Yi30fjPcHa/tceBNGeAVNNAaM26+wVpUDeAyl3GNqn6cIW0JdB9oZzwKc9FI30KuV+aNUMEti142ObyvqdPeDebgkEuRxurXiFhYk9GzqZytRFBuHttDM97WJQwJ/i2C0ApUgbyu6iqVRkXYJg4GQEcBX/nX1t/TFZy0JAgZK/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOcWznV/; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOcWznV/"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-953b15c764dso615707241.2
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 02:32:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774863134; cv=none;
        d=google.com; s=arc-20240605;
        b=emfBT95iv2oFoieDl9wgDkMcOSRQMXuQ5YdiqFQ8hPB/mhhGkhShhJo/jLYZd5EO9v
         aRDew+ReS4Ydu7cPs/t2uwnZc2ac5gEKyyzqOXCgzNasM/JrzGlQFf6I9gXxEcriIJsP
         JM/xO9ti4yrhgDE0u3selAnPP9uSLY3hC1m+eAtPfeQ5mqtVYSSmdxBNWUrs8KI7IcXW
         T8tafb0K6xywJPPaz+3lPLOUYHAC+VmyKeuUflrBXLjEBj98RmqScHZ4HrOGX2V2s3rZ
         WDS3hg1GrDDJUzKOidRTNx3lPUb8YeTp62KF6wDeKBS/L1ogMge0foMR6b2OxNZ+Tj2o
         LRBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=hJJh/VjBpyzd1mIknMZXOGHkVH0B/nUstka1p0sumpw=;
        fh=V7YZ+h+xlugpRZ8ZWu24XCVxmIhPHcDJXA+Ys3iHiPE=;
        b=EE9q/uUW1gp5LepoW7DP2z84vqTpPr+zl3VvMh+nCS6Vi8o+d4GuVG/Po7GeSsD7Tz
         iQLknpBV4rPTvu4iXIO5As7mjWU269pvtRnqTz0/rxrTVt/DSjXHxhwW1mmVVfWA70Kh
         uuA3jkNrlyNH+2zHTh3zxaprBNu8t8aHigFkSjsVk+mO9n5yLJxer8UrCZmUNtFAMK7z
         QyLyeSNxjgB6FH1w0doYP1N2OvC1zD1TjnhGjTozBVvExQw/FK/NBXaBxK/V8GvTWkoD
         /wKzPoQtuCRunpHdgPcsniBceVYaeRPONYFbtxaMqmlKXpWSRlGgEDCQy6quXhNSozdO
         FZvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774863134; x=1775467934; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJJh/VjBpyzd1mIknMZXOGHkVH0B/nUstka1p0sumpw=;
        b=HOcWznV/p8m/pVJ6XH40lmQHIz/9L/9cvNj2A26nuuZ7qNudC5OjmpuX4zfp48omKZ
         zQzgyzai6kJBWTWpdutL0m5gcUOXzu8nF91mVafvITMATT3HQYLrGkrMuMfAcq7jlG7o
         D5ss3pGx9/DbFVUUI6i9UhwvKsYapCbxC05BncbjbQq+QsBB5SKOtaV7vdG39EHE3kUe
         GpFEM6g9iwbkm1J5UOo19B0Epw7obwRvd7ikF0n1z148nr6KJJLH24VhkKD2rX81xzqS
         K6Njeu6zHEk4DQXPYBcr3Lyvzj5BySmbnX0eQgSCMtdm6zxk2vX41u0BglOsIJojj2QF
         wcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774863134; x=1775467934;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJJh/VjBpyzd1mIknMZXOGHkVH0B/nUstka1p0sumpw=;
        b=ZxCSR7VJs9rH5S0BKxUlxvBfEAFqLQOlvz0sg8noJ+Mg8LU5WCDoW+hsd4Vm1Yg6GS
         hrz+ZDhgxNHDJtnTSh4Wweh3oSn8d45Jb3JkKhc2gGUJOvTg/eg9C/4tUWvLsFdqDNo6
         XRmo5m9VZfl/3fUGTp5JivMrddHRThhUvs60xvCSlBQSioDZ8QoCbh4eTDSktqQ/rVGJ
         D2Mz49clDxbdVUEMz9gMDkmzLcC4jJx2FeCUv7r+L25qli1DYhQNsRgUe5bPSQkUDCNz
         HI22l9LaARWIhEP/GLhjBBELze7o6nhRzScZ/J76OGCJA+PtpRsySQmA3nSz+XTpJR59
         mDWg==
X-Forwarded-Encrypted: i=1; AJvYcCUvTlidFTuEqh6DQl+GYtXxnJ/PxJpPBIVUddbFYuEf6bVVHEhYUKyVSXk33fW2TL/bxwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqQQYJGM5p3pAp4PnFBcxSPS6mpLSKUHJ4BDpLMpVf/oLzMxY
	p6U/JSTNnsrwf1J4diIGMEsws/fufHgrcu7LnL23GbFXxdvb6sOcxWqrEIU706MokRxCp1pfW3J
	AAn19J2vKw3PAzPJ9n7NOqW7/LNhJbz2gMA==
X-Gm-Gg: ATEYQzx8DA+6zR70y6BIsKZ6LaGdO6J6K+x7oMApVVCBhUOe021XM7Bf9ZYlSgZF8Zv
	hkUL+0mc2dCioBf61BVEhufRHnymX1sMqMJqO/Oc9zXjNDAEiL/Aetb5rc4Ulx61hNwq38g4Ck1
	oAeADDR39UUzXxbXuLLmuvWgrKu1AmwbEpO82xziAQKvipD14YLaLaO4l36VnETsUeUYkcMmXvb
	mmzyg+pmkv5OV4Jm5V23G13VzOzR+rMcuQJ5+LEE2GiuLjjsWw6U22T+yDpyhDJHMZOwvAsO6xr
	L8vk3AvbC/avQbz42BBoIjoy2sCtk0uLzxSnop0s/Q==
X-Received: by 2002:a67:e111:0:b0:5f7:24e9:ece2 with SMTP id
 ada2fe7eead31-604f929bfcdmr4389176137.28.1774863133982; Mon, 30 Mar 2026
 02:32:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:32:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 30 Mar 2026 02:32:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260330065053.76919-3-24070721037@sithyd.siu.edu.in>
References: <20260330064454.76833-1-24070721037@sithyd.siu.edu.in> <20260330065053.76919-3-24070721037@sithyd.siu.edu.in>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 02:32:12 -0700
X-Gm-Features: AQROBzDtRQNLbXx7AhQFajUtnfjVJQHYY-VyW-_YPxIMxPDG57t4_X2Zy3_bvP4
Message-ID: <CAOLa=ZTMEJCQn2RDsLmVzPkh1s97K10bpCaCSF44MbbfnVXEvQ@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] bugreport: clarify usage message purpose
To: Smaran Jaianand <24070721037@sithyd.siu.edu.in>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a06461064e3a8612"

--000000000000a06461064e3a8612
Content-Type: text/plain; charset="UTF-8"

Smaran Jaianand <24070721037@sithyd.siu.edu.in> writes:

> From: smaran-jaianand <24070721037@sithyd.siu.edu.in>
>
> v2: Fix spacing in usage message (add missing space and remove
> trailing whitespace).

Version related changes should either go into the cover letter or below
the '---' in the commit. I would recommend reading the following
documentation

  - Documentation/SubmittingPatches
  - Documentation/CodingGuidelines
  - Documentation/MyFirstContribution.adoc

>
> Add a brief description of the bugreport command to improve
> clarity of the usage message.
>

The git command adds command description to the 'NAME' header within the
documentation. For 'git-bugreport(1)' you can find this in
'Documentation/git-bugreport.adoc'.

> Signed-off-by: smaran-jaianand <24070721037@sithyd.siu.edu.in>
> Signed-off-by: Smaran Jaianand <24070721037@sithyd.siu.edu.in>

> ---
>  builtin/bugreport.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index f78c3f2aed..6b1d1accb1 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -56,7 +56,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  }
>
>  static const char * const bugreport_usage[] = {
> -	N_("git bugreport [(-o | --output-directory) <path>]\n"
> +	N_("git bugreport - create a bug report with diagnostic information\n"
> +           "              [(-o | --output-directory) <path>]\n"
>  	   "              [(-s | --suffix) <format> | --no-suffix]\n"
>  	   "              [--diagnose[=<mode>]]"),
>  	NULL
> --
> 2.43.0
>
>
> --
> * <https://www.facebook.com/symbiosis.official/>*
> <https://www.instagram.com/symbiosis.official/>
> <https://www.linkedin.com/school/symbiosis-international-university/>
> <https://x.com/symbiosistweets>
>
>
>
>
>
> **Disclaimer:* This email is
> governed by the Disclaimer Terms of SIU, which may be viewed at
> http://siu.edu.in/disclaimer.php <http://siu.edu.in/disclaimer.php>*

--000000000000a06461064e3a8612
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 77742ea4e3fc685e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uS1F4b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWwvQy80d2xtd2RJR01vRDJiS1lyNjUzVXcxZXh2ZgorSHphL1lnNS9z
OG0zTmx3empQRnJFVTRYcDFUY3BwSVVXQnBUc1VHbTZhWFJ2bGhrY0JDMDEzTFNjWVZaZ1lSCnVK
cFl3WWFDMXBNSlZHZ2tvUEJmZ3ZWVFdLNWxZTktwSnVNeGRacTVOakpLdGFkYXdkVjFBaW1VU2d3
UnVHaGUKMmdGcmRmMWtmNEU1blZUVWdJejg4MjQwYkdRY28zbHh5TVFadjJERFl0UjVoQmcwNi8z
OFRRSWg1NW9FNnFaNgpiQ0ZpSnVRamhxL1RTbEZEV21pL0RhYXUwaGlzZXFyQ3gxMlZ0NXM2VGtr
dUk5eE9ZaktaTkNBUldoRU1UQURLCmNYdDM1WGN4UWVxMmU2Q0FJQkM4K2JCeEQzWGtpaUw3dmdq
QVQ2czJLdUZhR2lSL0w4QVRaVkNhdjZ6K1g5cmYKSDRrV3pYRGQ5dWx0UHF5Wjh3MG0yOGZVTjBr
bERBak9BMnl0U2FYWkxwbkRoS0xsckwvSWsyK2xibzczVk1sUwo2Yk9zRXBBTVUzdUNLSjA0MnFL
OXBocHlkUXUrT2JmU0RPRjlZSGRoWkE1MGtyeFRDQWd5ZCtiWjNVOXVPR0ZqCnM5S0VhcnNRR1hk
WSs5NTBKWXdQMk5aVFZWSGhvU085MmpMbnFNZz0KPWk0TngKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a06461064e3a8612--
