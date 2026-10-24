Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792862376;
	b=NhX65r6tDgny6WfpZGfTN3QYZv6XtZQEg/jfh92haY+MS5gCBLB0rv2qCPYrx7ZmLd/R
	 c/RTRgwixqye89BYRGfpJNVB0pgJBcptXmFr2jz+//+qfQFYzK1rfK844BM1/Mm2rhXzj
	 icC2gcOb9P5GF3oZo6Su1PdK8o9q1WHEnMI8nbZ6WxieM7cMkav5cAOhzLJYxdIjjktRC
	 lHWp4ofBfPTp9WRwqp6GyepsXpBm9lRw8FlTJWXMyVpPeLjcH7CdEvZSxBTSOuf1LWd3G
	 2t0cFUeEaJ3QvOGPcVJZDg9xznlipSRT+Kb7wNButwrrkz67bjhHZ1OK9HqhEUFz56A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZCw/P5gBWIN7xnHaawY2WOV5Pm5hZe4vz5pvhsYj5EI=;
	b=kAuEYm5u8T3BydAUIdtd2oo2ZBcpDOXMOLBu30DFIQS3B52+D02n+lj0OSqmEdN0bEHF
	 L6NZbzRHgMbH2J3vSKi/E4WhxuBf5eCpLG2BIYeXOCb6Xsd5N7w+ilQJwzmmB+8nmS/pR
	 D+tRM5MqYkJNLEyU72sfFeNwEbFhh7Pt7/AoF/6ypmcv3tCoJCgda2kLPRwlMoZQb0QKW
	 pyGn4e50+Txa3i9O83wTg9npUByUI5gGS1cH8hk5YyS19Ook0GWSE/2N/oO1z7mjZ/3Bi
	 QnYLI543ue3UyMZKDd4tewtEAth02yBYcvNQcEwpW8AdPVoBCClQHLHpQQ7sEegkzyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nLbWvuxf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB49606A31D
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 17:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EB49606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nLbWvuxf
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so3529826a12.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 10:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792862374; cv=none;
        d=google.com; s=arc-20260327;
        b=LRAxGfPQX3FGVeDtNZnZ0mPji4QRHFSSa9ekXumO0h/fl1vdZIFh4p7ubsvbubNBO+
         6biweN1b4SbUwJ23r03Hw2xyoB7ffCkSjNEi80c+4/sPfOfoF7yoBfaiSxNRj5byHjD3
         Q3PNpfZw46Mz6Yej4pwpj5gGdn0JV7k3xLvvK513PAFWcb2R8eRWVhoxyM0jUR9UoN5w
         qinYHi4X945Jl0qUvV13UP02N81HTpmI/uD4qHYeKruO5CavBO8yT7iMIb/BlD1VOU6v
         xrEscWQWhDK6WR3MzUCW0ilP+pEvTRLQ2k7lPWmuP1tKMSSRbnhyBglJ4IvY/wKtsOjt
         cZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCw/P5gBWIN7xnHaawY2WOV5Pm5hZe4vz5pvhsYj5EI=;
        fh=qSOEmY41u5mIXs5McV/s8OV+uFDzbGnDdUSy8MU6VIU=;
        b=hAoIpcgawOU7nH6ZV/KXQRgoOOyslPvLP7hI/LzAvbmG4apRb1mIbaimuva84nbQgX
         Q3Cm9n6B4p1J/+BgLrR8Lj1pPtTBYiLnm5HpEaQY7ioJD7uSWFx35Xr77sp7ZVU1IV7L
         aMjhbrifbARSAqNqpIP94F16UwQB026kb5P4sV9jbQI04nNFyr+Ma3/wTRMMH0Yk/3Ip
         3WZGf1PjwBYLYGtTYqRKT1M08tbcnsysIX2wZtpI2J7YzWZkZMsEja5CpbNatAXkAS/Z
         S1DQYgI9B6wfNvzsjhk1RrlraZm5QueQ8tsKOm7FZVA4oZbjLJDjvrJqcG3FC2wlThb8
         ySCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862374; x=1793467174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZCw/P5gBWIN7xnHaawY2WOV5Pm5hZe4vz5pvhsYj5EI=;
        b=nLbWvuxf6InY3i65zjl/AqRXC/6bzjY4Oko93E8vUhI0b1cTezUfC3QJjD7/eazv2n
         MDWm4VDfRX41Kiym6Xc55ancel17z9AIWDQOkmZlbmk9gGQJQtOkC3hP1Is3kdt8MOR2
         v5i4bl9AgAvuxvj2u6uD5Y74vXQi2mSXwy8hcJQ802K5BfHeIzWiibQ0z5sHEBzyBbmK
         Ft9CEiqDSsyspVKzzEr5UDxpz5jBBhmgWbzIq2Ur5VfQfdyFKMUm5KrzOVGjezUftkcO
         dNNoKokiPAlai1fCUD3M0eZBMzC3ChA59YATXkEF4sifIyP94jjfAj6cDBNBUJ2+lHPo
         bbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862374; x=1793467174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZCw/P5gBWIN7xnHaawY2WOV5Pm5hZe4vz5pvhsYj5EI=;
        b=hF+fpAM3w/7HmOAZYVBCGr//0pH99tRtQInJpdLRJrfDsYsjEdSOXc3igoVTV/zjzV
         pc4U7/ixPYnSyeYT3UsLPVLfhg8KFBZ7H1hy9tQA3yeSNUBtjmS2C4joVYjzg59d/nXG
         aXDvLuWfXx5IQqrMwIEZAFKq4zreZkjrgetM9hU3bnhbfCz5TAWflalxlwJX26FTSC8p
         nLJz03i2hEMXTMuqHuYZn/r7ial41x3/H1xJMVYlmDuNpbtaw2Q5UgZbt1UJCjZdfHGv
         a6FpDUkE1F17HOpuIEHmgU0wvvWjaYqdIJhF0V76Lo86hS2EZkxrwPKqk7/DUKGqu7Qn
         yM+g==
X-Forwarded-Encrypted: i=1; AKwUvByZSWFcEDppXyK3WRQJCdBf7e9Ytst3gEW74bSmcSchVS9uBY52tGtQ7ftNdg8X5wHKFD4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh8H94D+IxsphS1W4baT/ycelkr2dV9dOE3K32eFEeDtYWsQmC
	qtFqfrPpRB/tVJqypRsc8stTGR5ruH9FowArH9loc6FbGOx5yO+4TTypEnmbsdd1hZSsXV2w+eS
	3cdLnF6GWNM3QvW5g8lJAVcaWwepdri60GQlf
X-Gm-Gg: AYBFou1RWV4avPDCrUSYsuWX/sgJMzjxNculbUWRAUHnKozZk5dVagJp7UdJIBXNO9R
	3YQ7LB1b0VugX9oTrX/S454HIiPbprbaEynRnFb7rqgjK65zfrlb21+tlcaj7v8s1Em74C1gwWy
	b1T9VYaPym0NhV5QvXE4xI9N1znGp2DxTk6AXmPA/s8AQ0KJix+/tO+nICHtIwVQ4utyOpPQ3v8
	ShNYi1G05V6u8+P6aieGR/X5YH2AwWbIcRbjJZz9qqxbGD1NU2yZctiFFGZmrN6tE+3OEZen043
	9v5xsuhzj8AuzxyZZ/sOhUN6GJqCPpocye9TomKA8XPiPMwcTyfNahiuJO9kNlPghenr13dF31y
	uk34aDr3y4zdGKCR0r3V62BWBhRdPHnNkm0Q=
X-Received: by 2002:a05:6402:5699:b0:6b4:20bc:fa0 with SMTP id
 4fb4d7f45d1cf-6b442fe57ebmr2030055a12.13.1792862374351; Sat, 24 Oct 2026
 10:19:34 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
In-Reply-To: <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 24 Oct 2026 19:18:57 +0200
X-Gm-Features: AclHuK_U9cRQW7n1Aqp1ozbXv-vQixc1MHMVWVHd-aie51WpHWiLq47TeHa7Ycg
Message-ID: <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> remote.h says this procedure does "For the given remote, reads the
> refspec's src and sets the other fields." Ok, and glancing at
> refspec_find_match the idea is that "refspec" input is a query (with a
> src or dst) and we find the matching entry and fill out the input's
> fields.
>
> So=E2=80=A6 I assume the usual idea would be that refmap is a "superset" =
of
> the fetch refspec, since I might want to map refs that I don't
> normally fetch. (Or it might be disjoint, if none of the mappings
> apply to my usual fetches.) But that means that remote_find_tracking()
> won't be able to find entries for the mapped refs that aren't part of
> my "normal" fetches? Are there downstream consequences of that? I'm
> not sure, I haven't looked at how else remote_find_tracking is used.
>
> Could that affect, for example, --delete-merged?

Good point, I will change it like this:

```
 1:  ba7f1354cd ! 16:  4603c84d68 fetch: add remote.<name>.refmap
    @@ remote.c: void ref_push_report_free(struct ref_push_report *report)
      int remote_find_tracking(struct remote *remote, struct
refspec_item *refspec)
      {
     -  return refspec_find_match(&remote->fetch, refspec);
    -+  if (remote->fetch.nr)
    -+          return refspec_find_match(&remote->fetch, refspec);
    -+  return refspec_find_match(&remote->refmap, refspec);
    ++  if (!remote->fetch.nr || refspec_find_match(&remote->fetch, refspec=
))
    ++          return refspec_find_match(&remote->refmap, refspec);
    ++  return 0;
      }

      static struct ref *alloc_ref_with_prefix(const char *prefix,
size_t prefixlen,
```


Harald
