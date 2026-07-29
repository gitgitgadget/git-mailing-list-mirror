Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243A1F2380
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295707; cv=pass; b=XFZvIA7ougijZ08ETprDJhYnfQisPvDThfr7hxZNIGUP6iIn1t1KbyU0fuHi+9EWDJHez2IaJmDEvFcW28ikUXr8Z2sKAxb5VMsIKjqOEmH1tBukS7sSjdk2MOmjhbDwb1bma4jr5HZ9OFIeQ4Hvzh1hYlYVEEJOHtufbl1eyWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295707; c=relaxed/simple;
	bh=m0+tpzwKiu7g2EYu9FDNEerdzrVYkqz8kDwJTLcmd6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFbLF3UzeKQpSzui5vp+FfIsa6c/4SKycbT3/9JP+E+9eUZ29hja3M68ibJ9R5gKg0J6ta2v2exkI4Qs2SDO/BXgeGrl55d3XMhZ5OSNMbPQnxq/B8sXQmIfBN9mXiQJwGTnzVnXPKnzbX0YkqmsGDwcTnRfu/gg5ZIS9Wy6ehM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvH/DAcB; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvH/DAcB"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so340628a34.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 20:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785295704; cv=none;
        d=google.com; s=arc-20260327;
        b=rtakR+ZvMVkn3YF2S49RQp1eZcitVCd1NEQCferQuihutiLvP5ZwoFh9aDxCOZkzse
         NRyc3JXn21e+zdU1sdC2Vq44gkTaGKVgaj64HngdCncbfQoKUQRdNDq9nS7A+qsRyz0W
         MWTlE76cVGnrMK3jUfauOyE/k0ctlWgrzMcr1JiLFeF+7hOvLS+C4BpVPN6wwiyBo3cE
         kfs6F/qHKKI0K2iupn21Fp+FijMvEHUPSZLaxrkt9tsvbIIXkb55LvzX/oWIj7IkX9k2
         AKnK/l3oCpNXBsMNTeMvdXzlnnmadKWPtlqTkyWGvbRHqTBAbLXaBta2AqHrn9DJdeq1
         DZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3hhts0+1SrP+oyUQka/3vqVOGQcyxz5K95ZiMIgSJyE=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=IcYdxlVmkj3LZcAFcujC3ShCUEEtv00TtU0XzFRvizqCrzPaJVENLobh0AhvKx3GVm
         Mtr7G1n1Rc9LKmX86l0vcq5CErYGmMXH5pdsewXxGL0ivq+BoBBzEvtCivUgH4SHz4M0
         cGlJalb3LTCKnLqKLuSIGJxnRTreuMbN4aDDUcuyQ7Qq0+6i1PUtrroFPDgKsJ3mn/QT
         wyFgj99a+xMUht2qATz3LZklDSFjxyT+8fLxyOFEY9gSV6vVOYXPwTS/CHPOzYDeu+Kv
         CAGEkk0CX9aaDXVNw1YOx7OFeeVAvQy0JaexZGTR9q6HRv/m/8nR13w4v5UYNsoKYrJh
         XEwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785295704; x=1785900504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3hhts0+1SrP+oyUQka/3vqVOGQcyxz5K95ZiMIgSJyE=;
        b=MvH/DAcB3iaOt1Ngmau/AOO9IICx2ezlnbiVZCUU9m0mVDZ5UFc180OkZeHSrWSoxP
         cvArEeQcfWal2ABpBWX7eSf0tzNtQGVuFMt8PVlUD4mKXjpQ9GeXQNjIgWOBm23Gyk4C
         SYeOLyifJa7K8bz2sDY1xwARNS6fqOuSjPBgIiw5cwzE2yn8MOadQm6Z2d25y+Z2GQUb
         2SX4LbiJPKrXottuKw0FEpppVG780V+aBq/l8zc7bYpsJpwREp6239yiPuJDOl6p2xdK
         TD35+6NAEJHO1yw6R09NUZ0HO+deQKrHT55LX2zu/GPj9G45+X92wVxE51kYfGemGw4p
         s8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785295704; x=1785900504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hhts0+1SrP+oyUQka/3vqVOGQcyxz5K95ZiMIgSJyE=;
        b=Aohhs68/zbgb9MzLjtEnjWoYfaQECBBdjoZ3OYO65AQZUmQBGPVrS+nP8TkTmFc4Br
         p5saVwSLO3F44s0LkwgC3KoA85A6zZwcG9hEWsCmSGvTRDa5DtAqtkh/ClTlpNzxuJKf
         18KRpEMmwUYv1hly4JRxDykyrLFIk9inBUB9z+HXHMbad1o0s1RUJMvDn332BbJbDPke
         IputantYo2bJ5jf3Zj+blUP0yEzPObZ0qSEK+SUuTRYt8fSfIShii1MglbQmStqGDGo0
         APZwxQ0+d0SqgCg1Q8sC+gYOObwBJqXslbQUnm6bCmf09aBcVO2vcY204Ow2rfzruyhg
         hliQ==
X-Gm-Message-State: AOJu0Yz2+VW3HwZUdq5NxZ1Hc1VgutICfvwd9CjVs06Ee0VodGndZewJ
	hUH4HyS/S4H+9d+cj+sJUbPET6eFS9zhQ9wAu+4sRxqq2kjBNQv4D7bayvyO/nNMCom9CYR7kIw
	2jY+DAYEC+U0KuEFo08l0GtwjYj8CIufRfg==
X-Gm-Gg: AR+sD12+TisW8xplJ38XvUZCDbMR8Uy2yi0k5/V89lV5y+HGD5kI+p5eKestERdOjqw
	U75Vuy7q0jA/3dMPsbSuULFdCYk00YFAdukylBV2mYIoNuACLBlaaPRdQZdvwpf56onaANiI4AZ
	9HBBSANul9eZI0SfM9WCI6RzyytYtJ+2NetYAqNP0zn1zPB2STTzZkROmIsRDlaBFfWfXkFASzy
	CKp2EfIhuF5smJTDG1dHq7UGYsbZN7AHqK34TEd0fHDD1ECgzTvZne9nM+DxaUGxop8uXHqKP+2
	tM0/5NK2dyub2n/ewFGo6NXEp3JGx/NzvIpzoaFWURhTXuhsh/IoxQY2weUBz4nzp8cy4kM4SXl
	Y5gtaCIrASUGTYm/jkjDh7mG8J43RFUwi2/yKPVkT5wYGDpqbqE0QqgGpml9aAOI=
X-Received: by 2002:a05:6808:2392:b0:4a3:58a6:8a57 with SMTP id
 5614622812f47-4ad5b832e2amr2744498b6e.20.1785295704660; Tue, 28 Jul 2026
 20:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728215219.753678-1-gitster@pobox.com> <20260728215219.753678-4-gitster@pobox.com>
In-Reply-To: <20260728215219.753678-4-gitster@pobox.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Tue, 28 Jul 2026 20:28:11 -0700
X-Gm-Features: AUfX_mxmnhqPuBCE8viLZCK-urSemQw7ue2qMmfjDZHcdpJyCdiDyV0MumaCRd0
Message-ID: <CAC2Qwm+AmeDubDrkLmu8Rz9rtO3697gokwF2=2c5PgP--hZT2w@mail.gmail.com>
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 2:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> -       if (addremove && take_worktree_changes)
> -               die(_("options '%s' and '%s' cannot be used together"), "=
-A", "-u");
> +       die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
> +                                 0 <=3D addremove_explicit, "-A/--all",
> +                                 add_resolved, "--resolved");
>

Should this be "0 < addremove_explicit"? I thought addremove_explicit being
set to 0 indicates either --no-all or --ignore-removal (via ignore_removal_=
cb)
was specified by the user. I think this causes "git add --resolved --no-all=
" to
die naming "-A/--all"  as the culprit even though the opposite flag was set=
.
Also, it may cause "git add -u --ignore-removal" and "git add -u --no-all" =
to
now die, whereas they were accepted before.

>
> diff --git a/t/t2207-add-resolved.sh b/t/t2207-add-resolved.sh
> new file mode 100755
> index 0000000000..f88e3f413e
> --- /dev/null
> +++ b/t/t2207-add-resolved.sh

Does this new test file need a t/meson.build entry?
