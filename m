Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF4384CC6
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317903; cv=pass; b=jqj1zvb6cAHM3ho9oGD70PtkrbYU7lY6M06WHKcd+pc1a9lRhg7Jv+j6FMY0MwLtrTb1aAEmWBL5DUPBNKLmqgL2ud2JgH1h8RzCDZhhaR/iY3qO8JUeV8PPqFf/I9aKdNzAbM3xtQaE8uddhBEPIfxG4WQyVPeQ7rlE1E6YXgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317903; c=relaxed/simple;
	bh=0TBONhgM2hMRjWYxLScfVLqm54e1gHv5xOYfWCfA5t8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=mL4dgFtXrlis+QFP8WwrdloTURkCuF/ebAjD4gRTMTQsnJZHIWZQe3vzRM+WM1n9cpZSUu9FAuiSQBI0ZaLfMMD/O58qSkzu1GbVmdcmz4PBmBxTimdJIDEzd3joi3IUNWJaWS1vTLOHJ447WS3r8od4d0Yiz/y38bqN2yizImM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEwfUqox; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEwfUqox"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5e23be41cf8so426513e0c.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791317901; cv=none;
        d=google.com; s=arc-20260327;
        b=PBtzU02IudN4W5qR/BiXAjI3AYiDPB3AP7F+tH7pPEqY1fxeC/PcizrOtJ/7J0+eBz
         KmO5kkbKO6aZi8DxOPFMwB/qIcdQnp+Qohy6nh726cnekxk2Z0wKNa96AxiUxmwP+vlZ
         9evdoMr8KhV0d1h5oM/58GtUttfgXzz3ECZG139RS3zZPPKemPNRNCrwZxW+ANACek4P
         64LxdGMND7ifDcj8zzJXUdQ/WmdaKRWfSeQInIbSIOjI5oKBvGECWNy6/8zQJJz1k2mD
         Qr7XvxsTDYKhtx1x1wgSKHDVBNuHcbwyDh2V7XskyaRO73UvuhlT0HGtbAn7QkErJp6e
         6vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=0TBONhgM2hMRjWYxLScfVLqm54e1gHv5xOYfWCfA5t8=;
        fh=FyQq5Gz/M/HhclKfrP7iXU5fpQqYLH1hvRW5P9yXgk8=;
        b=rI4v/zhfCb+EcmYaFh9SxiBC9MewXTnWbx9qFfV8wcoVmS/EL/tWRnmPKeIdCPJlIq
         KyWv9ibon/DhWSxKw4hOKVrlzvhOEs5nJ3YNP1yvZlL5kuicqAjWfrAqWEl4Sep7Nt7A
         UK9jwiHv3q9rwIjIMcv9UdDaqmhZLtZg2IX4a/ReQG0gdwFPjTdz8wVWgkUHVyOilc67
         qpa4KGpfsax1NYqTaagZR7g08zUHS7IDcSOtkqTLll32U7MJCniI0ORk9VSy1P/QuOtD
         rge6pFJsh+BMaExOTBQiJdN83xu2szhAFMvHv9fndTL/ih3H5B7AWlPQsO74VTjp0gro
         E+pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791317901; x=1791922701; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TBONhgM2hMRjWYxLScfVLqm54e1gHv5xOYfWCfA5t8=;
        b=aEwfUqox+LXa9Em/cS9xxTBTwIK9qF3GKMW2aikINHcJR8FgKgM09sbOayHJA5Hr12
         nuMdvdfv7R0S1Lq7zyWL6SzsjF4VRftYH/nIECUZgddvDnVt+GJdUHCAmlAMNXceoBVZ
         ex3rI2li4VnUzodQBCkQ9cefrb34xqOXzG9jndFL0EkMCn916sNt3XSrrM4hB39lVf8P
         njuMkc6qOQzUYNqqdzgWDJnTKbnwvy+vdCcSQahTcXe5tyvKu3EZ5R5W+r2Z3XDQHO5Y
         FicKoTak7FAsuvSnm4LNoysvIpYAGx3UP8mkVEKHxd9ZC721XEsW0pelaYH0G0LwODXb
         pExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317901; x=1791922701;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TBONhgM2hMRjWYxLScfVLqm54e1gHv5xOYfWCfA5t8=;
        b=PTt97nmb+wLwHz6Mw8pK9cVkBQlmOxXG0XZCsV6G7ACQQKa2KAFaGFukFNQMmxnUhj
         W/TPKdJ9w8nsYw/GRimIsLJu2fe1DBW373CEZRL5K37EHkItpvAbY0d2M0uAzHG43D3c
         GdcuevdwDJzTTmuOXmlstU3+6jWmSChLWDlOoaefdzQy5suOieZL8BCR7s9VS4dn4L/F
         IA8/ItkN7Wmw2l6p3BbmUxEErO1LBo7b18ZleC/fCTFXPrcxSTE9guICp+JQ7GqXA0RZ
         CfbH+DwcwzgWnVc4K5PACJqwS+eyZWJxOFnZP3/FjKN94pqTEgcccWwzTxb7P0gWeD/c
         4ZDA==
X-Forwarded-Encrypted: i=1; AKwUvBxVBoEtJFT2osdHlOHMzu9cyvgVL5kmgJnJjZWx1zaf9dt7MVPAEcbUMHfdFh8gJawjvqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvpXYTX1ltmfdM1EqdrmkG+JAS4QowmAHyRg0aT3hx8SzRRadE
	nQ8mErmMT/71leZVBlzlplMuNH4zL43ZCq8OdZFYG5KhJaOP4Lan2tHrEcR0K16prE9FpHEtlcb
	tywNGU+rBOe9CRtswBV5Cq/Nl0Gw7kFc=
X-Gm-Gg: AYBFou2Qsj3+ZcuAE2N0QuoZ2qhZ1nhVeonG8JKC0feTM8v1q2505cDhLO6qXzhmsHB
	GWM3CUkngOhGF/gSEnaxYcLeq4B15ID2SayJQljcYulc/SPMj0Cnb6wrOs7hTZR6lr87kJdbN3V
	//F0GpzoS4T3HXBa3Ks484ie4sj75o+DSQ+bwhZ6dwfw07sU0ST9LNsthJh5Me74+Dtz1KDnFR9
	KbPOF/GwXmoj9ECJjjrYQo02ApmHstjQ1xEXlcJ+zGoxejPxhVjb7333lGT3eXthbw9rxkxipyt
	AGVh9bNvWKZWodhTRDSz05tYj/p7ruwhyk8An+TyDP/bb5szkU/ecgS9cZ0Bi+Amhs6arTHs01D
	O+x4O0h6mOP6n/Uig2R7s0WZaCrJorKPwEKb+ZkNZSZPJ4A==
X-Received: by 2002:a67:e713:0:b0:7c3:9b8d:5124 with SMTP id
 ada2fe7eead31-7c87c3ddfa9mr553786137.18.1791317901014; Tue, 06 Oct 2026
 13:18:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 16:18:19 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 16:18:19 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-8-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im> <20261002-pks-odb-move-alternates-v1-8-8a63507b88c4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 16:18:19 -0400
X-Gm-Features: AclHuK_U3Ghehb1GZqsVXwLdoXi3UghbWMAEx_vYb-CktaAv2zPq8p7lIeBy7fA
Message-ID: <CAOLa=ZT7tOCBtd3hHfXgkFaqgMgCt99HquD=hZ7WB0g3PbErKg@mail.gmail.com>
Subject: Re: [PATCH 08/13] tmp-objdir: manage quarantine as an object directory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002b9476065d31b325"

--0000000000002b9476065d31b325
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When creating a quarantine directory via the "tmp-objdir" subsystem we
> create a new "files" backend that new objects part of the transaction
> can be written to. In a future commit though we'll move handling of
> alternates into the "files" backend, and as part of that it will no
> longer be possible for us to have multiple sources attached to a single
> object database.

I understand the moving of the alternates to the files source, I didn't
grasp the need for removal of multiples sources from the object
database. Wouldn't it hypothetically make sense to have different
sources which use different strategies based on the type of objects?

> In a preceding commit, we have prepared the "files" backend to be able
> to handle multiple object directories. We don't use that mechanism for
> alternates yet, but will start doing so in a subsequent commit. But with
> that infrastructure ready we can already migrate tmp-objdirs over to use
> this new mechanism.
>
> Adapt the subsystem so we create a `struct odb_files_dir` instead of a
> new "files" source.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

[snip]

The changes themselves look good to me!

--0000000000002b9476065d31b325
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 37b8d2c2021107ff_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRlY0a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meG9qQy85MjhMWGdaeS9FNTMyRWZ3N3gzZ29uNkZMTgpZVUIvcDRCOGRQ
KzR1NkpYWWRDOWRBVkpGNkR2ZEhxVllBaUFOY2F4bEVPT1Fra21JdVlURGUyMEdXMGxnbmhMCjFk
ME12Si9VOHNHVUZXKzFwUWs1ZkxWRkh2UzVtNHVGK1dyYmtZSUR2RlpWalR4OHhWb3FJSGtrQ21s
TmVUWC8Kb09BS3dhU1JydGZOaUJPL1lOTCtkMzVuZFVpS0I3VEF0NnVCSzdWemRhU3hnM0tmV1ND
dXlScHRWZlUwZ1o5VwpoTjAvMVhaVFlLS0pMeVl1ZmRqWk9vR3B5Wm5yNTA2VFVYeTM2OU1WRXVw
R1M0cUI0ZDdnSGJCREY5RkNRVHhDCitUUldzaUdDdTZLZWg2QW8vR1U1NjZJL0xaSWFhUVRwNnpp
dXBHOWptL21OTEwxS3BmT3hBMWRWWWNVb0hQbUEKS1FUelk1S1lQR3lCYVJaWWdFK09vekUyN3Nm
TmVGcWhOU2thb3puMWl2TktaMVpWWFg1dWg2THVpbTNSZkoyKwpTTUFEMzdPV2RqYmsvOXNMQXVN
YkhpVHl1MGJ0OVF2amlId2YvNzVkdElxWWNjMDA0RmFLZm1vV1JURlkyWkE0CnI5U3lxVGlWSi92
cTgrQzBLSkgxTDdhNnpySHp3ZkduZ29vRDhqND0KPXZDczIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002b9476065d31b325--
