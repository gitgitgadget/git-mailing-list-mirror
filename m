Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034F38E133
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156914; cv=pass; b=unq6iYHcqLQHjzu8dHOuePnZX3VO15+R3dOmR+P59N7rQgcl/UgKHP4i8YGWnQZjn0Q1CTNDLDL9RZkTgY7OIvlY/GrAGPTbHCvMtT6UOotx36xBkw2N0FPlmP3RnH+HmrpanhDky62mKeSQ9fO/xfsFTv4E/MBfoVpDNG4kn1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156914; c=relaxed/simple;
	bh=Y0SVZUQLC3++4W2mCj+vVRKFonx7FpR5qK0dQGkEihE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ30CANVlyreAAK7JGkKxx7aTRtFdlbON1GSMpuYdO3mAiFaJN7InVflQn0QPJXmhvVv6C2iSzJpxFVYuKYcTqI122JH1VlA4rnCOYRa2mMWb/gJMvOICxkwmDV4tMh/97ARZInefxQYxMMy7EiY13idhM0NYRRjN05pxbI5A74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXHMmVAZ; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXHMmVAZ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56f6afbd205so847217e0c.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 01:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776156912; cv=none;
        d=google.com; s=arc-20240605;
        b=cn7Rzr22m/n8ZYC8BfXBtA94hX99GA8cAN/XN2p2k5w4CuKaCw2mwckb+xz7pd2/Ec
         Dh6kyCRz2MLF5xaSuGiGhEk6rhw2eE5ezNVIwqFBED9Tvd7ZUJIE3jLsi/Vbby57puiJ
         F37vx1G9d5gB3hecXWC0s5S7LcW4bj+y/8rP109blwAftDhylpVXOio/FvJkYTkgZAL6
         ExtQ1lJ+oTITuguTaTrvZEREkcevODyi/YA/d32dIEFLPTJe2RQXB7zoykPZbfI6OCKF
         u6TVl6W7ydIYc6TowHIGTfAyQKitw3G235yVfzZte/X3i8vNFIML4VunrTwuekRKrIPy
         HUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Y0SVZUQLC3++4W2mCj+vVRKFonx7FpR5qK0dQGkEihE=;
        fh=9GU4be8A7sQi3vxYjExjxp8dS1BI9hZHP9Yg2E6cVao=;
        b=jIwpHmmPJvUeq23dogpkR5hkM3oDjbue2KHxqnWf9aFKLYQmG/9AmSWAWK+BhoEX71
         4B563B8wNXvFZenz0jeFDaWNBAzz0zmFPLuUbE8VJizXWP00s5J8qP0S66/6I6wd6ymb
         oSBJxdYg5OUj9kTc8YQ2b0S1B/pkd4r7sWKdp5rj7UyQt9lKfRrY8mtPm+0VQ8opcC8C
         Yji9xVjyzUVDbU87r84aaUlkO9+x/1bybD06yDBZWh6Z1JK7F/rz8S59MHTpDZtuQLJM
         8l8HI3s1+1s+gsKcJwZEwVXIu4JSBrcYEesipSv6MKIhJBF1of9ZAnbTBmIfEX2FluhT
         WGVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776156912; x=1776761712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0SVZUQLC3++4W2mCj+vVRKFonx7FpR5qK0dQGkEihE=;
        b=OXHMmVAZtDmm1xmpGBy3RdRPNkbkLA3DLQeZI1DlDk9VGVAcQGE9OD+loS8WwyM1Vn
         4r9OSGbEzgqy3NoNG2tAQcYjupaWD0WX7UIOjzczuBMjFov855/sbrkLLdt2xV2giqIZ
         Xcmy9mMf9fylq98w0UpIp3PAwDMoUureU7G0LtPQQ8+LV+6UJ+cMRbbQXDrlK33LjNda
         7qWZjSOAIHoJKy2prMtMSHnGkoLUwaISlU+hOBS9S1G5GAaKOZYNpW8RVMX8+gh+IYY3
         KoF2hL4EzTQzSsZOtwKc7oRVCRA8dCx8/fqm50lQ4S+RtbgKP9qkZxrNPFrhw7kkQ7QB
         qLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776156912; x=1776761712;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0SVZUQLC3++4W2mCj+vVRKFonx7FpR5qK0dQGkEihE=;
        b=Npmc2gon4cHxw95Jn5/ZhKjwXg5Gd/nM/Isgy9ybpLXixz4/zKgwfS3sEhz8W6kE8l
         YQpqmEmixyeJQH653YEJmBtawaD3cl7VxP+Nr4RGQDsrysNz9aR1EWCgx3hbqBi137o9
         UZeXptLDpBdzoLhBOMShBbDjLlWsR+NwvmTi7oYtCLVl3sKMvyiO7yhBdPqKLArUAb39
         zgeQZ+jhSvNoX0NGVnXI6lT6wShuRmoLm437ePvNyVNbsptRR3qi8Yt36MdkCl6STe55
         DzdHplNmsxS/AuITKH2xgTEJO8pN5Ntl1nnwYfX16wLfUFFRvMRQ8Ku64t8pnIsyskVX
         Qqrw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ml8Sq/Lqh4KdeYJMDEThJLYV883Tmgd//9Pbfo+70SLlPJuGZHySm8PEMpP2tTbERWsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBI5QimQvwgOeCR5f96AKl24gLlLrTSO9ftPHCNXLhH0jLgsD
	CtK6SS8eXbNvGbKVk8idIDwqHUJNYe+020Pc2g0Ft7xguBtvRwP+hD4xkzCwx+8ul0zs649aEqj
	Zf0nk3NAYgR+HRt78UqXyVHJ/JNblZTY=
X-Gm-Gg: AeBDiev2zeYL608eW5a9sVH78ZY2O1q1AdJ+XJm6RXu72X80CPWDOImZt9ZlaI90EEx
	hsgSUDWokRHKUSQ4QIPuGqadfiV6ZtSdCm/cPrz52UNIfQmd+xE8hf6vAmmlJUMIA9g767LzcDU
	44OmTJDYKa6ivN623DYoO7ID3ru4jqdsaBQ+WzCnnXPbFJBk5n+UoUtjyOJvKYKXwYJzOongx3E
	xntABD3p9IxAeUxq064c6leAq7KuTZKsb9fkATq2uTrSI/S1gM7qaoExRKfD9No9KtjymZjTk85
	8j869qlU/qdUy9xK9ix5XOIysUz/JjSISiVc63eJRQ==
X-Received: by 2002:a05:6122:22a:b0:56b:72f6:1b9e with SMTP id
 71dfb90a1353d-56f3cb33a00mr5554736e0c.8.1776156912277; Tue, 14 Apr 2026
 01:55:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:55:10 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 01:55:10 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324123750.157143-3-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-3-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 01:55:10 -0700
X-Gm-Features: AQROBzBX48qgb4Ov73xmBJ6-VbZAaNZuWHJV5ltUmV7Q9-6lgkyXlj27veDl4PU
Message-ID: <CAOLa=ZR3=pDXZt=vM9cSMSCc1NfWdwjde-Y05EvYfNYnr1KJMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] environment: move "check_stat" into `struct repo_config_values`
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000d279be064f67c178"

--000000000000d279be064f67c178
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The `core.checkstat` configuration is currently stored in the global
> variable `check_stat`, which makes it shared across repository
> instances within a single process.
>
> Store it instead in `repo_config_values` so the value is associated
> with the repository from which it was read. This preserves existing
> behavior while avoiding cross-repository state leakage and continues
> the effort to reduce reliance on global configuration state.
>
> Update all references to use repo_config_values().
>

Same comments as the first commit. Rest looks good.

--000000000000d279be064f67c178
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: afa67fb89b3169c4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZUFPc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0R5Qy85ZW5BYVg1dytRV0pQeThSaFhXV2FQM1hJOQpYdTMza3BrbEJv
V2hRS2M2aTZTSDZEN3Z0SWgxSE5LeUZodDl0T3pXL3B2R00vbzJ5MXA5NWJMVjR6OGdudjY2Cjd6
QmlhR2RiUnkyemF5dEdRTzFVbnhJckdIOHNIVTd1VDhzMm5idVdtN0pKMU8xdTlSQ1hWR1FTRnRZ
ME9TWFMKeEhDNWluSThwaVdzM3JkNWNMK1BEdUZZV1ptbUZ1Wmp2cG5SMTVXWWlocllyWEtuOTNJ
OU1hNk94aEE5Y2g0bwpGZlo2WEJubHBrVjEvZ0xKQncxeEtVWmlLZEpST1YraTdOU3A0TzNPSGE4
VDdKaU9ETkZwOU42b0tBOVR3TnpuCkxHQ2ZNRE5lK2N6MGs1SzY5N3dDUU5CUDZxU2tBWHdzTnRv
MjJYbG0wZXY4SW1FaWJJdTJ2bDNsWERBdTFYa1gKWFMwaTUzU3dSbFEyVzZZcUE3YytnK2xnYjRi
NDlhNU10b3hLUEMxeDd5L01adWRKQXRab1VPV251UVlvWlpHagpjbmFzTDB5WDdKdmlnZU5RNGRu
clY0QnNLVHNOdC8yZ3M4b2hRVEFtcTJva1lJOW1GUmtOOVh4M2JuclRoc0J6CjdtQjFSekx5M1M3
aHdhUzdmYjdSNkV5SGd0aU9zSXMwcjBFR3Rucz0KPVYwRTYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d279be064f67c178--
