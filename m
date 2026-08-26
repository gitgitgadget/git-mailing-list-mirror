Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242AB3DB983
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765811; cv=pass; b=C/98/Cw/NGjO/IUyr+BajcomTd3hx2Ag90L/9C3GnUli+04vCbm7dXfnXxsLpyC3tRNOUspcT52LocuG9HFB0ZViaptI/Y+fampK5+E5dgTZeevuYhQ5/ulAdbq74v8827RdZ4Gi8XkQC3yZ4b2B+krU/5Zg91vUgQhOD7Tw1LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765811; c=relaxed/simple;
	bh=Zo5N4YwXMdw030DOsvqraRdKU8/7mx4drkzkP3dGtKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7aerMj0EnH9Pn88laa+7f+zGZmxjV9uCk0t91GLYbzRWz7YTT0yXNla99kyieTzoe5GLNt/cGeuTk8ytRlyOI4ehET04Eq0dSq/YCDbfUiWXYMk5Ah/j/a3PzATpA1It1V+8IzPOHmCWtoKxIwiCaSFKAH4tUFg0iAHY2kTULU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exsMMiIf; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exsMMiIf"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ee4399c423so1107982a34.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787765802; cv=none;
        d=google.com; s=arc-20260327;
        b=jK05POPbCLKlb/ybM3yX2ZRBNlfxwdC+2MdbD0ZfEPZSp3WltjWSE3ALKAoY1kCMgK
         mBpqW9jkvbzvGqpg0Ru67920nDF+Q4/1MU0ahCIMx1LF5XMLTejcWyAbijjnvWKH1V6X
         lvzxR2L6HK8C/3Q1bECT31w5a0arhZK+oDl2hhhmI7DziUf36IYrZzST+Qknjj4xKvOk
         fXFjX3luDdfUHtYoVS5rQFQ59QrpZ06Zl1txA9J0YCRSf31UqvxfiVExy3AjzEVt5bpd
         hBQplBqN4/fNB8ULQPxOJvofu++J7Xx2dyW3+Pf0HCPA4D1yaAvtw055Bhpyn7+pKNmE
         px7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B86sYSdcby7eLpZflQOfP7j2Gcapfq2tomSoep94EOY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=bOtfjIG5P9zfKULb8oVNP/44D8Tl0HGItBCIeDttWIrt7e80CRkA2MaWvCvgx9DMCe
         yQiQhl4izFjwETA0vZ+RRDfmUkmMy56uJiolGU4sdCafVgfZCSEX7IH74EDFgn95WeXo
         FCa6M+xCN4gAjzaG3mgtLdX7Fr2pceiQSCI8v2lr0s5gc5DIIlnjRmPdTpUqURXSO9ZW
         H5l/+3sFeNlSnLV30Fm9HugkxwAWW3P89TpXPI+YvKFZfT1TeIyBl2zaaCQEth7aWDdF
         c4pjD6ldAFKfvt4dGlYhKDW+V5F8Emk7i9YHGguBUu2+zgzVRBQkQ3hKXFSD8T9WmOVM
         Zssw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787765802; x=1788370602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B86sYSdcby7eLpZflQOfP7j2Gcapfq2tomSoep94EOY=;
        b=exsMMiIfJLffPWwXCysztDSrz3IWCb3tBjfW9gUvrV/kxmMFLxGgqqUMviTUkZofpN
         Y+YbI50eEhoRpE4/IE3kHyqRmNHXrMO2OzDUth//FlWhlEK+mqDK6hwcGxMMT7dikQ/n
         uRc81pB4hGpz/bCaHurAsMv429DYTRU57rS1NmL5i2kEncMEMa648Sf7HbmLsqtnK1CH
         1I49UQhgXpR6vNoSCkYc4A29ffuXvv77sqSv5ZPuhLpBdSl69XiD7Az3S4Jfz+ukTBKc
         We02Qyj8DF1O/eVuWeowDveyStX4w29gMAOBQCqHvmfQKLr/1E5b29VaocOkcTZjfl38
         asJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765802; x=1788370602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B86sYSdcby7eLpZflQOfP7j2Gcapfq2tomSoep94EOY=;
        b=oCBJzmPOi/GSUCjpbxkIUZpPZUammtM3my/m+2Jf1ttliYItgWBwcB4uu3ZOFrLdO8
         Fw/ic/TGOrjzrpaPmrRX6GkntOLKT05Dmub1gwXpdaJ9pblwZDU0v6gYzmBBCsIz992D
         32RfV4pgYrDg6XhDqX7ftkd/0hPjTckoTD27Tdfr/pbyUQqK8W9MisktCyhC4FpuG4EG
         6dbsJH4RiToyIeI3Fp90K8xyCP3A0Z5WZpWSIFYccHVB/TVzkKHPZjZOmCT4ud6YJwO2
         EBqMqhCjfUgYbLmW1PKioabIma913Up8lLKJ7ZSnQaEQAGEr+DG/IgfAE/67wEawm0+m
         /UgQ==
X-Gm-Message-State: AFuF++lBuqShNsDpLQxFXmfrg/X2PB8gOTaPUaPZDcvJGNdWycbl+n51
	hEJMwx0oiefadEXabDl1shmQwi6byBEhdvFMfvpkBj928OuLumr1KE5fDTMsxpRQx2m7mi2NPsh
	cQpkTsYaKTltXvSiGdX9eS6tgIAFurlssQg==
X-Gm-Gg: AR+sD11NNM0bJJaSut4SJoLA5DDpyHBt+FhipDCBBIBqwNgNs4LZpl+Xx3YzNFrvS01
	F8rPQh7xj/QAx3ZL0sW5C7fwYH2JsSBflfTk/L8cWxPt8jm6xUsCWdVgB7Uz2NEudQp8DrgmciJ
	cgMrVsSncPZHKZBHjJD4N1BypYVNjQMlspFoyvgfNcZjw2xLwn5UrbjbQ8U/AFOzLExkNOKduhi
	NwihAbcgq0aJJWDZG0mZPCAXrlVvTtDDEkjR2lSeUPvNDksj5e/96Ntb/LMoST6tYSlSa8WrJJS
	5Wfw9bgn13nxNqW00WfBmosI1SYWwrH3oNz0ZW3FwuHYIHyrJyWofRi5jCW/zxatFX3Kp5uGsoh
	hGJicUZNR4wNVGOsnacY2ylIp33k5Ln1SgAhGMjlnjvWx5FW5SvOdGs7St3FZCVY=
X-Received: by 2002:a05:6830:6d0f:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-7f4c50cefedmr9412650a34.11.1787765802425; Wed, 26 Aug 2026
 10:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g> <CAC2QwmJ_fjNw9z+8an9Doq6Mx_29R5mcGXT1=NnVvu-g71QByA@mail.gmail.com>
 <xmqqik4wizqf.fsf@gitster.g> <CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
In-Reply-To: <CAC2Qwm+Dx1UxLO3EOkQ-9uBokxacVfgrs7+XCj3BeM9vt8HcPw@mail.gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 26 Aug 2026 10:36:30 -0700
X-Gm-Features: AcwNN1VuijwlLsWstoQEpffxNpnyADPiGDnhejD78TVEaWKrj_4_JB6OSU9GV-s
Message-ID: <CAC2QwmL58JbGLVPX+bqrANvNtn1swwzLU+P+Pu=+aJ5euUwRXg@mail.gmail.com>
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:12=E2=80=AFAM Michael Montalbo <mmontalbo@gmail.=
com> wrote:
>
> Adding something like "[now] deprecated" or otherwise more explicitly
> suggesting the command does not intend to return is my main feedback.

Maybe:
  "Send an email..., only if suggested alternatives to the deprecated workf=
low
   do not work for you."

Only a minor suggestion in the end. The general cleanup to the text seems g=
ood.
