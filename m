Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793962620;
	b=YHKZ8dt7WWdUoUwm4R8TpTPpHhuPzT9jemO1Ci5z3cyd0+mWvUW0+3wskC0FJVp4zre7
	 feEaIS/RE/wfNng0Qq1z/djr65trZpex7EQ2aDteeJm3maSstBEmWiO5lKprpgJo0C8oE
	 llJpl47uyOsHgOwtoBdT934kUaU4kHMEKsMmPV2H9ZtueYwhCbgDnXA7vwtODAMDhtSoI
	 v6GkLb3Dgsbt6DQm1l8MW7BpFJlp1uCUw/COtMcYk8g83mbwNMg4+kv25PyCWmM7dg5uW
	 hVNyKTUx/waiYC9hb6nZernc7X+BXmhM8ikn+0BbJzYBvjZ7E6o6V9Vdzv5Dbhw1F+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MqGrDyA3cLO02VYS2DgYWA11nPzcGXgfWbF7tdX3k28=;
	b=WMNIe62aIa4/bAuON4TcSYO0lPmbJLKDZO4CI8m3WxjdR+wA+rhDYAcoxZzUBCo9xZX+
	 YtQnrB3faAM5iwtynzuNAjWApSvqrAwN4LGspnPTr4CBAr6Woqkrrqc6YGsX+vhee1TGd
	 KZLdypTBieBA7Alo+m7imJFpflBcQQFe2Ja73BSBfMtmPbdUBFP8ew7Q6UfxkrnVL7/6X
	 4XY+ZlW7CvdfxqyVH4XqlQPd/4RtiH8Rtk76mk+44NVWEckOZa0Q76qtqfZmTzBOoNkiD
	 Ebyd1cFTrzcxSDrdmmWehntFrdwU5LJeFWdU5paNnTsCu4RDKSifn+CW43n/1n0/rmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVF2QmqZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691FE606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691FE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LVF2QmqZ
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc013095d4so152107137.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 02:57:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793962619; cv=none;
        d=google.com; s=arc-20260327;
        b=b1gVtT0ipbR+i83A3+ifWO9KdKKEQCjNA6X8eDFrcTDODbLsx5m7eRBI+qeJtKgmFI
         qA5Poe+2uOCgAD4iX6K+n1BcT5jfyvZeK8U+CLf6fzAjyW/G5r59lYSqqTlKBcBOmJvx
         AtTEV0br/Cp8V1YXKeHb9xBUVVD1nWjKvye5CoOyU1NZZ7dxZILLoQwJ6CKFDi8DZZNQ
         mmBxBbZ6Xb1/GrSeiyCRkZCxUGCs5J6ToJko96uG2wx2R1bSKp/YaIy9/uE1g5Wnthni
         09nwd8Huv4a8hX3rQ0co4j3OS+UZ1xRRaIbTgs41lXmSvDZ9tE6Lu9oHh8iPy3Fx+rIo
         kuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=MqGrDyA3cLO02VYS2DgYWA11nPzcGXgfWbF7tdX3k28=;
        fh=Et4ze86M4MmAnYhy83HGz8v+NRNcMd/F80JvLqbhnBo=;
        b=bpT1z0j5u5+rTwVx8YoVDIpcjBQ5lfw/I17gP7zCzJ3CtQKjgmItQEFOYOzegAykP7
         9d5RncTBEHsnfiDv7QYI8AATBnseHlim+cFrXCfPWJgp5CLxcN1qqaIEVxO3wVxFEJbr
         qmNWM2FVVJrpaIuEg2TNi5Fz7zSq7dYPMiusoW7JDXuDOkF3vLcNE9DoTcM2P6ZWSe7t
         MZoCJOOwdjMBMLtRdj2bWJ+NXLasIXkWMykx8pzOzCldPlfdHnCuOvo54PPrVVZFwSyy
         kee5OxeJFeI6FxvBqkRFiUqamGrUJiFJ8frZkKWNSAYZVerjpQfCCmrUPXp9f4Un1s9m
         dbHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793962619; x=1794567419; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqGrDyA3cLO02VYS2DgYWA11nPzcGXgfWbF7tdX3k28=;
        b=LVF2QmqZCI10WP/VdDm/XIZmh56nulozBb1xW4uZ7YYj1uu19OoBoNlj4cXYwwcjQ5
         zGb0GJHrvKPwWRToCoeRS0bppzywbPVmOkv7U+mn74AR2fVSTBs34fghwQxFLqUvxAN1
         5BMHDWZKb3xoen+UaJpIQvMG1m/Q7N/EcYXGIpfozYjEd7BGzEmXxzCkUeSjdXyIn337
         Lhs36gjmJBx01O+CJw+9ql20zrkjEoZf8O+IaeHHnYmoDN71hS8uSGllhiUObcInahHX
         5fg23jhzLswxzSa3+jC+nBmqh9wNLvvQF2+dss9DS7jmOBBTpLqhPemp8iMhJZo04XmS
         z66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962619; x=1794567419;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqGrDyA3cLO02VYS2DgYWA11nPzcGXgfWbF7tdX3k28=;
        b=bMLD9vMiCefWYUNKazO4lPO1SuDyvp/yN86apm1QIhnVT8eG4xNaEOfPkgY82MKerX
         SYA93ymDcUH9hDOweWBMN3x7UVmMJVaoIFtib3TlwzDR5wTrnjGf1h8oAoC5+ZwVolin
         dlTn1BKQB7WL1+K8JJoXhQYelueY8MDQmoe3NAM3G1FYRba9tnODj/T4LXay3qNolu5y
         CkuKmHuxi2TOI7wrCymDND/1G4pQXMC1M+IOFGBKQSvhQ/5++CIfUBe8T55ubp5MOT4v
         QS4pzOd+2uHaJNCP/6MJUydRU6NSf5BVNFnQrenBQUMGbWTHGABleO1CMnHTaT+pe7ej
         hDqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxMw67os3F5KZk7gFEjgVgCYsgEqbnhsVY7OZrLDvyVyBz7gqseSUK8raJL82FS/bqmzS8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oHCfSQrfcXQjTvMmCgzJKAY+TiogoFhZAuMkKjK3JywYqJOLL
	S2qE5NsOz3LXp/K6gQtNNkuKETHssLBdVWxsi2L9nTYkJtpRSF1kW+XIFoH6EbqRYe126gseOFO
	s5a1ai2YxF7vGiOqtzMhNWUBYv+l5hKE=
X-Gm-Gg: AYBFou1EuJxIzZa+pLJm2BZMqGEWapxQdR07tlyD+qoNpSblzH4N5vEc9U6z8wMw4Uz
	DFfg4hGT/hYaPWkFIR8zqMLrdejya6Tw2+jXp6JKFz9dE6wTdAXwzR9DZKBKPBBCMbv86Y6bbmf
	8K/kry8B/G+tZ6ZkKuFPkhb9GlKAodwciaAcVcfWSx4EAW1T2GrayRwVAJtfh4txmNm4cAXG4lL
	ciRNrUqRT9sEO0DKjoT7f63S9pTpI8vCd3QSco49LaVWnNZKbD8rWPAJtWizmfycRWRbC+WvGoU
	AzDb3IQFsrukq3ydGDwa24Z4KAWIfHqLApVDwP2fYfIKfgWd+07s2et2qTB1LNO5Y13T2dnelAD
	FCuu0j9TUy1SMV2wEbTsnG4H7Pwb7SwERJ+c7xPdzA9guImzqkRic+oxOCQUpicnOZm83tvOtH2
	Msg/y8WlugAcu26sfnwJDey47Jt/o=
X-Received: by 2002:a05:6102:6e87:b0:7cc:95ed:3147 with SMTP id
 ada2fe7eead31-7d2a16b47e2mr980285137.34.1793962619307; Fri, 06 Nov 2026
 02:56:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 10:56:58 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261029-pks-rerere-subcommands-v2-10-07d5ba18e882@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im> <20261029-pks-rerere-subcommands-v2-10-07d5ba18e882@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 10:56:58 +0000
X-Gm-Features: AclHuK_2rZ7yhLzsa5PrGMxJBCLo08ltE_l5LvnXYE8syCEbyqRcqwRiKoILjSI
Message-ID: <CAOLa=ZTSxrEA5bq1_7WdjLOxGoZ5WXma0kb24hDAhfteVpXj6Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] builtin/rerere: turn "gc" into a proper subcommand
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000aa323e065f9978b9"

--000000000000aa323e065f9978b9
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> As explained in a preceding commit, a subsequent commit will introduce
> proper subcommands as supported by our parse-options subsystem. Refactor
> the "gc" subcommand to use parse-options as a preparatory step.
>

Okay so the commits till here are mostly straightforward extraction to
prepare for the subcommand introduction. Reading on....

--000000000000aa323e065f9978b9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b5e21f70288feb8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ydHNuZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2dQQy85UWVNR2ozTHRLUmZVd0JGU0ZwVmMwMEIrNwpJS3dBZjh4UXR0
WnM4dGR0azdIV3lsczhQZWh3UEltZ2hjbWZSNkR1aVR3cFQ1RlA2eDd2WEY5OUNkdU9XY20yCjdi
NndYWEhrMWk2aTB5ZEliZHcwWVlGQnRDSnc4ejYwUFdXQ0ZUanliTlhXa0RXSU1NRXd0Nk1zZnFw
K1k5ejQKdlZzQk9GVkNWZmgrV3krQUY1Z3VZcyt6TytPNnh6TnJUK05JR25xZmVkejNsbnFYWXl0
aENsa1JEK0Y3UjVDagpOZ0ZlQlRnejFXMUw1dlEvVnQ5bmgvMFF1MUZlbEI1bmx5VkNNSW1HR25N
NjdDOERNbThhN244Z1JGUWxvZzJoCjdRK1pzQVR4QWtDS1B5ZDdvV3AwbFgvUE5XbUg3MTc0eVd4
L0duU2NHR21INUVhYWRYTG8vV3htSkxJZThzZVcKWmM0WjJPRDJ6Y20xWEVHemsyNEN2MEpHRnQ1
MENzcWY2N3Ywc0sydGFHdnQzVkdTYnRkTDIzVGpCV3Brdm1YYQpOd2RvbVRvaHZNL0lJVkJKMmVo
UnE5L3AxRTFiRnk2MjlzTDhkM2pUcHBhOEpRV050eE9SS09BUXNUN0tiRjh4CjlWZytjdkp2UEZx
b09wM3pJTDF2aTJ4T0Z3Vkw4NkVtbHlPTytTST0KPTV1bnMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aa323e065f9978b9--
