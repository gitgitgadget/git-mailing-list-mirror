Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC318B0F
	for <git@vger.kernel.org>; Sat, 21 Jun 2025 11:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750504105; cv=none; b=A2kT0dwvzPkCSeMmwq5AZdhOFQS8h/XE1ia1S/1u8X3wo1la7jeiUxYLdfdb7fZJ3GVlN27OyThCZH+H24SIacRqz7ezkTCGzqeU4DUAOUklqXjr41bL6LCUrIfFFruaM4+ZCzsciH0lmFGyUzWKa7JOMJvexUBOlGL5zhWuj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750504105; c=relaxed/simple;
	bh=nX7m6QOUh89JZDmdPkb3a8kFBgzkjh2KEgBl0P8BgqE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXB/IVWi1zHDGoHUbLAdmOohm+nuL/NGKpXcHheqWEr1bXBnB4SU3+syMZpJOV3pQ5sJeVQCfNRgxpaUPOWECRkQFFMagl0icYK33a2XeX7Mi4Afwp9/sXOMHOrEgH6zEG/oIyDVUxshfQ5eid883rytIL2ToVWNvQEb7fJ48oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZUAT9mN; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZUAT9mN"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53167fb5690so839848e0c.3
        for <git@vger.kernel.org>; Sat, 21 Jun 2025 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750504103; x=1751108903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nX7m6QOUh89JZDmdPkb3a8kFBgzkjh2KEgBl0P8BgqE=;
        b=CZUAT9mNHCyJp7hDMxtoKE7M1wglm6CQs54Da65YfLk3HgtkzK1pk6ig5Ww80JgTkQ
         4hdGw9lG9yn1aWv/G8a07qxSyeYfVsPQagsuu11qSczer5SXrfGtzDUQ5hoid8NhG/nW
         9EHwHJLK2tvw9KUj/EVBxPhE3aAWZy2vV7+3CwzFANCrj52BAdKH8vmBzKfD5ZUtRl8N
         1EB6Q1KDoDIR9ScJfnN4NuER1mio0bKkVeCvTZfzW5MISbLWEUSNp4cdBRBxIAk78IA1
         czwIipRLfRdX7taQAPqa4BqFy4SGABTnm0c4o47yIdf1ElhVukJkeqXCwjstJuXSkR7y
         U2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750504103; x=1751108903;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nX7m6QOUh89JZDmdPkb3a8kFBgzkjh2KEgBl0P8BgqE=;
        b=uGouvRCTmjg61iKbQMSgw2IIG8x9dute04tHrvgfslasMyC7LqJgzOALMojumxYO7u
         qmm+CAQ1UKrobq2Q27Ha935ORYRS0uP27tpdPE+aTiK2isqfkWcy9Wel+l/T7ZLeSigb
         IUjgZdrdE5/4I1MLqs2ls95JAeBxWCdURvrALXhxO9D61OeMfKpINrpl8rwSF/pvb+Px
         NTDoS+MYzDtxAQe8W054cu+/5F/G2Nj9sIM8YF2Ds/OTKVSax8cJGAkooy2YrW4P2K3n
         nUbNQcO7q0SpwhHo5tET4k4Im+Uo5SJlplVooH4ZibfPbfYT0vqnkykHcdZa8TvsgR6d
         N/DA==
X-Gm-Message-State: AOJu0YxC9XhXHap2TYy7cEhIQmWt1gvonGtx7n5lrHOVpw3dTdWCDj+o
	xXB+tYOCRjXWbg8A3wRmpwCbF+NOmYKCRdJzPiDtsKlW5we9fafgO2RJW8e5npzZ8LbSRXcgb4a
	Cnu83gugYb1fWkT8dAX0KpI5z1iH7kIM=
X-Gm-Gg: ASbGncsA8Bpn/hfn0PmbfjJO6FKFegMW6/7WxxrOua4Sbqy/wu/2evFlmARJBEIP9Fm
	045gkj9K/B3az7lPMXoFb72/zOav4V+1ODQj15jIErVQqQzb+9aNJbHlIo+KLrVtrjVjzrGLabW
	Vt5h8Amn2SUezd7e6tS4MRgv+wcRe+czbG55Fn53sf
X-Google-Smtp-Source: AGHT+IEiWBrT1vfE2+SQIKm/yR70ZlzpopcPD5MLDKOc31SL3focnfDejVPAGWv8bosvlJ6b62KPUxGpbkbbxs+8vCM=
X-Received: by 2002:a05:6122:65a1:b0:530:720b:abe9 with SMTP id
 71dfb90a1353d-531ad63bdd5mr3894615e0c.7.1750504103362; Sat, 21 Jun 2025
 04:08:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 21 Jun 2025 04:08:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqcyay4c4o.fsf@gitster.g>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
 <xmqqcyay4c4o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Jun 2025 04:08:22 -0700
X-Gm-Features: Ac12FXzROqh3-72IiiQnJFh3nb1TgBJC7CQZcuJDtItRSYOhroVVCElYxcvEOJw
Message-ID: <CAOLa=ZRuyr_DALnjDJfT4F3SJwcExPKZZnf4w6g3+JshBM4iJQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] refs: fix some bugs with batched-updates
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000004261af063812ff62"

--0000000000004261af063812ff62
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In 23fc8e4f61 (refs: implement batch reference update support,
>> 2025-04-08) we introduced a mechanism to batch reference updates.
>
> Just to let you know, as these two are fixups to the topic that are
> no longer in 'next' as we rewound the tip of 'next' after release,
> if you want, you can redo the base topic instead of piling small
> fixes on top.
>

Well the first patch in this series, is a bug fix for master since we
already have batched updates exposed via git-update-ref(1). So only the
second patch can be squashed in.

That said, while it is easier for me to not re-roll, I'd happy to do so,
what do you think?

> Will replace.
>
> Thanks.

--0000000000004261af063812ff62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 904d520b1ad3bc88_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oV2txSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3RKQy85c2pndjd0UkkvM01XcFZzT29yNElNbFhxaQo1ZjJhVlBDQUtm
TG9hZTlBSjlPK3lEYmVKbVBpL3BVUzRXNzZCU0F6UnpmejY2OVBhSHVZdmMxbGVYSjg2dnVuCkd5
RG8xeFU0OEIweHBoSy9YNW1wY0x1cE8xZ0d4RUVsRFVXR2RNczdHK2I4ZXpXcnBtcERKV1Rxdmdo
UGJONTMKRWtaYkY3T0s3N29heTN5VDV6b0owb0w1NWtpUENvamxxMTNNbWZwK09BQTIzaEJKRGZO
YUtOa1VwdE5wQ2pKKwpSOHRQdWVYVjBYVTVPYmFjZ3FrZWIrQnZyR1Q4Z2o0Y2t3OEdGRnNiRnAx
T2dVc2N1Y25UbnU3aWlMSmo4WTZKClAwS1J6YmhFb0xoZGx6eWlUZ09kTkNZcFNJcVBuSUQvbkdO
aWZnYWVVSG1rQ0NqK2RRaDNZTHBwZjdyeHVQYVcKUWU5WWlFRGMvaS9RYTV2dm11UGQycThsOHU3
NkpDSkhZcHU4aEl5Wll3NWhhSEFlNFNXUHFEb1lFTHZDQUhaaQo4cldVSlVGZUptWEJhQkJGdFNi
WndIZmk0aEtldTF4MkVIZ3JwQUtVUDI2cnMwNjZIeDNxNXpYc3hWQndjcEFrCkJIc1FEajdWaXZK
cUZRdTJkRC9UTVdHSjE1aFhHYjMrVnJQTjhUYz0KPTFUdlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004261af063812ff62--
