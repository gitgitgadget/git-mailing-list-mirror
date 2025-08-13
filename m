Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035922571DC
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099518; cv=none; b=hJoe3mXWnmJ3JEYKFmZju0CnB573gvL3IRsurzBhtjF4vHNeyPw0kaunBP8/gJyKLf85jMucNw7tcP3fJOUxUMwV3sxH98niIm+wpWGrzanGT02gb03SOWRS9A9uT6HY+DwlB4Izb/gPDrTVojpyrudt7zxZRm8m+aRFD2Awat0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099518; c=relaxed/simple;
	bh=Q8fXQwIu/QpdL7LvWaMFKy+ZN1yJSMq6Ov985CdvRl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEmWE/tszZkLBxDAzFOI4DNtXX51b79Lna7Wm13ivQXVPe1Tz6g7wluivOIgutQuKlpY+SJiayiENEoGWUop+a7RgQ/QGWrTrsS9Ur6UPFM+B36CjxcKMCQQlGgAxTIBpcohDE+sZjPIcgSVycV43gfa5YSuuGMCVhOdBv01Rg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4af1a5aff6eso10430261cf.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 08:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755099516; x=1755704316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygNI+fZeKSuuhrnSLWrFdQj7yp8v/K4oOLfQkRJKjsk=;
        b=qzrYdMURTGgJUAwt4m0Exi4D1JO1DrtqExkUl+FC6znDeVz2RcYaulFM2rk3pf9Cis
         e/y5SmrUODYND1TZFqGTB4i9GuS5FqZul/W+tq0FhiVlBQTIOzJhh8mu/T9jP8YUgCL3
         VgCTV0KnFtD0P2EDUP3lRK9lNdMX1zkDctMypmk5rY8HbCML+BC3UzSpI9DMow9xFEps
         qVXa8JMahLFmoAK0+LXgaJdkrd8SNlpdIIUl3IiE9APmjxPBSiP2Nay4vUO0lrdC+bhW
         tzn6OLG3Vps/bGOhutdEPI+lugs38N+tpgaMEft0Aoq3W5vf1IjLOzaLMmC4eqvPGgla
         GVew==
X-Forwarded-Encrypted: i=1; AJvYcCUdDiNnf6T27eymYkzYm0zKgwPXf7RKZAuVG3NbwGvJ8POanQBs3Uc0fjW1xFXoFxHDUm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpikxQ1RZRa6FI3HHmHHZzmIu1DVXRIiSBPhCzj0h2DMhT2Xn
	boU2GGw2OCE5FWoXAL5nB1cxzcK3aExaL9rfb82+9GvxnDJaluu08ULC3TP4utZWSOFOcR9nc08
	REIx3z2/dM/bmrpJaSpJlyXJ59HQHACY=
X-Gm-Gg: ASbGncuKHn2ISzlOvshoq7wyZB0TedcLvM7Hp2SO4Lqo5iHYCPQrml67zHw+KmdeG10
	LzdrQ7+CaZRgkMHEfEkZ7+1goT9v7WlFR3ugMpBBrodYdLdsZPlZZzCkec8rRicN0360zS5eQ1/
	HTuVC9cbLXNgP6PsV5VbIg2teJPY1bYQljMlk/MoTjc4pSfbslSd4P0RjqatUZVrclsaO8T+ujQ
	VYOovcajyltBrxY
X-Google-Smtp-Source: AGHT+IEwBldnn09DcOTHdZvNbEIRH2Bo2TKA4iHF9zuySH24dJXap46rPMlXQmIavonlpTXPY1o/sVsXeP/POIJ7Z6U=
X-Received: by 2002:a05:622a:11:b0:4ab:56e5:f7a with SMTP id
 d75a77b69052e-4b0fc7cba31mr21955261cf.8.1755099515854; Wed, 13 Aug 2025
 08:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOZdJXWaC2U_YrwuDcA0x3iUeF_uJ658a93cTfdLftEXYRB52Q@mail.gmail.com>
 <CAPig+cTvCLU3u5y23HSrbxovs8cjcJdOUj0e1G9Rg4F1AP0jAg@mail.gmail.com> <xmqqfrdvp9zs.fsf@gitster.g>
In-Reply-To: <xmqqfrdvp9zs.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 13 Aug 2025 11:38:22 -0400
X-Gm-Features: Ac12FXzoxuBj29-GwClV4NWye1brDeF88Bal1BxkJQJ1Kj0saqFQqjXCvOfgNMo
Message-ID: <CAPig+cTr2e6wQ79VXpADuL6UGVwtHu0qkTfFz7sBdwM_MYk6Ow@mail.gmail.com>
Subject: Re: [BUG] suppress-cc does not support multiple keywords
To: Junio C Hamano <gitster@pobox.com>
Cc: Timur Tabi <timur@kernel.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 10:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > ... If there is any "bug", it's that the documentation does state
> > that you can specify --suppress-cc multiple times (even though you
> > obviously can).
>
> "does state"?  or "does not state" or "does state that you cannot"?
>
> I guess you meant the second one

Indeed, I did mean the second one. Don't know how I dropped the word
"not". Sorry for any confusion, and thanks for the correction.

> The existing text
>         --suppress-cc=3D<category>::
>                 Specify an additional category of recipients to suppress =
the
>                 auto-cc of:
> does make it clear that <category> given to a single instance of
> this option is a single category ("AN additional category").
>
> Perhaps a minimum fix would be something like this?
>
> -Default is the value of `sendemail.suppressCc` configuration value; if
> +Can be given more than once to suppress multiple categories.
> +Default is the value of `sendemail.suppressCc` configuration
> +variable (which can be given multiple times, one category at a time); if
>  that is unspecified, default to `self` if `--suppress-from` is

Yes, I think that would be a welcome change.
