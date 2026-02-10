Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0BC1D516C
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770728572; cv=pass; b=ZGCfqP83NqcTkLaSVB+yZ6yw7dFY0eSGvyf1Fn/G3HX1hAFpvviVPt0ljy8PVy8HSJLQ5JUXBXE5pGbDatyekr8F74CGlZz5wzPhHsRy3+XMB+ipjjdPOQvGTaR1kqwb4sPCGaM2tMPk+TA39YJS/jF0513HWvOzSGFWb8emtyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770728572; c=relaxed/simple;
	bh=0mJQ+RJ0lq8b9mUGwMnV2x40Q5Hvg6n+eWfMR1gMK4I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ87xw8TFVQRZKYVfPGBPjiqu4AZZX8Zp/w2P58KDTUKr1w5IT0vfWxY/I+zDjA3K5h8uNnzEKOjYonwzpl2DGjrDAtTH0vwDIfgX195uggYF3JqNBZPSH8DvFGiE5adPy5IvwcSSnvlFGi6tDYMzA8Mo7PSb9UwSHL7mGCTCBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeUCEkfp; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeUCEkfp"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56641200d6eso3240638e0c.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 05:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770728570; cv=none;
        d=google.com; s=arc-20240605;
        b=Ub/mqWjXXWSRUb5VoqOPxCke5sgE1FKxS1bk1Tz2TAzFFf9IlLI8N0EUaOF22OQrkL
         aQpzlmphi3VjeXyUpSuB5SeHqYNW3CQR+0jqIQvax3I0TffqNqJdfgzWS39lsBDb4Lcy
         ZOv8w1wJ0dFCeGYBagxQl5Aw6E3M04toz81/PWm7hwMrt0rDKaKup0XgtVOYrGFIFQoU
         C2l3bmdiQhP9obyzDA+A+tzLhDlhu36zMaKk3ciVt4fdUehWw20n80TURZHaP5EJXqdF
         r7D6ls5UR/Zy6Z2PH8HtWWlV0Oi8fwWLtEx/lj7z6n4bi+W2paxABOh70UPa2flfw1TP
         y14g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3+sEpYVEdu40qNWBrhWomfvW/3zPA4CZCkB4pt9DED8=;
        fh=E0rgsdqXW6tCaZb2Xj3mvK8a2j5Y/u/Mu4zAITXf9ts=;
        b=PlKJKaOu2qr9XDbVkFQG2apEFUYK4OhEPejcQJpOjIMfM4Yy+0p/A2gmGDxj8EMorc
         kCYTSsj/UH9JPMuVa13rMjSDITA+mMxVx/FBfeyahZOJ4+i8SQ0jRb9mpbxmsV6dvmaz
         kJd3vsWilIU9jhjh9qe0x+PciNDWda33J4f9f9sP64wQDxDKJWwi6VelcrhesnimIls3
         NeSHEeup6nSPluvtRDjdM3qCvaKuia+x4jfC45RbEwAog1k4eJI4mxJ2YXujSXkmZfO2
         rltNQ8xb6PRL83dK3sf7t8f09mE7QSvXjQlrZagTSI0yeYiZeaDCts8iOGFV4WdHmGd1
         iEHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770728570; x=1771333370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+sEpYVEdu40qNWBrhWomfvW/3zPA4CZCkB4pt9DED8=;
        b=EeUCEkfp3ZoqShAjpVnnZjGtv1KrrKbEkvwKEgR7KtCfA6cpa48eru6+eV2jlad9Zm
         SVrKFzGQ/dPWA9NuIbuzHQzYwPWlzscste2cn3dZfz/rvil9XH4PPoANjUqAiORbr3eT
         /zw2uhTB2o9ia+gkApTCi1sRy5ipik6UfO7zfhyaxHgbi8Rx0q3/u3ZwgMkyPy8kI69i
         P04dJobvrOjNCMYdHGVlTrJ3A+nsfD/coyHlAtkItF8KSpUts7OJUgAQr4vaMZW84V62
         PKyVC26H5vgHD+t62IKJ03kNa1iMJfY996/rdTQrgpg+q+XeU7PJmdYNAHbQ/PpLt80z
         43bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728570; x=1771333370;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+sEpYVEdu40qNWBrhWomfvW/3zPA4CZCkB4pt9DED8=;
        b=EhtZaQPvWmhS569Ppt6ZUi/lInGZhwbS3HCeH+8vu12mwgelGA0UPI977LeHG/33K2
         KtdTpyzsddI5W7NDp/lMDuDRWqbqCw5g+tas0OM8pMsGwwVH/DNp/5eIbR77+DGhAQg+
         KB13Uax/RlYuUauESNAGIlcbt+E9zPCycQCV9dqydlJm8/qU4z+188gDnDy6SsmRtdyU
         TJTMsVQPZl3nhQQz5Y1OrHsv3m/YwgRmm7vnLn30G73DixhretR8vf9FHpo7jDjrkREF
         hQ+5HUgWityRozLzWw9xth22nfTSA47ShqlWyrCRgwTOJweYI0bgg5GIYR7froinxtzi
         SoVg==
X-Gm-Message-State: AOJu0YxOjt5ueSoVCnCnzQAieZECnEZdxqBl38EDyhOWGV9nnoOFHcNR
	S3QHA/bquUy8K8tqXQQosLD4S4XqtY4RwrHQ8bl9YWEG2gUiL49IGX3JAJyVGmbjJpA0+jFfm1p
	CIi3jRKH7MOwsbJb+++Qx4K03jlFuluc=
X-Gm-Gg: AZuq6aJMCEb+v9FvI8BJMLXiItYEtye+EzsdhmmC+Uf6J8e07SnIQUJsaQV0LHTjvc5
	iaTf+Bawqvm1msV7ipVfkD95aKUyM+nuceB/LYGHo6QLNWrbWIFUz3F0WJoxtKFtm+BbZAwDczt
	Ks7fqr+U87skVve/AQ3Y7IlgQWILRKgWpOYdi5KGdiGem+K7IpKU6Lm9vD5ISMMg4rW8ckbrpIE
	8DBw1oxeRqBR/9skr+lX1LAooQvWeI35Uci2/a5NqM06uxJSwU1StnSEi+xf4D09iMHLaUw80SR
	vvwKCmjQWWvov0lDK1EALK8StSwAGjYttaWEBjdyUA==
X-Received: by 2002:a05:6122:3d03:b0:567:44ba:bd8a with SMTP id
 71dfb90a1353d-56744baf19fmr166500e0c.9.1770728570026; Tue, 10 Feb 2026
 05:02:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 05:02:49 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 05:02:49 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtsvp4wxv.fsf@gitster.g>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com> <xmqqtsvp4wxv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 05:02:49 -0800
X-Gm-Features: AZwV_Qi5XRrx9NVcUiHkQQakNNyzzWirW_tHJFqAVJp9FF7S0x2IboArXVFuHNQ
Message-ID: <CAOLa=ZRPLB-jLJ=4cdtO0DuDD=+tPp7t-Kei5pMsF0en6i2jJg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] refs: allow setting the reference directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000692b12064a77dfe6"

--000000000000692b12064a77dfe6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Changes in v5:
>> - Moved around the commits, to ensure that the code to handle the config
>>   in the backend is first. Previously, we added the config first, which
>>   meant the commit allowed users to provide a URI but it was simply
>>   ignore.
>> - Fix typos and grammar and rename variables.
>> - Clean up the description and documentation to actually specify
>>   protocol over location.
>
> This one looked good.
>
>> - Avoid an extra memory allocation by detaching the strbuf value.
>
> So did this (thanks Stolee for spotting the opportunity).
>
>> - Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com
>
> Replaced.  Hopefully this is now ready for 'next'?
>
> Thanks.

Hello Junio, I don't think so, I think we still need to address few
things as per the latest review. So let's hold off on it.

Karthik

--000000000000692b12064a77dfe6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7eaae8d631aed85d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tTExIY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmVPQy85dlpjUUEwQ3U4Z29rTWpSN0FkTW1yWFMxOQo3b2wwL0NUaVdB
M1BEVWFTYS9tcDlPYVZHQkh3RDVFbHNZVkZKOFJrWGtpZXh4U2lXVVZhT1hVdkJxUDFjVDl1ClNq
WVFDZDd3dHplcndRMHFxV3NGSEZmRWkvenREZngyRFN5VG1peUFQeGV1T1UzekxwZGFGenJIaXNz
L3FtNlEKTnVEalNib2VXV3BpenlUT3llMDQyMCtrdHNXYmJ5dXJsL3IxWXdpSklUOWVXSzFYbEFu
QjRDLzlOK2NDbXIrVwphVkp2b1lBMEZiZlhjajhrUFVhcUNpeGw3NW1Zc3ExK2tjZGdsc0Y3L0lN
dmdCK2VIY0FzVUxTVno4QVNjejF6CjVMRGo5akRXZFpZT3BieUpmZmlXTkVUQ0lnMGFCSzczUTJm
NGZpcHpRdnZQUHRXbC9wODZRa0kwbTJVbFVIemUKSFJnc3gyclFPRkM4U1hnZVZIdHVjcCtUblpw
b3dQa3owT1FCblVuWjF3Qm45dFJmWnNKME9HcXA4YmxJUElMdApVWnhjOW8vMjVPcjUzaXR2WU82
bFVUN0lHQzBIbjNmcjN0K09kYkMveGV3R3ZhdWxZbUpEZnB1WGVzdnQxZXEvCnVmQ2UwVHVrUlhq
RmxyUCsxbXZkVXB3TkVzNmVPQ3Y5cVpVVkRpZz0KPW94K2wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000692b12064a77dfe6--
