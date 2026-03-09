Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C2191F91
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022346; cv=pass; b=lWNDNwEiSQaRvTMWkstxWFvreWq27nQTCpIGme7MPgUU/mbeHA3V55XwAkyDoJSNDyx/l1PAirD/r0YafyUKtyaTqd3l0Ot6fuToIvimOsvndOQS93PdgFNuVDftu2erqBMI3x48FolB+rhmj3yLyq1+P+Vn3Elol43GG2MBFXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022346; c=relaxed/simple;
	bh=RnaeJkeZDqQFezAYy292IEQpSRO8DBljMeJyiQy8wGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWdwNIsqq+RMn4Y77Se7+pwaW/uwQLMy/pERlPeKULYRdC29K0nqnQPYje0yZFTMpbeOBIxJs329o9zOLLDYQxrVbbfFDcQpkzTQWWerQjr3NFgKWntUkkT8ZLRnK73zKe4c/WM83nSJnLU3M4IFWylE2UZB4cT+7yvbrJH5qS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2bdff6c15a5so363390eec.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 19:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773022344; cv=none;
        d=google.com; s=arc-20240605;
        b=ChUJqndpw8cSqS4VldNI31/oghMoh5AVafhUVCjRqlCMiSjLc+1WQjY/NhlQvUXCvq
         xRPgwLbKsx+V1V25KUb/cVkGZdHhl+hLdL0PI26qIhCwpjTnFrl3QZCldqn1Sy94eYoW
         z/L7vju9srvSEh6ZZErNtX2BYqqyNx5p0kM42pca9HOoaKUDM0C4leNhxcCqHLnTzPuo
         jfhMGhUTYJTnjiyQ6neKSdqFj8jcJn2+w8GKJjLFB3wFgfyPaQ+mBAOIsZCuTD04mQ0e
         jp2cphGZPDiWMiIi84im1FneOMp0q2y88ihSxVz/tTaSpsvO10gdiLcGaqxwdtdOWlOP
         kB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PoXfgSOEWj2fF0hixNOvtVMx/ipruO6v73Lb5VZH1uA=;
        fh=i53ynYO9BncglvirTbcjSfgVwFUR2x8H9+nJa8AADFs=;
        b=GAJ0jqi4Hnqcu0fqUekmnNlzmavDU4IxWj5XIFR7Uu79xH9bgttoI5HGX9uSfVd05m
         MSisnt8+FWZRbkc7GDF+r1Wj2iSoLOzENVapoibgiArAStMZinZNNo1YQTicD7QAgb/x
         0QTNuz0KpWz+K88RtCp8rt/Gqtit5g+sNidrXYfSejwr3QxWaqy2VfwzQm+Wj29PpE1D
         2X28a/kJKVatccX9VulrXbDsPZf3P/X/ovhwT85gFsMK/3CvuZvgsu+1dBDFAoHCKe/U
         MSNpBWrPm7yBwAc6WBJ8byN+TCkr8Fv+iTO0k/vLtlBMw3Zdv211rhKyRDG6NmPwoD1B
         yj3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773022344; x=1773627144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PoXfgSOEWj2fF0hixNOvtVMx/ipruO6v73Lb5VZH1uA=;
        b=Qi4t2Uhdeqz+5htHQZiP5G2g8wlvNMJmWzji48Q8h8xCvNFGkeQDHJJRqWmQMiIF6j
         qg75Shm7tGQmjCjG2RNMr2UksMNCocgV0ynYYGGRgcPFoJt6qc0/TURHNc457cDxh1T5
         zaANAJBqHCDM5DDBRVXnf1CesmaLLyxgCCRcGvs+W6XWhYJFvAUREncVhs//rkA/mbk7
         6+bJIbtsrjV84AapiMH0wSPi7dK4HVGU8eG9GY0O5u2yMwZUcJuyko1r/npshIuavzeW
         8lBlkMlI1paET+ehM78IJk7Gr0qNeoTg/O09POr+RWojNHjRGRt2k/Jjsj3TKFxtsVfU
         VzQA==
X-Gm-Message-State: AOJu0Yw2Q1TU06+npsdmSnZoRV2rnqMdRG8JqJZ2dxLJy6rVoy8kF3RH
	w9chhN5Pjue8QK+0tdv5lF/UIcsOR3QglUvn4unrHaJJja01Fq9PLExpo3qQv80PFwLThME1pvV
	UXnARQ9TOR86WU6rkCdV1RVMFkKQzEJk=
X-Gm-Gg: ATEYQzxXgLmwp/GOfsv6rxHBs77/1tMj8omLp90LJdPLKFaXss9BwI3GdMVhjHuSodx
	cVkQriuZ5gj1RGyR5cKNttRHHqbrrV8N/wC36rkBVnZjl1O2UeJ1qPFmB0biXD+a+RvZ5xlc6ZI
	dvBaoZFQrOETB733IZAVyldcTcYbPFvz0X+brr3/FS6sGB8IK6PAFlaOnLgAhu0n3qupoNrt7W7
	GYwwZZglYu14H+yox700WBA+s5hFq8n955jxdxkaBgudouss1TOhyB0mJr+n9xP0y8Paj26fgBW
	EMb5S8kIAHA9nKt48e5xOJfUetmdzBEVc23uPSe9l/KlfR9h
X-Received: by 2002:a05:7301:1015:b0:2b7:f145:a70 with SMTP id
 5a478bee46e88-2be4de79288mr1852779eec.1.1773022344091; Sun, 08 Mar 2026
 19:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com> <20260309005416.2760030-3-adrian.ratiu@collabora.com>
In-Reply-To: <20260309005416.2760030-3-adrian.ratiu@collabora.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 8 Mar 2026 22:12:12 -0400
X-Gm-Features: AaiRm51Y0E-Fiw793AG3tczNUiTz7Njh55L9dM1qXZmRJNLV4bxUE1lcj2HqdwA
Message-ID: <CAPig+cRGJVg+qo=UZA4syvTQ58G54tHo-pSZ_6dE6pU2e0agyw@mail.gmail.com>
Subject: Re: [PATCH 02/10] hook: fix minor style issues
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 8, 2026 at 8:54=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabora=
.com> wrote:
> Fix some minor style nits pointed by Patrick and Junio:
>   ...
>   * Capitalization in error/warn messages.
>   ...
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> diff --git a/builtin/hook.c b/builtin/hook.c
> @@ -51,7 +49,7 @@ static int list(int argc, const char **argv, const char=
 *prefix,
>         if (argc !=3D 1)
> -               usage_msg_opt(_("You must specify a hook event name to li=
st."),
> +               usage_msg_opt(_("you must specify a hook event name to li=
st."),
>                               builtin_hook_list_usage, list_options);

You will also want to drop the full-stop (".") from the message
according to style guidelines.
