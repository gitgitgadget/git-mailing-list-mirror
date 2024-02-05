Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6483FE4F
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707149410; cv=none; b=X0RoArWpv2C0nAXsNwbCJrxuDIjzvShEpsU035fPXrgC5+S1cKTWPc4LKm767oUvreKFblnrPQE6o6jlR/1IwH+ehYf2bNgORxJ7dNLgtLkBGzBloYy4ucthXlPjq6Kij20QaUMTOhdVKgx+yYJwCUhOac9nsZUfdp9JBF8DNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707149410; c=relaxed/simple;
	bh=H1IMg9fbwLD3KZ8JgUXJvSwZNiiIMkoe+IJiyP9lERw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMrvdtruy5VyzVlrFev2GoJS3EHWgGHTRGljkOXe2Hs+IHzryp0uETIYzvCYcNNFC2uUTtaDjQOewaS7VPU5fI4zoGPcPsqRFRf1vaXM1YVU+cpV6JMRtQK89vwiuM/pPEY9JQ/KA9/AcgbEQE99/TqVsbLEZHSqkAlfJu1TL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CojOF/A8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CojOF/A8"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e13cfc0b2fso2527611a34.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707149408; x=1707754208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dCFUsEelTGeR1BwMUQiRVHlsGnd5ZudjBUrmOFgLJQg=;
        b=CojOF/A8/fj2qNdoW+MIkepfN4VMmiCukoDLc3r3HqT5os9yAHRaE/xQsqvbEpiWXL
         9/V5FAXruck4Yv5HdDj86OJfv9Hf6CF3o9ylJbHiVN36uCoE9V7Vv/cLaHfpJP13e8G2
         z6mKKxzwGwKzkAGc+j0XU7GSdjm3cMqesSh8wqINd/pCb14rX1p120cfNOP4rtB6dNKO
         tLCFx5wku8aac1QGN2I0JAlh0CUylmDOVtCcqlyCar+zjqSrkCvj9r84UveP8IlUFOni
         hdSaLnbw7qGeyBAgEW3bykSKA+0NB19NbLlfCNBFJwmt8Q/S1o5zQprrnVDwa5IoBaC1
         XZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707149408; x=1707754208;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCFUsEelTGeR1BwMUQiRVHlsGnd5ZudjBUrmOFgLJQg=;
        b=MtuOQ+UIEzNMnwJN6MQzDri8oF+Dd0jSo+lZ+FLdyEIWpb6YDDPDalHz39WZKEnaYh
         DUtVkuaDw/FZn0ejrtCcuK7G7mBv2OBd0jCQNLhlAjvL6o6Z4fWIECqMSZtKThqsbY1t
         wvgWqS2sYd5cZvObMYaMNHMJqkbSie9K/fyeos7gTWsCehCWLzcT/kuzfK3P12jPBQ+5
         sgFdKgcXRMdhX91eTt7E5i91uOLz/9MTNNmMr949CSboIbFnq/EPZT81iip1Wr6cwgtq
         1IT9g6mz0Ay2T6tGgyA1Izgy6zX8g+PHaDoGBgl24N2xdYIitDTmgWxzNDWSjo2liUm4
         a4iQ==
X-Gm-Message-State: AOJu0YySQJEnjBDozGcF7hNO9aGcfx33P5vf092kikHTRf4E341PpbZX
	X8u/zciygmBHCgM+L5GVhZ+Y4usei88qPyz16o0t25bUm/6pn2yMgrttpmp74mP5cKd4G4ItUry
	Q3K0ypecF+v3U3JUO6xkMxq7e/h4=
X-Google-Smtp-Source: AGHT+IFjp0owmrAstXBPWdW3N3Yc2UFoKL8jiSFzRP8hzrrmBtxWSe0ytD0kvb0Cjqm05Xo8jaHN1k0Va9iLiANKyiA=
X-Received: by 2002:a05:6870:3290:b0:219:257a:da0d with SMTP id
 q16-20020a056870329000b00219257ada0dmr123565oac.51.1707149407830; Mon, 05 Feb
 2024 08:10:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 08:10:06 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Feb 2024 08:10:06 -0800
Message-ID: <CAOLa=ZQOALZRNqp7dDH0qDWoHwo6_3G8VgVuMbb3C20UdJ4C5A@mail.gmail.com>
Subject: Re: [PATCH] Always check the return value of `repo_read_object_file()`
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="000000000000085af70610a4b2e0"

--000000000000085af70610a4b2e0
Content-Type: text/plain; charset="UTF-8"

Hello,

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/bisect.c b/bisect.c
> index f1273c787d9..f75e50c3397 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -158,6 +158,9 @@ static void show_list(const char *debug, int counted, int nr,
>  		const char *subject_start;
>  		int subject_len;
>
> +		if (!buf)
> +			die(_("unable to read %s"), oid_to_hex(&commit->object.oid));
> +

Nit: We know that `repo_read_object_file()` fails on corrupt objects, so
this means that this is only happening when the object doesn't exist. I
wonder if it makes more sense to replace "unable to read %s" which is a
little ambiguous with something like "object %q doesn't exist".

Otherwise, the patch looks good, thanks!

--000000000000085af70610a4b2e0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8fdf3801e4ce9b23_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQkNGd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNVdjQy85bjE4MFZpcW1hRE1ueVhQMVF1T0QyUCtRbwpYZWN2N2tIbmhD
VlFreEVIR3UwN2Z0dVZTc1A4d29iU2wrVEUranp5c0ZHZ3RjYkxMMXdiWUtiUWZIRHdNT0o5Clhy
WnVvbzkrS2RDQkhoS0l5bVJnbzhuODJ5SVo4Tm0rQ3lHVGE0blQxNjdpYjQvek9yY0RzSGR5RjJR
UTZWWEIKb1d2UWdzUVpudXBma3hWSkNUcEZDYVYxNkd4Tm94YUxSa2phQ2h1MTY2V2ZGcjE2VCtV
K0kzVnJZZ2I0WHlISApDc0N4bVRHUGpUVjYyNVoxTzFkN3RCUzJUeUt5cG5PbU9UcmNZaTFQVjVF
NkZEWE1PUzViRVFVOE9ZR1E5dkFiCkR6a3lxdmJWM3dVejVuL093bk1GWGh2ckxnTmhyc0ZpbExq
ZitseFVoUWxSN29ZWk1WTm1lM0paaEtyeURSR0kKV0VraXZselZsOEtjbXdZcWIxd2tHaStaeWVI
aDE1Si81cVM3cnRtWFRHVXVpU3ZYd1p4Z0F6YWptMUZidnlEUgp1K0MwOEJLNnBtZUM1R0cyRzBC
bklXUXRYUGprYTBXczVIM1JGeGdTK2RBSURMdm1IbWFISXFqWmdIUm1VOGRmCkd5WWgxcFNSWStk
Z29TMi9JbzQzVXlONzlEenJMT0dNaWMyOXZKND0KPVRkQ3IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000085af70610a4b2e0--
