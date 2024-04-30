Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122617164C
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482668; cv=none; b=pvFtM30Hxgi3CdZI7pL+fJYcPoFBZInMGTBlNps03TBxFF+tQmT49NKwfWBDg0jD9VHCiQiOVNOqr6iBHFnKNAxbx03tRvStAINUBEpdOlWWFdKHr57u3jQQG5h4vep4QC/+jasBTOHsxaCZNkNj2qNEuEi3Koc5U86MRPUe3yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482668; c=relaxed/simple;
	bh=GpXUIvQwKyz7gabtZmwjDr9rsqXjx+jLJ+z10LQ4ey8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6BIJYt1vd1RJuwVS2HJbQ9KwDeLfnymeNW2vzXMHzvhPBh0dWqjwx7jKMqTnmXbtJQtvIWrv9+76VUwttcHzO32EH9+j+wiPWE8luBRAo9yCtgCaebLe8S8wBy3aGc6JooMN55kWcrHE691H47CATaXAutkLbUUUUSRzYhfHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAc/ToYY; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAc/ToYY"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23319017c4cso3621353fac.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714482666; x=1715087466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYuoIyWQ/60e6s43QxoiFnCEDR0kC7mdKlwcLOllIq0=;
        b=aAc/ToYYyXb+TSiqjzR4xb0PORj8vC7LBh22Kjl24+VWS0laRThYQsicNIdvl0h98n
         /DkNTnLsLuuknNpoMb1RVc8/J/EY1iVvrro0Py3akQSvrT8m10ZTjpwWlAXasPt8obcy
         jbKQ7x92CJAK1Wr2s0WZunXZrxBEFs08msy1nqVGXX2Z5q4SNscPR9LqfP4PVyll92tt
         61LlAJuqz9f3+26wFTJh/+JsuOU8urwPB73yeVHf2+xaHirvyC2UH2amR9h8NBlGZJqA
         hJtu0pSX7LpNU4pomZNUaU+m8e0A1ews3qkd/aTfynNDME0hQ9GDMyA053uVHaQrd+99
         oswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482666; x=1715087466;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYuoIyWQ/60e6s43QxoiFnCEDR0kC7mdKlwcLOllIq0=;
        b=JVBMexU93BQQ2wM5OxowdvkjDcZ6A+xpX/5Tj/WIs7GhuF8B4/QIdmUiV+BQPjTrBO
         CnXMP6Ss3EbVjq6UMGTwLwjBwYtqG7sfwIBXfUmGPYu26ntHN2A9HYDXWp6bAdLdEUgE
         xdeRtjclLFMDZonUuSMXdFv2MOX1mZUfBNtl8ZLCM+ezurwcMVDucI5ierDqMYQW+9xh
         voA5sH5N0GVmoH0hNBO1mcqMmN9kfaXCuq9SP/L0xH4Z0OqtK1IfjrLTvZqyLk6DmW1c
         e2d+Z0C9/8ey0wuDj0TQsx2j+0zatYp1LBq77ZqPWWKXILyafIFvourQH7OWiiYDvxhZ
         e3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1roamQ1DZqzcAZUjLzE+nJoGQfF4yhE64cNsNhxv9QuQcvJxR3heP6JiqhvZoLDsYtP/k2UM5pnzWzrHeAvzJOO67
X-Gm-Message-State: AOJu0Yxcr53gPIgyTzl1xHuhYU3LjGrMYIZPC+ptyvsMpvF4tfkq1qIV
	DBFKuRtcrlZxxfe6mLy0iBdQDrth/fTik9EO+TiAXeDhJxRXAkgzYOcLbJcXbyJPdgFytXgWTwQ
	6ABpIlwKY+Ku6Ka04PhiuozZaBlc=
X-Google-Smtp-Source: AGHT+IFSIoopMZfVseLtXCUIp7qXID+A9s0vvZ6HuiN6G4JiqBvlOFNRyDlzcMC5PKa+KZELtLM/Nn0RCj3cvv55kUY=
X-Received: by 2002:a05:6870:960e:b0:23a:fb36:ffb3 with SMTP id
 d14-20020a056870960e00b0023afb36ffb3mr14597303oaq.19.1714482665911; Tue, 30
 Apr 2024 06:11:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 06:11:05 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <95d7547b2e8c5305e76888f7dc0a41d2b9e2f558.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im> <cover.1714479928.git.ps@pks.im> <95d7547b2e8c5305e76888f7dc0a41d2b9e2f558.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 06:11:05 -0700
Message-ID: <CAOLa=ZQY5rdUqcy0yTB0haduf9EK7KVLeoAYLyaST4fMn6UyFw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] ref-filter: properly distinuish pseudo and root refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000468b780617501afd"

--000000000000468b780617501afd
Content-Type: text/plain; charset="UTF-8"

In the subject: s/distinuish/distinguish

Patrick Steinhardt <ps@pks.im> writes:

> The ref-filter interfaces currently define root refs as either a
> detached HEAD or a pseudo ref. Pseudo refs aren't root refs though, so
> let's properly distinguish those ref types.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/for-each-ref.c |  2 +-
>  ref-filter.c           | 16 +++++++++-------
>  ref-filter.h           |  4 ++--
>  refs.c                 | 18 +-----------------
>  refs.h                 | 18 ++++++++++++++++++
>  5 files changed, 31 insertions(+), 27 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 919282e12a..5517a4a1c0 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -98,7 +98,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>  	}
>
>  	if (include_root_refs)
> -		flags |= FILTER_REFS_ROOT_REFS;
> +		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;

The only issue I see with this patch is that it makes me think that HEAD
is not a root ref anymore. I get that this is the best way to define the
directives because otherwise you'd need a new flag something like
`FILTER_REFS_ROOT_REFS_WITHOUT_HEAD` and `FILTER_REFS_ROOT_REFS` would
be the summation of that and the HEAD flag.

Apart from this, the patch looks good.

--000000000000468b780617501afd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fc009c7927af63cb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdzdlY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzlSREFDRUtzNytEWUxPMVoweDZMZUdkK3hVMWExbgoyeDc0RllmVEI4
c2R3Y0xkRWF4cEU1RFNpQ0p6aVcyZXdtcFR0a1VNK3gySHNpU2wweG1HOVB3QVZRd2tPakZaCjBv
emhxZS9kenA2OU1DME1DaGZiZ1hJZnhFSG5ZZm5wcjVEZU5GKytoS3BhY0ZNSzNVWG9hZHB2REpx
U0ZMZkkKRFRMYnhiMjFKQTd5bitrYjJ4RHJUUUU2eVNqYlNmMUF0NDRJVTVhbmNsNmh5QmRvYlVn
dkhFYnN3QWJyWkhpMApnN1ZJc0hsSStZMThNSHc3RWorN3Z2NDFBUmVwNU5iUnUrN2t3Q3FmTnQr
bEtEN2NSYlRicWNHdnY3amFVUVRBCmhXeVplZjlHUUNsNE8vRDBRUmdvMi9OZ2tHTlVOb05BZVpt
VHFQa054S3RiRGc1OUhrV0tHeWhPcFdmeW1aa0sKdDdmRzlLQmd6dUtuOHJBd1BEZ1lnLzhiQnd0
d0hKZCtlZklqNlA2U3FScFhlNTRhZWRBeFRFTkRmc0k3TGhqcQpVb1IxY0FjSm5tb0VLdTlWdWFl
Y1BhNDRtY2hySldTS2FUaktta0IxY0VkSjh4bnJzUmVWMjltQ0hrNkhrdERMCkVJL0tXSm05WUpi
WGc5empSU3JRVmdxR0xVSWV3clFveEVhNWY2ND0KPXlIV2MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000468b780617501afd--
