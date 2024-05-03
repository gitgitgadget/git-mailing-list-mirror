Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2E20322
	for <git@vger.kernel.org>; Fri,  3 May 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746763; cv=none; b=uljdlzgrg+i0oXG3to0z8P8duPPlBjEQbR/OzsAdzSYJa/1jVPsjBo6Yl/5AeocgvsXPXwTyeJEXdw5QefJs0weYL97yxTcmsgKx9i5EAMXvE4dA5Ydzsrf+L53xX0jppaULHE4d+gitzvmF6lqGWyBqptoteM9WjJgMA53xjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746763; c=relaxed/simple;
	bh=EHcR30S6PMCtU/evTCwUjexuddcLOvE4I6O/5SWXah0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=fJik/GYbeoA96/zphLwtIfiW7HbT4+rFjrKVnHu8HWruudD73Ejx/97NKB47XIv1aTWK/9JUCyUqpMybOPBH0kE/aFWsrhVrB6+XILgoXhB2gbdFJvt4i7zXRtg0NTw1Ni+Vxasc/cDGfomTb0ZjWdvnoWIpZEMjakjBqivfqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD9W26mA; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD9W26mA"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-22fa7e4b0beso3877077fac.1
        for <git@vger.kernel.org>; Fri, 03 May 2024 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714746761; x=1715351561; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bppDeoa9VUToiMZx611KBfF5xp++4EOYDxuw/dw+H10=;
        b=UD9W26mA7qFOFbZw2tGyQo1kx0ffcNu7IYETrpzxi+eYApewZF6wwKWqyJy/sPJWR6
         PEfvojB8enAUYBHBEtbpuScw+CkQmFw0kf26/VQgBfV+QbAabPLcW10HbmHgqOiIKwTk
         auFlHT2Tqwl7BAoIcw7mEXn/4T+wyIRuh/lAd7HH98fvJHTG5+u2Zj14xhwQTHxbSZm5
         wrOUkt2484qRCPTwxMP0Qq1RtD+2uY+pYcZAfNrA6kliQuiYiVAaL9MIqERC1tgawWgN
         nLXYZ+bNrmoT4QeeL30vEMaMu8kdLv58QqoL7P8h2Gwub7qmpYu1RxCxl5GkP4b84lmQ
         7nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746761; x=1715351561;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bppDeoa9VUToiMZx611KBfF5xp++4EOYDxuw/dw+H10=;
        b=iAyrJ91ySrZVcPnwk3Fb9gvQcLXRm32QXYbD0G80N8n5Wy9/B9XBgerQz87N0v+4hE
         ihhrWBTBBqIi8T11GV2VCMYJuPnKUZBraZV7PUshBfA+pyBEe3r4cASzMPIFWeFToRQg
         4DJpQWagPQcT0fr1JEsDwkyGdYH3pKWQKK1Bb27bd8yWvgYgYnlO8kPb2+smkSqw/GCP
         PvcA4u8NhG5xX4HtlvUumBnWcI6xOxNB1sTal6AGFCDGr+VLfkHZ9BTvbbEamZ/e28fC
         imDRTm3sv7ZmCdCOlOgUGSagM/KBILqx0nN5/YubRQmhEnRXFsXMPo3Cup9sR+6gDpYF
         dJyA==
X-Forwarded-Encrypted: i=1; AJvYcCWXtgzvXbjRHFqx69MZo0txahqGod8xdVqg+8GQtgWTyUbQkR3zz1s+XTQVz9RIdP7HEwZU3b1UiKyy9rBkmE+z49wI
X-Gm-Message-State: AOJu0YwlXG39u+z6IxBO/SzrgmWPL6A7Kq3yxws/9LsxnkRhehqMK0yw
	Wq5VlOwOFfZOTD0bTxdcXQ6af8puwZ7sR7PNc0fJ52gq1JPpylMTQx11PLmGe+uN6uISP2n9A4U
	b1HCzS8w8LshPfqSm6RKGMQD3/ZblNw==
X-Google-Smtp-Source: AGHT+IEI6ev4YKWvjjcFHEprg1ykj047EFtsx/tmH6RRA6ewYzb+z664l2vS41chGJZT534lbOUF8Qa6jTnKkjkjbYs=
X-Received: by 2002:a05:6870:84c5:b0:233:378c:a06a with SMTP id
 l5-20020a05687084c500b00233378ca06amr3221382oak.22.1714746761530; Fri, 03 May
 2024 07:32:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 3 May 2024 07:32:40 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240503071706.78109-3-james@jamesliu.io>
References: <20240430014724.83813-1-james@jamesliu.io> <20240503071706.78109-1-james@jamesliu.io>
 <20240503071706.78109-3-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 3 May 2024 07:32:40 -0700
Message-ID: <CAOLa=ZTTHhh0xVzhU7WPCOm7oE8s=hQRRLztVR3_=71euRcSLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] doc: add spacing around paginate options
To: James Liu <james@jamesliu.io>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000099ee9b06178d97f7"

--00000000000099ee9b06178d97f7
Content-Type: text/plain; charset="UTF-8"

James Liu <james@jamesliu.io> writes:

> Make the documentation page consistent with the usage string printed by
> git.c
>

Nit: missing full-stop here.

> Signed-off-by: James Liu <james@jamesliu.io>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 7fa75350b2..d11d3d0c86 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git' [-v | --version] [-h | --help] [-C <path>] [-c <name>=<value>]
>      [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
> -    [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--no-lazy-fetch]
> +    [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-lazy-fetch]
>      [--no-optional-locks] [--bare] [--git-dir=<path>] [--work-tree=<path>]
>      [--namespace=<name>] [--config-env=<name>=<envvar>] <command> [<args>]
>
> --
> 2.44.0

--00000000000099ee9b06178d97f7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 594435a4c75ef75a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZMDlZY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGxWQy85VTVSSU5kdDUwTEFsK2xZTFlkOUJveUNnRApGdmVSVFR4YXdI
Y2NKR2h1bGsxZUgybXNnSldvK21QMkl2UDlrZ2dOb2NLbFpkT0ZVMXZLSTJNSVp4TW16bmVaCjBG
NHRIQ3VnUkt6TjBCUzZtbHB3MHIrSmNBWTY4Nk13VUp0UmhxazZXZEpsRHQrSCtQYWpWSFd2WERZ
V2k5NVQKcHJHaFJ2Mlo0MXk0bFRMWkxqcGdEZGd3MTBkay9IcUhQdWd5aVBiVjROT0VtODR5NFFB
QjRTd2tNaUErdlhVLwpnYm5rRTFhUmcwdkdkbTNxUHNuanJ5YzdUenR3V3pwYjdXTm9YUlVBem80
K1A1eUF5Q1RKQTkvV3RtcC9GWm5UCndPN0tHNWpCUFh4Z1BnOEMrVklpK3I0dHF4aG8yYTE1cHZr
bytLenZNUklUSW13cVFPbWZTeUNOMU44cDRsU0EKZ3lsZmFlQkV5QmIyUzVBazByNXNYK1hMSVZH
VG80RHI4M29BaTB6aE9ETjFzcTJPcUIzYzJqREwvektZclZlOQpnUFQyMWJ4Uy9xZUFQQThReFlv
UFh1Zkg1N0dCY1cyTzhXakt4OTk1dFlQck0rRGtGdGY1Z09GRndNL0VkS08rCnhieHIvVFYzYVJK
WXZoTlFnVCt3ajB2TWdjd1ZHWGhiVXVBMkY4cz0KPW0zaGsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000099ee9b06178d97f7--
