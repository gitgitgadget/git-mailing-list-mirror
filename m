Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE912D7BF
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383186; cv=pass; b=cCB998HFclhxtXJFws2N8gTIiuHwA5LN1xHM7E/OQAatXo+zykKoG0G2Qtk+x8FSHGVyTTLya6K8MNqXUaNlAmzvrsM60g2LJYEdcslEx/6zzdIZD+wBa6dT2ZbNRMj8kqbuP00s0NCtnCOJNHQsYSdnNhI4ZBJdPYtOr3Keuac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383186; c=relaxed/simple;
	bh=Ey+7aR1oKROKgSyjd3w57D+O31zuLxInTu4yC7Rbubs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anGaTDMNqejsT3SuJFUE3xv1PI4Pye01xwyCzASlIL3hiVztKUAdXcxxbsiicsSQJAc+jvAfKyorgCPOpyB/4IFzCHuQbKsuKHiizwohjhenBU2blGLidFMQCCUTL8f/NRqLCXHj4J/QXHXdTDvGZWz8UbMSCjKINawwvgUVgY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXlRSZ5S; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXlRSZ5S"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-682fce74c06so97984eaf.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776383184; cv=none;
        d=google.com; s=arc-20240605;
        b=QmiVj7hQCPDf0Ntyn1Vbr5YEDspD+eaioH/Gb3ZgPUnbFGDsFJSeyiNYcqfgH7dQ++
         trGDF6lLwI0cH9MGJJs5daDNfmaub0O0QmQtsEsHRxeJnWl0Q63/AUUDrZlZs0kCUfXo
         pJ6dGdtGA9/SrxMj1Rw2elQmk1WcEEjdZJTcMfh2ldGroyeb04GPnYLKwZwcm1CP5yJW
         xrAOszBHhiTNRU0MktibQ4ZIgql+osUhnDbIbauVpljdBr2PzR0fr9lHvaYNZZ1ILTLG
         26gB43EA812XvgI8aoJlp2Zb6YThv9sHJgZX3Of9vuHguyj4U+hYfU0oFyZPlW3Kt4Il
         fPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VPRvTslcANziw/URo8z+0kOOdVWyAU67S8I/argGiME=;
        fh=O3hkcmfTEnxRfYvuLL9C3u0ItrA86r36OHUfrkDLl7M=;
        b=YFjmuUB3ue35P+Awv6CSMbwt4ubG9sgBgells02aY74TXCMzzeFCSZjmX8KB2V4oIy
         ZKRtG7vxjp+GjTMpP6fbefU/DeI1XsEWcULaUXJ1a5mkZQACgjfY0hy2XS6kkgh3hndu
         yege+wkAE8r6c7xv1n3IZoNxocKou+58TN6zir0qYLBp285mYLavP7i/bL/x/bPXuFP5
         G3PtPBK/A+PWwx20txsPzXoJPOW8sDOpxVjB4OnlTGGx0YV3tr0Lyd4Pw5R1yqE2ycmA
         QXwQJzzhgazQeCWThXjisW2yMwYd6GfZxxdw3K+NF2W4Z4Lfvt+3UHWmM3853PJGRE6D
         x/fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776383184; x=1776987984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPRvTslcANziw/URo8z+0kOOdVWyAU67S8I/argGiME=;
        b=ZXlRSZ5S6dPilXW0Evj1ikg2zWj4jUo2FM8yumh9LxykqZ5G+pIO9uNT/HLJAjPuaL
         /znbAmC7bu5u2zyiSNBpox/oPD+vveZoA8IcjWb+FFk0SW23SgqUt4jKNhPBHk45NDdu
         9IYLWI5K3nKQY2uEV6ZqRKvP89NBvceDL+EjPzaE3SOYCgyhMu4HniQDHGnkUhCZtIbX
         lA6WkQQL3OAN7J4YAa8sH1EczRg34f/kU7ko3e8eciWeASPIqS9Y336Fi1Pd1tWL4p5w
         yDnPpYNIZz2HZBT2tn1qBgie5nQo+/H/l93ygPK9egI2Afe7BXEipXSJyqOBV/GZzBJQ
         hjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776383184; x=1776987984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPRvTslcANziw/URo8z+0kOOdVWyAU67S8I/argGiME=;
        b=ib8uNOuY/FueXb+L26cMFVgNEhmlg/XzoE3mOLXh44tnYNDWwcFbru3cEh+elZAOK7
         XUlttnHh30STgRjI2j1kVKzIyXvwBdC19hAgAQcgMGgcCn2+CrQVl1H9mv0tS1+DLaEb
         IG21lEoggtnKu4QrW/BzSpH6nTHHmStxmHgnn3P3a19Z/4srk5W31dWS6OOZmblq316B
         86q52k/lAwQ59hH4Tmhags1AwxxC+8VlLlFfBPJUe6y6HwqzkCDzoeA0plMRQMn7oIQ4
         QHu46+GXisDO3IhSbJ7dYtBvo1pOO3PTMwAhMkKoSbo4nDQAWrZ7iKr42ef5t16MXcdV
         6AqQ==
X-Gm-Message-State: AOJu0YzpvagfwEQ5TIruXrMFq8e6LVlHpCJpNzOCoKzuxaSMuVH/iX65
	ufYDgX3AHUClWPFasVM9hlgJLqAT2kFScHcE+jh02OaZvtakSWhN/lK9Eh20/K6/e+rhX7iRMjd
	UI2IB8wm3pD9OmaEbLhdYKrz+FMupulGu0Q==
X-Gm-Gg: AeBDieuQNkpKEKSziFO0DDslMB8ecwK54T/JOXcZOsLJPZLsOD/hd2ZLxpgqEdbOHDB
	W/1XK/oY+OwtsBnibG+oxnAnwSLMOcwrkY7FOUTvUcsYijK7ZF+CUQAS9wjjlX+2KB/ubcKn/H+
	khFz9Qo1aUDRQlCdT0BjVPr4PSbTHM4COqa42mWxeHKg0UhoSQ3k4gUmquXPn1Oe1c11LjskBir
	9eC40XkcBwa3py/csWsiBfe8uBzQ6bskrH8YwikL+9rMhMCR1BSWI9kSZ+YJV7pUw45k3NKdRCU
	Q2a/zsaIzb5zqNtN7fyFYJE43y9lJHDMML7GOqjA5AH+v2f7JxStTFmmBAT15yy/6ztpf5pr/xo
	phhDbsLnbiXT4Ji76C2HiHtz53gD9MwfhtyW3y2yLABCnhkI=
X-Received: by 2002:a05:6820:1610:b0:67d:fba3:abe7 with SMTP id
 006d021491bc7-69462e2a1efmr408865eaf.2.1776383184298; Thu, 16 Apr 2026
 16:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com> <34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <xmqqo6jqpzxv.fsf@gitster.g> <xmqqzf3aofdj.fsf_-_@gitster.g>
In-Reply-To: <xmqqzf3aofdj.fsf_-_@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 16 Apr 2026 16:46:13 -0700
X-Gm-Features: AQROBzBUwBoCfA2Toep5iVWt9QZI-lleBgg7QeJUjU1zSCcPS1dMJ1Z29xmGdyQ
Message-ID: <CABPp-BGaN_PtvUVyR8sskpLUev16FjaUbTj21j_Lna73hEYGmw@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: st_mtimespec vs st_mtim vs st_mtime
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, LorenzoPegorari <lorenzo.pegorari2002@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Tian Yuchen <cat@malon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 11:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Most unfortunately macOS does not support st_[amc]tim for timestamps
> down to nanosecond resolution as POSIX systems.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuideli=
nes
> index 4992e52093..4e54139fd7 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -693,6 +693,12 @@ For C programs:
>           char *dogs[] =3D ...;
>           walk_all_dogs(dogs);
>
> + - For file timestamps, do not use "st_mtim" (and other timestamp
> +   members in "struct stat") unconditionally; not everybody is POSIX
> +   (grep for USE_ST_TIMESPEC).  If you only need timestamp in whole
> +   second resolution, "st_mtime" should work fine everywhere.
> +
> +
>  For Perl programs:
>
>   - Most of the C guidelines above apply.

Looks good to me.  As a minor nit, "need timestamp" -> "need a timestamp".
