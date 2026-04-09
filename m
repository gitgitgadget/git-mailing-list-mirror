Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29325B2FA
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734616; cv=pass; b=FPXzcuRs7CH+LB9p1J9D2+mGMQxu9/pEdCJvB9MDjGIWfQ5IEGVozA+mM5lae4V11PTt8ud4Di4sP5hiRWRe7ugWjFx+6yWAfphD1EiBPU6XZK6CkKSRNguGZ3isNheh5NhqqYW6TpcGOGjhQG79k8/D3JBV7t/CCoYszTsxJYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734616; c=relaxed/simple;
	bh=+100ODoDGNYCRPfH3cGnfWLHKMol78knDD/V6p3i7Vo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMT9JLyJIJv9lX1XW04OsV2GtobICZEEDQO4AjrMf20Q35rnU4ZIuQmzuhjutfMB5fecxRiygZ7sZn4GrV5Mm+dMg++G0wGKl2kEPbgkjbObVQ6EBqiboGYhN5sZn/1kqsXQMCkCytziOPOJXA/OeYfHHX19GrXwzF8JxyMj6xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS3UQk5j; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS3UQk5j"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56d9ed609d2so229312e0c.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 04:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775734614; cv=none;
        d=google.com; s=arc-20240605;
        b=kWtjMbIVSrBEoGTSFkdBvYum6bXf0DXTHNfN9M5pm/jO1eABlmPbYqo+q1XOEt3L4D
         gowiv5jGqNi/cI+V4p7/KptygSaLZd20Vc28/rg5CliqrHvcHUAbHbdZ20pGPu8Ghaof
         lywsDmQJ9zfR9obd3j6cAvG0Vgn+m8+252Szr9tI24KtBcyEbeZCNTG1WYiIUXt8KKQc
         EtTpY2cx/fu1UkX4qHM2hfuxmJhV+GQG9WA2O0lzTNMe1IpKQnFdPi414zXtED5lmqCi
         3dA6rZ2cM2cDFW48piU1ugfw9Jvw8M5Gj4JCNzcjAkeRqqpN286GIXg+BYcLeEi7eeNG
         jivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ocLZ7a2EuvgGvrAI7I5FTR4VV5EYbMTBaZJQKA36srM=;
        fh=/iPEXjRvKaGr2iuhz5/2IK4L4iUTK7Xc7InsfvOFf1g=;
        b=IkNVVNRP4vRpyDmQu3KLoyAsXtIPdaSNZRy0jTO4JHSdIqE8D2ohcZixi2/arJ7873
         SijbE1K7+n/8fR5Ifc2tEQiXOrzbzL82YPCBDN0i3XFPlxx6jCwGb1VflIP8LlJj+b8y
         XIj/f1HJliSYaf7u61+ECqJaBeyti5GGxzaADPuVlXmdPfMoerj1Rxw1VGffyeEMGhNI
         4EQ+5Ykrbht2C4mJtCZaTihxuMHJjVbTXwAdMlQydK7MElx4SbO75bVHVf2Idol6Y93p
         rV8mOo9bcNRRKYtZ/VEU6qzhQE57osSb+1HN7fB8MjwI/mUeIBaGRc4P9XTiPVAv5pV6
         ngFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734614; x=1776339414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ocLZ7a2EuvgGvrAI7I5FTR4VV5EYbMTBaZJQKA36srM=;
        b=RS3UQk5jMOvjdIBgLSw8LzqzlOIkZddV4bjFFHayOhAK1nq3mvOZRJFlYmIa5CfGld
         N1+ZyInUBhp9GnFjYrphAU5OPVIZ3PG0zLMrlV9PkYNEsyAGVh8hCJ75BwSw6E7O2TKU
         lp9Ls5CFGQ7Ma/RXggf8t1W/12R+LV5pUN7TBd8WENqIYXT8adF9c3cbUufTq1IIPYoK
         bsKXuvCUVxTZlxErx16HcSzTdoWLHMj41NuBBWdzirsedp5rysKuVLLou436lFX0yzc4
         ZI0RtzQ+NPZaYG1RmPMTbtaCjwmXlDeX1/RvJjUUbH1Lcv7dATYpWMK1aLflclYqsCx5
         O+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734614; x=1776339414;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocLZ7a2EuvgGvrAI7I5FTR4VV5EYbMTBaZJQKA36srM=;
        b=qdwYDF/JNbMJMEydHC+WLDcsp4tbB7vxT51gkf00oUa8M2O9sEuHHQo4HdRMbhskFS
         krr8vTZX+3tTYthj0IZGaCxY5Uytd4BfiLffZc7EtxyYiWgx4qLP43dcvtzfEM+9UOq0
         X5rrzGH/OZJX22l+Eu6slrVBKWs6FmhZAm9Mc4tnZreE9iTgMrCpuB19TDL8c/qhkhKR
         mDYXgzvk/yuA3imf+StLmi/fd4JDtCJvQ8tFrqAstnoORFLYagmgtbr7F9m2VQa9jeKc
         mWkT2lPRxH9jgbeBLV7FyPHMA0IjEs/gZl7LWsJtIVo5cAtOS/WG9a2JvPIlQe5xGBTh
         5PIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwglU0qMXsXffeKJLKbw2BGDaOqB/7aatgfu8Ydw5mosMnc9ES6s19PxTLPsunM54if3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDlIPiOi5xKzeLWralmPadb3uFOJjKLoV06pPjZyPsYRpVvBd
	OTduM2NguY8Pwvg5ToL5iYMIiXwegWQCoo1RX9Sb980NMqn3oj6oUvrnMoiuxIHs3oZ7jv4BDUD
	Rd7pkwj/H5yEW3rABc3I+ZCLVu+NAN01Jgw==
X-Gm-Gg: AeBDiesA4cTDodqN/I/nhawARSWA0ILRm4uCTFkL2bgwsCtp/vlB8m24Nq0mnySQZGU
	CqYNpKL7aLE/VmFgLFtUlbIfxb4ObICIYAkPyZG0av+CbUeetRTPW27TrB+4urDmZeoc2t7Thun
	+B5p/8/avNZe0eFtqClnfnAibi4jsl6Yp9GLTfpqPINoIKi3ohggVk8RK6bme3hdkk2mICJhX9+
	+rKQAICE57ScjgNak/zCxBL1RLxuLL/9Mn9yn+VNq8CI3ZF16KRlNE7BUNwG3l9fw/n1CIGIv0L
	FG/26v4PyLqlPM35HYRrdpKUfJ0F9FhgDVjRneORL7/YqQlSAzk=
X-Received: by 2002:a05:6122:2a53:b0:56e:f5be:1068 with SMTP id
 71dfb90a1353d-56ef5be1ca2mr6677020e0c.1.1775734614492; Thu, 09 Apr 2026
 04:36:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:36:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 9 Apr 2026 07:36:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-9-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im> <20260409-b4-pks-odb-source-inmemory-v2-9-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 9 Apr 2026 07:36:50 -0400
X-Gm-Features: AQROBzDTmGbfHK57710vXKoVskn5o94ZsHsBh7CfbmmC4IfBxDHQmtrS-uU_BVo
Message-ID: <CAOLa=ZREniG1jkqk4SW6W1s6hLHh42fLQK+8tox59jprn2hPPg@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] cbtree: allow using arbitrary wrapper structures
 for nodes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e9a2fc064f056ec8"

--000000000000e9a2fc064f056ec8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/cbtree.h b/cbtree.h
> index c374b1b3db..3ce0d6b287 100644
> --- a/cbtree.h
> +++ b/cbtree.h
> @@ -23,18 +23,19 @@ struct cb_node {
>  	 */
>  	uint32_t byte;
>  	uint8_t otherbits;
> -	uint8_t k[FLEX_ARRAY]; /* arbitrary data, unaligned */
>  };
>

Seems like we need to update the comments at the top of the header file
which still talks about this field.

[snip]

--000000000000e9a2fc064f056ec8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f64dc1fdc5af072_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uWGoxQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md2pKQy85RjNPQ21qdTMyaldrNW5iK3krS0lTL2hwTQpYZTQ5aGQ0dXZW
SG1hSk9RNlowVXlZNVJPa3lLdkh4b0hwWWg5cUJ0aEdGNzNuRW4vLzRsMktEajU1SUVscEROCnBs
N053WmZUTzY0ZkJaN0VGcTRrOVZvbFBtV3FoOTVTMkxKNmF3MUlTQ2tMODU0dHFxS3oyZ2NaTGZn
bHp6T1YKc0JXc1NtUWs0OEJBWFVVa2dvajQxcXpQMEFHeDdKMTd4UTlOTUhta0dGdGFiREcvbndq
dGJjeHpwcGN6eXZPNQpvazhxTmxWRTROL0xNazZucnIydDBqODdYK29oQUxMU1JaaGlPVDhuMVkv
U2t5TWZ4ZzY1WURubHJ5Q1kxVlZGClh5cldVQkpJamFNUTkwUkhXbEMraWxyb1NZUVlJd0x3ZmI3
STZNQVRKS1ZOZGc5MDgwMnZXL1Mwc2FGMlF6S3YKbmNxVG5GcmVLYTIzNlJIMXIwajllQVoyTFp2
blRFcWJKRndLZDg2NEx4QlhPN09sem9SL3BYclphancrcFBvbApiTER5K1l0eUN2TkthajB1R2ln
SDVuT0FGUzlhMVZJZjZQMUp3UzduQW5UYnFrdnZ5dytDZHNVck0ycU5QeG56CitUbVh1RGJZS0VH
VXlOa0V0SjZya2pRVTZkTEh5U0xvR2N5VjdyOD0KPTZJQTAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e9a2fc064f056ec8--
