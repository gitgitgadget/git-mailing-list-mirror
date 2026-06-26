Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2B3BF69D
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782512600; cv=pass; b=dcARKjiM3nIT7hgEd2oH1Skasw7d+Y+RcaCXdAMeSwYwMcXRG5ovzKmGMInil71im2pmxIxl/FwIwu1VYn6GDtPWePgu7mH4cR3V1lm5KCoPJI3GU/lyQ7BWPElAq7txxXkYSYhNoR08fA/sL4jTFShKZ8f1Vuo+d87OJQYBDSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782512600; c=relaxed/simple;
	bh=g6i9+dIPH1G6CGkfUD7flKRGXb1aFTG/Ghz8ejr8Tgk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9k3PwIv83pCjw5UFmFDe1RjoFIigq8y9FldPwX/7t9Xsxcq6fsaxOMDA00EsusJmZQgWXaoCLd4Q9dmFpIJh2XD+gmuL7ZYUN1HzxhKkOIDWHTnDQyhUUHo2dYS13vLDlZLgecc/Yvl8pi1LcxgLfFI8/ow+sybtU1TsJCI1E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh11z/Ze; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh11z/Ze"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-73415614289so665238137.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 15:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782512598; cv=none;
        d=google.com; s=arc-20260327;
        b=HSP6GfAYl5uL4SjjYn3dE3TdLW5Aw3qGYmD5jgrD7QpEDNkRvlbf6EifHX1liCs192
         os4t+8QveAogyeXSYK/iWlZJl/oTFWFycUwSFmylmkQ8zdAZSmv3lQ6CMxjRzapv3ZR7
         lFczjIOXPqKRPUDCQjUEj9b/VBbGkRn98Nwz2D/nsU+r+6NtjFsXpkdE8LZ9nyr1Nj/+
         iC3rhf37/mRM9nDsH50q7xG+BNzsANs/7gEEPx/Ics2r96shfGZWjE1wLOoBGvFSqsQZ
         RArTFGbtBDxYuKbNYM81d7+r7ZDQrd2mjDgQ+P+GGjznMQkJQB9/6/Y9y6jP3/4q3Til
         XOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=eWOVvU9kwE3YJaTUDzr/VfZWS6a7ttzesoGNcBSEzHA=;
        fh=n+sZU5apJn0ZyH3UkQH5Ypb58c715NsgbLX9WwX9cIg=;
        b=HTGhsABU72HJ6OtrsqY2C29zLX3CHmtyfu74z5miwggg68FwtOu7cH2vSepu21d4KR
         oL8naPkpUoomYT5/2oSL476fFLjF7tnTAf6FQbsn8dIBTxxXtSZiu3E4XlLn9XAvPco/
         0fIz+H9szCG2q/z45AP9wi51pzxi6ZCa1d1h3x+dx6FaKb4RNjqrUR7mrLFPfoxG+bWD
         CcXoSpXXL9pHp5HDhS91o5evdZIeEHIQiyZ+ago98R2oM5OPEqndhAIIjw27DjieUp6/
         bhGeNR+kBaDk/Va4YP3o+hj0oyy1NryuxfT9au+8z93I3WQyHz526sdxjnRxngaOhnMa
         F3ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782512598; x=1783117398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eWOVvU9kwE3YJaTUDzr/VfZWS6a7ttzesoGNcBSEzHA=;
        b=Jh11z/Ze+g17N906hsiRzEFCbg3rjgVyo5IQKJBYWvPzLH3YRpdkZgILGRxbzMdJxS
         4h8HAK2/o8PVFHuNIw6RVaKMdIZyWIxuSSXfecHKhW280XgJWnmV9iDj/6tVhyrimC3X
         nf6gZK/2i6nSdO6RtpuDkI9lDz7c+kc0mthvsbUvNRVY1KI1x/NH10t/08GvWBNtU2vq
         TJRbRAYcHNrUlxpR3EgKo3HRSy4qOuCjCo2ufe6II0Gm+PZER1MZmbmFIJfFq9SaNEuJ
         V60bz23jxw6DQ6yBCpP8sXKVYIFmZdwiNxzgjZOr0Fu7w9fjyipOvaMGQk8zgmEY2Wl3
         mQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782512598; x=1783117398;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWOVvU9kwE3YJaTUDzr/VfZWS6a7ttzesoGNcBSEzHA=;
        b=bLETZNgITUJHnmeHYykxkR7KqSlp7KDFhD0h9wTdKHPl2zjPC10jALLwG2+fYunm57
         sLXQKQL8eBEnuViJacohDV5vaYErgoDCxkCJe0iPxPWsUvJQzK1hcgfErPSA6XuWNYYf
         d54dKlOjEKg/LRPWb+hpH3c49E5y8q/17oqejODobqO6wYiWuW0mvjzos4DxB0mgSTXn
         Rjt66HrcoiaTF3V2vvCvwkG0AT7YtN03U4Xdnb8fNesBj7WUJr0xiKl0O4AKC8uc6hmG
         c3mP2IUs23C4bbAbtnF3k/2d6ScqYiOKTE8CN5Ac0h8iNZIZpL2w6D8ITxBt8dCifkoD
         6zbg==
X-Forwarded-Encrypted: i=1; AHgh+Rrci3VHqr1LPdJoW/J81vNbXwtJcJoKhGrzMlR1C02t4Xq5J5iQ6695EZ9Vk/rX9maEWSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gvWzCUd0XhOx52pIjgY5Z6y/nVjRep+MlkYzp2m+0HMx1XjV
	h2+CDSCcHfAYln3qHuNxImgHApCE/sKaLM3XRsRlYtMK+8QFxBu2OMtYKgKk8wI/nS+1hu5GVMP
	VIiK2D7MbBzc4E19afbzs92Py5uKsUdM=
X-Gm-Gg: AfdE7clrtDu+GUnMMYZ30JcsOYjdWYWeMP5HK6H+hYKAQo6s12az043UORMbK1Bw1Th
	Gc0EX8+rrRYvlTKuf/Bybq30n4P8Z1t7ABhL5EcbxEs+FbqrBRmZ3YT+JT2Uu8OSA07YqRWVlJQ
	wvRR8rGeEQNwB4GvYtxoSYP0xVM7lJid4q4BUPKHpHxq3td6eJJNPWIY13cy+w0R/w0yGWgJPXF
	HUQITxRJHSFINGtbhRmaFloDVYMQhebeJsv7ytRZYTOuKMiIbEpPTId6O8AR2I9nk5wwWs0mTWL
	6YFLx8UjGBF1mD9Hg9+nBtICgIMAWtn9uTLVtD+k1ZsyuAet1zuBZSIjJBkvbg==
X-Received: by 2002:a05:6102:5695:b0:726:cf2d:6076 with SMTP id
 ada2fe7eead31-734372070afmr4012998137.29.1782512598027; Fri, 26 Jun 2026
 15:23:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 15:23:17 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jun 2026 15:23:17 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260625-ps-eric-work-rebase-v14-9-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com> <20260625-ps-eric-work-rebase-v14-9-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 26 Jun 2026 15:23:17 -0700
X-Gm-Features: AVVi8CeDmPIcmyYD49i-ODpvT8JUNkmgF38U7Yboj5L4GUaL4-3EDHBJLlJE8uA
Message-ID: <CAOLa=ZShTcHOekT+NuxMwZz-7P5i9aSWXSL6MW9_9aKkNwqsig@mail.gmail.com>
Subject: Re: [PATCH GSoC v14 09/13] serve: advertise object-info feature
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, chriscool@tuxfamily.org, 
	eric.peijian@gmail.com, gitster@pobox.com, jltobler@gmail.com, peff@peff.net, 
	toon@iotcl.com, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: multipart/mixed; boundary="00000000000036a9eb06552f8ecd"

--00000000000036a9eb06552f8ecd
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Calvin Wan <calvinwan@google.com>
>
> In order for a client to know what object-info components a server can
> provide, advertise supported object-info features. This will allow a
> client to decide whether to query the server for object-info or fetch
> as a fallback.
>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Helped-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Eric Ju <eric.peijian@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  serve.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/serve.c b/serve.c
> index 49a6e39b1d..2b07d922b3 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
>  	trace2_data_string("transfer", NULL, "client-sid", client_sid);
>  }
>
> -static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
> +static int object_info_advertise(struct repository *r, struct strbuf *value)
>  {
>  	if (advertise_object_info == -1 &&
>  	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
> @@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
>  		/* disabled by default */
>  		advertise_object_info = 0;
>  	}
> +	/* Currently only size is supported */
> +	if (value && advertise_object_info)
> +		strbuf_addstr(value, "size");

So is the plan that further options will be added here to value? If so,
whats the format we will follow?

>  	return advertise_object_info;
>  }
>
>
> --
> 2.54.0

--00000000000036a9eb06552f8ecd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c943c2d3c03e256e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vKys5SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmExQy85eVhpa05adDFrZFNIUmlHZFdBWS9BVi8zUQpJTy9od0tsd0wv
VjFzQndoRWpMWnEzdlBzR1duNEZUT21OWGVHYVc1TzVvSmttRHVRNDNRblczRnArY3NmNnd0CndQ
ZVBwMlNaV2pBUjJ6R2pEQmd5RGYvcU5mK1lyS2hiRmRJbzY3NHRSQ0diU01OdDN6OWRZL3FaTVZY
Ukw5VXIKWjJzNzk2ZTRnd1lWRk9Oc1VaWFR0YlJOQUtJVlIxTXNjVTVDR1U0bHFja0Zrd1hCSzF3
c0pJckQ2b0F0QlJRVQo3YkV4YjArTm1rdUZ6Yis5RFhjQlJsZVBqYTlsUVhJSVpuakwybDJkMSsv
UXd0OHV2a1llTEFWTVdRMTZLWEVPCmtiWjF3WVBHS3ZWdktwZmVQdFhJNWI5N210WnMzYVN6TTVU
VDNuT3loeDIrS2U5UmtBQ3pkUUgrbjZyY1BFL1UKbDNIQWJoNTNJcjZ6ZkVvaGJ2Z2NkcklPL0k5
MzBkSVN4cWVpYjB2cDJ3NWVZVFVBNnpoRDZEcHovVWNiM2NnUApaRjZFRnA1QWhsVFB0UU9xdU1S
eklYK2tYUWZrUmFsYzlvZzdtRWlMMTU3UGw2K0s3OUR5MXlLVmlPVGlNUUNHClh4WVBGamVwQ3Bj
NVc4dVhMU3FOSXk0L0lVQ09WODFkYkRVVlhOQT0KPWxZdW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000036a9eb06552f8ecd--
