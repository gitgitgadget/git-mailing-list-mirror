Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E13418A28
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448072; cv=pass; b=maFCxd54wBZxGmdICrJMAtwI16stfyAwTvCEZs326JMi66eMZuS9IvzHMi9Rmq7BAuwvz8TI3YIWfXFO4syxq2wLNh7xNcwBMdFd9r/VDeiSZtPr9QxfKK9DYXk1efXIr2OEnAeVyaemOfOyNy6pcQKjGIGmfBSJRYprXHjBq04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448072; c=relaxed/simple;
	bh=R0+YJt65NuoO5jaKd7wixr5J/cCa8wIeMiJguYOqr/8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHvRjl0O/wXDaCR/vG8nSzIRgrO7u1wym2pAsJnaB+G7WBGDrjcZhHsb4QahBaZbM3zcdNC2fn+RYqL/DhUE795/mlo2L4DC+XChG6Zud/1opn+ewY8qL3yqVTkYBYXyc3aeSZNBWhPkhAp/fOOqOLw5Ta+4CQp46eAEJ7FOd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBBBDbL2; arc=pass smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBBBDbL2"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c98e1942dfso157348e0c.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 21:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789448070; cv=none;
        d=google.com; s=arc-20260327;
        b=UyfeR6W6tBYnXSWVKLJ/xcJ3y9MIfXvd7LrYrIoaZAqyF+zfmQxf62GbcsDDmfC8B8
         bjrMwyU8VRCfYkEpJFpd061uZ9uVE7gYpdatjEmoyASj1bGPucQ4xlMPNwNTKpydheOb
         T05ORc7AXeGnepNY0utyziiZe5ncNyUwNNxWxXOPbnt8nOz4TeNVa1GkZ4qsK6D4dsLg
         jJ3PIMgV+pG+qelu7BrPM+cvvPsrTRahqHGYU1vvHLaUZaBGEgjSWaGP1yyYd1DUrL2q
         O++6K0R8xi7KEq6aeQrKzVzKPvx6kVvBH6nfi26sXvLgdjI6TVQTUqkqH9byZ+x4fklU
         Gqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fSNhW7TjldpotY87p2sA5/bbdjkMa4VRwHVpChY8yIw=;
        fh=D4uDqIpMAU76UF3y7kLhifPMaIKyWsi4/hRzYZ8Ccvc=;
        b=OR1rXezsestB9F+JZ9e/sv7g5ed6d8nglNEVZDeVRkIH0lSrqnZQfHXD3lBate/vu+
         t+Cf9lh4ZeRqLrxcz7Vsc/zHzLX5P1eZWGh5G2PRCly7Qs59Uug5gGzEy5LosPNw+FQW
         b6eEbiE2jDwjSjhR+lpTaYw5a1KP73GbPCgUjkO9/V+VoUOXMtcs6VnJ9OEAXAzffrwg
         ToSCQTAXP5JBavkOiufDa0WiyoDjuxWWMjM1X3GR9NWWdxSysYgSTraZh/q4vR2+wqAB
         Fv4f5wCROR/MVkYRjvGeXuaqIL2tHiy0/oG+yBrirj8mZG+0xzUfknqy3sTU9H9/haUg
         j3Gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789448070; x=1790052870; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fSNhW7TjldpotY87p2sA5/bbdjkMa4VRwHVpChY8yIw=;
        b=OBBBDbL2E8mbqinKZzq+lLiEdJJUTStfHE3YqaDhGF0u5yTEiajwBjoJvDmfcHP8mD
         Plita+EzS/k1iyZgG99/hR48c8YbeP3qCUNnxAoFaaJajIrS/EPKLF+bcD0KfRh5Z86i
         b0ZVAutOWKS8DDMukwTGY7kLzNWKow2xA19fycprMonfj2YIl78/6qJWJE5lSf5yznDd
         3DpYEhUjTP4vbABfd/FeDvrXA4cksXWHO3W+aWRHhh0/tK0MehZcv9M3q2dFvqTLbQJx
         Dem2o+VbTWscygopbGx9yaam6SAxPVS9l1vGK3cXHW3+ihtrj0x3+iDD1Yw4IxA3O8uh
         fbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448070; x=1790052870;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fSNhW7TjldpotY87p2sA5/bbdjkMa4VRwHVpChY8yIw=;
        b=hWpB8uYcz5/eSf2maHcAUwwMGlwuU60ephKodoxWhm9S85awdJiTs0vprI6x4sv/Fj
         29pZ+SA26cJ9BGyZ1HSGGrakSf9wiMWu2AkOzn6u02lE9FNBox399LS7vZ8tEOREwINT
         Le1pdnww7tLzj7NX4xFJOEoTPl2YsF2h2ocS0KKOS4dJjHLLdcZV9RA5VFjr5fuI1ty2
         yzBzwawgsRdomHH+4xNpNEyw0MNWxSRlceLQHAJrKltDfY4yp5f9diGtnoh9c5yfIrik
         qllKPZ0u2GWQDYrCLybdrEZtnNEjobY44AVxFDRHlsV3P5OrOtdoUYO3SAs0qJW01TeJ
         U0tA==
X-Gm-Message-State: AFuF++nD7pifaMbgd4onbO9zC4hYn4NyMpMb7IXLhy6AjoAdHZvjUFC7
	M1Y36TOolPIDX/jubDHnGa2yvhGNI8KATiUOZKWwb3hHPcelN26ZQ8psm9UNxI9x/wpaVDgA8qK
	6/pk3M64s5mV68ToPx8e3MVImRVxha7M=
X-Gm-Gg: AYBFou0pyc631t/Wo0n08H6o/RsaFZThDIf7LZCYzbYYlhqO6KGc4ZmDrys/G5ANU1t
	W2kxt3OwSPxEKPwoHOWv8+0kPvGQz7612nq9mikp8CamBJ3jos9HICDZAJLw6jVuKDEVrow5T7p
	gbNwSk2zDz7mAdltGzF5gTmTMOii9chXiVoJAbeh7lzQ+qBxZRZw/1UANKdDRePmdOg2YjjKu5E
	kil9FgTCuDuv1HIEjfDOwG6SaLOHYkmoYZnD1hR7NoTwT8hab/rHFY763QnGVsSj05wUGMPJ9RI
	nX7KFW2mNkG3OGeneVVmxqaWI7kBw+s2kyKvdkUSi19xyb61DJxUjJ8AOpM2ZgLADLFWm6gq73K
	2+vYld85ZegeotqtN0YA2hLE=
X-Received: by 2002:a05:6122:e266:b0:5c2:b01f:e503 with SMTP id
 71dfb90a1353d-5c981e94a8emr7951036e0c.7.1789448069763; Mon, 14 Sep 2026
 21:54:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:54:28 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 00:54:27 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqwlsn31gq.fsf_-_@gitster.g>
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
 <20260910-758-introduce-hook-v10-4-06f9c506631c@gmail.com>
 <xmqq33vfa2ny.fsf@gitster.g> <CAOLa=ZS0PT4bb+k3HR4F_aOoJ5uUuMFx+Dnte4LpPEekFxs9uA@mail.gmail.com>
 <xmqqwlsn31gq.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 00:54:27 -0400
X-Gm-Features: AcwNN1V3pkPb3HIkxqf5JQ8OyzFjd0KpQPPdAycZRUMZ2mcDrmm5Uzper37lBb8
Message-ID: <CAOLa=ZR6qeiG1Mbq-ui90bRZyFD51J5XVRt_yRM2+PYukOVeAw@mail.gmail.com>
Subject: Re: Re* [PATCH v10 4/4] hook: introduce the receive-report hook
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000008aef0a065b7e58e3"

--0000000000008aef0a065b7e58e3
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I could send in this patch for coccinelle with the fixup if that's okay
>> with you.
>
> This patch until it gets fixed will take the coccinelle updates
> hostage, so let's queue the following on top before merging it down
> to 'next'.
>

Thanks Junio, the patch looks good.

> ----- >8 -----
> Subject: [PATCH] receive-pack: coccinelle fix
>
> Let's not check the nullness of cmd->error_string_owned before
> calling FREE_AND_NULL(cmd->error_string_owned).  It is cheap and
> safe to call FREE_AND_NULL(variable) for a variable that has NULL
> in it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/receive-pack.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 9ac7717096..1d5b050beb 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -2452,8 +2452,7 @@ static void update_shallow_info(struct command *commands,
>  static void override_cmds_error(struct command *commands, const char *err)
>  {
>  	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
> -		if (cmd->error_string_owned)
> -			FREE_AND_NULL(cmd->error_string_owned);
> +		FREE_AND_NULL(cmd->error_string_owned);
>  		cmd->error_string = err;
>  	}
>  }
> --
> 2.56.0-rc0-195-g1e3108ffbb

--0000000000008aef0a065b7e58e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1cafac3a2396f1c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xb3ozSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWVyQy80MXpsSXQzWTZlb2Y1SWxMRE9VUXlML2FkRgptMkF1NWtvQUZP
ZUFCd3RFdGpQaEdVdFBpckhpcmd1WTAxVDE2MWJmMHR1UUJGSHZHRnNQbkFKMllkem9vOXlpCnRK
TFNkQ016Zjk5dGFZd0lyb2tRaTJoRExHcUR5NmJqS2J6cXR4ZVBQNjNvSjNvZllmdFF0ZExiMTh1
cjUrTUsKMjVYVWdrNzcrOWNWTEN2Q0xHM3ZaWGw3YUdWNnRzQzBBOWxVMFZZUzRmVWx3Zk1xeTZo
OU5ESWErWkhDVHc4LwpDTmlOQTNkcnhMVWtZeDlielJGdkRoYzJlTFhSU01sMGVQcmR5ODhYT0Js
NG4xdE8ySmlaczRvUWVoYzFtVUxZCkY2VjgwSXZyeC9Vam9WN3QyK3QwU0ZITmtkM05Hb2Rpdlpm
MzUwblpqbFJReCtBQnlVK0h1RFZhMmFkRGU5SHMKMlR6TkoybzlrQXhoYU1QbVRMaWkyVjg4OEQz
ei9HZzBjRHN3cDYzMDNLbXRWanFUSXNSWjlSVEZINUtKUzVHYwpwblppNnpqNlBLZGhLQ3dIbVpr
d3lCQmxrUTNseUtyWHNhTmFXeGFobGxxcG9mRklGb0JOOXExdFZ1Y0RxUXpnCmV4algyU3JKZW9a
UUxzRjZ5dEV4SkVFK3EwWEt6TUp0TWxpcmlPWT0KPWdxeGsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008aef0a065b7e58e3--
