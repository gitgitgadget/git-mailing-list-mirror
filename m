Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FD3A542E
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563336; cv=pass; b=o2Y2/nCKw0EjD0Ob5HnVe8om69/cEHNNTaN3vHXgHLkPIM07WIcLtC4f+5wQd4fkKI/kyB7lenNXypCnnJQxCDU2XcPbWjozaFOry97gs+HfDHeUv+AVkvM4XsuEVYo3bM/djliL3Z7XwCb0KIsckEtIpcCqxGyQwdAOOx1OLmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563336; c=relaxed/simple;
	bh=20/eFJHL2PVWKFmpxbArwRysKo4I2IefMmrOssEVk/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/wuqVr738/F5Dc9gCZP3tnEKTnr0+He9UtEbxByK3MUwWoVEabm5VOnpcnh1YS+ESUyAIgwZNmJ5YFciCNCIQ+n+B56De/kCIkKcuwIsKeQZL7b8f0GlDJeCRwcztPZlWE9T9Q+8NJXR2Ozoyyz9fAhZXimuH0jxMexo+57cIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQyj3sVY; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQyj3sVY"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-128b9b7e3edso157571c88.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 05:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775563334; cv=none;
        d=google.com; s=arc-20240605;
        b=WD0OeVDLXuNRCYf4WKyXtbianhTEnMTh7bNqlu1W/Hn13GHcegdOg3B0riF7Z8qqGz
         NGlfw47n3dTJqLjPMdfgB0qQfdZrUE9fVt6rV/DyOIhBqDDrNd4vP708tRerTIxUKpPB
         6QYi+lW4jzQAIfpHNDaXBxnOpQHJyGafCvHKgClxDXmUnnTsM1Q3LVoLXn63uxVwCocN
         wQ9kIjDRfQD8ahrDb8sBlP4y3lP4KX6jEmt193oLPf6mOx6ztsjGnS3qK29NPJbvQrBz
         XCLy+UiKrKbR/7+HFS/vfoiwxUSEaNRE0PrJD9yc9UbKSbUpb8QK6BXpyYx1fp9/38Ze
         H1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=po7brspWTtHWNk3Jv546tE5a8k8PWCG63Rv5L8fu3RY=;
        fh=9YIIsTdqbn/IOwcwD19p2Nqg09YwnvZKB8q0RTDKXEQ=;
        b=jBO7ro8ebbwA7teGPP4B4wniK+UwHuY9LyFPubA4XBb37ukrU14mfxsPqizV2JAA+J
         Q8nd8XbYORG6hexIlLAeUmYm8Gl7h1PdoV50e2SmTQF4Wkmz4w69bl/Ia/HYbThO6GRO
         W0x/lome60Z/Acf0H3tDBETOI003H4gRDO9BrqXjVgvKwOS8QLbi00XfAa1Ygdw/CLW7
         jc4xDTohpbQl4LUfwKGDwBbgLJwgC1rV44w0WPUHYei0qFRmBM6VZ2skLAeQiqDHFf7Q
         Kcl0kOtiuH8nZXhV2fQT+oDONQLmOiyqij1/9bfOr7GN6wiJDSgc0mSjznu1c4/C/W05
         h/pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775563334; x=1776168134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po7brspWTtHWNk3Jv546tE5a8k8PWCG63Rv5L8fu3RY=;
        b=GQyj3sVYcix+bLkIO5ehWlBKcR7ZVPn6rfrMiOVggt6W1Up72ccYifLGtZm9LC7ba7
         0A+CTkI+jmDmKNVOA6y45FhhfXiVIKsfwnB0mtno38TA1WRTlUMHoXZg+JZCrPUHVGFa
         FOzJ1PsBc70o0Qk8C0naUzMODdJZFIIs19/0a2I57SDuaoimpEszub0VWHZ6OfljZCJt
         5Q1gFjY+JhEXIIAnUEWDMEjHxx1KA8+XxBpV4nI4cyFlseJOmsKgAZm20dGnwJhYPX1i
         XotElsKjQCLVk+TreGVzzPDo1U4bPVj+HaRinsd0dXkL+zb6Q0MEG1BlxuE6i5hLZuoW
         aKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563334; x=1776168134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po7brspWTtHWNk3Jv546tE5a8k8PWCG63Rv5L8fu3RY=;
        b=sopIv8YPe8kwOlFOBfSEAlOlZQGvu/xkrDpKla7nJEpSZ89OHS6BfQ5Q3RwmJBtMVT
         KwuOobw7s8GA0KL+4m8TEHM8C/K+Ui7JPmyP1HtZi471of/+f3KOEOjhPuU0yw8TN7R8
         APx/bWzyD21rMlMgUBi8eoTx+kzvjbfFolHJPiukIxtg40yN1AiKO2Ob5e13Rj1bTC+1
         NP4cs8WRqljhImeBHPFpwLwvBjQ7PIrFbpnUtucSd1vFIzX9zgqILisPDJLKJP0q+wHv
         Vc86cz65hIqqIFHAXe9OxECvwtPULLXmXX9J829HvuD9DSHEJo/V/9ixyCEdKkNPuXID
         hsqA==
X-Gm-Message-State: AOJu0YyfYrvPylJZARyKcR2CfKLJf/CY0IiZiGdNmn+MsZpQCx7X2cxz
	ypQ39swEWrbMR+leL/VUf0nI4ikLmbaQSHarRnTxkM0CbfPosDtwMmcEskTAMxCNZVAIUEflgDb
	+VRVZ12qzyWiMkBHLmdWjyzuj96qxQI0=
X-Gm-Gg: AeBDies2jPh5Xy29S8le6MUpdIpw7xxecE0nVqM7/4s7RnWwE/P2h3/q2wz41gaviW2
	WxYHOgNrQqkcS0T8xHAhu4oKbBQQIEvZ8R/8E/iJWWuOxTSzLULsGFF0F1vruRWD8nBo5AKSVMI
	l1bwbwNeuhH8ljTQqWx8W6OLaRgJK/xNZ42xvQ2pZO1wDOAH7enTy9PEd9pacHV7EFicqzwBLu6
	M79uHaWonN9wjawWDo4ZJmK5tD8YHVvLJeIOuQnqGL0chj/1H7FcTtt+w6y1OysJZjTxxxZ+hyZ
	OGobLSQdA/02znyFvLznNHrsxy2BLwc/NjNnDNTrdIGg/QT4nI9Id92DnR2Al39dpRiH
X-Received: by 2002:a05:7022:43a9:b0:12a:6ab7:3f73 with SMTP id
 a92af1059eb24-12bfb639428mr8752928c88.0.1775563334338; Tue, 07 Apr 2026
 05:02:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260402070613.85934-11-christian.couder@gmail.com> <xmqqa4vlu1ij.fsf@gitster.g>
 <CAP8UFD3CMwTjC36Grhb6_6q0SBWtTwBX4_kM5sf+peTgd7P3dA@mail.gmail.com>
In-Reply-To: <CAP8UFD3CMwTjC36Grhb6_6q0SBWtTwBX4_kM5sf+peTgd7P3dA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 7 Apr 2026 14:02:01 +0200
X-Gm-Features: AQROBzAq2X8xyVgA6x8KTWLKipV2kXxeGkENnBA98WWkdXUF_f1p90NXoRfXhcE
Message-ID: <CAP8UFD0pa9OOHwBtiK_+xE5jq6Qq3YPi=E_kNLpQt==soFXmGw@mail.gmail.com>
Subject: Re: [PATCH 10/10] t5710: use proper file:// URIs for absolute paths
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:16=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> # Allowed characters: alphanumeric, standard path/URI (_ . ~ / : -),
> and those percent-encoded below (% space =3D ; ,)
> case "$pwd_path" in
> *[!a-zA-Z0-9_.~/:%\ =3D,;-]*)
>         skip_all=3D"PWD contains unsupported special characters"
>         test_done
>         ;;
> esac

It turned out that dash and perhaps other shells don't support a space
character in a case bracket expressions, so I used the following
instead:

# Allowed characters: alphanumeric, standard path/URI (_ . ~ / : -),
# and those percent-encoded below (% space =3D , ;)
rest=3D$(printf "%s" "$pwd_path" | tr -d 'a-zA-Z0-9_.~/:% =3D,;-')
if test -n "$rest"
then
    skip_all=3D"PWD contains unsupported special characters"
    test_done
fi
