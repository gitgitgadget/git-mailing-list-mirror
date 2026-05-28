Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CA342515
	for <git@vger.kernel.org>; Thu, 28 May 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954077; cv=pass; b=lIzXn9L0TsKrCjIpYy1HvqQq1Pn6C1L/ED1i2mLHIQxIoF68K8rQ3EtT9iTaN2ko4EvBxI5qYx1Jk5rqS0SkfWwjJ/LeozDxvXHcEPeWNTvfulY/Owz6QBCRM/zlD4GCp+wsHxX/iowRNFaBCIwCrgCta3Wvi4DfhjWaBd+WftI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954077; c=relaxed/simple;
	bh=kgPq778HKP1UQ/AiHpM/OvbcHp2+w8MId6jtakY6820=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjJe9aB0GQJI15Ul83yIUTK6/xiV+46yPhASV9t3oxSOQP344/CRaCyliuE9ga+MyZiw5m0cjJIwXdEUHk4RBE61kZWMo4LObn8fG16DQwHktf1LJd0t0uUphhsz/6fRlHd0Z09Tzt06KkJ0/pEveL3TgrLaJWSbvL6dhyG47ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdVjccMO; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdVjccMO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso21176421a12.3
        for <git@vger.kernel.org>; Thu, 28 May 2026 00:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779954074; cv=none;
        d=google.com; s=arc-20240605;
        b=StCM1MHp5R3tu/k2+tXpz7BxAF1799HcZ7UEYN82rJEKlPR/HUhOP0wYsmSgGsvnZk
         c4nZN53OM9cmJSOd11o3eXDWsKiq8prAMdheh5WipwpJAgQF9J3UiMh7ELheB3FOAKnG
         aVsmfr8xojRq/uiwe5XgzzhNhMk10EJur70Y8rafy27maS4F18o6l02SiMoMrsxvDWLD
         wdJNe04P3sZf819Wu9EEtXgL2G7r54uV8Lvn5jkGWiZn19PykE7rjGD0Ctu+LYHpk9lg
         8NZ4BjgxCxicF19PlPhATlzoAP+kP/3KLzIAs6i8BHZ/gRW6OI2y1TLU8TjYxYZ53+MX
         5IJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aHiPmnyXlCx5RT8SYIEGua0gi2MhxaC4aQ7GtyYf2yM=;
        fh=ekZ78/AdMUVXAKhK6FbN5n1ji0JQG1skevRCO9fnTXY=;
        b=eL9jeCiLV5IjvJOJrgVVCL8v4oIcAyVNZsweRdDsmSfCuR0ydpvfIAJqHMSsHER6lo
         mUrh2xq6XppWr0/cOqE+5xER1JiFN4Kkagf4OSsGpeXx6xi0WLy6oz7tzGHL83zoIcWL
         9ByuvIub4Lu3E0It12R/+UXhhW7xD1OIQqT54se5WCYtmo74UD+sD7rDbCew2u1CtQ+l
         +5ochZvGJyGV7zemnos5mwT+vYgkF2MUP3CALdDCL03qwwci3BE0UwfHF/+zV+/kmsew
         XeiNwB5JkgQQ9UM8oxerfTLqnXmJcXY+a5qX+fKsM1FcqMKKa5rzfWVr5gVzWy+4c8Fw
         IKCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779954074; x=1780558874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHiPmnyXlCx5RT8SYIEGua0gi2MhxaC4aQ7GtyYf2yM=;
        b=pdVjccMODmyQ4uceWNlO3WgnRbsw13nkFdcG50AlTIzDLCBCUsAZiDf4DGHynN4XUA
         5n6zy9m5OFS7ni2j2DC64QcmkIqQAAZnN37jI9YYZZ0VbIeG1BHVzTfYp3b/QcJWKvZS
         VFUx1o+gqosztQ3yH3+KAWyk9IGFO+lmePLifE/jEC38Ts8RLLhsXgFyBCLYYjMj+Dfl
         7Rhl3tkT+DArV4PxmL2L3oWw7uuvEeNvD7cvea+8Ja63+O+EaWBZhLnO7hrSCKU57Xwx
         hcAtcPN3rPbb+mzZMjsF2qf5za/O82NArirOmVzIN7h0XE80/RFS1yTvaVg1rlbhNgFp
         Tjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779954074; x=1780558874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHiPmnyXlCx5RT8SYIEGua0gi2MhxaC4aQ7GtyYf2yM=;
        b=p7TqmPB+uqsEyo5FiVIDLdigCz6IUrwEO7gqbK3q3BXUzxvt1bF30OMe4eDKEfdk3D
         Q7NuCUod9anl97OxIDQBsQk7RFSKuBh9LSAuzqVI5WlVPVivH52qfO7gvoc0aVzZgsR0
         C85oIVgMFpwIo4Pn9y7X76q3xvNoiySohu31plu4cZUJBycNLX8vFxPSEcxCCs+WNNvC
         ZukGelpcUhzG4kdsrp2fqMqzUVwmlWLcP4GR34BVBkJGXb0ZxkJqTd1hCJw7fX+4rFHf
         9vKzqSDMKGWEDQRwqUtWh7tJjAs1mmnLDAdmNstLsBrhDID1Qm+dARh3knAW/ql7YLIQ
         dYQg==
X-Forwarded-Encrypted: i=1; AFNElJ/w07SBvePHdlUEby0U4s70wix8ypP1OTGApDzOrvne0eZzWFldkI9FIINgKq4uqsk//do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSm48DavdTtu09z8s3b80LB9tfosoWo1R+RtE9zPUrL+U2fAOP
	qbG+TuHXsnRCNkFji5qT8lP7X1/gkO7Ygx/z5Ghs4+Jbd1UpH+FGYrw+BBMD5Ad3J5vitS+vujz
	EI4igdr2H9vXF7dzU+2eFiM63PwVDTRY=
X-Gm-Gg: Acq92OFHuewrAqpLsQxwpxs4RImyY6nC0iu/OwbhAEHJysNdLKZOvayO0jWRBqg4MIR
	uao9n4USauP/lru9JzUnAkldnUQgJwRu017S75l7f0fhXnnJcsr9dL5MWBTdIlMtLHAUbxNn6UP
	+NEaRIrf6Bn+qOD72nF2OBxDnv2watPPZGSjG+RidCrOcUVPCGZdWVmQcv3L8Nf1iAVgPQTJ71H
	nOAHstd45MJlfpFghaxdlcfYkAUODEPs7kq8PopYDH9eGMlUftcm2G7CrmMX19qiK1hisABsMtb
	27R0G5dFUBmiDe3vMA==
X-Received: by 2002:a17:907:9604:b0:ba8:2ebd:dfb6 with SMTP id
 a640c23a62f3a-bdd25de289cmr1601346066b.23.1779954073889; Thu, 28 May 2026
 00:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com> <xmqqse7cjku5.fsf@gitster.g>
In-Reply-To: <xmqqse7cjku5.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 28 May 2026 09:40:37 +0200
X-Gm-Features: AVHnY4L9DaQiutNlm6spU899VqRCrg3xXRVDU9PI-vCr1ECiP017-vLDIgQrloQ
Message-ID: <CAHwyqnWjHTpWfbMcBHOabny5NQN7xTZmxew2yDWWu3AoosngWA@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: initialize packet_buffer to avoid macOS linker warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> According to Internet, Xcode 16.3 or newer introduced this insanity,
> it seems.  How about adding -fno-common to your CFLAGS?  If it
> solves the issue, then we can think about teaching config.mak.uname
> to detect macOS with problematic versions of compilers and add the
> flag as workaround.

Yes, this works:

```
make -s CFLAGS_APPEND="-fno-common"
```


Harald
