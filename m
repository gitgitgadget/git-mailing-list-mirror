Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B22AD17
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916420; cv=none; b=i1plk2Ya2vUUP/XlxuTe1hXdgBMr22vsPWHVc74/ePhI1b68d095H8RhtB65+IlzVBavFfkAiFIYZmJ4XIlvPl/fr8Q1JW3gfMgSKzMqhnsYsmlG0/sq5NaE8mFFHieUnetSQzRIoZofSg5gA368wq9KbTUXuTqMv6Lz8fzVh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916420; c=relaxed/simple;
	bh=kWM8cHoAEhc0K2tmysHNvCXfm7GNI8YdJjeRgeqtp9E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3gJrRelTDPyKVr0a9YzwFkWvPdyhp7pctENI7pjk8mx0XT7fRFW6cLFuIiqHNHkpBk0P1BECBDSFQZ9lOekvqDms7iiTvCx/CBs7PK6Rx+Y971loN6woXhbnkaE3R1sOGo5n4WeoCpr/24dzM5K6xXN5UAjUkJ1EYPfz1wYV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTp9IH2l; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTp9IH2l"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70224a923fcso89733a34.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719916418; x=1720521218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3xcOIReju24nk7RklPkxS/vRHbT0P3DgAG2ql2jjDHI=;
        b=BTp9IH2lQAM/xOPc6lCzms4qsg9OwL29/gjF9zWAnv3ltZ7EqnaawRqVZGlTUf3OcM
         JQVkfBCYlCoM9BX7UUtIl+hddHX9sz5kKMEpwqIc9Hs9qdfAC78myr0mbXbLAUyMrU5C
         L3+2ZDolDCNe2AOutWTWkUFB6ZNh9Ok2mBRJI50W7rTbSRbzKMtC9FJipbpgVFzEO07X
         oUAquuu/eanF3eCkiKe+DCuLgBwdrBT4fwvsxQniFtPeQK4AeoMKN9W6xIEy3KZbKpaJ
         SgwTkULbKRVjCTL1d0jit9vVjcdKpdhWAGUUJkF/XF5++AASV5goiLzcqbk3gspP8o31
         HBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916418; x=1720521218;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xcOIReju24nk7RklPkxS/vRHbT0P3DgAG2ql2jjDHI=;
        b=gpEcWYue/7fxdT70oxgxF+ygHmfNuYHmuuSWdhDZkEXNWkfMqY1ukusvbMbJqDgKT3
         veCQxVH4Ztox5woNnvxuzTOC32490F/4VY7ry6oSNwNiz6ywfxeoe8eDXD29I21Cq2Tr
         FJZ4nov7MwNhC1zIloeOnzMuiqLtJWMqe7dNOV/cxfVN6t1CxMVda6wBgz4R5xOUl5r0
         viCc13rX64PousaS4TDNV/JtEz4lyJQffPdSunv1K1nzIUSWsOBQEI3/iQDC0QTfyIje
         +Kl6QT6o5uk/5ghg+jny1BoSKOX0MJYfkJ9u5DWmjpIjW9tIA/yFDPmLY3tmbb0shmo1
         DdIg==
X-Forwarded-Encrypted: i=1; AJvYcCWDatmR7BExN8PAQ06yCvNnDYfpavjDHsamn3eMlVy78exiLgefgK/OXYqrZ3+XhTwJH+tMLopoFyrHJvBt2+UY5zBE
X-Gm-Message-State: AOJu0Ywne1G2I6ZQKXJmpdHOFLPvcWsvAk6R3Hrmyj2JYfPHa5/ud1Ro
	O0JUrO+vCcbwSI/T/qB8pL8O7GCl6AH9mdZQqq/bkil/JRTZzr/E2WKR+AKjL3zwaGWtOp68/d3
	bRSGduTMGj1EV6lJWcxBKIeDH6Tw=
X-Google-Smtp-Source: AGHT+IFMdqIGt+ZD8Lp2PkeXmHBhrX/cOypL2Ab173f2OnPN5d9czIikTBW+6LU7bt87cA5LgZyro6Nauz8j4GV4Szs=
X-Received: by 2002:a05:6870:611e:b0:254:a168:cd61 with SMTP id
 586e51a60fabf-25db35f163fmr7257498fac.58.1719916417686; Tue, 02 Jul 2024
 03:33:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 10:33:36 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux> <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jul 2024 10:33:36 +0000
Message-ID: <CAOLa=ZSFTcMn+CsEcE1G5hnW37rw81zcUaXBywVY7xbBN7mhkA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v6 00/11] ref consistency check infra setup
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="0000000000001eb959061c413f2e"

--0000000000001eb959061c413f2e
Content-Type: text/plain; charset="UTF-8"

Hello,

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> This version follows the Junio's advice. Instead of creating the
> following data structure:
>
> 	struct fsck_options {
> 		enum fsck_type {
> 			FSCK_OBJECTS,
> 			FSCK_REFS,
> 			...
> 		} t;
> 		union {
> 			struct fsck_objects_options objects;
> 			struct fsck_refs_options refs;
> 		} u;
> 	};
>
> I simply use the combination idea where "fsck_options" will incorporate
> "fsck_objects_options" and "fsck_refs_options". Karthik has told me that
> I should balance the job I should does and the extensibility for future.
> So I use the most clear way to do this. Also Junio has said:
>

If I understood Junio's comments correctly, he was drawing out the point
about if we even need the separation of options for refs. Since the only
option we're adding is a verbose:

    struct fsck_refs_options {
    	unsigned verbose:1;
    };

wouldn't it be better if we simply amended `fsck_options` as so:

    diff --git a/fsck.h b/fsck.h
    index 6085a384f6..ea97f48acc 100644
    --- a/fsck.h
    +++ b/fsck.h
    @@ -135,6 +135,7 @@ struct fsck_options {
     	fsck_walk_func walk;
     	fsck_error error_func;
     	unsigned strict:1;
    +	unsigned verbose_refs:1;
     	enum fsck_msg_type *msg_type;
     	struct oidset skiplist;
     	struct oidset gitmodules_found;

Your approach seems to take a different path though, where we create a
new route of creating two new structs, one for refs and another for
objects and adding both to fsck_objects. If we're doing this, wouldn't
it be better to use the enum+union idea, like Junio mentioned? That way
we would have clarity around which type it represents.

[snip]

--0000000000001eb959061c413f2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7875832d9f2718bd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hRDEzOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNFNsQy80cmdyei9TbmR1ZUIzaTdDVzBjU1p4cytYZAo2SUFvNUJzbHpw
cVdVZ3B1MytvTjd3bEMySTBvTkcxTkI5eHNURkZadDYwL252QlkxSUx6RGI3czd3elhDV1hRCnIw
aFNLSklBMlM5eTk2YnNEcWFmS0kwbGorTU9jK1k1bUpEQU1pdmRaQmQ3RHlJdFcxQU9RdUdHaWJx
Y0lsY2EKdjlwUTI1ZldPN3VmMGcvcnh3T2lWbzlwMXNvVFFLZ3JmLzNUTHZncHgwNTJXVUtlTjdE
L0k3Vzc2N0VJZ1VobgpDOW02UmFkdEYwOU1oYmJCdWdqTUcrTzIxQ3F6RHU5eUlBeHFKMUxZQWEw
bmZHTW1BWFgweG53MUJSVEkwVDNFCm1NTllNSGY4TzRoOUdoVDR5aEt5eFpESzRGUkpkVGpSdkxF
VmpnY1NnVXJSZXVkRjNlTEZKN21jcGEzSDhCZU8Kak1QdGJHcGNXWlg3ZWJFN2YranFBbXdxUDFT
SXpzUUtHQ3RERmdCWFpLMVhFNkVnK09oZTBBUWVTdGRRd0t2dApxeDZaYXpKaWpUU1AxV2JBSW11
YzBJLzNlV3I3ZzhyeHF2dEhHV0xkemV1ZXpTQWR2SnB1M3hnQmFJZTFTM0FzCm44V2p6QmdHc0tB
YVVSL3J2dlNvbnNLb1NudVAyWkFOaWg1K0hsMD0KPUhGVzQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001eb959061c413f2e--
