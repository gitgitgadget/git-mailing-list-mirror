Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278518;
	b=Nae4rUQniJyj059QWpUAM3a12xZf4jw5f7hzpqnjzpRULnz0ogd3cRMl1oiUVhKRJPua
	 88O/UxovATYFmsBnhnYPEhYOb4x2buPE8kA5etxnK9GPhvz6tbmEkloGJ87DSUaIgN/zU
	 aIfbrPPqqWGMHNWMHkttuqh+nqzN6gzLByX9JzYdrbVH/AUGDKo9x0BZ8mBk3HIQH7aLx
	 iBii7QeNl6qFAgutx1qeViySRqAjNbRKpG+zD7ayuaE/Pswgo9+e6KLHeKg/dmxxHkS25
	 bAKetw/B81B9sTTxjDF8lctWBJmwsO+xaTa85xnkc2gZ1lOv8iIEGIo083w4JyQ9uqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=RCBUhqIqSDIwvI25RkooxdvW2DZbzW8nP9vIhmJtmbY=;
	b=T46R9ql0iLORi9niYK9ixQmQMCQaKjeOelIc61qi8E/RhIPy+qFKAeC3LK3SrQ5UalRr
	 do7z89EDRu9SSck59fXxoejOhQE7D+Nwv2hSMHN9FU257g4mrxCkpxrIlGWb/wxz9cY03
	 a+oRcRWJ1kZCs6IRbFcHZAwbnuGYZ0qFTUbirEdAiLuxV9AV9r0E7fAlcFilolHw1QlHE
	 AL/tgX22nlgN3X5UUEsDd1Gm4aSwtaPQNo1H4Ry1pD9bf/Ulg4Jo2amuNRtezdtA/p7Os
	 x+KGyU2j1J0qOVUSgQ+kVuUfmzSxKYhqmULWX4r266dX+ZtNzcfJ7v2f1SuHhe2zJGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UalM6NVA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB16606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UalM6NVA
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1892297e0c.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278517; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0j1dkSL99Vtca+JxzBANaGa4Y3jmRtuhOiBd2h0FaAQZy5mo4P7ELz02nMwBSs8R1
         no3QZ/Uc3cvIjOdHO1K2oWijMuBU/bRufADrG3EJeaSH7n8pWbzg3TyIFLC05/bOxAr+
         FX5ch2BF6BnsyLHrMPftHyEwmKWnrMa7o8aKHufb42bt0LxOrAB8P2pzTSzbbUU1jTMJ
         r17044XPeMKfaN/SsusFL4kC6OwFviE/eZdBOEh8kjP1P6DhY7TieAnfEkgMqbOvI1re
         gzDbfnJt4heJ/3ljF18JAbpalDDRrC7BJYYJoRxE9SJbiiZ+ubxFLaxyiVPBzzRp1nP/
         TbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=RCBUhqIqSDIwvI25RkooxdvW2DZbzW8nP9vIhmJtmbY=;
        fh=18nicFiHTirRLCAe3/ZbsSVU6pIEmhaQMvWER+8HkRA=;
        b=apRKPaWSID+Jyg3+WDHV/pjP3KkJjPjdaOe29jiek4cEcfMeUtdo3NOHfRU8YArZKG
         4v/kh4GM8WWFcLAauHWsY/44tO9QEkbHKauiP0yTt0GIcSMxqyURG4utVFRcCEmQ4jEb
         LLJDfzP+ZeyGuVRI6X2Ogyt5c91/qmFxvEGUEJoCinrrAxEr4CKoYWUtQD6PwCJV+bkr
         Zw6y2bzteL5d34tw3pYyA6yhX2V39XM2/NzQZBmlBqSi0aD5USAzwc7O8Dw+2G4AJ+P8
         gnMlc1EtZ+bycRIlC2m5y6ezfegsEdGOlZ6l1G/sXh/Qxym7IG/+R/CiUhtVcLrZUVAF
         Nlcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278517; x=1793883317; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCBUhqIqSDIwvI25RkooxdvW2DZbzW8nP9vIhmJtmbY=;
        b=UalM6NVAmEVVFtSU9r/7vBx9NtzBXGaxAU7+vY2zjGzLiNfCjOQrtdyf57krUdeBy9
         kL17nMb+GsQNEcxs6BlVNAVHqQhaRMQtJ5Vr5v1q2slxaa9ciRYS/YHOuFHBJYsgtltw
         N8fD8nVaDRkcDcwdF/jUWBZm8t7hFlR3T1refX5jyN9tVorNtvlT42xO+V+3x9xCQwVD
         OJ02PgZQJeAF/e6zMzfFNDFAFGwuvOXfltAQ9k6wYrt3hXsmop8pun61kkhVQ4CYknEE
         HDD/EstWyq5HtDbYoY49HNbpVKYDdgJQfqNamOptZuIWaV6kUMn/Vi42NI+zcgPfZFJ7
         QiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278517; x=1793883317;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RCBUhqIqSDIwvI25RkooxdvW2DZbzW8nP9vIhmJtmbY=;
        b=BPDhJIwn5dxHBbHePuMj5YSbbzJQu6jkKw5LefTlsHLpTIcCQdlnGKWn1KqOp4k/pm
         FIRpB/BjIhNqxO34bkwoS3c+bG5nbGx161nUiCSA2LW9jCC3Hz5RH6UbDR3oWMViNIaE
         gdkfZYbOVDZCQNqTYabc5fTd9TLlbigLAgqgZwkvgLw2Gwdgg5LrN3UaIdTXJyGgLxef
         dhNu7L3CRQApEtM7+aW3FWZSnNuRw4qkm4yKiWbNumkPPB8xwPIlXP3hbTSZobTX+c6S
         t8gMEEBqlqWD+O56NvHb43SKCk4X3N0ywkibroKiL9iMxG5sR3YPMk1dEysoAvDYZR+J
         Ra0g==
X-Gm-Message-State: AFq9FYIQh7Kloq7wsylB0q4+YPtxk+LFxH7yN7Ev4MlAP85WOQdZPf5R
	Q/XFs/rVpC7iD4oGB3I7U6jgiH3t0M8acjE+JLdpP1NbcD29tjVnTtU5riTfBrRSg4FQxXW+PCs
	MeQWQV6xRiyaMs6BADcsvr8cMwW0AY00=
X-Gm-Gg: AYBFou29hOMUIohXUQgVE/+5WxCvanxNaMtHcV5YKyKE5WX2KUGe2JUA6Inu9C8jGBX
	CRKHAllTsKu0zNjrobP5Bi34kVYd24rvLfhwVtTtNp/tyQ/OYl0IZ4YsgmmCZrf49hF7iuC0DkW
	mrRbNf7sZyNZFPt6+fICUj+ZC6S1HtnlfFK7UacPt1OmZYquyVfCjvtC7HQZss1GJV7LwEvcWsy
	/tiIXKSdZ55coEK7YI+gJTn/2D7VrGL/1p0+7LcRagWFm9svJ8WUYbFqqjWEVKOlodMqyQ9WhjT
	hLAmrdPeqkFYk4+XoRvmB8ou6GIO1l3mHzRKRzTfx5DjjKZT15NHi0MhlTlpOGoraSJ3vXAa5+K
	6LkKnYfdbUzlGc+BuqZdb9FbpggALOMYI0qoWphA7NbtEqVpeZcV1Cam6URuUtNkkMK9+pzy50g
	z1EpDiOUqlMwEcwWqqPHIUZgVoGZw=
X-Received: by 2002:a05:6122:6602:b0:5ea:d247:adb0 with SMTP id
 71dfb90a1353d-5ec4cbcc13emr2918044e0c.4.1793278517327; Thu, 29 Oct 2026
 05:55:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 08:55:15 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 08:55:15 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqv76l7e48.fsf@gitster.g>
References: <20261028-pks-commit-graph-cleanups-v1-0-c549344c363f@pks.im> <xmqqv76l7e48.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 08:55:15 -0400
X-Gm-Features: AclHuK_J59PUNam9gL8PC49MpY99VP7dpcBTlFfjjLLqXGBpSZ-bz-xS57MXWRw
Message-ID: <CAOLa=ZRVhZjv3yXA76wK+fZ0o=FrwScHcT3=xJOOgYvjG6cSiQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] builtin/commit-graph: some small cleanups
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000027d22065efa31d9"

--000000000000027d22065efa31d9
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> I'm working into the direction of making commit-graphs pluggable so that
>> backends can fully control where exactly commit-graphs are written to
>> and read from. This patch series contains a couple of small preliminary
>> cleanups.
>>
>> Most of the patches are rather uncontroversial, I'd assume. The only
>> one that might raise some eyebrows is where I "fix" git-commit-graph(1)
>> to only accept "--object-directory=" for subcommands instead of both as
>> a command-global and subcommand option. I feel like this is quite a weird
>> outlier, and it got in my way. In any case, I'd appreciate some extra
>> thoughts on this.
>>
>> Thanks!
>>
>> Patrick
>
> I read the first 4 steps and they all looked sensible.  May come
> back to the remainder later this week if nobody beats me to it.
>
> Thanks.
>

I didn't beat you to it, but I too have nothing to object here,
everything looks to be in order :)

--000000000000027d22065efa31d9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fdb9d1549b19ec0f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yalFqSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWgrREFDVDZGcGx1UDFtT1JxdVRyZ3hOWU1sQ0JqcgorUllHVDlraUZB
L1U1UzQ0elV5N2hiakRONjlWTks2ZTlYYmpTN3ZJOTBHaFZCa3JHUWlwdlN4bmJJMG8wQWU4Ckwr
ejlqM3lvZmRhQTA4R3lNbTVrbCt3VEZNTVhxS1FTVGcwa1BndVoxWTZMU29LajlQMk9yQkx5SVdE
b2FNUjMKc09zanJTTHAwalI3UURpOXdWSmFyQ3FoeGNFL1hTYlBjMVNCR2hyQW1Hb20zd0hPMnhj
alk5TExHNGMrRlE1VQo3ZDRLKzNaWTd0b0ZxSlJibndrY25LNnhHQlB4eERSZkYyTXloNmJSMC95
eHVleXYxL0ppL21uTnc1dDQySGlTClhYR0tWVzd5MlRxbmdFR2FUeDdoRVdSRDhSbnZqRC9hSVYz
YWQ5dm0vSU5xKzM1NHZKclQxOWdIVFM3eno1VmUKaTFySDBWV0EvMHpsdlFsaDhDNndHTHBMNGIy
N1JmSE0wUlR4MGh6ZTZhK1FYMFdFZmxDejJoK3hBVk90dUYwUAo0NjZWUHA1ZEJxQlNlM05weHln
dXJsUGFxYkNBNXc0UDR3TE9xTDgrVXdFMGpQdFREbTJsQzFuSjJWbnN5TmxkCmR5VzZIenRDSE5z
elllRFMxYmtOKzM2OENhWUFBcXRJMG5CVjNkQT0KPUFzUWMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000027d22065efa31d9--
