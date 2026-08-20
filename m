Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28484749D6
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787235304; cv=pass; b=Z37xx4hZNThCNitlEGZy8hb4cmJ4e57TJh0UZcLh10nOsw4jNMa4pNEp7rvWqk7spvzD4+aN8d3itvL+Iu0d7HAuVNa1j65RqOq6bIw8trkLpLHlprAXv0LZBIHlL4anySenH8g7gHZ8+U6W9K8WdrpdFflfBKyjKhEZXzemIQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787235304; c=relaxed/simple;
	bh=dAw8fWIDvctTG3YoeEGFVI0SpXYjpLS0Nry+oh/YKYs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXt3QbWTGgXHrYB8sdRqV+jIzRvu79P+KYi4lWKtGIfaIyF8w5/5H5hK30SVr38pkfObaO52qbP8bN/rgvLiehzKsvz/GdvMbS0/AAjGAgUe6LRJGRkU0WIwj/0/jdEg/+SQ1cDEwu2fBQFkFue4U3Iubo5PwHSgNq+XeTWE/HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW2N2zH+; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW2N2zH+"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-777ae5e5caeso829811137.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787235301; cv=none;
        d=google.com; s=arc-20260327;
        b=HMKUnXvdmaW3PKaidtpSA6f90aa0bljA204d5y2Hj3ha1uGRfe5e2H6OzKiIB0GwUS
         d7wNV5mw1PAeXAZti+iH390tIayvVUvA8VMOsPfOUiEwpbGy2zJNMiyy/es3D7FsM29Q
         VqoJCHS/WxahGytZFSObV2a5kuNufTU97WwFUd4OxBKNxiTMAafLTX4Jfr2PrrNS5fKV
         wmAcDOMI+o2agA1P8K5kwyCBmxhQ8p7E3HXy/KrMthyr/kz9Zq5Xij9fJCZ2gEkyny+g
         EhYczW2oBaF7KGAlerxB63Gsn5oONRd0sD0nNP4q+Wl156SqOjUTnj98Og7D3Uc+p7Sd
         cgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=294oSSrLtl5nYu/jMtIam7QOn5Qnd1bBsXyaSDqpNRo=;
        fh=Xh0GKgdmJuRT4bb99oOjPvuHnyuiy8nwcdgehmCIW2Q=;
        b=rQLb4H5tVTGax6le6mF4fCZHaMG8lEsuuFC6yYcLpo4G5ni6+ka2lvS6SD5P5w27Qj
         beXFFhym9aA+Hs8UPGUVcY5ohyjZPZknoEMucBW/xt/8ONP3skG3PD3uyd8XD1NaNJVO
         ckU1mjA0qk2/cIOCMAn7pJQqg6XehjPBwWt7J/r399Vz+b+MrAOz3RycmlIOFzV4xdEI
         BrymxFgMqPtThtCsyHWnGzvk7cXgA7C/k+UukOnZ/SYk8bzg+JGnPAtwa3Nuh7HiJL4k
         B7rqTJE7RXYa7vNzmB+eane+PSYA5Iq+VqCAyWDUMjsbkBd+p92DtiZ2mfLtpm4Gn+sW
         g/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787235301; x=1787840101; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=294oSSrLtl5nYu/jMtIam7QOn5Qnd1bBsXyaSDqpNRo=;
        b=EW2N2zH+GqMtYlkaDjbgiGKsLKRhZGivoiei8kXE3CzWZ5AmzdPKVGxOiIXzndtJtu
         DgJjZ2zV4EAsAWwnBkMJiaa0cGoHr1SGJ9r3PHHKLfmZ/XE219SdiFYLj7nkIU6IFiMq
         eW+uSx3WhMYZ/lhhyf5rL+zPSrb6oO2/m2NMLp8PSzX0ANuFiwFTld5wBYQAFbI+CtWy
         syJVmXHrEDaWRT0Lw4JIa/hlwPmzfk2lbe1iiNFSfiynMRQeYCmxV48G/Tp2AD0/jc/l
         0r09vyyFbRlJsRmISee1AObwTbQz7F0IrhcdSIMHZ8w0HpeLnoEQHZg0E8nHHOyr70OO
         vgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787235301; x=1787840101;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=294oSSrLtl5nYu/jMtIam7QOn5Qnd1bBsXyaSDqpNRo=;
        b=WOBBrMqDH5zK71cVjQ+s0Hkfn2LDDc7/LX3XtnP/G9ga8MX7L1dfJcNfLe8Fy+ASrz
         adAWn+tlhgmbKaXYmlswrLsb/YthvjulFw+cp6gmTd9gqPhtHoL/0h8zjcRGnkFelF/9
         wRFfUf78ivIzHYyo21pDOfbAUDmn5JcSCzoJn9oggczZKMEp3pw/NiqDmdu4lXqLt+sP
         Xtmq5/gkujLzXXXr+tmENaIBJ1MsJvFjrj/ElxUbnswswfSUx66DXMfAeRIM2Hj9KJv8
         s24mRsUxW43o0Z3lrrMXH3I73HgQRUG+jDzTLpOQ83zIo+YoIWMv5kxK1ibl7RI2d4SL
         priw==
X-Forwarded-Encrypted: i=1; AHgh+Rqx9z8xTu6+HD3F30tgf5vRE8Ib/TLrxUTXMT7MBK50OrCWtW0nnY/31RaxCh+bgLBvNYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHxEG9wRs8RjHkFBNFyg86uvL2MQo5jcIpvvCQeDHZrwzFdnz
	3a64Veun5UP+0KRXWfQOzuTIsm8fhHwvDNYQaNc+KrCp4UtALEPWv/sxz3HPElbYLJ108WAVFk2
	/LA7AuOhiu6EbmNFtny4v7wB51NLuB/q72XEz
X-Gm-Gg: AR+sD110ZgqT931XikWPSYBdLreOoucn/RVWF8NNLs75wUyX+EK9ViRURcv3CGOTE5P
	UJVOkoTRA2DJpMXMCygZFi48+/Iwh6LYX4Xc+K2pAfp3F2kKWN2rdnrNuPXzQhtkGaHSbOFFPhY
	oMVgi+YlTAW+Ml3cFYJqzAh2QQrF85QpFb5IOaV1b+tEWSShL3AOR7rhuNbRmfA5CCQUPJavYA6
	pQKvrP0gF/zSgM2EWsBSHzZKoENB1Jo0kmug5vGSiHFBacmeYj7HFnexv6QfdZMoPOl2XmfN03k
	OWILdJ6KhXtqERKTO7d0RzZ2ns4NgExUSSr1mUoA2Js7mDl/uqx7d8FmqqLGVp/opfZKDKaoVmA
	8CBrQPajaDAJUMv+E9auqWcbfwbaB+gmo4qad4aOR8U/cLQ==
X-Received: by 2002:a05:6102:162a:b0:777:dd3a:87df with SMTP id
 ada2fe7eead31-777f5a42114mr3982701137.0.1787235301339; Thu, 20 Aug 2026
 07:15:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 10:14:59 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 10:14:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
 <20260819-pks-odb-generic-corrupt-objects-v2-0-a984e3a0ad6f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 10:14:59 -0400
X-Gm-Features: AcwNN1W0jQ8TqdBfeQIaNwdujrHvjHNreygtampkqXqn86Cm94d6Q9m3FrHJ-JQ
Message-ID: <CAOLa=ZTVxdVAJynKjb0LjmZ-+b5nQmyD0Bm-aT81rOOdJ0a5yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] odb: handle `OBJECT_INFO_DIE_IF_CORRUPT` generically
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004453c706597b2563"

--0000000000004453c706597b2563
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when looking up an object with `OBJECT_INFO_DIE_IF_CORRUPT` fails we
> want to die in case the object exists but is corrupted. This flag is
> handled in two different spots right now:
>
>   - `do_oid_object_info_extended()` calls `has_packed_and_bad()` to
>     check whether the object is known to be corrupt in any packfile.
>     This function reaches into the internals of the packed source and
>     thus breaks the abstraction provided by our object sources.
>
>   - The loose source handles the flag itself and dies directly in
>     `read_object_info_from_path()`, which means that we die even in
>     cases where another source may still have a good copy of the
>     object.
>
> Besides being inconsistent, it also ties us to the specific backend used
> by the database sources because `has_packed_and_bad()` assumes that they
> use the "files" backend. Any other backend will instead cause us to die
> when calling `odb_source_files_downcast()`, even if the object was
> simply nonexistent.
>
> This series fixes these issues and makes the check backend-agnostic by
> extending semantics of `odb_source_read_object_info()`: on the one hand
> it now distinguishes whether an object is missing or corrput, and on the
> other hand it starts to return an error message to the caller.
>
> Changes in v2:
>   - Adapt the series to use an `enum odb_read_status` with negative
>     error codes exclusively, as suggested by Junio. This results in a
>     rather big restructure of the series.
>   - Link to v1: https://patch.msgid.link/20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im
>

Small questions from me, looks good otherwise! :)

[snip]

--0000000000004453c706597b2563
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26a7c8d996e3561c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSEMrSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVl6Qy80czNJQnBSTDgrci9lSlV4Rk5sbHptTENEVQp2SU9xWTlEc2Yy
UzQvQTdia211VWs4RUkwNmJWenF0T0x0OUthbmthMEwrOXZyVDN6Sm1taDZUV3FicEdZUUk1Ci9a
aVR0c2NzWWo2c0tOclRxSk56alp5VHJ6T1RRQlErSXh0MzJEUDNUeE1yblFzTE5VaHpuTWpWU3dr
VTl4Y2sKWnl1UU43Vkw3VUxhWG5tbWNmR2VSdEFvZFM5S3F3eGJ0c3UwTTFzRW1vV2drZWhCNlVs
RDU1THVSR0lZVkhYYgpuWE5kdndnbEszelhFdFo1OU1tUW9ua1FqVWVmREhjdFlpRUVCTnJGbW83
QXlqUWZYckM1ZmFESk5GQ1ZCT3drCmFOOURBVlIrVEdXaWpRR1RJanRFWUkzRzZ2c2VHYzBpVkI0
cmNlK0llRFJ1eTRIeXdlTG4vVGFsMnZSNVFzbTgKVHZDazNnSlNkeitoLzFERE8yL3gyMitBSmRy
aGd5Z1FuQStWcmZ6ODhKc05vL3BEZjBuUU45OFdhMTM3TkpDOQoyWmhlTlFabXAzbkEyMWN3TWlp
MEY1SERRbEwxallDNVpxKzRma1NLWmlNVVpvUVc4WUNXS2Mza2gyZXg1QmE4CjhvUVFmaGZaMFVo
RmM5dzlDVjNyOXNRRE4wM1dzSlZRV3Vudks0QT0KPVJ5S0gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004453c706597b2563--
