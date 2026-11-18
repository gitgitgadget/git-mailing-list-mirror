Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795000882;
	b=MNGrpVexqDKtQvEvq6dIsz3+uGswHLrI44RKuOJLY2Ufb+rErc4ymZ2eRCgN685JWagv
	 drRkMzykPqNdQATwcucS4RAKwVt05qDMdZCNUMCBHjSAC2BmyxRHrRQ0yl282dC1uQHg5
	 huB88dBJbPXgxhxroQMi8R0s2o6AwJbd9AD25NWdnJf9pXaRPMtoptNAMqZIEwRs1nYZl
	 ShlNIb/mBI/Adrk4UHAZXhjRP6cncA63DwNMrjD9NnpTHf3Y/Oa2e/EgAiTsdq6EsSRKm
	 hI26HcfuSzTdpigu9qF29xTDUcNfyFaCXtpv0ofo0aFCAuWZtADB0qJlA6pWMgliNmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=/q9rnZJsogIq98xWmqvCrqjBqjUhLVYmpDfe9xr49fA=;
	b=zoeMULH6kAWeA7BPPVeVY4+fjMJFL2Fo4y6/tlfxONvt2WzriRySRyEVqTPSaLDsa5V1
	 J7YQXJn1a+Yt8kLsaII9+NcgvWTsNWpImapXVc9ZJztzYRHlBEFVokGduQwLGktubA/vs
	 9Sn/akRCgKo7g1iiEN6HsbCFKDAoThqpTlSZ54Pg8BixvLQ8JatVfb8uN2vkx1ohJgsWx
	 6xhNK3P9usDWfDz9vYBWo9IEL2Xdbv4AKYfHLVrFs/e1FSHTJP6HRcEC+/bz6MQN2Y0D5
	 0Xdm8gECfQ607fu5f1xKI+IFOoAEnk5YxRnu+rX31lOt8DuCN/WGT5Rt0+3ogUvjdxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wf8s84d4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6E606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF6E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wf8s84d4
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ee2ad94713so523889e0c.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 03:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795000880; cv=none;
        d=google.com; s=arc-20260327;
        b=SlCKeS39c+LiiYWI49Ao/OY/IjSl3QYvjAmmLazt0BQ9zKD608PKX4jgTRdnBqTjxE
         Wj5gxBdsV4P1bT1yjCVhq7EX59fjov66/Rdm23I/8y6q3D4H5u3csSFOHR6IT+MggT85
         a4ghtBfgm3SzZ1l0AoRczDdML+g1GZotPZRPTse+vt+y9LfdQYo5iNyru9nAXDzi0+Nk
         JRhACQrALJh5WxhHiUa3uk1BFkB1u4p4xoFw0vtbO9XaUHdKCDDz7jDVKmuUdflC4O9O
         Zo1QpOhB8tEW1QvwfI2OWz0BUKAqt5I3N0UMC69IG9YOfscBfy4JTEGEgLIDkOt0QVaw
         dJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=/q9rnZJsogIq98xWmqvCrqjBqjUhLVYmpDfe9xr49fA=;
        fh=i0NMGGmvYNXJWQcSuR5IbfH9Q+oHCJ6aMpvrMu8ZH6o=;
        b=kgLArHkXnfAv/epCLgDR8//MvZqofkDf4Nw2K4Tgo/0RuBK5/WFDrtzHXzjNUbWmLw
         WkhlMF4YydlngX+urZIpuvkVTdoKtiS8eU9Tiu1tH66WyYkp83jwc70lT5hXhtudZiP0
         jgvmcizlVQGbOjYS2qMZByYF1tVdaHC4hkQP+zM5+LgnJPp0TYCLYd1vQWss76rIZFES
         mqCppaQyPt3Awwy36H63UO1wjfnEQqHfj7EUpMXu+qKVU88oqlGduoErQPg/5xxNgevX
         dUZ/CFrVdDSbN+X//tm+EtydL8e10Q5UxCEOMOyVr7glyiAExDq7wermgz6hHfhKZ7zR
         zWtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795000880; x=1795605680; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/q9rnZJsogIq98xWmqvCrqjBqjUhLVYmpDfe9xr49fA=;
        b=wf8s84d4RrAIgBpIKowZWrArmuDBu3Wi9y6HRDKS+FcZXatvVF/BLdSem0Z5gbxYCL
         CvYeAl9O5mPrgMdJKGu7+EA6k5vxKbBDFLVJ+SoDjm4pMQXS6HV/OnF2BAnyuGaZuZwm
         kxlEzLSY9rmTZBCn7hJEmBFMMU+I6WAiOBbb4gGd61Cja7YYJ3pxfwtk/uBTIiKqzm3r
         9KFa9KxE/WNPCg9ssrJMVXSSPs12k1VWgON8bYHAzAfrm7gC8pBqBlUSf6DHSiY23doR
         1q8Ry3UG56uAYY2T4RhZs/KUmvQU3C3NF1jPtbJvEXFBkBSaFAqnTDblsZSMScE2F0UM
         aJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000880; x=1795605680;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/q9rnZJsogIq98xWmqvCrqjBqjUhLVYmpDfe9xr49fA=;
        b=Z3w25NR0sZS7lKS5w+K2TuertZR7ssCB73F6qrk5JFz+254Yo0gwoWsuadXiE4POJ0
         Huky0q62H2/Fj4eFyqC/DBK7pbX4zh17Gz4fjjOUfbUW20yMQbwxbAtVGE8NxlHBzXc4
         46axF0MaRcShbirJfQcdSh9YLwQn/4TlqlR8T1PyyRNl+v8EkW2aedFZvp74aOoQzA/X
         JGuh6jPQly/x76rPR2+QYUypupJknCRuvNa6ZI6f2ciQlovrfuOcTWvpbsDuVyh6nBU/
         IUId0yZ7SMhtrww1uKyZOz5Ja2k/KTr3hCX6mpE2f4wLrRX7+29BXObqWH0wApKme3Tz
         EcyQ==
X-Forwarded-Encrypted: i=1; AL+hErHMGRxrVcphohyE7cS0SEJMOWI7qjrI0XRryW/9ijDxj1h36F5zktMOXPTlt9N0gBBD4SU=@vger.kernel.org
X-Gm-Message-State: APuU4Z//1eKVtPnvoCiownHKfI+dP4Y+WufWWaPCQdvzbewPlF/5eOmA
	F3yKlfaotjqWGLCVNZ3zyyXLTxqQEOaeQzKR1zl4q28hvJMJr27eGHEb+vEx87VmE1p1idKGgZD
	n0p7jv5ydE9o/q88Yf/UCi/QZESWbAG0ogg==
X-Gm-Gg: AYBFou0A6YFok1mR83GfpiZosuXVd9BhH+XxiZGSWnfgP1W0dAHcflNvVANaYolvtpa
	F1Ox5wV/F4Z5yGYaikIRPjqx9CoKSXPU1IZxnoPRPuksyF1l9bkFnOMOfsbhBU8PwdMZB4mrxu8
	zTJtkmYAGOls1Hyw77lWvw3hAzvUswnYmspfo91bTfZTk/yIgo0xKVF1+LNYRV3GgYZx1fTQX7Q
	8tpN2vFscN6CSMAT0+xQ6JFTKv87qMA3cNVqWUp/aL60WapzZ54atf13VhVuMfHnsdht1ANzybZ
	nFG9aAI58jQTOX+nT8Se9e59AioHs2vFiGLKiMQg/IZAQeM8N6dGTKU/AdA27ijUT+Q2LKLuo5S
	ITodEkixF2gfmLpL6Ya9/iUCeHUOmKiP/x4m+xNmLKryRfbveyO6EUrRiD36XBHblKEgC1F/DOR
	hcw+Eg8oOvDH8juPn3NFFaewXkXm8=
X-Received: by 2002:a05:6122:1904:b0:5ec:20e8:45ff with SMTP id
 71dfb90a1353d-5ee647862d9mr1035426e0c.21.1795000880396; Wed, 18 Nov 2026
 03:21:20 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 03:21:19 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261117-ks-fast-import-consistent-check-unsafe-v1-1-fc1ed53c79b2@gmail.com>
References: <20261117-ks-fast-import-consistent-check-unsafe-v1-1-fc1ed53c79b2@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 03:21:19 -0800
X-Gm-Features: Aa3M54omSqk4rhhNVpqANpcqPJNck7WXeklmHfKCWiwNFRlYczByIxUsRPRD__E
Message-ID: <CAOLa=ZSYkXMP0pOX824B9rZEJyV4kQ9FqU44zW4Z76R05HUxnA@mail.gmail.com>
Subject: Re: [PATCH] fast-import: do not show the path when "feature
 export-marks" is forbidden
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d9179506608b35d1"

--000000000000d9179506608b35d1
Content-Type: text/plain; charset="UTF-8"

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Since 68061e3470 (fast-import: disallow "feature export-marks" by
> default, 2019-08-29), a stream that uses "feature export-marks=<path>"
> without --allow-unsafe-features dies with
>
>     feature 'export-marks=<path>' forbidden in input without --allow-unsafe-features
>
> because the whole feature string, including the "=<path>" argument,
> is passed to check_unsafe_feature(). The import-marks variants pass
> just the feature name, so their messages do not include the path.
>
> Pass "export-marks" to match, and make the existing test check the
> message, not just that the command fails.
>

It's not just 'import-marks', but all other features provide a static
string. So makes sense.

> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> ---
> While backporting patches for a security release, I noticed this.
> Was waiting for the security fix to go out before sending it.
> ---
>  builtin/fast-import.c  | 2 +-
>  t/t9300-fast-import.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index ab5d2a2344..998167794c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -3918,7 +3918,7 @@ static int parse_one_feature(struct fast_import_state *state,
>  		check_unsafe_feature(state, "import-marks-if-exists");
>  		option_import_marks(state, arg, 1, 1);
>  	} else if (skip_prefix(feature, "export-marks=", &arg)) {
> -		check_unsafe_feature(state, feature);
> +		check_unsafe_feature(state, "export-marks");

Change looks sensible!

>  		option_export_marks(state, arg);
>  	} else if (!strcmp(feature, "alias")) {
>  		; /* Don't die - this feature is supported */
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 15f511fb6b..33c04e0315 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2337,7 +2337,8 @@ test_expect_success 'R: only one import-marks feature allowed per stream' '
>
>  test_expect_success 'R: export-marks feature forbidden by default' '
>  	echo "feature export-marks=git.marks" >input &&
> -	test_must_fail git fast-import <input
> +	test_must_fail git fast-import <input 2>err &&
> +	test_grep "feature .export-marks. forbidden" err
>  '
>

Sigh, this will conflict with my long series [1]. So one of us will have
to merge the other topic in and send in a new version. Let's see how
things go :)


>  test_expect_success 'R: export-marks feature results in a marks file being created' '
>
> ---
> base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
> change-id: 20261104-ks-fast-import-consistent-check-unsafe-0a94ffda7518

[1]: https://lore.kernel.org/git/20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com/

--000000000000d9179506608b35d1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 40fb8d4fd0a1c191_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yOWlpZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0JtQy85a0hNRENLTmdqOWNKVis2TGVFYzRGT2lFcwpIWXpmbUZ3ejYy
M01FbXp5YVdxUHRSR1Y2T0thZ2VMWFVzL0h5Z2Z3SlVHakZHM2RsU3ZFN0pzZXhsemluUU9FCmpP
UDVkV0F0YlAvUU5sVkxGbS9xVU1FNHFqWktMUVZsV2pyb0RzTWJtTTZrbVJpRURrZUplRUw0YXhE
UzNQQjUKdFJ3alg5b3NzYkFYL2c0alR3MFBBaUh0Smx0c0RvbXFLaEJqSUZ6aVNJd1NBRGkzWCtW
ZFdHTDhNb3NPVTJmSQpxemtQRy8vRlNYWjdJWmpDWUlsb0tWMjVvZGRPbmswb1BRdTRLUTJaQnd5
dzJ1alRqMXNRcUlxWlovUE1LMjBLClBOMitwL1c5ckxhTnZBRXBLSWVHVHd6ZzFQWkxWczgxTis4
Z1VKYjNJblQrbklQQ1lvcGZKTFY4Y1NZR3V0MkgKa0dqY3pzMHlqeDJjaFRueHcrN0xPZkdjMVBD
SXpFQmU3dVJqTGFOVUwwa3lHYUh1cjliRW1vbnZvUTZNQ21WaApiWkNGcGZiOWluek4yU2dPT2xB
Mk1zQkRqNDFCcjZ6dnNseXJ4bnpuOG1PVk40RkltbWluZy9kU3o4b3Erd0JrCmcyRWhsSHlQMkFU
MUZCL240NmRFWDlxd2luQ1lHaXFTZ3R6Vnk0ND0KPUxYWWcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d9179506608b35d1--
