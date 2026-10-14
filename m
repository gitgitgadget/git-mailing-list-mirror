Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36734D92C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989116; cv=pass; b=Wvx+moazUaqGbEErLC6Cxr7Dljto6L/3HWqNQGqHsM/KK7J0+CqoiJZXZUnqeYnkSwX1Hde0ONyc3L3Kca0pcJUzBqxwn5EuSUnYPbD//DqqT8PsaAe1TYgDXYcm7A2vQVESTcWxxMMwFqV6yFPr26Urz6ZOK/AMop4c7Am7a2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989116; c=relaxed/simple;
	bh=7fesRzZns/KZrpIA7FwVZIgPPI8dDCpxsFTEwE/cQLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Db8nByn6pknn49RVmqXyZv1kF4xUQyTJyHmSyoBkR82FS976dC+NEY9OZEnHx6CWY5McnC+zv+1U4tiFyGLXtlOWQb4nG/s/6ZgLFqqdNyYLJAaXEdoX7GSiqED98KI5Lld9FrwtEYUGoluNa/TwetNepgrV1WSCEBMISS+GVew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irBl9lei; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irBl9lei"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2dcbcc546fso520785666b.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791989113; cv=none;
        d=google.com; s=arc-20260327;
        b=aZ/cod2M/loOdOpItEDMjw5Ezj//68nXJusdDCKugp1ch2SCbsjUdv7hGvBu6uWxLX
         gJCpr0VG4CKz+V9/uhwL2n5KYLHPcSpmhIPFQOdv+GD2U/4r7lUIWa+mc+qtTNCVN2R7
         H0YgrlZgRJQyU7UG28tJdanRmzvxTgt2StnTVzLoXTyJGtn3JaVnRfo2uR2EHmLlZ0KA
         fdLTanWy15neBfU5KXWKe7b7WLOliHhJqXIOqoX+uIuXSN7u6GoDYW+CkxluBIpv0KLU
         AzjESfDQAA4dG78eZtNlYDkVQsopmWRnmXw77AdrYO04MPk0LJByCOFfNRa6saB3GA1T
         En/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GrjksLd1hHL9TcLOuOiKDFBURupGbDBXMwGSMOsyD4I=;
        fh=vSj9PFhPeljTYt/cuRUiB4FEthFjf/0nTmE6dJoyn0Q=;
        b=RGCdsQnE1dOWuXJ7EKZoHu5XnJ46n1hSQLOHClpHKWW6dP9jNFtJ6lOcdT8KpaRCYh
         nffgYx9Fm3Jk72rQ+xNk2fymzx0WkR/qlrMzvHIaNGJE5ptzJdcSs6+2fkCvClsLv/4t
         8mx8YPJaz++4Saau115tEG//92qG1aGxwbsCJ+ULsVFdpV64gWejThvb1GBFZJmlS1oO
         F+ZagiALmeH7CnFDtegC0O3vK18CaREqgk9fpxJIk2b17krrVpuXAmHLYPOHsf06tBbD
         +w10nOrH51cm+Fhj61ePu4J2/lfZYptiaZKfcj8lF9uZx2AmPjbxgVM/C/I8aGiQWvRf
         b1Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791989113; x=1792593913; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GrjksLd1hHL9TcLOuOiKDFBURupGbDBXMwGSMOsyD4I=;
        b=irBl9leiUrljJGbh8tl8jG5MSPIhdAqj1qwvAQ5PmUUgVZRQFCKUHooLLeqLPwENkP
         bN30taVWGFxM32GTgqS+E9s4uaT8p34EIgRd5iW9InXKXM/3hX1ZAZzlqVMJrQ+4wy1R
         yoyGSIXJoqY1MfO7l4Nwb6UQrn8ID3NmP3K585o53NxcJ+kDMVBQA1EnxlmQ2sg04ceq
         CEfQ1vWfAP+YRRSYQNPp/6573pmE/vmu+OV43Fohxazb1hqMTe6gN/nupwQSXmDcg+8u
         PPxFHXMwYhVteTJeo0RhoBYARuxIWh8yXJYL65H1UUW/23P8eMCaQBEg0dm5zzONGcjQ
         TdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791989113; x=1792593913;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GrjksLd1hHL9TcLOuOiKDFBURupGbDBXMwGSMOsyD4I=;
        b=rvICKnvjEQjlwivuVUS0SLOKXpAWjJPBnjgAhPb9elWDGqNXxT/x3gGFVHLmqxRHLX
         qBTTIkTm6wsjaiAwQJLJJXbO1x0uJXBZAllyzbP8iiR+0yJ2AJrAw0dtjy6jeuf4WtQi
         NrUWcKWrolmSJd+YemwZMFkcDn8lXQ44gYOl8jPkrcmmWfT90cKMo0NPXAO/r5e3MeKz
         oaKOF15/h/MkbS4p52iWd/JdKHIsw5byrctDVkOUk75CL1vV1KX+OY5fAlvw5G4lDvf2
         TV58wkDOSC66uqgSEuSkQur3Mbj23ZQY0CsJXVSxUrw3yUh9zbP6RLNvkZN3CeLZ983u
         hFzw==
X-Gm-Message-State: AFq9FYKZdwMGUDXMPa5kvQLFiuW76glbzJ/iz/KOUsft1JJl5ela3OHT
	GlfRYmC+1q2FlXDQjLXC2z9nkwKV9y3fYnasquGLXQSpbUUaIzo5s9jGxnRD7tWexYerp4/DWi6
	ovtlr10U80YwDWIjQ17cgr83qaa6Gj3AbIP0GSdgM3Q==
X-Gm-Gg: AYBFou2EoMLuMwnKGP13gYHfpogMvI8MuFUHO+1Wp/u4igLOHb1sQxR5w7w0rpS2XD0
	Z/AliSdZqyT87ldapNDFJn6SVIkwl1g3J449Ad6LSVaOlEZwRfAv6vvwS3ZMg4DMcyZqzX4WcJc
	ZORLZCqs8biQSCBOUIu1zIu3uuNIO4WhlWEobewszSOHfUH0KI0ZszgJhlAX0WR3gcIFFRrJDlj
	C6Z4u2snL61JIwJcD8zPBqMI7yg3d1M/FfiPubbGpG/Bhyis41HoyM7RDTl63S1KtZCBQT8acJ/
	RfNlB77PQDsIngXcN+wDwhTZo3O5wQ+C/QAWo609sA//6y2QCK8frW78sa9v/sGkyacnkMjQ2HU
	=
X-Received: by 2002:a17:907:1c85:b0:c29:f5d8:9c75 with SMTP id
 a640c23a62f3a-c31aa091abemr1557612566b.36.1791989112615; Wed, 14 Oct 2026
 07:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014105613.49334-1-vua.okafor@gmail.com>
In-Reply-To: <20261014105613.49334-1-vua.okafor@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 14 Oct 2026 15:45:00 +0100
X-Gm-Features: AclHuK8UAd2fPpzDwb9DTnMSGIljmaNCxDTCpBWqjeNVf4xakKhNjjlT-gx8csk
Message-ID: <CAPSxiM-VB_JUexggYTMmYcHe7W7pw=XNuMrENB4gZoq2Zo8J7Q@mail.gmail.com>
Subject: Re: [PATCH] t0200: use path checking helpers
To: Victor Okafor <vua.okafor@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Replace direct directory and file checks with the corresponding
> test helpers in t/t0200-gettext-basic.sh.
This is a little bit more confusing. The commit message does not
really show why you did what you did. Along the line of

"Modernize the code testing whether a file exists in "filename"' seems
better. Also, your patches is doing two things, i.e modernizing the 'test -f'
and 'test -d'. Ideally a patch should only focus on one thing but,
since this is
simple patch. It is okay.
>
> Instances were located using:
> git grep -n -E 'test -[efds]' -- 't/t[0-9]*.sh'
This part is nto necessary.
>
> Signed-off-by: Victor Okafor <vua.okafor@gmail.com>
> ---
>  t/t0200-gettext-basic.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
>  test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
> -    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
> +    test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
>  '
>
>  # TODO: When we have more locales, generalize this to test them
> --
> 2.55.0
>
Thanks
>
