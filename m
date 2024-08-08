Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61BE1119A
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723114005; cv=none; b=POZmaFb4x27oNdUV+STunAxllCB9opkchUL4V8y3guDmKKwXtk9LSJqeehWYUtCfHJfEhigP073T3k2WVNKOUY1yI1i+RopSlie13oxA7c2ABaFO3qVHzYGwGfb84KkVtsheJMTacK7jigWRdpFNLrV8SEpTxNXhvYkLYhPin8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723114005; c=relaxed/simple;
	bh=LxCPqGYZiaJWqidUkwZuDkU7RAE/pvNtlrPcQma3/FQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt7ZCf0SrMrXRzGdXa3IqOfjiPwDK0w1PmtpfOYoOj5pAN9NMh6B+WEuAtt/yYp0uAz/JpwW1L5dX5eKRE5NtD3JM3DdT0ob+o4VaRthiaWOoLixyyjxPS7HxBETQXNzNmZux3CUSxIjqf3lN/NuNA+T4m5Uj2Ay85PhZZwKPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyKmfqdc; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyKmfqdc"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5e97b84fbso393837eaf.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723114003; x=1723718803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy38vghzgLo+kyloLBwwdle/d0Kg3/rn1c2PBB+jnKs=;
        b=TyKmfqdcgOQ1HbNoqg1cW5DWbZH15j2S7KXbEMMmIRf7ANEW9wRMbQxHgISOi8Ou0X
         a5p3u3xOZoW7cXWvkIQ3ncxmUfSOUoJK9cn9fVzjEv/ln+ixXk4nE4x4td+64WoLRJMZ
         NlTL5KkgMYEpvOJuUmEyFm/vdd6D6tcECs9aemmbgCM+zVIjwySWiyI9gVHBpqHbwMyg
         EJPEoycVpTJFQXLCSCRFfMv/vtv6wF9og9v8nBEDnh6ntXjWhibNCqBXCDr+D6CUMLJi
         U2bkTxYahCLJNvSuYEy/ipLU1yHH7MSs2UZj0dacdGbWpfZ5Fk9AF1/WQ2IxpSxpTROM
         FryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723114003; x=1723718803;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy38vghzgLo+kyloLBwwdle/d0Kg3/rn1c2PBB+jnKs=;
        b=Q1XSlUfDcoD+doU6zthZwjt0Uq2287YSKZeDSRYTGY71uXU8cT+Y4i6mKPWKEmkVmZ
         POmdJYPUou6seFJk4Kzo9jHJ/edd30CTTZRQdpkrA6qrVwWkw7twBg0199QgHT2H3OGW
         VwiHsBdpIleV2VZakoM5/cCzFm1Md0T9fq4G/gqDONrWZMHPRJj1QNL49X44KDHFJSJK
         U0iPE2xmspTQFDI0lTMMk70NVPMbYa3L6qPdK939htkts8ugvphVV0OoNsIZIZfiQVpo
         WRi42+uAehDYXRJd0He25i3h99YaGb3FApLXEWgRAPZXMN+pNF8r9fSUlE1Y69VvXzUc
         RYaw==
X-Forwarded-Encrypted: i=1; AJvYcCUhh6CN+IswzmKMTBTO6eatyKUJyfhY7wbqETWZC6/MHNxO1njcnve43tpV3HNp+ucOEhtN8b4lgSiUfmfEIqX3YukN
X-Gm-Message-State: AOJu0Yz7MHXnhENQiE/tLyn5wQQ9rbZfxMAxt/uCHWh3Mukfu7ecQolB
	cijsiJG3AIS9MPfVzbya0RBZ2s4o1hMBvTxXYXsIGGYkeCZ6xCWk8S6xTrKFaD1FkAewp7Sx6sL
	spDl08MzSfNAtXU3i4SJTTPXdGDs=
X-Google-Smtp-Source: AGHT+IEgrKZe4m1lMgddEsE3CTXr500ad/fMr/50LfEMnjlOwXfFq8XZ/1ZtLXFtT+rT3RvQzEqEdzW3nWC72eDOX5w=
X-Received: by 2002:a05:6820:270d:b0:5c6:9293:ed8a with SMTP id
 006d021491bc7-5d855c8111bmr1162520eaf.6.1723114002887; Thu, 08 Aug 2024
 03:46:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Aug 2024 03:46:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <63e64c8d82783b5d3fc8db189a29d69c844f5465.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im> <cover.1722862822.git.ps@pks.im> <63e64c8d82783b5d3fc8db189a29d69c844f5465.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 8 Aug 2024 03:46:41 -0700
Message-ID: <CAOLa=ZQJVTspAsjxrQa-WVxX4tnhAd0NfwL2e-MXHvyq5+cwfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] reftable/stack: test compaction with
 already-locked tables
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000000cd5dd061f29be94"

--0000000000000cd5dd061f29be94
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We're lacking test coverage for compacting tables when some of the
> tables that we are about to compact are locked. Add two tests that
> exercise this, one for auto-compaction and one for full compaction.
>

So this patch prepares for the upcoming fixes by adding tests which fail
compaction. Makes sense.

[snip]

> +static void test_reftable_stack_compaction_with_locked_tables(void)
> +{
> +	struct reftable_write_options opts = {
> +		.disable_auto_compact = 1,
> +	};
> +	struct reftable_stack *st = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err;
> +
> +	err = reftable_new_stack(&st, dir, &opts);
> +	EXPECT_ERR(err);
> +
> +	write_n_ref_tables(st, &opts, 3);
> +	EXPECT(st->merged->stack_len == 3);
> +
> +	/* Lock one of the tables that we're about to compact. */
> +	strbuf_reset(&buf);
> +	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[1]->name);
> +	write_file_buf(buf.buf, "", 0);
> +
> +	/*
> +	 * Compaction is expected to fail given that we were not able to
> +	 * compact all tables.
> +	 */
> +	err = reftable_stack_compact_all(st, NULL);
> +	EXPECT(err == REFTABLE_LOCK_ERROR);
> +	/* TODO: this is wrong, we should get notified about the failure. */
> +	EXPECT(st->stats.failures == 0);

This is a good catch. The autocompaction code has a wrapper
`stack_compact_range_stats` which handles this exact scenario.

[snip]

--0000000000000cd5dd061f29be94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 33c7744b446a6fc8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hMG9oQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmNHQy85ZUJCNWNwcTIwdS9nRlgvc1dQaUxUN0NIWgp3eUMzNWNCcXQy
UUFxN0NhdVlOZW1oTmw2NWQ5dmU5VGNsQTVVRGdwaHdzaTBnYXVhZVZTeUNyOVllV0NQK21DCkNu
N3lrL3VzeGU4QnNGZXRQTDR3eHVRcmlIN0ZranZidG9pODd4SFo5MTd4V0VleWxOb2lQdDE0b3dK
bE5CRnoKd0Vua0YvSG1ta1pqSWlnUTU0RXVjRjVzeXpndDJYOFczalNKajVENUEvSTJBM3ladDFO
TlJnckluVmdFOGpsUQpyWFRlYzRmUDFDRW43MncrRjVURlVyV05aRy94eHFuOS9WT242YWlQVHhz
MVd0L1lwV2Y5TmxOWmh5a1ZudjRaCi8rVVhDRjRYSFd3bERjbVJ2T01wbVFPZ1V0TlllQkFwNzJq
b2FVcko0RmtDR2QydXFVV2xXZWlmUzRUNUhEekIKem5aUXpWOVhpRHU3d1J5V0RQVGZ4TzQ5Z1dz
MUh1cWhtUk0veEh0VFcwNHg3cXlCYmpYc1hqZElQSjlXZWFhRQozSnFuWitKMS93QkllSW4zSFR6
cUV2TnRMdU1iY1NKemk3azFCQmNjOUhCMTJ4REg2UDVwcTYzV2N4RUdOc0ZZCnlVVCtPaFVQd3ZT
REhOUGhLWEh5cEtxT3pMTHF3NDRZZjk5Y2Fybz0KPWhwZkIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000cd5dd061f29be94--
