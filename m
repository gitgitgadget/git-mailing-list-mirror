Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94CC248881
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492231; cv=pass; b=Zjq26qKRX063Hp546jjPLkjWuCN/wpfvftAZ/wipI07sT1nCrzIDx49lO8THfCJ6kT7hMhYx3EYc4idoObNG0EOqde4p36TfP9rgOH+UMIPFF6439DybUdrxh1CAXeGgbdTaSoGtk3gDCiMIea3oB07APr/rr4l/kYrHdsimuO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492231; c=relaxed/simple;
	bh=p8HWCN22Ynoe61bGj9NpmsoWzsoNwhIbPe8S1flpddc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbt4JIyyYbNjnvgj30BLpINPlPpcFMSB6XQyhIdjtN6FY6KvRpQsXXhHFsKMPrLjlYBldOBA8rhZNhSCMSiCRjM6tKYiFRFWxapjgvAed6yi6KhR3RoWP8rPxOK79eT7oamF27anjVQfi+wY3v7OFWQ6L5/+cUMohIRPKdNANAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtdxxQjd; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtdxxQjd"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-73495ebfc96so1115281137.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492230; cv=none;
        d=google.com; s=arc-20260327;
        b=K5R0/FzmaBdhCHyoO1d2WesW8SujXKTbm4ONVuhMMCcqRF1JLFPp13sxjLF6IXHcWm
         foqvjt57E5KL3V1Ynibj3GzQXV5aELiZKuIIs7WSS+aqSOxYUoLkMIBQ0Pf3YMN3zUpT
         zqLdOwaysUqatUpUy5Dff7pVj8yRzUhLFW7cX77xq6UchJIW4q61LykNgd1/mwoZTk5f
         cAYY8cLSOEbEx5KG3394ZtWiigNRRKAnxo4IAmfGvgR/As7VM/f6uTLdoc+QRmezu5uu
         5szTkcyK07L5MaC8DYS25ieA8E+yk4xHERE8LwXUhl9JPKqdTiJ7uQFQ6csOeYg2vPf/
         fceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=QjD3vSsaW9hgJpI2kpWns6C/zv0HLhVJUv4vTMe1Z4c=;
        fh=rfZEVlH2ERFpGXs8buIylvguDKHKWMDAFWEjLh715/k=;
        b=PGD29mdA6JXDO3Oxmhgqz7s6PzHsk1Mgt1hcW34Ze/Ph/xOP64xwiAnB2keQ6ca/Dx
         V0TY+TxqCL02Mih1jR+mkjQ2+uPJTaAVdOdumBswvYocxbUSIjlAbpyJZIJ+n7ioWlwU
         rxQDPT9wRU6/zuN8hWaiUX5A11UreEtWWRoEAvENlwMwrbRaO50iWEOBoVZy89+LIYml
         T6Y7Mj30xNukAIx1NNEW8/5qD31UbTGsTTKh9dGYoVhlF8HlmENP+W3h98PsFG5xM1w/
         BKMy8qchFEzrHBBsVg/LdIkFwBJ8Bp470thgkK/mMZTQpog5nvf4WEvSMDZo2dFBIIwg
         BAVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782492230; x=1783097030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QjD3vSsaW9hgJpI2kpWns6C/zv0HLhVJUv4vTMe1Z4c=;
        b=CtdxxQjdNIXhiHtyo+tLLJ0Pb6oL4oULmRUiOFnkvDY4qgKM7jfkpjicBK13kNGser
         7i9GivQh7PQ+yQ4KmAMsecNUcQSG1NrlLVLn408owD8R6o7YIRvtl2iPSXTj/2tfoBFW
         dcedtQOZU1un2qXxSVdFVch72ijpGHyuNueVe/8i+0ZADCdfRpRk0pXzXbJW7A19a9Ir
         ws/znLykX94iDZUvQf512BzgFJ1YceZspCsN1KmKBuCiVHFY+Hq0pvBgoltdlM5Ru0eD
         4DQMzd4YHHYG9DlhAHisaTQrc/KDi+w7EHwJak9wEUbWwebircjxXOU6YHCmdLbTuiHe
         CkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492230; x=1783097030;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjD3vSsaW9hgJpI2kpWns6C/zv0HLhVJUv4vTMe1Z4c=;
        b=kLUOYb9isDdfhudyeqjn1NWfhhcXSOgQeCCWIhGOUOBQEyWZ21rpvEbmcpjv/TEBqr
         4LQ6KUHP96vNbm8ZposckUXvhZfkmxs35rxDHS+fE7m08DCH/Qu7qQMePCr40viXUWaT
         JMi45l5V5R2jT7LjBQtUb9US/tsiH6QRTxnjKlcGfVNgWMTa+k+mLWI34bkiZrEmT8eh
         5sUzsU+BlfTkYUfZg0yGiJRpPFFUbu6cvKc4h6qSaIuNu4EYwN6COwsNe8HBBJlxCPXT
         BTNKflDTuF7eZeVtwHj3+TXJVI9F4CxYC3acjx1OF6u6Zc31wQVFXtQ6sTdeee8PpNZU
         MTog==
X-Forwarded-Encrypted: i=1; AHgh+Rr4Q/Szm4Vn0XXdzll8w1Fb4qWBpAfUWn4vlXYFlZQNmhBQQKK1tbFFr8lcwHNThAT5cGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhyX9s+FsS7Oue2EzcxRArQsiH9XEg02s/7hULTGjCYRiO34Y4
	SG4oZkjCHsjQ0XyFoQpgaYf794fA1cd9g/dHqckTx65xuGawwyN2K5IlFNOtB/ZJ1VRm2oF21YC
	9dw4tjsyp71QjV3nv+NATP8FC5BMW7Rk=
X-Gm-Gg: AfdE7cmjQZ61LpaB6XUqYXAOhLQGWjbxX/uOvlBqIuUr98Iv/iccjGoNO0SJPjyuv9B
	1QmIjwdw7wfebnkLyDz1eFPbEVw51ukv7+7d5y/ywN/vJKLHf9rqyhAexUcDPE6J0rz7b4bcGq9
	gInq4UEXZjYaM+JE/q+ztF3R/KdoBcYBRT7uKbKsRLoBC+CTLKgjpnOgk5sK63OQRvo5hR86WKO
	NUhhRzhLqTSarXH8sqRwnZV/t1nwW+ttU+sZnDGB2GWwUrClONhLv3fYjZ9z9cpXftuBz8Hm0eL
	qrxCz13USQP6xYseZfE36uv7AEFnFfXe00jqS9eydgUxIVzX/0pXmlAJZdnA7c4=
X-Received: by 2002:a05:6102:5cc5:b0:722:67ae:d46b with SMTP id
 ada2fe7eead31-7343484cademr3697999137.8.1782492229616; Fri, 26 Jun 2026
 09:43:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:43:48 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 12:43:48 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-2-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 12:43:48 -0400
X-Gm-Features: AVVi8CcggdUWUHE1hc7WPeRponXtpjl8dirG0UyM1ZpcmvK6aM_zS8UBFyCfVvs
Message-ID: <CAOLa=ZTzj4_awdE0P4eU_oBd6Laq4CO=dvLJZ2F42CSsGo3pPQ@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 02/13] git-compat-util: add strtoul_szt() with
 error handling
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com
Content-Type: multipart/mixed; boundary="00000000000029611506552ad082"

--00000000000029611506552ad082
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Eric Ju <eric.peijian@gmail.com>
>
> We already have strtoul_ui() and similar functions that provide proper
> error handling using strtoul from the standard library. However,
> there isn't currently a variant that returns an unsigned long.
>

Shouldn't this say returns a 'size_t'?

> This variant is needed in a subsequent commit to enable returning an
> size_t with proper error handling.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  git-compat-util.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8809776407..7f417f1acf 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  	return 0;
>  }
>
> +/*
> + * Convert a string to a size_t using the standard library's strtoul, with
> + * additional error handling to ensure robustness.
> + */
> +static inline int strtoul_szt(char const *s, int base, size_t *result)
> +{
> +	unsigned long ul;
> +	char *p;
> +
> +	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (strchr(s, '-'))
> +		return -1;
> +	ul = strtoul(s, &p, base);
> +	if (errno || *p || p == s)
> +		return -1;
> +	*result = ul;

This converts unsigned long to size_t, but that is fine.

Looks good.

> +	return 0;
> +}
> +
>  static inline int strtol_i(char const *s, int base, int *result)
>  {
>  	long ul;
>
> --
> 2.54.0

--00000000000029611506552ad082
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3edaee3760d52dfa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vK3JFSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0Z1Qy85MXRZc1krajFoakNSNHdtbHFlL3BHQXdJdgpvdy80Y0t3cTVu
aDNXUXNia1VHV05qc2VyWm52Q3VsSlZEaURUTFNYNFMvb1M3WmNyUzdGaTliL2s0MENrM0NPCmEw
d3o5MHp4OUFOQkExeGZLdzdKNXhtQXZkN3Q0QVNpY3dUQWJjOU16WTNNeVhYb1pVdm1ESVJQRkVO
NmJNc2UKcjBLODZPYXZ3c2JvWi9KQk9hSHdxZjhINWhoZXVtSnd3ZVFSUFJkOG9nRGJ5Z05MbWY0
T3lIWmYxSFRrUGJ1ZwpHdFoyb1FodTkvbFoyY0VvemVxcHR3YmMxSmpVMU5LVTI1OThzQmVjV2Fq
RnBnRmRNSGhrUWR3VkFTcXBWV2k0CnptdEphTkFoVHpEYlArV0pUeTRwVnJtSFc4T2llZWtQVjBH
Q0hyd1Z6akVXV1JYcjhNYjYvVHJWRHlPK1lGckQKTHlBK00vVkU0aUdPbEkrQnduV1YzTTFkZ0Js
dSsxY0J5LzAwNTFBSTRhb2I1VzJVekgwSCt3SnhOSitCKzViSApYbWxZVms3d3c3YU02alU4eW01
MllqK2QwZkpRaUF5YnF5RzBmY1VVR1k1T3JlWFQ4aW1FV1JDTlEvQ1F1U3ZvCkdRV1ZlUHJjalNi
amVRUEZ0UGdxa3A3QlhMbnBhVDd4VVhGNDhpRT0KPWZLVXkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000029611506552ad082--
