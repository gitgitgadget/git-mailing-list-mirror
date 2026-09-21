Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC548E0D2
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995620; cv=pass; b=L+4h+QKrx4Jnl1Nx9N+VSR3jcXRmeD4kY8DlrNHbn2wdINwv4+RP4U+fasdXPt/YpIrO2TlTe5v7yaMZyALFds3YT3aYOtX4Wz+e6eUyr1HNZrlM6L62t740NAbXm6f14rRzYlz9cSjpWnh2uARrZF4U7KJeWTWTIpYsSAs8ELU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995620; c=relaxed/simple;
	bh=6Z63uV7/f8b80dTp9eOyUhRoOYaU7N5C0nm3E5QQ2EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=noxRmn4TkilDJ1DNgMI3odaQk3+gTrO0L7fKq4/iHsmliAmmx3mzwRMGWANQlPH4meiefxrG6iLuAwOP32RXCTBM4IFqdYLzjpgAH1OxcumcEnbqzz8dgi/GOr0L9f4o5KrBNoX0pks0cUDuSsRgtvDH4C1tlpWj8vGg7cSReQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu5Ikw45; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu5Ikw45"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1744fso4874681e87.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 06:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789995616; cv=none;
        d=google.com; s=arc-20260327;
        b=hX4qSJs1OtM6Kos18onNWQ3sQPi0/pdgmjQRz9NCU5Y662bO+Kiek+5PCkofY6v+08
         sy8QkxLVaA5A+P9oHDb0Nc1FLnFRREZSKt4ghf5YjLPh6qTGRPyqpsdBNvvvB2a6iCEf
         xF2a0LZs06F+JI2O4ShWHZTFzSo0Tkjpd5t9Qiysr5t+j+JYwXLtuz4+Yfe2MM8RmIgI
         iqJcM29o7n3WWXZS0vTd4gn/+JWj8sPddpkb//4UQW+SH8qQvY9SNlQqdjEdYBhWEAa6
         knL7du1pu0JcevAKgoiDnxy66EK0lHGotlLguNOnFtv+LvxkGly0fQZoHtrB/r/AfVBj
         lOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GlsTDotKwtLXwHpXdXFqcncKg42mZc5uO6aDXy8P4Tg=;
        fh=F77Y8snQqH6+nbvRYFZAy1jIIWOftTnYjZXjjr5A4hM=;
        b=qgI6GwLZHTEydTX6RtsU0ya2zcH/lZGeGdvlEO+er812RzYMQVYGt4AAnG53vTs8BN
         fihC00w8PwxpSvDFlkinlHEsBRz2fLEc5ktVEdCIEqy3TtimtrrAIPWTOJU5jcSGZL7J
         MQZliEvEcdL9kZ9dqRwircXqJ4dIbvAyt67yeCNxUhN9FSYI8HkNR/JfoyL8KgCkxYpC
         4De7JakXtefh3qD8hQpxrN5UE0s3245EPRk/aq2xmHwi9uPjU4ktQ83+7p9QwEjl6fdm
         LZIt0o/ULmMRUiFLJXAqy03M7/iTo1lVET0wdO6WYkFjQkYFlnTK7hHAT6/vtSnt19sv
         SMug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789995616; x=1790600416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GlsTDotKwtLXwHpXdXFqcncKg42mZc5uO6aDXy8P4Tg=;
        b=Qu5Ikw45OxA8YaPuzHKpH042V3cbPvW+fHu+nWMze6DD2Dk0q5vGZ0rqJyOYvzZ1Gg
         7nHo6Y+ZGEnsKVEDO0Lz8uH0rCZ527OTm8nyKjpgY8WoUazSL9sDV9tzqR9LkSdifMSq
         pfTSEB9r+dMefJNxKk9CoPCKAvtnmKY90BHAngbHciEBe8uPTYqK6mLVcvgrDR3Hgwn5
         AbIX4p3D1HsgFaCha+EqIjMt4q1ieV1QXBDdQTuDNkX+EyEvldJJdsJZKikDdXAfV2XX
         en7xJIxFLQzwXDBr8a3dHQg+k//0JxrTLkSIb3zRhcBb88KZ9veOzoogLlb4Rkv46hha
         w1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995616; x=1790600416;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GlsTDotKwtLXwHpXdXFqcncKg42mZc5uO6aDXy8P4Tg=;
        b=O/cK6eatyFQQDbtXPMT7Gsj/HUqjvNUkQET2rv8Z85z7yxvvyQEibuz5N2f4Rau0T/
         UoEf9iMjArTDkZo2djvN6AAkZZywVq08iC67qYn05nN2rciRheqP5MbHNP1PiGDjG2Ca
         WdaAXPwqSB7xxz6NFnRcEW9wKuDGBDSeuYgYaQ0gzRWElsSXzNKAvX6wt7CdwDcRTM4S
         VhGKQIJ00Jwlrp2ylZB8O0zf49gHGRr6IE9Q5m4q6wTIOfy0lJMEvFMyCjSHmovtpTZQ
         50SkSBrnUJif41oeiujuwnJ8OM5z6tb6g6AgPVGrak4ATH+/amcpw1RxqLAAKpGOiJxi
         okBw==
X-Gm-Message-State: AFuF++nrlkSICrcdlyZ6rUhdesTQ+T6WSfjHYrGACRKsr7x8JyGSX3Sx
	TtznPvtbhD2mlAoY0PdtCLy22k635xr/aae3SW69VbIVNQOnC62opejJhSayNEjwll7JiwGIuJn
	ZmdiVR6jIjnTRyEy5O6/cVFEKSZVKYy65iw==
X-Gm-Gg: AYBFou0HSVvdRztNagnFHLULHq271nDQhE6av4FIpoDpq2hMoCdF3IWRoOaA8TEVnGg
	c/RbSu0FHqkfe8h21GQ07Io0r4ZLlmgq+pPcCQlhBiXmkDlKla9+r6lU6tadhs6f/KwRw0tRzdN
	cDTeOYFS4UVzMGI1RPi2zkI+HiPIACISMEKeKfc1xIot2dicS+xmSjUho0mklyHtT2kEbziXUy6
	UOc5qbsvhFZzaNxOvFdevIyMLX6CMR2jWPMqCgwS6aXAylDkFB3jsWu+K+nAPt0ZXxmzOrYg27G
	l2mgYTFeMcTJMsEpgYFyRblHeCCzlsIJxgMpB+lfv9puVEoLSUtRY19y
X-Received: by 2002:a05:6512:668e:20b0:5b8:c55d:b3d7 with SMTP id
 2adb3069b0e04-5b8c55db598mr1729932e87.41.1789995616192; Mon, 21 Sep 2026
 06:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1789994808-30642-mlmmj-3f9f948b@vger.kernel.org>
In-Reply-To: <1789994808-30642-mlmmj-3f9f948b@vger.kernel.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 21 Sep 2026 06:00:04 -0700
X-Gm-Features: AcwNN1XnWJm0DIvTKUTkKqt2g0S5giE5tcwLAKRjxm_1OclIy2_nqvFeMMa88-g
Message-ID: <CAPx1Gvco17vf-rmQsqumLdX8Gcjnu0Qx=e7_PdFw0p7BDRLU7Q@mail.gmail.com>
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on OpenBSD systems
To: Git List <git@vger.kernel.org>, brad@comstyle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Ugh, somehow plain text mode got turned off, re-sending]

On Wed, Sep 16, 2026 at 8:41=E2=80=AFPM Brad Smith <brad@comstyle.com> wrot=
e:
>
> @@ -209,6 +229,10 @@ static int git_get_exec_path(struct strbuf *buf, con=
st char *argv0)
>          * after the first successful method.
>          */
>         if (
> +#ifdef HAVE_GETEXECPATH
> +               git_get_exec_path_getexecpath(buf) &&
> +#endif /* HAVE_GETEXECPATH */
> +
>  #ifdef HAVE_BSD_KERN_PROC_SYSCTL
>                 git_get_exec_path_bsd_sysctl(buf) &&
>  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
> --
> 2.55.0

Sort of a minor nit, but given this code construct, there should probably b=
e
instructions saying to define only one of these.

Chris
