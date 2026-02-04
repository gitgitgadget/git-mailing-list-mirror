Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50F3AEF42
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200288; cv=pass; b=ZfnLrJ/ysdg4B+y3aRZZL97Y06FFE9GsTKC2FZ0A4VX7UeJxbY3yfdXxuIQQvDsde+c3qevXiO9brHRxVjEVNApfPR6x8+xv/hUK2IWTN/VWTLFTPs3r4AP+kyXPiTJzYCSlPYc0Z6ODQjOfOB/JdUJRInvRTy1rcQ1V/GxAlDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200288; c=relaxed/simple;
	bh=DO9c4m7jvLKt8e+ZKcdOiITwSKt0xrYXImTzW26VzjQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgY1bAj/aXUfCtw8LX3+iJlnBIIQCRIr/bIimk8M4tnehQ1GmWat5/fHjhFR9vs8IriT02FVY+ZcMNtA3Vo0tUPjY57psrdF7QKm5uo3oHB55CsYrwtcF/WymoaNhE+HJ0sEKplRZH/giRlnUqErXtNg4MVnZo7DY9DJ98pbFXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsZCMfm7; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsZCMfm7"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-560227999d2so2491201e0c.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 02:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770200287; cv=none;
        d=google.com; s=arc-20240605;
        b=BfGwRmw9JFIIstvMqLARbeF0bHNwXEKR4YPFR9I/1PDc0wCVW9pCRqUF8O14N0QJcH
         31PqNeXSbbWXTlvQVXRibObjLlXgrs446ixaqSBGlvLuVsO4hRI/fY4FNp7t0tz+SNvs
         v2uxI1VtRzP5+j2Ia2uA6AViekRg1oe9jGBFr1z0PiuvYOr2Jlcem8feQwTP3Dyz0Rtt
         zPfofCIX9at8B4pWWtsSj9nBiTLYkEXBRNs6TFXvVNWOenpmlbzipy1f3eni1lLjpqBZ
         nPb09e0AJtEDVgvzH9vJsjWC2dfdVOOB2X+pXCFyLPeZ+HowQHGLhSFcQgBMjUe0p0Pz
         ltNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=DO9c4m7jvLKt8e+ZKcdOiITwSKt0xrYXImTzW26VzjQ=;
        fh=9uWQBhZOf5QottMGhU9fVrSzLY9SYKUGFgYu0Q6UzUQ=;
        b=Xjh/Ufawqvc4B2T9q7LwPfG0pLKn+uKmVoraamawDnlx6wbTlQjCuMPijSrXI+dspU
         Mw74ZjxZ4cT5pPWc0/Egl1xsaLQOSIedM+4s30GmHeIpBS5LmKKiGhhrRUp861UNfDMs
         pmpYy/q6seB9f5g2LOSAmT1Clm2yt8I/jJuzJeb95IE+FlsQGAxoUlo02po8L2+kximu
         aEeT/HCB2o8KAC+n1yHIuCVEjyE0jofpL3og4bvWH0iig/PyebKPPnTlf+BQ09oFf1ID
         IxulEovVT02HFt4qFpwXyQ/A1mcmygl7GjculKfD1csejB+/GFONjUQx6KNjob9Lwki1
         hesQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200287; x=1770805087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DO9c4m7jvLKt8e+ZKcdOiITwSKt0xrYXImTzW26VzjQ=;
        b=RsZCMfm7Blfz80ixRp+bB3FAAS0g0bvVcDHH/V0AYp+xV0xH+s/QSWZsieDOBMB6Zc
         6QBZqTdcrd//gYMXaWR5NS9mEzqpPyzgkxVq8w/DWiK+DYC/EvbpS2eKqvw4osegzFDC
         sLS8OjQ3zT0AE1UI9aVAQy8TMwCu7IfpLHXrhnwFhjQbSEr1iscH/wOMbr5sW9Py/dRr
         iyrdIwYB1vB5Uu4eeDrrjjJ1A2ms62W0sa5B1xOvahZfCqCLKKE4GWgPpYffGAYHPZSn
         LOnMl9+m7oHWo2K3AOFULZQjVTdxqCv2qgZVcKfk4VszY074sT3vanHbgdntkRgMjGij
         CFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200287; x=1770805087;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DO9c4m7jvLKt8e+ZKcdOiITwSKt0xrYXImTzW26VzjQ=;
        b=Jt0FGWIUBakWxQ/CS4S7hrWJi4LUkfM0aWXmvqxktz+RXRMogJwHzLN0F4BuzWK0bQ
         EMOTNonlFPTcegWmVrULSYMbL4J9uxc8R36nwuYxJimQIgfWKFozHS3KgMRUBcvE40AP
         8UNsbtD1Rr2x6ddAbsXrScibXvPVeB5gykaKB+M7bjGJe59Jj103GzVMNe9bMtosFVDc
         AWDa8xob5l/ByPwtN6Mpja9eHEqVWsEdrn3R/Jql90ziui0I5h7a+MZtup2G+1nMsTKQ
         o8fpqpTAkm9B/syAIQcUc27n/iwjQP6Y+RjebcIQuvA+9nK5vfo4FaOBVDs6h0BPml0O
         /y3A==
X-Forwarded-Encrypted: i=1; AJvYcCW0frEuz40l+AsD3N0E19Q7ukffY7at6gCi8uxgui0uMiNFcp9wC/ZaNKMoR75A36tSgro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNqc+7hLOCxaIC+bnUGC54ERM6SWggpLHwOwVqZ2plICXPezo
	g02KB0I7trGwKiok02z0e9ZAwPIMj34UHSnlQHmYfW2povDb5+z7sXkmYDKjSNZY5oWH2M1EpDi
	TPIyTZ7HW0M8QIBsxDPX69E8oC8LX4kQ=
X-Gm-Gg: AZuq6aL6x0wZDxl/d1+0uYmXv6uDySDmQeaQbB5pdRaasl+YzmCj6uIzxZqDkt2R+ss
	jEUgfk3fjY9Jy2dijt9+eEvL6MPm8A1IXnP55iKITReBfixSJmoatqjPl3lQf3SBXRz4GimJ5NP
	C1yckyOCOFEoUgvFPQNH7l9poDEgCvnBPNqQGwnbCTNyKfgfHTlYcs+lpY7YR6PDf+db7Sz7tkq
	cYxL7j9kq1Q7142OFYfDQ3GbR5MneXfaN7tuANba3OeDcGmrMfabUhimMhVPfVH5QfzwMVkqXaF
	ZQoLDvw503rFhe7LR3MQwS/PeWNPgA==
X-Received: by 2002:a05:6102:e0d:b0:5df:b5d4:e45d with SMTP id
 ada2fe7eead31-5f9395e2250mr863432137.33.1770200287317; Wed, 04 Feb 2026
 02:18:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 04:18:05 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Feb 2026 04:18:05 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260202190458.81443-1-shreyanshpaliwalcmsmn@gmail.com>
References: <CAOLa=ZT6ReeaPvJiNh967Sn2p3K8sQKEOOMJ+6-7ZdFO+wr8mg@mail.gmail.com>
 <20260202190458.81443-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Feb 2026 04:18:05 -0600
X-Gm-Features: AZwV_QjP8klTJHYuhguEqpbDbygZZa7HxDI5Cs7lnOThApBocA9jVeZBZyyl4vY
Message-ID: <CAOLa=ZS3MHhHQrD3yJfZYfaO_FRdjcXQ-G-A+tF4=e6xmABjow@mail.gmail.com>
Subject: Re: [PATCH 3/3] wt-status: use hash_algo from local repository
 instead of global the_hash_algo
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000004eb9800649fcdf28"

--0000000000004eb9800649fcdf28
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> > wt-status.c uses the global the_hash_algo even though a repository
>> > instance is already available via struct repository *r.
>> >
>> > Replace uses of the_hash_algo with the hash algorithm stored in the
>> > associated repository (r->hash_algo).
>> >
>> > This removes another dependency on global state and keeps wt-status
>> > consistent with local repository usage.
>> >
>>
>> One final question is, does this mean we can remove
>> `USE_THE_REPOSITORY_VARIABLE` after these changes? If not, why?
>
> We cannot remove `USE_THE_REPOSITORY_VARIABLE` yet, because the changes done only
> remove the direct use of the_hash_algo and the_repository,
> but 'USE_THE_REPOSITORY_VARIABLE' is for all the global variables
> that are still in use.
>
> In particular wt-status.c still relies on the following globals,
>
> * core_apply_sparse_checkout, this is already being addressed in an
> ongoing patch series [1], so I intentionally did not modify it.
>
> * comment_line_str and DEFAULT_ABBREV, these both still are used in
> wt-status.c but they dont have any local instance in wt-status.c,
> or in any other form.
>

Understandable.

> Removing these would require a wider refactoring (adding in struct wt_status,
> adding helper functions etc) and I believe is better handled as a separate patch series.
>

Yeah, my intent wasn't to have all the cleanup done in this series, but
rather to ensure we have enough information presented. You've already
explained the reason. It would be great if you could add this
information to the cover.

> Though I require some guidance on the preferred approach for handling
> comment_line_str and DEFAULT_ABBREV going forward.
>

Happy to help out. Generally using an RFC patch series generally has the
best outcome, since it provides material to base discussions on.

> Thanks for reviewing.
>
> Best,
> Shreyansh
>
> [1]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u

--0000000000004eb9800649fcdf28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e380ea339b38fe6d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tREhOc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzNWQy85cnEreFdFaFo3cndBWTVVSEk3NFFkMmpqTQpmaDFjNmhJbEdF
dDA3bXNGY1ptRTYvbFQ1YjNjeGFRL2hNWjJSUE4zajN3aHlueHZ5MXhjYjZ6WkZpcXJ4MmV3ClhD
d3VIRUtjdGZPOElvUno1U2V5SXFSOUNWck5RSTdROEpkeFp6VmIwTmhwUDFxQTVkN3FlOHpjUUtN
SDVGY24KbmlYa3BkZmliS05ISU03WkhQQWp1cjJEOEVENGxlQnQyNXEvRXV0RTkza2lwbW1PWm1E
ODJGZzJhRUhIVDBJTgppU2Zzc2pNU0lzeHBIOWNZMGZYSmRibTNPTXdiR3FxSlora3F6OElPZVpI
dWpZcXlmYzR6T1hiM2hvNXF0NVM4Ci81Z2t5OWtQcC9Eckxvd3ZOcU1wUG1CSDdGejQwV1BuSTB5
aFZ0cmpEZktTMVZFMzBOdVF4cHN5VTd0UHh1N0kKOHZXZzlYUjhHMHN1ZWNCSm9BcXJtT3JqanVr
ZnMrVU1DK3h2dTZvajdHT1prdnlZMzVSaXhDcllTV3pxWHdwcwo4MDFPRlVWVkRZS24zOU80dVhS
eWZualYxbElDenpWUDE1YkZ3S0FKOFB5SmQvU2JKYjJ2c0pLclBCK1ozMFdpCkdkY2NDNks3c2tY
WnBiVTZBdmVyajVJRXFUczhNZkV5TjhVODVlOD0KPU1vaFoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004eb9800649fcdf28--
