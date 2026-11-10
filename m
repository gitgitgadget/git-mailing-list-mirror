Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316425;
	b=yd5nOlp30LvOjC5Lq/mmwupgVKC4o8D+TbR1JWjv5siyvIHuvM+oClN5EU7D5PedK16X
	 gRwOB9YUNKlrvd2hxeLSRxqS9/Ken7D/nr97w4l2yfgYyq4+kVDcxUd+nYE+Byvt6p1LS
	 7uzQw30dKYrx5NXkYy3ivbMfZaQ2A8u7mZOP4Em4eIVj5b+vCkZbVycL/afBoSgN2mBVw
	 Vl0F5N7XbKRynO6FtiFDsjVskpn4kmPxlP7LdcFqxUlacFC+idwMgtU9ch0lc/U5nygQY
	 NsrlXY1ZkGksNDvCQpnBPry0lhiA2GaixPKVmICukNEu7jU28WXaVChn1ulJKr23rhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=s9fOjXI2wO/jLfxFFAeVxWwfpmimYJdRaJK4HSB/COc=;
	b=DnWckP6gWnN0QjJ3FCeh/GmiHZR/S4eHXlS4Bh3QMcAGGjxpjiMh/leLkKnIwSQl4PjZ
	 fI9L+q1tbVBYRtJbCxtipooLAnaT/KDZ+XEfei+RemxTQJVi3Flh8co7wqgwguJG2kd3H
	 ZdyuNmktffZBQETDGZdDl73m1v2coL3nYVIlS+TDvcdnAWv9K4c58lyBwzci5sC+dXzVY
	 tyXFI9amElviBrCITVu9YUR4PjKbR46zLvu2AQNvoa0rUHGBdIS5R3/223+loBuXJdkt7
	 GD38dOeTU3ypLSf9mDJgTaluvOhqY2LWNLhTLWpnrasAvvv/pPdeRimu5TAeAtqzp+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1FASwvl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC85606A760
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC85606A760
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g1FASwvl
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso1345510e0c.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316424; cv=none;
        d=google.com; s=arc-20260327;
        b=ArS7PA69uhpToo2aO+f9AnUQ3wbEE4AptBP4rJzUd+j8o45TSwbjYZS+KfuqWFOzrW
         qELT3HruNObie+dyR2IzgiCcBLpj2l5ViZH+8csLB25gPxesqCjrbxM0/3U1S7T+geEL
         jn1eNJLVX6plzagd1cdOrHzK9z0sL4u57/qrm/bQrn4ub4Fv0+Mnu9JmtCp2n6OeuHq8
         zDa0BBcr6hKmleOoCIz0trOq890mKo2ZifuYsnLPTom2VPbWDkdjh3YS6jZw5iDWNPMX
         NEK/QoccKcyTztO6BlfjEHsBkSvPKDXVWMDblb/q+tX/oqjx8VvcR6uybXqDzt9f93j4
         4EEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=s9fOjXI2wO/jLfxFFAeVxWwfpmimYJdRaJK4HSB/COc=;
        fh=gxcvO7TBd3GRkZEzrTMRQ4eVVo001NfL+KFW3jJJRnI=;
        b=B40Fp5ZeIYjVlCToxckP5cfuX4WudgTacjPmynlVEF8/aJPCHK919ZFf3OhjDdgVX9
         6DXq/gqHgreeNtqhk0xJfFHdnCAD2HpHU8CAbXsBOqMTvrfwNqrV/Gem0PbhWIrcur4K
         +ezpNQLcYdDVbHcj3+M/K/j4tcrm7XQBZKd0Oe9qAO90IFmknoi8Eu2Da3D9N+2ymKMo
         /ZBbLJ4ZtW+OEsUunYYz5Pp0ft7xagnr6voLGH3iPZlWawf56DMWqXrf7CNkBXq36vUf
         msUDDQNGXBvWRMPBJXzdL1/ytxpW17KhGUQhYHmCycuZ30HfUEY3k18ONtp2PwFX62hP
         nWKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316424; x=1794921224; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s9fOjXI2wO/jLfxFFAeVxWwfpmimYJdRaJK4HSB/COc=;
        b=g1FASwvlvLdYVn7Uodh5HxR//yeFrlXR3ltPKoKkmJzkW3+hrFl3IIMfq31GChNfp4
         kZs5f+pcALmINbaVUpAkHH2BKkC+PSE2RhfO2rIiXgouNcmZJdcjDHfR/0hO/X3OS+Uc
         UdD3jqP2yxkclWUagCtAkKrTAEPWNqcIOHpRxvCbo/KktlFP733km7MTVHXaHFLDsfw+
         b5GPttTjaS7NFcbsn82PQzHiy0asaCpCZKrh7tH/6ofAHJ54DebvM/Bo0Tf5LusdIWnZ
         BWPzBnucSIALD7ADmQdtV0vIme1xkoygp0r2PdrFLl+ecAOCLplCrfLoQVaGavJs3yHS
         88zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316424; x=1794921224;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s9fOjXI2wO/jLfxFFAeVxWwfpmimYJdRaJK4HSB/COc=;
        b=2Xs7grOBQvO6mSfZaLhCkD5/NInpqCzC6JcM7SoKkc+ZMo6dBPgOc4SK2u35e4xSDk
         5etGKTaxA2GvEKz6/Kc9cmOwXy4wCXVGGhGN1buScJL3LBEF5aNtdMmSb6atocNYats7
         aokqTKeot6Ag9eX84Ax/kKVXiocT8y/2bS+GngqQDxNpyU2mNS41T7BnlKxRZ4qVVM/9
         pl92NV9b0xXxG5KQI3On628Y042aNNdkJsBHcgGOb5pr0dkpe7sQsBreuMwgBhSDhboG
         irEQbxzbq9NdJfLBdLKjn00KKAvDpYBp1C6qMe+sUkd5D48ItFj8nGx5NRBALMWAf6T6
         Ox1w==
X-Forwarded-Encrypted: i=1; AL+hErHxcHQrZbsy+Q42jnQodLJZGyfNX8Jofe1KXT82WOvBX0pqi+8FmWODh6DWTWRQdORSWE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FX42U/L08wCBrcaQwjEqnGCUTZ+DKoKx1mGwFNe0zmHBfJCUA
	EAXvLRsXB0/Xfn4a6bl553SFlGrWpzgUxtVNHTdCwniE523ScBlE8CyLEkpXFn3mcZW/9oEUS2j
	L5s2UBDw86TbYlka2djnhv1G6zsbPgxI=
X-Gm-Gg: AYBFou1bX6fJiRJ4TuwSbovC1RiIwAzXvoDqOx59YV/PCVfEeTW2voGTXqg+2UHxUYQ
	HBAim6jbmijj49Y33Lrtv2QpBGotsgFGesVaKUCEOFgsiOrmUGKVNEb6SjqJlt3vRm0TLNH13ZX
	hDruv/uc+g0g04yKnjktQznvfn/GXrmzSrcNTMtx91pyKyn2d3ftpVMPGmumEG967LeXDcCpJrJ
	O2PXKcAhWE98LCRdHvP4gyyoPSYlJeWG3yFmx+xWFZOtCf3pusi+haPGPZw45ckvDz6rl7FBpHT
	8F9IRmbMB2QSn8VrGyHfuEkD7qimOKZ0KU0pR4hDqf7GTm9B4X5S14j63mkMfavVEYJxE7nzP+v
	HatZuP0BYiU9ILfQ7sslXYkDnk5WL7nHhHEGaS5IebPPySORmouuav39xSMm0meWWU3TrazrxMB
	RBkR7EFwvdOkd4qPFSvWF9DBhWfRCy
X-Received: by 2002:a05:6122:3982:b0:5ea:c984:5ad4 with SMTP id
 71dfb90a1353d-5ee0cf262f3mr557367e0c.2.1794316424413; Tue, 10 Nov 2026
 05:13:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Nov 2026 05:13:43 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <4b46f8f0-4acd-4101-b133-8d4ee8b0ce27@gmail.com>
References: <20261107193020.583215-1-jelle@vdwaa.nl> <CALnO6CBarutmydfmHDM=y5yfUCQY5SxKKcoCrd0NXCuNVkDuJQ@mail.gmail.com>
 <bf54db39-d10e-428f-8c6d-b444f37cce81@gmail.com> <CAOLa=ZT_U+gDjdLYkbtqRjUxwHA6q6+Uk4ssznyHgn09xcFqpw@mail.gmail.com>
 <CALnO6CCfKsd=w1kVvbJ83WtJPbsH8hGcfZUUTE9eGqWOZeA=AA@mail.gmail.com> <4b46f8f0-4acd-4101-b133-8d4ee8b0ce27@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 05:13:43 -0800
X-Gm-Features: AclHuK-xW2aRF_I-dA0sWuukXLOW9I_L8CUDMmBI4u4jQxes6MZ8XXs7XxgAmCg
Message-ID: <CAOLa=ZQowi+fepj+RNegTZhK_Jy4G8VLE_Af2UdsO8-rCdviJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Support --verbose in git history
To: Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Harald Nordgren <haraldnordgren@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: multipart/mixed; boundary="00000000000017a040065febd9fe"

--00000000000017a040065febd9fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 09/11/2026 12:43, D. Ben Knoble wrote:
>> On Mon, Nov 9, 2026 at 7:06=E2=80=AFAM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>>
>>> My preference would be to make this (current patch) default behavior an=
d
>>> not even have an option. I don't see a disadvantage of having the diff
>>> always being shown and it definitely is a better default to have.
>>
>> When the diff is extremely long, or if the user has other means of
>> obtaining it and wants the editor to open quickly, it may not be
>> desired. So I'd prefer to still have it optional, personally.
>
> Another case where we might not want the diff is scripted editing as it
> is much easier if the script does not have to worry about the diff
> getting in the way of its edits. Personally I'd be happy to see this on
> by default - the history command is marked as experimental so if having
> it on by default rather than following "commit.verbose" proves to be
> problematic we can always change it in the future. If we were staring
> again I'd also make "commit.verbose" on by default as well so maybe I'm
> biased.
>
> Thanks
>
> Phillip

I'm on board with this suggestion. Plus, I see 'git history' to be more
user facing and it's always nicer to have better defaults for users.
Showing diffs and verbose information seems to be inline with that. We
could add an option to disable such output for scripts (but that can be
done later as you suggested).

--00000000000017a040065febd9fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b5cee77f626e62f8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yekdJVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmhKREFDQ1VLVE9YS0h4VGJJZVNRaSs0ZFJRV0xkUQoxck1ETXVML3E2
Mk1GRDVDZW1xZEE5S2pCb1lLNUM5eXNES1MwQTE4aGNvT29URHNveTFWRkxqMmxVVDcwMGkvCjF4
R0I0NC9MdDZkZkp0akxUcm5CNzEvUTE1eWhLaXpvUmhnNGJJK0ZwMlVPNkVIU0RmVDFpalFrbFNQ
YnRYNnkKMGpWWUFFc2lOMmhVRytvcC9USGdYWk1UZDZscnpibGF4NFpzbkFOY2xhWjZFTTNjVkpq
aFphUjFBSGRsZWJTZApra2s0RklLdG84bXZkdUMvWHoxcHFzVHIyeXR1VVQrb3hNQXJmbll4Zm1P
ZWdBZ3NlTkVjQVpROWpmZ0pvZlltClIySUpmRUd0QzQ2c2JsUkVyZ1FIeFAxampJU0sxckRHakg2
akJzQitjTXVvNnhlVVpKdmxsdUZpVVBjL2F5Z3kKTUpLMmpqMmZ2UlY0RkZNVHJJTUFTMUVOcTZW
QWdsM2xWdjFNWExsVnVCekNuN2R6Y282OTZOUFNkM1c1ZWEvUwpPSEVrUmZzc0I1bTQ1MGhtVnV3
QjI1TDVqRysvU1VvZE9ZdWhtdDFwQUlENzNJRjJsZ3g1b01VOUN0Y3NtU0xuCkY0VUUvV2h1UzQ2
d0pxMTJhV3E5RjZRSUZWbE1icUZRanNFZENoVT0KPW4xQncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000017a040065febd9fe--
