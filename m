Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0B1DE2BC
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750602035; cv=none; b=MDZgtcnx2vC7CmPX0MmpuUAMNznNYZrbZuGaByWhVW4InzeVNLpah/zeROArJR46Y3lebM0JpsEBdu6OduT4oXugFHjuLX/E1u2nzi1H+ZXYZMBWQnXusEimxtApdXHdtwZGpIH76fTf55NCqyIWwBA0DHj1DHN7fMO1Je4N5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750602035; c=relaxed/simple;
	bh=P+ft2FJdhuw3Y7LdCPYpMSsiFFEjJo+Y5ctUDwC6uJo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oW0BzgUbNLy8oPkrli4OJHYZ65Q/g7xgpCNXJIRkE20SdOZY2pGOvs+ZlOOs4KvhdbxPLTHWqSu0VnPXd5DaoX0JSA8peMhHjRQ8lMpX939uL47cVrdtdHtPTUh6Iw4vhDnh9u3b1ecrqLxtjZnq1Y2FKd6co24bW1OH8gY/LMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWzSeltv; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWzSeltv"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4e77d1333aeso1047024137.0
        for <git@vger.kernel.org>; Sun, 22 Jun 2025 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750602033; x=1751206833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vB6mwegIjfTN5Bvkj/gLHaQIIT8T0Wpd8zRoTLiCfBA=;
        b=IWzSeltvpxGdAY2R8Vj2whw6dMy9sW+YstUEO+SptVNi5P+h4PvFhGQBB8RPppgfqS
         uMljw9k9lE+vjm5D7bwQuY4HhUIyiCoepcY/GG7t4dpXfA6H72OW1o2zRQuA8Foeo9J7
         JDoZIcstvHCVGycNUM7GOLoNzvwAY2vZBHyzhwrk19w9ZbbbyeKyGgs6qYi7dIAzSpG0
         rstEhQ4HwJTRao0CfeIFjXeMExkSxwFelIYazOeQDpUz8eAGP8ebA3h5yYNnRw1HQA7P
         0cdnCXN+2rx+si3jjTo4C7z1AaawuXNQt6r4C5CV5ytD7DtKH9UpCTlxn1Y7P7ieJ3aW
         47ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750602033; x=1751206833;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vB6mwegIjfTN5Bvkj/gLHaQIIT8T0Wpd8zRoTLiCfBA=;
        b=dT2Y7fjHGzDPlCMZNM5vJN/LEP7BLJpAgh9Ske3o7kL0tDfePe9hoI3YapLTQ9lyXt
         RytSth2jd0HgmZtY3EhtYLRhOndkyEbaN8mhdXAjGM+MQ9szwIDH8wklf3FM0Fpn2Pv1
         yOYtum+amCW+aRMD80mlvh3iPjO3ZtBQErdfImKdTdpaKA+Vw059V9fEMCLO2U2q3aVR
         HUKwQtD8liFijUgS6oQP/UW0Nx3w7hve7bLh83lOGlfM3vsR7XiiWNtyVcurw5vLjnBN
         V7sp50Ph4wL7ATjemnLr31+EvbkrpOOdniKE16aQznt/QRR6auhLdrRBB8r5CrM3njGi
         jayg==
X-Gm-Message-State: AOJu0Yxuv4m+NCE4oM1cfOI7HgRQpbjyN7QezmMd9ngRPLRDtO881JHw
	kK/Jou6O37vdfpWfQ1Tx1zDpVULbuvrq8zl1NfiYD14m6rWeqMvyYeHZEpEi7nDs8nkYu3LwK4k
	calDPq6yGNhcVsko4V0s+JkA9MlYfJ7o=
X-Gm-Gg: ASbGncsOPEqYtE25RFoTyvjvvpZTNNh80K6UHnl0k+hrQDzmPXYdz4HNjoQGWP1SxSD
	cFwjRa5okhUyLQmWfYoMlAppijdVyB23YfaNawQj0RoRixAmj+Ydq9IGD/vrXo6F4CPdXCItzWc
	tjMT2ucD45Gbz443HIXrilnvqaVrDJO9XzGtVF7JvH
X-Google-Smtp-Source: AGHT+IGKhmYYYjYDusSgtA/R8Am3kezrEO3spYG/tn1V8LKYNB1QZ9ndUjt3jNDOV4qYQc85ZhNMD7lbmvykm68xv9Y=
X-Received: by 2002:a05:6102:f0e:b0:4e6:d911:dd84 with SMTP id
 ada2fe7eead31-4e9c2f56aa1mr4788894137.22.1750602033139; Sun, 22 Jun 2025
 07:20:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Jun 2025 09:20:32 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xgo8kwk.fsf@gitster.g>
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250620-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v5-0-f35ee6b59a82@gmail.com>
 <xmqqcyay4c4o.fsf@gitster.g> <CAOLa=ZRuyr_DALnjDJfT4F3SJwcExPKZZnf4w6g3+JshBM4iJQ@mail.gmail.com>
 <xmqq5xgo8kwk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Jun 2025 09:20:32 -0500
X-Gm-Features: Ac12FXxsccXk8CkbXHIpJHiADKuMyvnnQOPQ9C6dfIGqPwXIHfMxjSuJlatri68
Message-ID: <CAOLa=ZQaLN5ijGJfGZkBxTd6JCKizUCne=yWs+bBgrW7mv3PVA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] refs: fix some bugs with batched-updates
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005431af063829cc05"

--0000000000005431af063829cc05
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> Just to let you know, as these two are fixups to the topic that are
>>> no longer in 'next' as we rewound the tip of 'next' after release,
>>> if you want, you can redo the base topic instead of piling small
>>> fixes on top.
>>>
>>
>> Well the first patch in this series, is a bug fix for master since we
>> already have batched updates exposed via git-update-ref(1). So only the
>> second patch can be squashed in.
>>
>> That said, while it is easier for me to not re-roll, I'd happy to do so,
>> what do you think?
>
> I'll let you decide; please choose whichever way you consider would
> give us the better result.  The second one seems to be a band-aid
> that trades one bug with another bug, so it may be prudent to leave
> it separate.  It would make it easier for a future change that fixes
> the lower-layer transaction processing to refer to it, with "earlier
> we took thw two step approach, which had these downsides. now we fix
> the issue for real".
>
> Thanks.

I was thinking the same. I do think leaving it separate has the benefit
of extra context being present which in the future would be useful like
you mentioned. The only downside being that the base patches are anyway
out of 'next', so we could squash the patch in. But, In the end I do
think that keeping them separate is better also because only one patch
will be squashed in. So let's keep them separate.

- Karthik

--0000000000005431af063829cc05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2429b3eea3cedc1c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oWUVTc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTVHQy85MjY1NjhrV1hkK3pDank4Yk4renQrOUFEcApteFVmZTFJeDZk
NWRqelFldVE0VDRyYjFWbkFVTW45Rm8wZ0hyYi96QTBxdTE4RmdBQm43N2FWd3pHUFNJZnNyCk5H
Vm1STUFCdTV4T0hENUdtQm9mY3Q4bHNNS1RjRXFYYjlwQU91YTI2Q0xyemJRZDN3RnQrcE1oV0l3
c25ISkkKejM3alEvNVcwdm5IbmZxVG44bS9iaXRBa0JxNlh4aWRQVURScXlmc2R3WU05WGZxckpY
Q0tsa3dkTUNPb3pvOQpaaGNIMDdkUjRvTGIrRW9VQXlQUThTRkk2MEpLZWhuZHZiN0ltTjgzTDVS
ck9NT2dLRDJXdnREM0l3TFBKcFdyClhEc200N1U3SGxkNFFUVjFhcHh3R0l1MjFaY3JxQ0V6OVdV
bUV0ZlN6eEQ4eFRqOCtDOUhuRmhuem91ODFLYW8KZWU5UzIrS2swQk9tQy83a0VzWmJEcHpMMUpO
b2d5L0g1QTBNdVNjNkN5aktYU1gwSFdueTdkU1JZZ1o0d1JpdgpBK1hLc3FlSGp4cmYzRGh1dEd6
RVA5T3NaL25RN21PMDI1YWFLemt2TUJOU3VodWNCOE5rWXV2dFZTR1ZDYm82Cmh1dTZSNXpYc2Vm
cnI0dXNhU3R1dC9WVktpUXlaQW13dFBQV3p0WT0KPVpyZ0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005431af063829cc05--
