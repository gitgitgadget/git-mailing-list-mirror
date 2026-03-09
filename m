Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C3E86277
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052657; cv=pass; b=f1TK0owpLxXOovIcGaKiIBqq5uthNjKMN6fP+QF2A/pzNs0Dy/ERfJDwRfKQ17yovygu4wqXflvW9Ycrz44HLC+p08bunmvzSq/08N8RC1n4SgrfO+uaRcGC0bngY56eASys0M6D7SwhSKIqsWua9WYauCwT+1cAq4T+5n3vlsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052657; c=relaxed/simple;
	bh=Ta4gpLDu0syjyMqlgVd66/k4QmEffk8za2eR6F2kijY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUFlBVU9Z/KSHNtJnYj5oX876lzN7ktBA7DS/mZpjQwDCUxor/2syGVcC+ug+khfeGl8tLmSPkUz5sn+gvyeDAE0SdhorXWpnIOarn6RLK+ys7B5Dq0v9BdYFzgH5UZfCIb9eaVewH37k5JlHkU9lunTMKWLtV7cuNvVSwRGPHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBHx75ej; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBHx75ej"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56af30dde0cso1507276e0c.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 03:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052655; cv=none;
        d=google.com; s=arc-20240605;
        b=d2NPQWZQGgvyD9UsTR97qyTZYL7JFlwM10WKS6nUsqoXSJFvOOEOeufeIB3os3eNgs
         NEVlEH3V7a3ivgZpkO+/y0IabYdvgNc7xXUgPuD/Oc7MO3++jdXsacGUccJfsyiyTjJo
         gcAjmh1uTbys3XpdUWqV0HroozUeSUC2HyHRbAYm/2GYhPknW6EvfuSsB2SxYuQciE8g
         p3NaqPeo4frXL3eo4RprMfE9/7iRts8FUilXcSGEOaqKp4HK1NihqNrZ6+r4Mb1Vi4ll
         Hl+l6Im9gti4jd7EtiymHBUOCMZa+3VVcihZUzuF/D0hCGURVw/I25L+YjHJ5k8EwKNb
         Hqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pkW3eguSaYFqEiee9tamXDI+f/kTEYGftVuKcZ5G2bY=;
        fh=8N00NLR9PqZmdD1ZnCNr5K2MXloMVG2P2baBh+0NDaA=;
        b=jEAxyQMwKxO01Epd1BsJRx63c8ElRGfCbVjZXfHrcNkpSfErAfNo7Xs+2/Jnwequf+
         8XluHjMV4VpPlev9TR36QQI67P0TpJZnJ3YnkU5rxZbKUxve8k1B7yM/NJBO1npH7lFV
         aJjmIMSvH2heAuugnK5fZixNMPsM3/hz7c1ILn9vNaGrQu7OLcXLcT6MjjwuWzq63O1n
         vpyBvhEL3M/RrlhsbiaNRCzfjIvaMKJABZVuJxtTdPcte9vDQHlGSw9u4bQ6IPQ1u8vH
         SVQ1tmh2ru4eZ30fa0c23SKmsgDY4VDLicCTYDPJk71RmmG7PNVtGc9mv7i+L+jkfTyn
         Puog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052655; x=1773657455; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkW3eguSaYFqEiee9tamXDI+f/kTEYGftVuKcZ5G2bY=;
        b=YBHx75ejJxkXMbWgwnAvzn6H9xNBo+rmoOq+HeN39lr3d2Nna/p3UHk1CjPTcne9QV
         33d4SG95aNAGCjjm5qNHMJgMh4OrHL5DIuAm1uyqKvPnjnurBAewURFXpciZo1vpEWY7
         KDAd+D75o/OJK+bSwJ0tOH62f/PO+s2sDf7zEXMEgDIj3bm4CDgKrntxIpmNAuQgyWoo
         VGQ7jEasYVW0K+hMHDWQMXyDOmp1OhR/y3TRAPhp0Uf91v8SPgwffek9kxDt9DCMHf7n
         4zROgcZ7gXRxCkJ3ozTsm8JUfPC8T4AxyrRZCYtpVLTmcTnF4c8jTjD01VMStdVFlH66
         Yp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052655; x=1773657455;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkW3eguSaYFqEiee9tamXDI+f/kTEYGftVuKcZ5G2bY=;
        b=iFYLlUcDDxZyWH47VFf4AkltFAjazoTQjSamydYArp85lI7rXmPaiey+AuGILPeUco
         h+MDfZ+g6pxRgs+xlQwuo4smcGaoYowxMao/taR1W+/CQ34r5a6a2PORaWzOGinkIliC
         jEpehBD5F1yqMemr/vxH/We0hj++GtjBsh4dnsxDB9ashdJGb8r8WqFQJy4d6GKxJtHE
         ktGHSEW/+3BHgo2SnAXb41ddjdg8wEYt4I2cn+R9jjknZ5Rrj3BAUOLjR2g53D3inLdi
         pYJ+HwIbWI0ZWQEcXUH5xFkBvT459IYT+Ch1A2UCIrv3oldkpfzYpkXY0rK6ONrRaq7T
         rtHg==
X-Forwarded-Encrypted: i=1; AJvYcCV8wIU8WdQivAETIdI1D/FEaaJ8mMvgeHWeicWfpV+7mhSXIE175Of0T3Gy+FLJPz0NS8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhZKmBWijdqVCQ8WZPLGmjl4y0DlCcKFjYf+6kwBPf5rBSp9b
	1KZwgLycjFqwGXXplmxaCMeJJt3BPcjCsDKvfx+icKgcd/okYWgu8lpvHwAtBaB2kVDSJKBJQLE
	Do6/i2QHp+WkaZWupgNOJwHIQnP5t1as=
X-Gm-Gg: ATEYQzwai+GSwq4eDwZBrQogbLogJOnJmvewBPHmj/jRHAF9gD9FJ1BHOl/yHYl/6/2
	IJbcwzr0CE4YI2h7zKqfkrsicVoWKhXy6ificoVaIVSjbPGYPKftfMsN1pqHSGrBqIIpnWRxSu5
	cXW+ms8Hxtcvb2Ye7vlFmeWBXqknAg3BIArPHgs47t9B+O+ReYbqSdMASRwWPMl+GvoAOeq0yzu
	fviuOQ3N3aj267kLTgXXsYmIG7V53iTnPDg338HEvg8UyzVT2wrISEXYlmdp3BjVkFQjQzwstcN
	M1+ji3gJ/LQy5V60LttBZOjwJzpBzIvZu1IbirvfuQ==
X-Received: by 2002:a05:6102:6c9:b0:5ee:a12d:55b7 with SMTP id
 ada2fe7eead31-5ffe6184467mr3797043137.29.1773052655469; Mon, 09 Mar 2026
 03:37:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 06:37:34 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 06:37:34 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260301105228.1738388-3-shreyanshpaliwalcmsmn@gmail.com>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com> <20260301105228.1738388-3-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Mar 2026 06:37:34 -0400
X-Gm-Features: AaiRm525r5iXXWd5EttR7TN1yshR-5yvqgyd5Zb7Mi8d6na7HAk9Oa1VBEpgVkk
Message-ID: <CAOLa=ZQaLRBxjbD9yPJd3ksvAgnpyuCAKM=Y5YXvwVgw-0AzmQ@mail.gmail.com>
Subject: Re: [GSOC][PATCH 2/2] editor: remove the_repository usage
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	lucasseikioshiro@gmail.com
Content-Type: multipart/mixed; boundary="000000000000b2a036064c94fd35"

--000000000000b2a036064c94fd35
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> git_sequence_editor() reads sequence.editor using the_repository. Pass
> struct repository through the callers instead of relying on the global
> state. It is called from,
>
> * builtin/var.c: Mostly the_repository is used in all the functions and
>   there is no proper local access to a repository, so pass the_repository.
>
> * editor.c: The caller is inside launch_sequence_editor() function which is
>   called from rebase-interactive.c:edit_todo_list(), which does have a
>   local repository instance, so pass it down the caller.
>
> With no remaining global states in editor.c remove '#define
> USE_THE_REPOSITORY_VARIABLE'. This removes another dependency on
> the_repository and keeps editor code consistent with the ongoing effort to
> reduce global state.
>

Well explained, the patch looks good to me.

--000000000000b2a036064c94fd35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d498e134e9bab9f6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tdW91MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXA4Qy8wVGFsT0dsVEpMOWVVT3VXNW1GazV2Q1NVZwpZVGM0S0RGamli
ZHVkTmZTN1EvalN5QWViNHNDZ1hNdS9iVDlabDdJcUZYV2dzZDlGQWVpRVMyRlg2VjB2MTZVCnc2
dmd6eGpibmFKNkJDdkw3MVloeTFyZW9kbTRPbFp5YUpGQkNrdFF0aDRUeE1SMWNoMEIwdnR2M2o3
RkFiNDAKaXRqUWNUVjlqT2Y1cTZDTHNUempFWHZ1VkF2UDI3Vm8rNVJmWU9IK3J0VUJLaHc0L2J6
Vmlzc0VCNkVWcFJBMApVUUxHRTFVL2ppY1NKOXRTU3VDM0pGYmZPUHUvYkwweDNNK1lnSmNOeXBo
d2JCNEZlWXFzQTFLVFV0SFpQWU40Cm1uNlJuT3BQWi9FbG9kdDk2QjVySWg5UWNOYTdza1RqY21J
bXF0S1J3YnB2Rkt2VTFZRTN5bys0dUphRXl6QWYKeC81czdGN0pJM3lIMEVtUDFPUndwalBid0lV
bDJsYXEvbTRLd2lEanJzOEQ0ejlESmU0SlAvNmkxTzlSdW1LaQp1aGVRNnZ4ZzJ2ZURDVTdub3Rl
dTM3bUhGU3FqV3NSZ1hXQmFsbEpiTWtZWDJLS3hKK3RZdmdwK0o3UE5meVhCCkdoZklmOUtpZ2lt
VlZnWllucnJ3UE5wSTRDanlVSHB5akdadDNkVT0KPTl2U2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b2a036064c94fd35--
