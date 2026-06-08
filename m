Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1033CEB0
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935130; cv=pass; b=M0/Jh9iKgoywGWJ3U34lwful/6g92Gmb5rT7BhTBYYue9Hmb/MPW9+6Ki79PkMJH8uDE5ldp1iMN+ryuuihzwK16PR/dI5RS5HN7BXyaEi5ADJT9LVfjpJcZ8v76cyG0Cz8vxSfvBtgp8YnL9RWY+hPdSXphbA8HWDRoeFfWwic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935130; c=relaxed/simple;
	bh=8n09mDmAco13WFJxce+PVcDiCIy2mle+XUF74+w3pu4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=bqjG7LlfDURVEitALNgH+9cHkh4/trrHuCCd6wrsznLWWwJtOuNm8gYZutmu1v1LHfui/aPr8glSw8HnbEiMfEIfe+QO4YKhFl0oIj5vhT3VkKpotyO7upXWSSqH40rQ7xYHW8fzZn/4IkJMloZ7db2xVB18RNmUK7VOlkw1lT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIUmB3fe; arc=pass smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIUmB3fe"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-96387977596so1536994241.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935128; cv=none;
        d=google.com; s=arc-20240605;
        b=HI44L21tVFoPQBc3WWLC1CAtk9ByrkytI7Fa/eAmhtMkHLD4J+v2mwSxuVmG9VAbgx
         bKXeOvRaz1deKpa1rQoVcohyFCtVSwzAsaNUW4Mo5L8PvgUsPy53qqEdxdrEoNH+uE76
         /ecCqlgTmJwtIl5+ZgnV81I+BezTNwIXIAfzshFWm0eJx6w2E1fHEGUPUSIwVuQx67+U
         k5vrYv8i+8O4Ak/ZfGXcrMxiMJk4I/hEDgPMYlpYXNnqEiYk6VZU00/rCHnbWcrqsapd
         xrimCaGExccIRVWehf6zm5bdMMXp2w7H/6Yf8Kowe3MHMBE0myk0rQMTprb2puRZZKQc
         jBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=SBGk2h5L40xotWwHAMMDLn5kLppfAvCziaI7v7WkfbM=;
        fh=zh6KFw1nnITbNTwjFcFG74Q+rhqMpa0VRwaWrbwRkmI=;
        b=jguma78qtJpYuXwlwQT4YtCp5ze7nnoVdWn62paI63dE6N2b9HI3ARsMg8sWyz4QrE
         Hpuq1D8dtOI47jypmbsSS0BmRawTovMjn/B2ihPKbxpriEGiRHrdIA9edJUVwY9CdJ7J
         Q7TOiMDSdlIxqgWZFE4x5JpiIyA557p9EMxbOr69niuEVWJl7AZPMtzCpRYGp4ukarib
         Z1G0ZKzJPBbPsghGPFl8NYKx3ct3OiUbP0ueCQKusyT5o9XmIgc/uqyNlG+H44uGNVgP
         4AziHuEljeyqBgNx8VhES8QzWgqC0D9KUfZ2MUrVxSgW6IdaH03MQvdnKBRQLT4ixrdN
         A5Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780935128; x=1781539928; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SBGk2h5L40xotWwHAMMDLn5kLppfAvCziaI7v7WkfbM=;
        b=UIUmB3fe6Zy+o0mZvqzWcFzNv5yXG2CBQjmLOGLAEXttqgBINMSeMcZfGqsEQ0BGKp
         qhNnaXN4ROt/AXUubca2WfIgwESJa3uiL4kHsTIToIbcrcy6RA9jcWCsswjqHCDaoHWW
         0LWMAWsvyMbGkpjwHd0n0wF6Yb5JkEU/qO4oxZ3duaScQM3JpVg0Y0/NNPmUl1EUqxeo
         ek05Kk+6IbxcyS39CfiyhDrirrLs/oqDbR76zrnPCWgDOLe8lLBdZd0m4p/OGBmZslTf
         ccx+LBb/42op4KctsBMjO/VpUFGIo30pzV86ypcRvQqW+beYOt5heQJX1lbyuEgdcURY
         wYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935128; x=1781539928;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBGk2h5L40xotWwHAMMDLn5kLppfAvCziaI7v7WkfbM=;
        b=c3NeoAM8YpAURt3jTq7rJMg2o7XG5MUNaZjAe8bAerr3K74OCWYeFxz4kQOgW8gELT
         S4p36hIIqQJiqJXOVUiIEr6oQOuDND6Tw2J8YYi0n06F2D3ShJIuKDPMVROtJcVnHf4Y
         rQL7wQwn8rV/0HP/RBeiI7SKXCX0Y/PVSxYPyJPw8WwUd3zQDHPJ7C9TOOvN66+TPtuv
         x4Acy0edHWNp6k1oQ2KvJYIsWliDC+6QUtlbqQ1YUvFcB178ltN1VOQz1d/UhNhVUfeA
         9k5XRDWjD053myc7ynurFlg+//E5g3ihkPwpfc/0Ygn7iR5CHAgyFzxuz5tcTgZRaAwr
         SJ3g==
X-Forwarded-Encrypted: i=1; AFNElJ8y3UMNqPcySRI8+1+ZDbRvFzavsG2D0QWi+nUbW6ZmcG85KLSd75zlPg6bI6gj0atUUZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtBCF+ojHclVCS2niC9jfTz177dcyKeFH9RpJ69vYP/Vu35B9
	yh8fe36aL1o6ZZXspWrkZ8ndFlLQqikpPF8h4PI/R2fpZHn0P0xihEMgmiXu5iwQkoGHx/45C/7
	Ivpg+JCjJqoEvB+gGHqn5YSFdv/lVqxs=
X-Gm-Gg: Acq92OHClyHs45+uur1Y7lsFy4mBogqFf/mDpMnnuvpR52g7KtdxJPUjUO5dZOuAOqQ
	osqEmd0dDlIkJyMtJkfcbWTeY75kHWl+1KB8SKSb6ykMufRWfo59iGoD1RLZyq03v6TGYDWDE8v
	1UowftiFip2FwDSLWng6qsOWkj4BNUYq39YsMmd/JcKbDHR72A0RRFtgSHOSgX9IcMsDteg+B6V
	nDwcfO36F9oRLpmNJ94ezi9huHzTLw0xBbJ5gJgPscixq5G8qJo8LAfG683zi759LLdkXdOzLZF
	+gb5/a6XrOXl+Sr2wQhOzk7NpypkVRpYGQ3qvGpWQ5rrria8gY2kNCc/ULzggBuN45oHbwJA0py
	u4G267bzS
X-Received: by 2002:a05:6102:32c3:b0:639:3b08:d64c with SMTP id
 ada2fe7eead31-6fef353f3a7mr7639836137.13.1780935128055; Mon, 08 Jun 2026
 09:12:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:12:06 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:12:06 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-11-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-11-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 09:12:06 -0700
X-Gm-Features: AVVi8CdTs7PrBSjxroi3OPOKoCxhLw0YvIbHwepk4lwzZmoUH7qd39iCnKO9ViM
Message-ID: <CAOLa=ZQdGMo83KggkmeeKYMR475TFqLn=o-nJz4QEUX2njgaOA@mail.gmail.com>
Subject: Re: [PATCH 11/16] odb/source-packed: wire up `count_objects()` callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ad25d80653c04531"

--000000000000ad25d80653c04531
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index a61c809c8c..013d8a50f8 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -338,6 +338,39 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
>  	return ret;
>  }
>
> +static int odb_source_packed_count_objects(struct odb_source *source,
> +					   enum odb_count_objects_flags flags UNUSED,
> +					   unsigned long *out)
> +{
> +	struct odb_source_packed *packed = odb_source_packed_downcast(source);
> +	struct packfile_list_entry *e;
> +	struct multi_pack_index *m;
> +	unsigned long count = 0;
> +	int ret;
> +
> +	m = get_multi_pack_index(&packed->files->base);
> +	if (m)
> +		count += m->num_objects + m->num_objects_in_base;
> +
> +	for (e = packfile_store_get_packs(packed); e; e = e->next) {
> +		if (e->pack->multi_pack_index)
> +			continue;
> +		if (open_pack_index(e->pack)) {
> +			ret = -1;
> +			goto out;
> +		}
> +
> +		count += e->pack->num_objects;
> +	}
> +
> +	*out = count;
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}
> +
> +

Nit: extra newline.

>  void (*report_garbage)(unsigned seen_bits, const char *path);
>
>  static void report_helper(const struct string_list *list,
> @@ -549,6 +582,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
>  	packed->base.read_object_info = odb_source_packed_read_object_info;
>  	packed->base.read_object_stream = odb_source_packed_read_object_stream;
>  	packed->base.for_each_object = odb_source_packed_for_each_object;
> +	packed->base.count_objects = odb_source_packed_count_objects;
>
>  	if (!is_absolute_path(parent->base.path))
>  		chdir_notify_register(NULL, odb_source_packed_reparent, packed);

[snip]

--000000000000ad25d80653c04531
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 27057471378aaa58_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTZkVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0lXREFDamJYMVo4M2JXczcxOUZzVnErbExLRUlIagpQMzhOTGpNdFNS
Nit3V1kwZElVTDhrdTZUSkd2emZ2a28vYzFXY2xFNENyejFCN1pzVHNkdVZFdEFNTXZESGJEClR2
QlN4cFZFSDU0dFAvS2E3OVpqa3orQUxkZE5DVmZJZWJXY2hyNTUwWEY3bWVPRjZ6NzV1Tmo0b3Nl
cG12R3gKdDh5K3BkRkNHREFLeWZWVzBJcTd2QmRyNTRWU2N3SjVkVC9EUzByQXYwbVZsQmZZYnlx
ZkxzYzFHT3YrMkIydAptMG5QYUtsQkZvUDZsRmgzTXpqUk8zZkx5YURQR0k0MnBMMVlFeUlIdlBj
czJCcTQzaUU0V2FTTDNmbUpBYlZYCkRmOG92cUJCZUhmQ1o3dGJaY1NYZjlLTHkvTE95aDY5M2V1
ZUU2TzVtSGx6cEYvSms4cmdMT2lVSXAwQTQvbzIKUFVLbTJMQ05IUExVdFVYVXRUalNPTDgwa2sy
OHRRd3RCNlhvU1FRQnlrdlJGQnJzTzl1Nk53Q0dSZXdlQzAyUgpUYVNIUHM4RitVUk5TcG1XNmQz
SmZ2SkxLeDFodS80Y1lPdjYxNlAyV1BHbmdnbW5PTi85a0xIMEgrZndYa05WCnlZUEZpY21sNTda
SHVVK1YxSFhkMGZocFN4bjBoUHZoY1lSV2NsZz0KPXpTaHgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ad25d80653c04531--
