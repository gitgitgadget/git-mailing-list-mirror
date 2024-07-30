Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452C1667FA
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331416; cv=none; b=bpSVmIQA+Cfv0+Jnf1arldNb37BV6wDpgr9kCMHqCV2P4VU+IUseBIwxQILgIlVyDACUCHDUoL0SbjrrW19hHpf9lHr3Qvqz2Okih1eRm3g8piuC423xwkRmGY5RPguUIBRs+kidDXZZC+MbWnG2xjUp1q8ATrZhhmyMfZE1n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331416; c=relaxed/simple;
	bh=QXyZmvmk23ttRtJ6Y2dN8LLFSV8IUjcI9AGG6c5aIec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=OSsJop6OSdv91j6Sly8q1zO/psJzTdARr91H8TFSz96kCe6VF6UkQtwu8rzZ/W+tpsnGDZNI1HOikDzPK2jTykxeV9jV9S6US5wXlQzeXZfp03VayAAxf7sxeW38cZiTPTnbXd45kuWQoEzekcax2grR7kjr2bL9/bPRv6UoXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlTIchSP; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlTIchSP"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db14339fb0so2981027b6e.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722331414; x=1722936214; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKMlkif7RqoavjlCFiUIZZ3GL5AvWmoVo6MuTrMtDOs=;
        b=RlTIchSPa2Fc6jUhANz5TFgKG6Fb1DUwWbh4iYV1Mo4vxBpKbGQV3g8dKerB6AmAeC
         FMzKvW8oBbF7k+rcIlhB7yNEhz0eHs5sho7+p3sQM0weJ4xF5oV9+qEP5Ku2zod+siFX
         Pn7+nCRsb9wBqqvnPWbnrA064RysHg1b0Fk6XQ58cOlSh7ddvNWEgP6ZJ6huVzQFIXui
         FlMap82kIt/IIKhCGPRbdqTbSpbz3e+ft/cAfu92xMDNAUIDbu5Q9Cqf1ZRvuMB8tTb4
         mnuQTXB7mQMhQnUjUENQu0JpiOJFLlX4/M5s+vVQJcmk4SofrV90CKuqrNFi0RaA5BgA
         yCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331414; x=1722936214;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKMlkif7RqoavjlCFiUIZZ3GL5AvWmoVo6MuTrMtDOs=;
        b=h5tLtfUiGDL5ZZ0Gurd1h/2kpnxRvJbkUMNE0W/h/ldmcBDJaiiIh9Ll0msA3zd5f9
         sv6H8dih+ldxWAbyCpaR/Kt5d43Ur5P3QSiq7NvGmf39yZu7Vb/aIZwfwbm2+Ude9WAy
         plo6H39LBhRfc8HSAPSPfkbh+Vc5rsGohzNIbsSMf7J377AZtrAdRoba3cSa+q7B5020
         VlanhPP1D/RubqC9gc1PTkzdt/DdTAWgn9NwcMSqpeO+RZbMIh5TBWarIrHIU4lAI56Q
         MzQH3x3fZ65ASYm7lu0I761BCBhrR1Lsq80UG0ZUjGqbQpL9eR9neS1RBK+7DK25Qkn7
         cROQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiQwvTXAi4lH7r6oNhgR+ULOM0/FqoGfopjNNk1R5JBKE6+YKyXCC0qRzmmgyHGUck2xz9VdESFKAvDTg5TDZr6Z+B
X-Gm-Message-State: AOJu0YzFHwpig3FSZrPd2O39wK5n6GEgLjjLaOt6ML3Cr7rMwgE/ICDQ
	zsHcEtTSg6liXrVi5R85/hb5lD62It8Dkj/NvIhJdH17yduGT1GPmUEqeDFqcKsvtDD8RoKHUI7
	NvxrLMb7IbnzZ+JpNvFh7DxmSzLURvQ==
X-Google-Smtp-Source: AGHT+IFc86EBmB5ydO8PtLLPuxzS6RA7zzsWh4jGV09YuztPD851atgRQjDRPNMcfV4h8KRtry6VprdwlGA6o7WEHos=
X-Received: by 2002:a05:6870:2191:b0:268:3afe:54f with SMTP id
 586e51a60fabf-2683afe0ca0mr204246fac.11.1722331414191; Tue, 30 Jul 2024
 02:23:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jul 2024 05:23:33 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im> <08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jul 2024 05:23:33 -0400
Message-ID: <CAOLa=ZTj6RxXH9t71q2fi-M+Xh-vOZnKzDk_mPmhNTEqVjkAzg@mail.gmail.com>
Subject: Re: [PATCH 03/23] builtin/describe: fix memory leak with `--contains=`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000020fea0061e738809"

--00000000000020fea0061e738809
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -637,7 +639,21 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			strvec_pushv(&args, argv);
>  		else
>  			strvec_push(&args, "HEAD");
> -		return cmd_name_rev(args.nr, args.v, prefix);
> +
> +		/*
> +		 * `cmd_name_rev()` modifies the array, so we'd link its
> +		 * contained strings if we didn't do a copy here.
> +		 */
> +		ALLOC_ARRAY(argv_copy, args.nr + 1);
> +		for (size_t i = 0; i < args.nr; i++)
> +			argv_copy[i] = args.v[i];
> +		argv_copy[args.nr] = NULL;

Eventhough we pass `args.nr`, we still set the last element to NULL.
This replicates what strvec does and makes it more robust. Nice.

> +		ret = cmd_name_rev(args.nr, argv_copy, prefix);
> +
> +		strvec_clear(&args);
> +		free(argv_copy);
> +		return ret;
>  	}
>
>  	hashmap_init(&names, commit_name_neq, NULL, 0);
> --
> 2.46.0.rc1.dirty

--00000000000020fea0061e738809
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b3f87179dcaf262b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hb3NSTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mejZiREFDTU1PcmhNeVBIZVQvRm9kRVJHVjFhT0xuRQpEMVhCeHJqYWl0
NlM2VEtGclIvNVU1U210WkNlTkZKa1BmQUZBTnkydTJ4KzdWUGNUbTBzbGlTdzJhSytIWnZoCmJD
ZFBWYWZnc2RkY0VCSCtBL3Vhc2VHOHJ5bW1XZi9PRWg0Uk9tQWJja2tzT0g1ZkJnNGYxUms4YUFm
cUhKMkcKOWdyc1dNQ0xtblFGcjRETDhzSnkyVWZXOFJNTTR3em5XZ0pYdUo1K3BvY3NXWlNaS2NG
Yy9rZGdYbzJtcDhtTwpBN0o4N3BzbXdrL3hKV3pzNVdHTnlEMFEvNnRZekVpSTYwZWhJNGE2QTVm
SG9ld0RleG1rSjViWW5VMWx0YnROClVTS3dmbW1mRWg5VXdpVkNURVdTMXRnWmhBc0xnd1diVXFZ
eTdSTzh4WTVNeWVZZHJyS0ZUbHVSVXRPeGw0d3UKT1NtTTViMFAwVnBkM2dJMzIzR2Y3LzdFMG5K
ZWZhK3Nxc2ZBN255MzY2WTh6UVZMVTVKQWkyZXdoT3h6VWFhQQpRMFZOTGpqTkNDdEtFMkw4WFlE
ZDd2N1k0czEzWTh1YUY4Q3ZkckRQQjFQS1hEajVCRDQyT3R4Zzcrei9WZm9XCnBGQXFXNStRSW9z
YU9nMGlRcGlialo5UDlsVExrcUVDaTdXQVNMRT0KPTByMzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000020fea0061e738809--
