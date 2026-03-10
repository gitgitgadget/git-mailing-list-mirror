Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19036E493
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146775; cv=pass; b=V94nVHzLMOPRccrxHWa4f0f/sNV7hdnzDKZtfOQOURyWdfuGfuTXzgAdwO2Tf3l+1ANu9m/RiR4cs/eceY8zmSWzB/4zWiLJTRVPRYzxt2OykLQCn44oqfN1AhV5Tak+lqn3Vo6IGNkHwAjaFGnc4891BmP+iX72iQYTVXbw2FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146775; c=relaxed/simple;
	bh=KCg7ftbK3Q6CdnI6fZJcS9FyBWjNNL0ncleqLJtFmDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/b8QaBUh49nHB88XD0LR2p/GMsn+ySvwWnkSXr5ZoOf8rOxuNw/mlAuTS2d0bNCTQkhvrlQnCvRjTx4WKd49N4OrKMul//YeuQOXJhVeUYHt0cBRnx/JUWq0VGaguWgWxKHzaxXIpyd9dpSE5kHe+qqvr+/6j4dTEFJ8hxsX6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdnxdX0S; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdnxdX0S"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56af4e998d4so3734644e0c.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 05:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773146773; cv=none;
        d=google.com; s=arc-20240605;
        b=cZKPQ1AC/X7cAH1QrS2A1v1gKb6OcdmzPG6Ywa6H4kGqApqhvxkJYu47JiJPaYrywB
         om5ddnNLX5ZCZj5DWnxVJ/eDnBEyhq2w8yFejc3AvhH/VK9WK59Z4O4J8BAfzJlHPCD2
         Eo0OzrV4aPSCIDQFhlrmHN8/+cuh3ae0YzvI2WPhDrPXKEdOfFQyXgNdBBZ4aNJQ1v4H
         hX1hDCynLiRSHmxr+fzTKwQNJjLbXgkVAzYAXVPZGSyJwbcGFj9x/xu6vwQusJ0MjhwQ
         nqfKbvS5sZZK8uWobNLvTsLaUlXi6sxDjv4/ozkl7ztPeZ3dFxkFpmEmzJTaklnonWNE
         RZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ak5da2oOfIEi4PLNOfYrPeA9jVzIP4D+gartJNi3Lfk=;
        fh=f4D0bglr2fKIyIFO2OgvL2C7lTotkobaj05GZsWU270=;
        b=L49rcmyMmW2GRLRbAoa7Tl6NGK1RYOf4cL3Xxxh25NWNAFdsyv9V+Lz7ZSy4Q483ta
         kbe99QrokFLFfUscQv1fhafVdkLAXEycnt5xnMO6P4pULlgVgxEicFwfn3j8q8CUmzgz
         2pQU5CdKfJ2th2G2ufjpMTJF3ExmHPYEPMUz4+4AQ1Cr81lrmTWfsgMukZxySzIsqJc8
         GfuKf9TI4x/xGHSPbfV4ATIKzLKlWbzxvb9dCHpstaJbtwmJUXkevQlqtSAw54qJcPQ0
         kEI69R93SWLyObb9F5qPC9PTYWQaEjvo8QwKg6/JzvAHdzmnlfJPEHSW1Fftq7YRJXeA
         QUtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773146773; x=1773751573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ak5da2oOfIEi4PLNOfYrPeA9jVzIP4D+gartJNi3Lfk=;
        b=DdnxdX0Sp61jbPBf+9MmYgD/9vmtIyySfcl6uld7V11u4r+VwTvAKqOSQZjDWrA2e9
         GZipd7O661Fx8OGc7oHKrUhFD3DBFTViFIhqMWlUH7iM0cHkNepLbQKhXJV3kWEcXrBH
         mx5Wf60GH1RhurPh2vDbzioCnw9FJ8Vc2qtDXJzXL0iAFFg6NBDa74vB3XW55csqrBVc
         Nvy0pgh2vPOnJlAMhlFXhG8C6tLLAhahZKWkmdtROKESW7aZo8pxPNOYJTS/jHfShxWb
         CNCCfIr/dtssfxDxzS5y0+ezth+wk7dDnGKnriRT7/SIVp9emIEA9USgB1x0pqg9/ZBL
         wg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773146773; x=1773751573;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ak5da2oOfIEi4PLNOfYrPeA9jVzIP4D+gartJNi3Lfk=;
        b=FrrOTu0lggjQP+Qw4S2sD8OCJyugyfrhnTLF3Z0BWRZWAHFvEhBxUm9wUYb4ej+mI5
         t5fmQBAVIgY0JQc3irBRF2hSSaE7tnxNAfcTz6hQIful2GhaOTFP+5yPrmIujEPrNDML
         IsbtH4tasXB56Wq2Z8PxRAZEpk7gH0z+urL2r6KQ0QoDBcPvTP5sZfkI8UZjqznLsjL+
         htoDm94QxM3wThvVQYhm9LNm4p4CEpepp0E9Cs8o5f+oaJfPQ8OOlnxw+9l7Pt8pVqsX
         4LTNQyBl+QxSLPMHQroKYwex5DveOx4wU9DlUosOv8gSo93mXJ02k1WBsQdS/gZYSrf4
         WbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWK5WPW8IDcIDNVfSaCRUCypJZx0AhNyfg88ZxD8GhChcsfdkKmTRM6Qd1NhcfXzolLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1YL/vA6MwDs7eq+/40W8dQ5D3KfWfwybkH9pnI/bDsH7UZ1xC
	C4vu8zMGdAlwL6eOf9ZFGiegwnhoRrVOTMU3VVgHRiaFBTK1yq4Zv1/YtYD1qGSiqD1r78taN/a
	/sqXuF/K0oEkecCsh+XwwLh1LE28hlTU=
X-Gm-Gg: ATEYQzzhxEzXd1DNuIkANPC/dp159nBubaMafxayS6j5lM3zs3/MUpHAGlnuZM4vb8z
	q5lFShB7BxEv4yGDCTf8ksrnjwCexiyWcvfTnxT1w7CgDTbV9JY57cTEZ6CJOYhK75x1K+jFc+0
	D5jDMGiytHF7h5eJM1SE+l7JOnlbtGAb3p3FqWM1U6T5MFy2KyR+FqPX2BypqTO81UWx8uvV8FB
	8avTdk3/oGPyCm9wPMCwzHcIp8goezeFgAlF9H/ztVWZrmTF6tIQCufr7J2wZEW4a/eQrrKrMsB
	Jk7zdcgzds7088xREyOxWs+BVLIrSTSwN6yvv+9JMg==
X-Received: by 2002:a05:6122:794:b0:566:ec03:4683 with SMTP id
 71dfb90a1353d-56b37584cf1mr1334597e0c.2.1773146773320; Tue, 10 Mar 2026
 05:46:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:46:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 05:46:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080114A7548292AB4B60D817CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 05:46:12 -0700
X-Gm-Features: AaiRm51y9lVZiGiD_Xi99BceBOSWIZPkhQH_GrLWvbIVAHdInw5aY7gGQWowZo0
Message-ID: <CAOLa=ZQ3eCky2rH_D-6=vwQ26TKW_dSO84+Z-WL2LFJ2rGVmqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] parseopt: extract subcommand handling from parse_options_step()
To: Jiamu Sun <39@barroit.sh>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000008f26b8064caae712"

--0000000000008f26b8064caae712
Content-Type: text/plain; charset="UTF-8"

Jiamu Sun <39@barroit.sh> writes:

[snip]

> @@ -990,38 +1017,17 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
>  		if (*arg != '-' || !arg[1]) {
>  			if (parse_nodash_opt(ctx, arg, options) == 0)
>  				continue;
> -			if (!ctx->has_subcommands) {
> -				if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
> -					return PARSE_OPT_NON_OPTION;
> -				ctx->out[ctx->cpidx++] = ctx->argv[0];
> -				continue;
> -			}
> -			switch (parse_subcommand(arg, options)) {
> -			case PARSE_OPT_SUBCOMMAND:
> -				return PARSE_OPT_SUBCOMMAND;
> -			case PARSE_OPT_UNKNOWN:
> -				if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
> -					/*
> -					 * arg is neither a short or long
> -					 * option nor a subcommand.  Since
> -					 * this command has a default
> -					 * operation mode, we have to treat
> -					 * this arg and all remaining args
> -					 * as args meant to that default
> -					 * operation mode.
> -					 * So we are done parsing.
> -					 */
> -					return PARSE_OPT_DONE;
> -				error(_("unknown subcommand: `%s'"), arg);
> -				usage_with_options(usagestr, options);
> -			case PARSE_OPT_COMPLETE:
> -			case PARSE_OPT_HELP:
> -			case PARSE_OPT_ERROR:
> -			case PARSE_OPT_DONE:
> -			case PARSE_OPT_NON_OPTION:
> -				/* Impossible. */
> -				BUG("parse_subcommand() cannot return these");
> +
> +			if (ctx->has_subcommands) {
> +				return handle_subcommand(ctx, arg, options,
> +							 usagestr);
>  			}
> +

Nit: we try to avoid braces around single statement blocks.

> +			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
> +				return PARSE_OPT_NON_OPTION;
> +
> +			ctx->out[ctx->cpidx++] = ctx->argv[0];
> +			continue;
>  		}
>
>  		/* lone -h asks for help */
> --
> 2.53.0

--0000000000008f26b8064caae712
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: abd34f5db818c9c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td0VwSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1BrQy80cTJCZzRuczhKOVhOdEdKQXI0Yk9EYS9WUwoxL1JyTkZYcnJj
SmZsbmpocVdwZmczVERtc2JpemZibTIwSk9LR1QyS2NqQmVXQk96Nnp3bkNiMnJTUG4xUERmClAx
akFkODAyN3UyVVFjZ0hObVJvblR4OEdja2ZjNGFBb3haTzFJenZBcVMwaEpJMkMzN3NqYmMvMkFs
TWlCUEoKZWxCMzI0d0ZBWFdrOTEydEhSYWhWUk8zV3E1S1I0bDIzUnpXUzNPa0ljUEFuSVZhYThQ
ZERrOXk3OXU4c3JlUAp1ZkNrcWdDN0VYWE8rYXpPT2ZZdERpcjArbURXa0ZPSFNhQm81T0QrUlRw
OVB5VTVZeWY1Y0hlREQvRTM1ZE82Ck9PTWF1eElHYTZBMVM1VGJmK3ZpM25MTGcyMUFpbUpRVmlL
Uzl2a3RTYnNjckJCWGJvcHpNUUsyRWZhc0dYUDYKSGVGazB6RkErb3JxTXhBRzBXclJ1RWlIeHVl
aitvTktFNjllOXk2SXo4eEJvN1RiMkdob2lGZXA4eDlSNlpZMQpqUTdUNTlSMGgrdDJJSWJ6KzR4
ZWQvN2ROT2puNjRaOVc0Z2M5ZStOeUxHcnlIRDBrMXFiZ3ZiLzdVZTYrSTgvCkZCcU1ySWgxS1U3
QW51QVZodVpSNzc1djQySVY0d3oxaUV0TlIvWT0KPTFZS1oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008f26b8064caae712--
