Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793002446;
	b=m8FURLhTMYapRh4uNGXaHCgdU4/JLtrNIpUshgvszqtLpZJVtsyrWVKxtHqvzzqSjWQN
	 7fQ2sr/DE4pnyVZt0herhBrEnCFARJR4RlZDx3SMkHSqKotveiIwF3DB/YNfI/Ec9J57k
	 C1Ao8yjgfuneoWtvZ1527gJUm3aNGRYKJViRrOVkGJcRdDXw3e9SKZguSYwIxflCnajoP
	 OF7Fi2+olRdYlOy6lGGPJ75qnK5l81qDlfCazpS57x28QxM5hm2vcAxlNs13AzSthmhd8
	 RUw6zDsyPnpA5j7NgskgNnGACLEcd4dSvPzfDZLo87u/mNhMFn9VLcSHyaF3hLz1Iaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793002446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yuWwlt9MgiHVdZr++M6RXzNs1gOzqA54G8bySEpavxY=;
	b=tlp/LIE/25psxkJC0DA4SzEt+9Qfnwrjf0LJG/ZasWGEwvkynJr52cVKofCfjK6kTr16
	 posnF34koolGNSTTL+I3RspXAUwaIf3tVLSMihiEEwAqL4TlTR7d2bxvX3xi/WInieSbU
	 WsHRtxug8ITuTrWoSMK5LGoxGPb3ry5sZbwjd4cLxdYIMBp4kNSCvBU9l+RqN0jtzX+Uw
	 ybwCLX1aUEqGm2E2PuRBZiO0xBpMphzBkaoFFYxTU2uU64Tsu9zlRnFK6pCOMW8sdWsQ4
	 WyLzDXw8SyHfxJQpybvr4a3VEiY6VdMV7SlJEgSa5LS4S3KaTpcVNTYJvCsL0auzMgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E4GyO3na;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091E606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 08:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C091E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E4GyO3na
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5363316fa0cso43625501cf.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793002445; cv=none;
        d=google.com; s=arc-20260327;
        b=JrJMtAWo7XrervMpA6bKiSMhyF+cAqywCIDAGtpq/v1yMJFORr44ZQjMZolyy7mRRx
         4Goxi6qUvbkm96p4i6j0wuP+62ogpwOSinH7Uh/j3Rlai+sakqo7Jc9iryls9a2owqbO
         TbbzqYzpcEUYybqI7HV21A6bRqQrShDzU62TTcbhyaryr1Jr6uBT1qgwmKmMfMFq4RPH
         IHUFu7rZNTZc0TIc1iN2DPuDDyQz5ovf22Y2Azph5km5IKDB4P/epXwHdy3EaB5vox+Z
         WOyEWMlXxDz8v4B5fg3erId975eUyuPK8qKqDECPalvbdT8Iu3qAOcD36ZMJM9I+nNsN
         N43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yuWwlt9MgiHVdZr++M6RXzNs1gOzqA54G8bySEpavxY=;
        fh=Cfo2c2UfHIfmSceJosHrauJZuPgmQ3C3XPKabR7IN88=;
        b=a/CxrI6V3DSitqN8eQH0wUcU3CbwBlqUhRNkZ4N+prycUS8a7AkO/kMdWMS2PGTJ2z
         6W0OGeiYUIozcovqC24wqqOanIUHfd9EGtIgUbEwVF5tFzoSn3U9+4j7p53vb2qM7LGw
         uz8JSlj1PkD0QtkZstAEX3p2UUTF+iUTtiBzJcSp114ZyAyZtxULfuIDsjCDnh9+S8aC
         7QRDXutAB1Y8IsfGcU9frMODmmznekBSc/DNRd3CcND/Jc5YqaW5E+2dcPANildB9H7L
         F7PaiD7NrT7S9ozgDZtHhQnCDGKjVS3JsqN4uEsp8/WB3emW1EMrAhRZp3sjgisoCeCD
         vqjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793002445; x=1793607245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yuWwlt9MgiHVdZr++M6RXzNs1gOzqA54G8bySEpavxY=;
        b=E4GyO3na6GNugK+R4l5fHVebUV2DUQHkgtHUSwkBE+7yZWwUtbudCCxUI14gmUVRaS
         Jwm6gegJWxsD6OrwUORVHEp1bg72ksqoDY0PX0OlKaESP2k8WC1QaGaYcjP0ywX5rcIb
         9sef39KPxuWe908yuoEAVsbPT+dz65kSpOHlmMvoYF/0wllLgHPL70sa7byFDK71Q002
         yXqYyKJ/C3vgbpNJ1oKa5PBwK0ZqETRYJgJsOWpFoU5XSur5yodAbJQ9815+iIpWpfpM
         IQ+mzkuO/OyUEENGNmW2M60d8o8PHD8cGRF7NIAGA9UDF7MntjeO9es1ciPkIwtoiLkV
         n6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793002445; x=1793607245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yuWwlt9MgiHVdZr++M6RXzNs1gOzqA54G8bySEpavxY=;
        b=hVekztmAziibWzuq0Kc+hdcgriyad2THutncMAMJVgxIIxINfAWRCN4n25gLYhAOqH
         cfW6g16BP1yezGmkcNIQhXnGGse2O6WArybtgdEazRiSYwIm7FuIMUZ/QnPEnVfP7luj
         +WuxtY+J2q2DsWYW79E12FyFogfe586ui9V/mPCD4eZ62jtDjm9hnQvxu5KF3ZcptaHV
         IgWwqlXPC/fnJnMeNKvLy7p3ukT/GnoM5WnN/9UFiU4XBhgaj+Vw9O+/zPbATxWGPqnY
         u1bEIOpkgQMlqNmaERrLeDFFk2HKvj+1bfCEDsmUq5WEUpo9dqTPLKC3IshEPr5h+ETI
         ctjg==
X-Forwarded-Encrypted: i=1; AKwUvBw9lgB7FxA7VflbA6w2xr3DGW4tFGbgiri/qSqKIpfFBojnd3qAo+5kEUotED0LZER9tR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeB6oCUgTSqrK0fBD3tOlz/XirM9nn5EhJkiMIZjkTjT+sJ/4i
	psnksPq+ijfQ47J1qKxMT2CcvUYExibKnZsJdhKPM91YaL9121Nd/EdIGBXFQa/XQusYkduRkZM
	4hMG2scU1c9bPGerkz84qpXzKKSQ1bjEPeZVT
X-Gm-Gg: AYBFou0PPNEMMDbvQTVwE+OWyPtnhStKjWho2pRSBH9GUUc2AhCc8nyp9YRF0CsRNrj
	wX+RPtYWeXr1UQoMz2CHi6dlXhE7/CF3wtKG+xQ8U2NyP64D+PHdmPBehnX5+OwiJ7BDTnaT/oB
	jhqzXtOyBddGxRL5xyZqlqF6losW92hOAh3Y2X2VbvhJcwni24GQnZMxfTG2JFicTJbBJTNbzcp
	H99uLavhZumo0dWThkRGVDvKDoqCJi2Smbj14VCBZQLAMwL/947JyHmzzJXY4aMSSrGklXfrrQp
	NgF/0h7Bp5IY+udETAuR7ETiTYZDAFDK1Gtpk0cHmoTzW5G2WvK072aBsS0My7CvOzzyCoJR4NQ
	JghrjN0SJsw0vXcdbQDEqm2zoCoGLHj8EB2bvKA8+bqkiibvorC+01NDiUA1qA/gHuIpg0Q==
X-Received: by 2002:a05:6214:5985:b0:91c:1ea3:8d9c with SMTP id
 6a1803df08f44-91c48cdc78dmr103115426d6.8.1793002444581; Mon, 26 Oct 2026
 01:14:04 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
 <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
 <at79nEHLDrcoCgn_@pks.im> <CAHwyqnVVCp9ovsHDtc0pHYrFvpmdJq74gyx9yf3+ZWkL+d=CVA@mail.gmail.com>
 <at8KIQPtBHXyLPyY@pks.im>
In-Reply-To: <at8KIQPtBHXyLPyY@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 10:13:26 +0200
X-Gm-Features: AclHuK8GJKUKcNlr1q4XTlmbVw9pEELGJENe1uRE29lMqMlnFGD1XRlmwv6x_Vs
Message-ID: <CAHwyqnUwSv4Pa1GT3rikOcho2MVYA7sRV7RpP_KXcSa-2dWrWQ@mail.gmail.com>
Subject: Re: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:07=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Mon, Oct 26, 2026 at 09:38:10AM +0200, Harald Nordgren wrote:
> > > > @@ -121,9 +133,16 @@ macos-*)
> > > >
> > > >       mkdir -p "$CUSTOM_PATH"
> > > >       wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &=
&
> > > > -     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
> > > > +     tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
> > > > +             echo >&2 "error: could not install perforce"
> > > > +             exit 1
> > > > +     }
> > > >       sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM=
_PATH/p4d" 2>/dev/null || true
> > >
> > > This line is a bit curious, it makes me wonder whether we want to
> > > tighten it as well now. Any reason why we wouldn't?
> >
> > I asked Claud about it and it said this, does it make sense?
> >
> > 'wget/curl never set com.apple.quarantine in the first place (only
> > Safari/Finder/AirDrop do, via the LaunchServices quarantine API), so
> > xattr -d on these files always fails with "No such xattr." Tightening
> > it to fatal would break every macOS build, every time.'
>
> Well, if so we should be able to remove it without any detriment, right?
> Maybe that could be part of a preparatory patch.

Best way to find out is just to do it, I guess. I can include it in v3
and then you can trigger a build on GitLab with it? I'll let GitHub CI
pass before pushing anything out.


Harald
