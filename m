Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792593121;
	b=A5W89ITT/+I0i+g8oHHEwagrxLmm3UDfI8E2PsnUZlVIc7+0HR4xkUZO/TF6F1q+m+RS
	 pn+8YxJvuecGsJ8UenDfzLPH/HSRXC2tFdN2iKEPL0feZJXiRU8u+lhUq164s74A2JPW2
	 kHb9Hg5L9CGRwOG5/Ax6yaWw9Dc28Yrajxec+nDLTB0PAnzOauap4cnP+8dKJITbWCkvE
	 QGUzype8R7GK9wvwawiVivv+5LqvtsYhtobuC2UpSKT55tSTMw/x9EmbMH9pgAPHldnl/
	 qE/tGhqbNDp047TL0DrArPnsyUaTC0hF+YYDfodKydM/Fove/gkr7vqu4peOh7BJgRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=/jITt3a0vndGCjOsL9s1I96Yylw6b5Tf8UcDnB6cpAk=;
	b=L+YGU8k6oViZDHiL+IXAgbK6bMz2jF9qY/kskWkbzv+c76asvXXQifNKAdh8RtKuHL7H
	 TqRyU+lSwz6roQR19/y8nCojhPvHqZ04zT7VYCNJ9R0FQE7RTUmOG9vbCH+FBtDw+UfI3
	 441M3Aon1ow3LLP2CoYnvhaiIhAYZu+kffK6JeKCKLrjN430I7p5BRgi9sk9vmPDMNybD
	 MAElPHx3ITTpIHiRbJ+jS5eGaUoDgwrvQR4ztv0gbdct3qhHCW7eHrRhuoZiMOxoSzCmi
	 R/Sss1794qw4bqZjequUSJj7LI98OGIcWsLt0P1/tXYZqOIVt13TIr6p+wBNnrbftRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI5RBbjW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F352606A31B
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F352606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bI5RBbjW
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99075306daaso426252241.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:32:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792593120; cv=none;
        d=google.com; s=arc-20260327;
        b=AVX+YQVcRCrvV07Vneyp5I9j8ewE6HPK5lLoAq+IVlNY3Grp2jSvJZ4C1y3BHSG+/U
         ef2JaguGf1iixuePcs2SZmvrdfh8JfWmt+U5yYeEcdSw7+u5OTpjDieB9bKqftZ/23zQ
         KDNKuB5sozrLdRQh65Kz08SremCX0vNSdY8mcWZ4+QzhjTEnMchJNie1C/fWkHGgyLEn
         qR+lqs8AD6FJjyVhOK1b1QSu8zny9+tnDqb8t0Lh71h+rV7s6dCQbZsQd8RI/sM7IGJV
         /RAKNgNSYAkwI53PYq+2Jr0XrmoruJk5XcXfklVRxxHvGqu9lMT5BYxXGH0f4sgvfV/o
         eEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=/jITt3a0vndGCjOsL9s1I96Yylw6b5Tf8UcDnB6cpAk=;
        fh=FqHd+ogawzL+7cR/mhGHQv+U1AqzRGLuZg5kDQg46O0=;
        b=qE1uTysuhUL78iT8Yk+B1wJM5lUmDjMgmQ/fiHq3hoqgQGNZsPLhKUqBDvB6iymSN7
         quVvz+K3Pk0aHgYEMQuHYbn5eFexNIXTPVPH9rwBb4nPBkaUXj4+hqwWTxrzYOfm6JwU
         pYG8i8VrmJ1z273pBliZ4/G10Kq52ZJvb79v4eCEymyoNGILmPvJ4+ci9lU+LXY6W/jT
         fe6on11lViqSj4lCVCKSbqeqDxKnMXS/t7kJjwisw88DP/gJgAwVBxXjBuvFks0DhmZ7
         f7rz2VcNhWb/qgxVz3evvtkRb7HqYGSLMLa1ZUkrfVQrb6HI7zNr1IWzG46w6EXN2DRH
         5i0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792593120; x=1793197920; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/jITt3a0vndGCjOsL9s1I96Yylw6b5Tf8UcDnB6cpAk=;
        b=bI5RBbjWT/4637fuJwB4DSAprWeDy9YKG7Zu19nKI/ycVtEgXGkanRae8t79OgAYvz
         LWLgQ4ZUihrg4hmG7ck64EsXJU/U3MXhUoClOhaM53Tv7/frtUoQhkIAgIRfR8Ghh02g
         oM5rzypycPlvZngkvSpCZlM1Ntb+90ueD5rSSW5hZgRbZBJAsOHonm/+H8hAwxCU9vct
         1z09uB8if9zX+1uf208SxPFmn7/Corzdn9Y96IxlDULwHVc/T9QVJ54Tdi6iTAviTRUl
         rcYf+/e51h9nZWxXCmiSzrPd8wS6NLdIoCtTWLq5kYOBlH3LHEfY6SZRpRkLtjoe3izP
         5NwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593120; x=1793197920;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jITt3a0vndGCjOsL9s1I96Yylw6b5Tf8UcDnB6cpAk=;
        b=VkjUOx88UwwhnQOeRLyuWJuz5aAJ/POSHa7xbeJUEUHAu0cI7UKZ36r1yTnSbzh/fm
         IkkZSuymSB5+QD6VeXtP4RCrWCMNpzwuiLsAWK1qv7MQlhatBNC79ahRaE6QcNwmIbTa
         +Qf/3z6YsmGcQ7aoA6zEs23DDOU0vj5Al0Vwrr7vM9eQ7KV7V/O6cN5Gq7vh89t3G7GB
         RFUTBUaBsxTWu9hnzk095bL1cRyK1/jD2v3GXS9665B5P+T/+9O13bygz0EA4Y0MVKcT
         8D5q2YDW2X5YJwDTPAHC+abZ6Q0ehLaFtfT66zV7p1BGZpUnzEojkbdRYL2bCrouOMmW
         wqMw==
X-Forwarded-Encrypted: i=1; AKwUvBys/QWyxPyEzGYjIJioww50EvNVRJjiByzCZD+9M16TFYo7HgTn6lmtE29H8sam1NWzwcc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ4LlFokqSq55KHUhN7fsfa3pCTabpXDu/0j2Kc2lJMvencHCe
	5g2qtXPzbRkjZbyLHWXj4sp584nfAUa5nvbllW8fpZimcFKR5TUECRKF5eh5erGCiiz9/dRw7HW
	alryYrjfoKUjKb4e2Tu99k2iekAXLE36voQ==
X-Gm-Gg: AYBFou1moy47FDn9sOGHlrHZt6r35h9ec6f2YYPPeca4k3BXa4CknrPHTNMY44FRIpz
	HTUR3RWCn+YDUqkvpsF99RpjCJ9LJzHpugwISHvWq3mhzHxU0L51xa6Zmpgw+WGadWntSpILy4e
	/CcLgJpIlLI6Z4LnpJBXqkURdNynkTTBfUuFCEB4nT8CdYj3haLbUD/GXpj0kT9LnesNvTuGmHh
	Qf5BKrg/7gaxDhUne+jvVjNy8f9IiTiKVKnrrpr8zyKUGcRJWryyHybiPccaw1yphrpW9JVlSiO
	l++zTO9MLxsVA5bprWE/1zLZNRu6DH3YuBDtHAwqmbO2SxPJAZQOWReud6WfxFtSwu4jrPPyDZR
	bt06MInLfv2hIxiDz3pMMbkrnrMO4E7STKeqN2L3DSLtMs8r3JlFTOj3rAhOwK2HL1i34u3+KtX
	H+JaeuNxvQQ844WmVxTq8JnMwBGXA=
X-Received: by 2002:a05:6102:3c92:b0:7ba:9a61:23eb with SMTP id
 ada2fe7eead31-7cc9276c9b0mr853897137.37.1792593120300; Wed, 21 Oct 2026
 07:32:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 10:31:59 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 10:31:59 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im> <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 10:31:59 -0400
X-Gm-Features: AclHuK-YPUyoqvDYB89ukFtGiRCFBnKufHfXw4mYezKAi2l078tg5wHVKwqxwuk
Message-ID: <CAOLa=ZS3vbjY9yxx1TCaAtUp5D5KeQ+qiB805SPqhZT7NX+uFg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] odb: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000029b33f065e5a9c72"

--00000000000029b33f065e5a9c72
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series introduces the object storage extension. The extension
> is of course similar in spirit and design to the ref storage extension:
> it can be configured via "extensions.objectStorage", has the same syntax
> with "<schema>[://<payload>]", and we have the same mechanisms to
> configure it ("--object-storage-format=", GIT_OBJECT_STORAGE_FORMAT,
> GIT_DEFAULT_OBJECT_STORAGE_FORMAT, "init.defaultObjetcStorageFormat").
>
> For now, we only support the "files" object storage format, so not a lot
> of stuff really changes. That being said, its optional payload allows
> you to configure a different location for the ".git/objects" directory.
> So if you specify "extensions.objectStorage=files://objs", objects would
> be stored in ".git/objs" instead.
>
> The series is built on top of c51408889c (The 6th batch, 2026-10-16)
> with the following dependencies merged into it:
>
>   - ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
>     `read_alternates` callback, 2026-10-08) merged into it.
>
>   - ps/setup-enforce-repo-passed-to-create-repository-has-no-state
>     (phew, what a mouthful) at 0ba59c8453 (odb/source: drop
>     `read_alternates` callback, 2026-10-08).
>
> Note that these two series conflict with one another. The conflict can
> easily be resolved by just deleting the whole conflicting sections.
>
> Changes in v2:
>   - Ensure that `repo->object_storage_format` is always populated.
>   - Link to v1: https://patch.msgid.link/20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im
>

I had a look at the range diff and it looks as expected, I had one small
cleanup comment in 5/7, but its harmless so I'd be okay with it as is.
Thanks!

--00000000000029b33f065e5a9c72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf95df038b4f5474_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWXpOMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxjQy85cFEzeThYVndVUWxnNzlMWDcxWUlNUjU1cwo0dThwR01NeFVL
WHF2N01tOEVZMXNmZkJhTVZ2TnRpV3lhRWlCU0lKTjl2NTFXNUhLK0c1SzBvKzl0WHJ4cHNWCjhk
WUNMUGFXdktNL2ZqalowZ2duTDVYaStoRldrQjRlQms5YXhUMjBVbUxyMWU3OVhiUnd0ZGlnd1JG
VHc5RXMKOHM5YmJXc0V3UlRGamZRRHFRdUxIOXRsRWNzMDRZcDRUYUwrS1lCVW01SDExOEloeVlP
N3preGhLSFU0b21ZagpoSzFEWkVMTUQxUUlnNWZYWjVXM2poMDA5U0VVQ0JUWTNWWnFDOHVEWitO
ZTUwRk92SW9EVW1zZEMwb2Vvd2RNCjZ2NVdFVzRyM0VLdnJkRzZ1NU9sS0h2djgyL2RWTXZISllL
eW5XeW9qSEs2SnR1SXdtZ3FVeDErSEdkbnMzTlUKUGFra2o5ejNVdmkxSU03MUp5ZHlKNFA0NWJk
VUdGQVpSNHRMdzFGTGJocndML1gydmxsY1BpS0FKZUZiSGVkTgplQnpxMHZtbEpHb0FqbWhrcG1i
dkxjTk9wNndFZzUzUjU5Qi9mTk5iNG8zcTJnSUhYbWVQSXlyaGZIWUV3L0t4Cmhzb1lnaHdFTFBu
QjlkQlJ5bEFrQ1lKTmhOR1hEZ3k5NEFxNElrbz0KPTM5RHYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000029b33f065e5a9c72--
