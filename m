Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80035B650
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851145; cv=pass; b=P3ZoMn3GR4qFav1ExOHQmZgkswET03Lz+wOJTzAMI/r7ZcO+IqBr2v4S5i2Tiu+dW6oi6xMGu1bPQ0uNQvtoszUSV7VEV01iJkdz30d99d1alQQJIBlzibNmUSeaziYzGC6nZRzskHlk+M8H1bSeAqB29e4LVKkyUvOUe/lWRzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851145; c=relaxed/simple;
	bh=T4Pqc+3b4/IjkX2IOwUvg+y1zEy3NhjFHkaJvGOSWp8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=QdHp5KADVhWY+2j98r0bl7DIQC4g2cUeG3RgNGMWY9wxaaloU6+MgIFABISzWZ0owQLEbpW8BAET1FgrSg9HLr7TKd/JuGjAY4rysehQMzUD72H0oo2fuQBwaAiOTfk0M/rcBEL/qtRUnXs2DmK+PrJcNNcyDvbFqaq16ZXu0UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyljGQll; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyljGQll"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a4fb331cc0so606672137.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789851143; cv=none;
        d=google.com; s=arc-20260327;
        b=fXzmOfsoIT95BuZ+Ir0/eLJF/6ICqETQ7pt6lW60akhIrNYDstvxsilH96wUpyS3oH
         1mn/J+0cIguUWE02diLV+VBrep8/PhfjmI/OdApLXqyhKG1gqHte7fBGQjTE1sZwfEYw
         Go04jPEzyKIbUj6Ft6RFELLlTJg7/ca3wz51BClroTxjRfR5fw2bMNzAETD+YExF1ZRX
         hLss16cAQoh1ZjLPo2/GIMzPn+XPSUf9sZPt/53HHYYRoXlDG1ahzFzJqyEuXmcHfTz5
         UpBMIqhbVgJt/DOgjtkuhUEmf2LpOw+UKsJDcFyZKtRm+KwuB1dqeceFRb9N8Zi2/cjd
         OMvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=LhUPBUEw5ix3Sy1A8Zl+1hHTp6NS/NrcKOoBNzNS1EY=;
        fh=vz0jbdUCoByp0NNEz5ix6tFQIfX7cVnZQPkMT5rXS3s=;
        b=UoiR62KBNvct1WWOJt9gQt47w73pJsPEMOKTyR0jYxxL92TizNnzpMBN4EvpMVhwSe
         8X7xzKrJl7o8I9/r3gCfKJO/Mze26wbwsGUcMfmOFMO6xgsxcMMAt+wwVOTxbJUfDtN5
         4DiCx8AO9k3tDknOIDzUBf6Z6tNbizr28RtEiKXI+Doh4kiKKD331caIdbQgORDea2RD
         RQ8BMd+ynbuLYIg9AjqXBXU50TpQ9xP/N9LwL6y0HB1IdZlmV3SZpU346KT6rne2Tgib
         cUoNk2H2r9I/GdeVkoPpMsaOi+hIBJ8K+blP5l3uby1/5IDnKewo6AU02kRwDOR6RRhx
         /rFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851143; x=1790455943; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LhUPBUEw5ix3Sy1A8Zl+1hHTp6NS/NrcKOoBNzNS1EY=;
        b=LyljGQllakDgZUTjrYQe6tKSEnYA+HohUss5iy7bW9/x4MMOvWgUP7jj6M5sQRvgRW
         yfpCev3JnjR9VjL+XbQRcfvob9pnMxRgs3YMqmFGBkiiK+evT6U8BikqxcdFbQ2w3Qrj
         awTiXUEvojjCIU/Hxbx2O8zRz/PMJ4KiX3qACBS/naBB5vMF+eF4Zj3WDNFoA9SkCMP1
         Hc4CtRD2Gq1+dIdlKjJoN4GH9WIOMXDlrlg/s7jGgQN6GfrtO7jvG8dJahcyFHqC6nzW
         H+0Ey1mZtmWFvmSb+XFKc78bS7a6Jh2jQ4oHPr0mn46rmWO/2kCmeipvlD3AqbHA11BX
         sK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851143; x=1790455943;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhUPBUEw5ix3Sy1A8Zl+1hHTp6NS/NrcKOoBNzNS1EY=;
        b=0xL3IRT9dOfMw2nYvpjjbmdhHQluoPI+JNds/Bb7Fwtw4NwIVh3+nCp7DNPDhZv934
         37DAb2bOkOFbXXi2pkxKHNYHK0PGvPnckx5VetghpydS29J4Ao/xo0LgTPvVtvekkc4C
         Ay+RPv7DRV5sRPbWGCLa3Wb6jwsayNMO+92tGCPv1eycMtbBHiNOUfbLE+E+r9tdJ5Qs
         bgyyjOK4BTuLMhzdDrC911P6HeTQZ9FFGDAAo1OJXeesLMWaGicaMxzjSAkxrBQlnSeu
         NddSw1PVjbwgXJifGGfnPby2nWPUijfmbaHvVj/oBu65KuE6Y7xKVYb40IVuNUFDQgIP
         YWhg==
X-Forwarded-Encrypted: i=1; AKwUvBxnhMSs1AYPNqgXuhr50nmbL409//qQf1G2NxmqVTBzK1Jk1VAshwozs2xo0/qw1HNuP3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++mVKsEmuPIZI9ysZtLZZIAgjFEs9SRPKPMYAP7xGo8u6CjAW3Qv
	zXe2rX7KDvuQ9N/DgYmlqH1XJ1nqvuPAwlW2GZ4PJMss5z35kC2TfJgIHgLj3j7IGO/0VM4jQl7
	2I/nrod91GJfhyeH+fK5LQQKtr/IqpwxE6g==
X-Gm-Gg: AYBFou3Cj0UghAruKUVwjlg/ZHsfsAdXS8MUVS5/rfs/TxdMDie3L43evdMJV8A7zHy
	fwrjLO94HARkLQu+KXdHib/Z+J5pzXlhctSVb3MpGtAPh3xqLKozDjLVa28HejlIRdyaDTm3hso
	Lvp+4CkycM66l5ACOIl4wz4apSvMIcPGt5OSixWxC/U+SYhHdE98v7eiZAaftOQTTZ7DEIuQz5M
	x2kRWIB5RGwES++OOsSs85y+L+LcDT0cJcG+eZyoRIu7mvQkKnILYE2ygDZ4TTbveVG3n+R5tvF
	tZi4DUr87DqOtbnTaZXUvwHvykg2oBmO63ClWy6eqLaHrdq2PRO4131jur+QYGCULB6ccKWrUnf
	Mv1ONwpJaaOU8oIpesDOwUfdAcC9803p1PuLXQk4HK8ctPQ==
X-Received: by 2002:a05:6102:5345:b0:7a7:195a:1b23 with SMTP id
 ada2fe7eead31-7a7195a1f91mr757025137.29.1789851143197; Sat, 19 Sep 2026
 13:52:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 13:52:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 19 Sep 2026 13:52:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CACQ=SRHCOCcmVCgHqd+sjMsZ9LCdSHuXdCo0gkwxXwYgF7iwig@mail.gmail.com>
References: <CACQ=SRHCOCcmVCgHqd+sjMsZ9LCdSHuXdCo0gkwxXwYgF7iwig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Sep 2026 13:52:22 -0700
X-Gm-Features: AcwNN1X7dkQIvKwER30mpJ3wAtD-kLULuVvIbasi44JmXUJTJnX3-pJJOXr4zHI
Message-ID: <CAOLa=ZTN1TU2A1sgEhiw=ymMYr6Ge11cMEubSaeKqr4WNU=2EQ@mail.gmail.com>
Subject: Re: [BUG] reference-transaction hook misses destination of git branch -m
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009781db065bdc3125"

--0000000000009781db065bdc3125
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> Hello,
>
> `git branch -m old new` changes refs/heads/old into refs/heads/new,
> but the reference-transaction hook does not report both ref changes.
>

My understanding without digging too deep is that both 'copy' and
'rename' do not use a transaction, as such they don't trigger the
'reference-transaction' hook. This is definitely absurd, since we would
expect that all reference operations should use the transaction and
trigger the hook.

> Observed with Git 2.55:
>
> * files backend: the hook reports deletion of refs/heads/old, but
>   does not report creation of refs/heads/new;

Yeah, because the files backend calls `refs_delete_ref()` on the old
reference which is done within a transaction.

> * reftable backend: the hook reports no usable rename payload.

Reftable doesn't call `refs_delete_ref()` and simply writes a TOMBSTONE
entry to delete the old reference.

> The equivalent atomic operation performed with `git update-ref --stdin`
> reports both updates correctly.
>

By equivalent atomic operation do you a 'delete' and 'create' command?

> I expected the transaction to include:
>
>     <oid> <zero> refs/heads/old
>     <zero> <oid> refs/heads/new
>
> Minimal reproducer:
>
>     #!/bin/sh
>     set -eu
>
>     format=3D${1:-files}
>     root=3D$(mktemp -d)
>     trap 'rm -rf "$root"' EXIT
>
>     repo=3D$root/repo
>     hooks=3D$root/hooks
>     log=3D$root/transactions
>
>     git init -q --ref-format=3D"$format" "$repo"
>     git -C "$repo" config user.name Reproducer
>     git -C "$repo" config user.email repro@example.com
>     git -C "$repo" commit --allow-empty -qm initial
>     git -C "$repo" branch old
>
>     mkdir "$hooks"
>     cat >"$hooks/reference-transaction" <<'HOOK'
>     #!/bin/sh
>     printf '%s\n' "--- $1" >>"$HOOK_LOG"
>     cat >>"$HOOK_LOG"
>     HOOK
>     chmod +x "$hooks/reference-transaction"
>
>     git -C "$repo" config core.hooksPath "$hooks"
>     export HOOK_LOG=3D$log
>     : >"$log"
>
>     git -C "$repo" branch -m old new
>     cat "$log"
>
> The behavior was also tested across Git 2.28=E2=80=932.55:
> https://github.com/ciembor/git-hooks-ext/blob/v0.2.0/tests/compat/README.=
md
>
> The reference-transaction documentation says that the hook is invoked by
> Git commands performing reference updates. A branch rename changes two re=
fs,
> but the destination update is not visible to the hook.
>

Either ways, I think we should fix this, I could have a look if you
aren't submitting a patch yourself :)

> Thanks,
> Maciej Ciemborowicz

--0000000000009781db065bdc3125
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8dcdfb62b0af0de4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xdTlnUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTFkQy80cUR3MHJtd0NBbk1DM2k4Y2UyVkg0b012QQpNOUdMU2NWVmJH
K1hueml1dklCRU9RRzlWUEk0akM1U0Q4bk9ZY1hTek40WWxmbkduWUZwMUE3ZEFHTm1tSnpGCmJU
bjAyRy81WStYTWRRT1I5bFN5Y1RDajcvYkM0dWhob2xaMWFYYk8xZGRMU2IrVERsUzRUKzNaaXJh
MjVwYVcKOGxjSC90NTNtZGJhclE1byszTVZaMjZ4bitqcFFOZE16Q3R3aFlTTHZmaTRqV29LTUto
dTU5eFdiMlZsZmxzcwpFdG5YTndaa2Rja0J2bCtTbFIyMFR2M0hraDViQXdDenhJandhd2VMdzlh
cEZyTmFsdSsyMG9kL2F0VThKRkRLCm5lRWRjdXdXM0x0a3pLNkUxT0pGMXIzbFpLajcyT2Z3Yko0
dXhERDg1NnQ3YWEwT1grcUptakNyYjl3dUVxVTYKbFlSK3VUSDlSVDdFWnN6eGRmMU5hN041dERW
U0I4MnpweDUxK21Qa0lTd1Vpd1VMMnJ1U0J4YUJkbk1MSEVmZQpOeEtsQ1NnQ1RGMEtuNzI2WjhY
dVhaRTIweGhLdkJGRlR1NUVIaUlzOHFtc3FMcE96ZTVGQ3M4Vnp6blNyU21sCjFtbmRkN1pYcUJ6
QjBlbmJhaGJyTDZxT0FwVVVVT3Q5bXlzbUx3WT0KPS9ac20KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009781db065bdc3125--
