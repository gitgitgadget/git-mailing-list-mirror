Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EB4A2049
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999074; cv=pass; b=QQpNw50Grx6NQCZRBR40BW4dTvMluPUbDgs/k2/BKhphic9FGJRvxZDc7K9tVgCQf8Cr4Nd8uyEG/gCX8bW5pxNSmHcQKgX5Cz2seIuYexiYxI5/8SSeOFCjY7nHmSTXxalj8Gr0zMdfioo8E+4J6o1empDCo/Vn9w3McHwAgdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999074; c=relaxed/simple;
	bh=i+b6xCSibyQmq6ix0Av4h6LxV81YnChOTiWKcxOw1eQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LgGEvbdF0kAnGWwH994YNnk23ect/L6lTWJbIdEYe6w3AuHnyBK/KNqj4bsYmZGnvdtLMT+xBBzevyrDVqDTfKJrWfdDJ/we8/4s94jl9DAiONBgnsd6ho1pUA/IRPbnE+jp6au6Cy2luRqXy9e3PUHRG7S/0QoJawQSBH7vYcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQU/7ZAZ; arc=pass smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQU/7ZAZ"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-785643199baso999908137.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789999071; cv=none;
        d=google.com; s=arc-20260327;
        b=MrMBjwtnAEufBeLLqFUzki1nRntIjag4AJYqRclu+1zpXqBpv1VubnmZXZGX6zLYfx
         76mc/gRAmCZPMQESf88nP70TCLTLmtY3vZtQqIh9iZOrXtIqfpc/6aK2g3WV1zMSjg/O
         eZx7Bu1t7pqukU0ZDZAyYw0BT6imaFedRPsq0pH5LkAVL/kOgYzkQX90387m0jyIaFKq
         GSWVPRyGBvlaKwA099Es1BsQoPY51/q2t5oEduWoFR12bjT5JWaMUJtzuoGF1pHHVbHd
         E7NkkgfKkl7d8w3nEoEGr6BsdOIUppPKCFJqjDjbi0K1v/pNm5XEnDO3bHt79qr4DlcM
         +Nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZciQ2iwDuCSVCwQhUAC0SL03s+mU6Rsu21nl7jRmOpk=;
        fh=CY4m9CKidqP/19NW8teNgfndZPPqM4Akzw8gk6zPGAQ=;
        b=isiqeYMGgRCjJ1wGrezfQPPG2YvW3Lqi/j+iiDtE82bMcOUf2tVsbf68zaGOmkv14r
         5270M2S3X1oK38wsp0zc7AqZjbMkgpCrCzPfVhe9ke72lDS33eepCqBSChH4rKQ6esf3
         I6t2WvWUDphlXR2oEDMnO4bjtSMlg8jWYN62zzpTMdWkqnhYlyGEyjtUO5HQAQVsnqAF
         Gh7UvRSlykzrJOa/nOkl5F8CNXrMdEiFRNMCJQDyzHzwf+3V6yI8CcnLlFBvSBoKJg55
         XFpxEstR7zwNT42wWY28vjwdZGfIE/ZRd8dxznmHyovNZaxG2rP6x+57oLIoBC7Y044Z
         n21Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999071; x=1790603871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZciQ2iwDuCSVCwQhUAC0SL03s+mU6Rsu21nl7jRmOpk=;
        b=nQU/7ZAZchBIoiIRxfJ/+wRXTap9/m9b7EkuTYY6EWKEzM+Saf3VBnG+ZuBPV0bZfh
         HpwjdcBuT9rxuESlCPFjDKP1FTiVsWlY6gHda7U0XMSViJrMjUa3zPpGaxxqrF/x0cCO
         /X+fxuXCPPi1LTJLlbPNCR4k6oCZw6s9h5gzV4dUtJ3F9AcIKtZwkgDjN+bjRlwSm24a
         7ZvW91FgG/s8l8BmbBx9I6xGztClbX6ku/GIKPnz/cA2TxVcFjE1NAv9LqWQ+ITwjizK
         U2IDwIuPbhX7WTipAde7dN2l0rj5elfmK65JrOeaj0lfiuYuUonNzu1MxuNa8b5TFd6D
         Yqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999071; x=1790603871;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZciQ2iwDuCSVCwQhUAC0SL03s+mU6Rsu21nl7jRmOpk=;
        b=cUhJjWgmcZMyxHjJa5vzCmnA/tuxiHj76JHl/w27KnKD8n8SMM35wX4uWXQ24Yyuqn
         f17f06exIBaTvAVpqY28okoWnPqlvUM1cb1Xm+5DCIwmoy4IZDWTn7J/ssOWge9k38sQ
         4S/Y5UkZlH2JZj4qOGSCYUgcDy3g6BRkExeU2/Aa2SsHPteYXEPo5LkxnOiNM2Dl36G8
         dMEJ8yAm6XBAZQ3OScfPFaJo8SxyVafsqfGv7QqijRgPTE50KwXR9mD3p3mRNJ4Anq32
         So1CaNB+3OdOZHJGWCJqIBMQ92YJQKN/fuKIIwCg64i+5YcglyHj1ALi/eZsGuqCrB0y
         9b+Q==
X-Forwarded-Encrypted: i=1; AKwUvBy059E+1hqffSzqCynrhxU3Bp/7vErTazKJikQBohQU2Qh2LUQO95Fj/usw3JEDubKn4Sw=@vger.kernel.org
X-Gm-Message-State: AFuF++njTnkMoCbOFKpIyfjaGNipYjkkm5+TLOBKb0ta0tJ/ccgYmElG
	Z9wm9wGq+LNfZ+HgWynsb+afZZXH1OOSpfJfenfj9AIst1w1q3kcfPlw7gwM7+b2vdsFsyloCXL
	DwaPTtETiMb+wYTO5nrFOv9tOCXVGl/g=
X-Gm-Gg: AYBFou2Cug915NDwtidhFmHXvvnfztcUgDda6meyLoUAbWZE1X6vq9RcruJU/ifEwD7
	QFgu6dyOObLpE7ckEMJpJWbqgfoRK/O2Hb/1UZMX61vvSqdQknQpng2rRUOPrIRac++79i1jER1
	f6Ty9Ziu5HnztPWqcwzQ6d9NYj3B4G+TzXgS4VakF28iQX5RFRwccDcrZBwevHxvKdRydBErkS0
	pQvpa4eYd//LuZgL4KC6609ucdIoYG++kFcSlkZbAu6b40B6aicIZIOvia5NXIwCAN3E+5/SM0i
	NQW5xkYh2DuXSAZeRxfP7qGJCCvcrgmGJ7pwKsmywF1jv5eQjn2YdbXxyRxlScEBKWROH0aOf/G
	jt3ubgUZdahdYKVT3ZEMTJ7obj2EOnKzoEH7tPQBQDYjj/g==
X-Received: by 2002:a05:6102:290a:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-7a55b94f016mr4583081137.12.1789999071497; Mon, 21 Sep 2026
 06:57:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:57:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Sep 2026 06:57:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
References: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
 <cover.1789901584.git.maciej.ciemborowicz@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Sep 2026 06:57:49 -0700
X-Gm-Features: AcwNN1V1c-cdpOi0u3Vq0q22KSy-traXK4cfXg4HmKC5AEASpPrwRWaLovhHa7M
Message-ID: <CAOLa=ZR4V45R0zST_gxb3FMSWCwbi2MFN=5sCzhTAQfuZrRH7g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] refs: report old OIDs for batched deletions
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Phil Hord <phil.hord@gmail.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ce4001065bfea235"

--000000000000ce4001065bfea235
Content-Type: text/plain; charset="UTF-8"

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> The reference-transaction hook receives zero as both the old and new OID
> when branch, tag, fetch, and remote delete refs through refs_delete_refs().
> Those callers already know the values that they selected for deletion.
>
> Teach refs_delete_refs() to accept aligned old OIDs and pass them into the
> transaction. Besides making the hook records useful, this makes the selected
> callers reject concurrent changes instead of deleting values that they did
> not inspect. For branch and tag, this restores the compare-and-delete
> behavior that existed before 8198907795 converted them to batched deletion.
> For pruning, it prevents a stale scan from deleting a ref updated by another
> process.
>
> The values are already available at every updated call site, so the series
> adds no ref reads and retains batched performance.

I still have some concerns about backward comparability here, since we
go from a delete all without any checks to a all-or-nothing situation,
which can be an issue with commands like `git fetch --prune`.

Left some comments on the individual patches.

>
> Changes since v1:
>
>  * Document the conditional deletion behavior and its race protection.
>  * Add tests that update refs from the hook's preparing phase and verify that
>    branch deletion and remote pruning preserve the concurrent update.
>  * Avoid printing deletion status when a non-atomic prune fails.
>  * Use a local string_list_item in refs_delete_refs(), as suggested by
>    Karthik.
>
> Based on maint at e9019fcafe (Git 2.55).

Might be worthwhile to rebase on top of master. Seems like there are
conflicts with d38352cd43 (A few more fixes before -rc2, 2026-09-17).

[snip]

Thanks!

--000000000000ce4001065bfea235
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 68e1f1dab511bde8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xeE45d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM09UREFDQ2YrTTVzNUpFVHVkYXl2WlFuUDE2TENCegp0TUF6WXI5REFM
RDdVZHEvVUJVWVkvakxmYUFlSGx4dU9kUUlZZi85Z2FaSzNLWGpJNmI2YlA3eElRaHpZMTk3CmF2
dHBpQThFdDdpcEw0c2gwekVKMmp0NmlJRlBDYVc4SkJkZVoxb28vZGtSbGc5TFFGWFF3RVdieHFn
TkFqTmwKTCtQaWZ2VjBHZUxxUm10eEVmOCs2aGM4cGUzZUhGVlVucUpwdEZXbk1uR2RtTDlNeE9w
RXRKMnhZdVR5em5UWgprdGNzdENwZ0NIM2g3bDdNRkM5YU1zSzJFcUViakIxdjhRSTd4QVNvenBD
clJqM005NjVNdjFablp2bHRmNGlUCjhaVlJOb3dweldLSTlIS1ZhK0FwOUYzUFZVL2M1cDdTRWtW
RDVYVEIzNEptQ3F3dnJNM3YzZHB0T3VxaUE5Ym8KL3VnNHpmYzhDb0FjMXkwSUlsRURFZ3JmWTA5
Skt6OUFweWhQcVh2M2tyc282Wm5sM2xHTnhhSUV3MzlscjZLMQpwdUIvd1p6dHkva3BFSVBWZXkv
TFFDN2FsbW1tWnFKMlNzV2RLeW5ML3ZZNGlMOHpiUVBhOFp0VXBpMDJsT2hxCjFDTUVEQUd5YStY
cWN1QVhKOG5zcERKSVlCNUQyYzVtdkZkb0tUTT0KPXJrdjcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce4001065bfea235--
