Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9F219F9
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726015; cv=none; b=YuJJqV+asE4WPI69TN5wAqbA31V4dr8WuW9UI9awGnV31L+Hqsj7pgZkqoLf2iElDNepCt5FbaAhTENfxQSDOHpTbVgmmCG4Wpnh6j7QyyCi3mU2YeSgVhWrFG6OXa7jtoP2CyuB3wc8nfyB6sDXHHPj12cI4dYcygOSrpXflas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726015; c=relaxed/simple;
	bh=peaJMRQF1hX8w7WGpd+DNuzFED5dLIFIMWqqRCp1MDE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EdU4C4pzdlvyO5LQoAN2sDvqrc5jmPHC/2l3Akeyw+pyJz2rnrXyFBeWzqUoohh/xAGWmfcUrs2PLL+O2TRad8Zvdl25gSAktkEfX+ThyEovN95+l0MB+8oy/xfUsT+h/eLiYx/WUN/GU2tfLENKnjEbXyRGEGHWxlX10E92pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG8HrxnQ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG8HrxnQ"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-234cbd333f5so2625079fac.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713726012; x=1714330812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IV3FrQHcZGJxB7z/OReEqg7vh91YwhBmzE6N1PBM+TI=;
        b=XG8HrxnQg1ODJRXnq9aSlev7e9Zrbv8fpxLeVmcQTGBXVanhONBYo9RLQX9VzAiKmK
         z1utp9nXnJZV6mj8wtnABmIhmuen/GzWwz9ZXAnxJF56wbAHsKd0atvygaqtxrwUuAQO
         zVjpPf/pWqFv0EDS8c1ILj1TC2Y8neOfTJksM9kCwIZYf8grfofUTS3ScHxvOUt3qBDj
         l/5eDLGR6Pytxbs3J8XbPYrwYOojz7sKUQbX16B6gSXqKqT88xxyblK9o+VeyImaICM0
         O0AKh1LzX/oBG8VaNCbPecqEGwB660ri3tHPkcpH2exFBPTn21T2lbpsc9en8qCf08Sh
         Tgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713726012; x=1714330812;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV3FrQHcZGJxB7z/OReEqg7vh91YwhBmzE6N1PBM+TI=;
        b=dv4yRu3tjdvOyNd8oYBQ1WSUU0/sH3pR+H7g354Y5Zzctm3kKJ+R/C4/pA6cJ4kd1X
         Qnqa/ulw+MmCk6w+u3MQm3DZP2oBh6+EX3xgaHvaX/NW3ykd+z5Qb/RrV9qfOHknzvzI
         kMnfVWecRZh2+i7m1/NOzhsTv0D6loopgxezcrVeXoO2arPjzktmSeBy8uP5Xu8OtpvA
         4RVi0U8zIWihIXM/Qr57KtHwVHGsU7qXPCIuWR2HkVHlMgqJTgHnfbr5d8MIno8KSHc3
         n5IGCv+49ntvFD8ttsSTYlC2kFBlyaWpUUJNJfk+8nIts4HoYtKPgiGcrxv1EsYNrBEB
         S/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVMaQ3W+/eu47WWRTZy7WuH2+JNYldXf/VeyvP5ERvXKjwr8SLF3j6XCOd0WPefTDTQKT22HOPmcWaf1rfGk9e/ED7h
X-Gm-Message-State: AOJu0YwWzGxzj9pIhW7XFI0j6HhKtdM+x3noslfdg+r+IYi93qLFxnIX
	FqAWD+lJBs+AKnBLel7Zpqjm36Am8Zk0FjJurpjAqauePXHkOjlPsmVx4OaBDced4oN8efgv9ts
	Tx/3s4C2Dpu5m6MaFdsbZ5Yl3CloATA==
X-Google-Smtp-Source: AGHT+IHrNQTBqMBRH2zOAmGwvvamCvyeUkH2y14Dvy+gw4K9cSuFWn2EkHzZOzliD7OjpP9fCq7Wn6qMEjmnbeqZ1GU=
X-Received: by 2002:a05:6870:1613:b0:22a:76ac:5ead with SMTP id
 b19-20020a056870161300b0022a76ac5eadmr5097688oae.1.1713726012335; Sun, 21 Apr
 2024 12:00:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 15:00:11 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiI8IFdfBHEqr02C@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-7-knayak@gitlab.com> <ZiI8IFdfBHEqr02C@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 15:00:11 -0400
Message-ID: <CAOLa=ZTA94HModfa40So7Uk7WAG99G+XabvKfOY93RCL6Xac5Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] update-ref: add support for symref-update
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000035441706169fee8f"

--00000000000035441706169fee8f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
[snip]
>> +	/*
>> +	 * Since the user can also send in an old-oid, we try to parse
>> +	 * it as such too.
>> +	 */
>> +	if (old_ref && read_ref(old_ref, NULL)) {
>> +		if (!repo_get_oid(the_repository, old_ref, &old_oid)) {
>> +			old_ref = NULL;
>> +			have_old = 1;
>> +		} else
>> +			die("symref-update %s: invalid <old-ref> or <old-oid>", refname);
>> +	}
>
> So we first try to parse it as a ref, and then as an object ID? Wouldn't
> it preferable to try it the other way round and first check whether it
> is a valid object ID? That would likely be cheaper, even though it may
> be premature optimization.
>
> Patrick

I think the issue is `repo_get_oid` would also parse a refname to an
OID. Whereas we want to first check and keep refnames and only if it
isn't a refname, we'd want to parse it as an OID.

Also, why do you say it is cheaper?

--00000000000035441706169fee8f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3accae29521d92c1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZbFlqY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmRCQy80dDlVaGU1RTRxTXVPNW1nUTBXemhtQlJabwpNVUhEMm9PVU5D
K3pRZXl2c0tmem1IbEtMTTNKZFNIWTQvNVJiRHVsZExDYnY5THMzQkp5c25WQ2F4aVRlOTlsCjdQ
dmpJNXltbWVOL1UwTFBwWFIxVE4yRFovZFZGMWQ3NHR5TkdpUGo4RUEyclRrVVJZOUtmd3pyNjk4
WkxpcE0KMmVlcnljUE11eU1tQWN6WVpiN2dUdmlXaDdpRGZmZms1V1hPSmJMSnY3bHQ1MXBiWVdz
SjFKVHNuT0MrZXd2UwpXU3JMVURXNkMyN2ZoZ2c3eWNzcC9MOGdERUJJZ0NkVGNUTjAva2RSaC9k
T1FVeXBFZTBkcy92ZHJObW1iQVhlClBsNVcxYTdmc216b1R2WUlteTlCRFlEMkJsazV2YlJkdFNs
VHBuVXBiRjJSUWhFTkxYd1JHNTBHRnR6TU5Fd1YKeW9CMWF4Q1VqV3FvN2pwYlRsZVRrS0JVQTgz
c3AwMmhwcUtyM3N4Um9jMFpENHBNVmNhK2tEU1VQbDhjM0MwSgoyOVA4ZkxLQVNLTVdTcnI0Y2Uy
eVpFSXJCL2FKbGlRVXh0OXBRZ3g4eTE2N05Za21hV0dwRTFQanJlM1ZPdW1jCms0WGpsUVJlMlZR
T3FjVlVXRy9wY21PQk1DcGNhWHBkRWNqakRHST0KPWhMa0MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000035441706169fee8f--
