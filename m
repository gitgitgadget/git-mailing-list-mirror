Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017096;
	b=XMotmTu0YleM2mpTEbzcI9D9WWOZfbfJAogd637a4xbGMZJmW1V3z9z65hOzkIO7p2NU
	 x6HRSHsedzUS2YGuJ17z4Q7oXYNlgQVhOWiIx4hBvOnGcdrNE2c1AdNyrvVEJhCQ7tXr+
	 nDV8tZro4sUMHYPV0b3nRgR+j8ID11qyHREfldZeld/7pkaTiTd6VMBkh5W97s1tYBR2V
	 zoutfODG7Dl5k1L9Y0I3r3RuJ25z3j3KW6fCYgyGh/ETiqpYZq1qBAAGWS2C+hgXGaoUT
	 cM6QVrc6NvM5E53MOQlo+TbxYuh7zaB/cPHK1IjqjGW4bATwV61KSjLjoL5S6TmUf5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fg+laQkv227GqKq8SsA75OZmRMEO4qe7f9QQA9ZrTUw=;
	b=KiXAVuMbAZ7ObxiUKPJAGjovGlUoiT8QP+93W6eh2fZMolyN/K6Ixsl9mwqX9DkP51H+
	 1BgWNLlXLgSiRyd5sh58oQN8y+KA9Oql+cpOJt8jcIlOFORonvT0+TDEPk7un7XKauZPK
	 ibSF8aGoRkI2CJqMPd7zmozgZH/UQ7TBeplOM7f0vosOBt4d6Wq/FKGVYnAmLqeblitvM
	 3buEZe/NQwRFje/mTzKHOcyFeZ1lA01cLzxu4uE5mGwXhZDJ+Kc2DiZO58r02yRwVtZbw
	 DknlGS50V/PlQJVpwlfoHHU6hDZwQEzSFHy5ou+OWwE3L+1vZyl77UdChYvlc2mQBDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HI1KGEaL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99100606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99100606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HI1KGEaL
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so4595975a12.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793017094; cv=none;
        d=google.com; s=arc-20260327;
        b=okRf0jFKYgUFac9gfxFqNFEROBbapgbktNS9nHWW+Ae6jH9kPhKIHLZMsT4Bzj3sDJ
         LBls2sjvVhrHz/A8gdFbch7w78WS+BnghroFLCQZ1osVe7c/21U6MbucwqqPgWcoZTWI
         h814yn0aB5pn4HIM6m1mBGMxusaAdN2XPticyiYuEiYhJkSXFA9LSTWzxXYuFv67GpDs
         iHEU7V82T5qWblt2hgnScMxn2O4dPXJezvFq30t6bpXdfxmshnhENunhkUzeasA0Y/f9
         mnB1TvB3OpG6iaD8yRiwd4/6qnJthxtA89z0wX31zKdeo4sAtG/yLMDxfr5PFSCSEoXg
         pJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fg+laQkv227GqKq8SsA75OZmRMEO4qe7f9QQA9ZrTUw=;
        fh=m20qDFFMvhvnnOS9ODCuRJRd93yJ4/3nwV8H0Xt4BQ4=;
        b=VDBZonao57+XOOeWs1vVeXDE1/wX3ZJShrRVY7pE5AeK91MPY+X5vMicp7fsj+90e5
         jWKoQF+wW2MphBN9i7TJ3cB29b9HFsjp8CdudAJSrshZ7cQN8L2ELBS09U2XXtMrnynq
         VNwHWlS3UCPpRaUoYra1D4rQNCW/JFPG+EP21he7+uVoChu576cQvFjPdbud+LWatFIz
         H8FEEWGr62yEkiwyLJs++CWATdR5oPSn4KhBokFV4i/OFCdLgNvozjXHwyzcKIiWpHEo
         ctLSEy2W36Up6SMst3k3AdEBXshzo8eNm+qSYn4qZEkgKMxhs3SII/1ENb7zBurJ1JOT
         qBWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793017094; x=1793621894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fg+laQkv227GqKq8SsA75OZmRMEO4qe7f9QQA9ZrTUw=;
        b=HI1KGEaLRoXLP9hjpWYuvgxKovnq0UVWbpnDF8B+GCSudMETuFTdTLG+YbpELFUFA4
         v4DfVztvKLzGeyt5yNKp/SshgBLYblPGShosaRP48LqcaTvI735NmHbauRMUWvo9QLvf
         gR1nRjtyZMHaCQENM41y8Dp80RWRYwQTn+cctFX73ee+SCOwWE7DZSzzOxRHQpxFRzSI
         Y0E7/VWp9GMAGNJ1OPSxAar8RCSz1K04EvPcpNIlg5YpHMj/iBoiSC4+WxgUEgV6Ey6L
         0CZfkqgANiXZ0q4qAdSOLmKG3xTLf2DWprN22oJ2bgns8QzOZnwqVUitt+Ps9yV2jwzb
         8HIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793017094; x=1793621894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fg+laQkv227GqKq8SsA75OZmRMEO4qe7f9QQA9ZrTUw=;
        b=yaoWSwOYoRZa0hpX+zgl3C4vRRbbhPQjgh5v9fCpq/QtDzMApczayHYEhpZLLOohDD
         kuEWUSdNGDfvr1U+5J9u2IS5DG1Q3M+WTNaj09UJK5PeDc6M8ESMNQtq/74EMuAW1XKS
         ntKOrDgufXCSoh4j79QJT5ULyxxyLIs0g6Ek+XG6j7qJ/kuSQy7fobIJ30bsaFmbD+N1
         /YqM4+0k1dkZ71+V0inCIRNVM8I2NUlYOgAlcqiF0B1VNiB8B1tISn+7kligHrUgZ2xf
         M1ls6LIuzLzhMcszxItu/zeo0mYWH8c/VhIYjYHP5DZFq/imQkUbcAxw/YJ4B0Rj+pSK
         2Dyg==
X-Forwarded-Encrypted: i=1; AKwUvBz8hK7s7kpnsExP82xav9C3Z0VxQYHiUtnvAuJwIuR+njekX9KChs4XMlPiY6rQwIHaDD0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWMHHl6scav8jS/1ME6ii2YSb8PT2iPVmUkHgaijlOwcY4aDw8
	bRfDLqcHvPo2JV6yxaTmmtQDRg6WU0QoUu+3JhH6Qt9PejXNyaDsj/cr1ar6qzEBecISAtJlzjP
	YUMyUe2Q0XgbaCI+myv5i5VI+C+t9Iag=
X-Gm-Gg: AYBFou2Xq2go3M9Cn2HdKbtt8jtgtDBo1smL4Acux66Ri1Dnmcso/j3tPS14Wg2wIJ8
	vRvXTZ8/qtI6iOHuYS9NWdNhC66PXSQ5rTgo+AI7rhEyxkwDCJP/LGNjAwXPxRIOgg9xQeQWOTT
	SJo//1SF9jVP+UC50CxpM5/JvEOijW/Jlts1TWSv8Ir3Me3rYPJwU54vLLN9cHF3ZSXLFjPu7Xd
	HitCbJH2i+7tF6L3ZTSRvlpvwLQqEMrimj9RqXqGtnDAnN2vA+c09m6WxfaHAGWkVgnAN1ZXoTs
	IzktfeWehJQrhC6R+Hm10JOEneG9+6MDCfWwTQvlg0tfAck+rHwZc/z9o97XV1ovGZ2SpqOAYa9
	qllnRc916dmT66MzbQHuufKWeKFi9ziyNedw=
X-Received: by 2002:a05:6402:4404:b0:6b4:66c9:92c7 with SMTP id
 4fb4d7f45d1cf-6b466c9978emr3801693a12.24.1793017093785; Mon, 26 Oct 2026
 05:18:13 -0700 (PDT)
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
 <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com> <a57cfbb2a5c0f34e44595c3b688b18c760258685.1793008465.git.gitgitgadget@gmail.com>
 <at80okuHpoUjUYpQ@pks.im>
In-Reply-To: <at80okuHpoUjUYpQ@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 14:17:36 +0200
X-Gm-Features: AclHuK8Sxp7j_7qsDa3ijRbCnxzPaK0tphtK5xMx5fFQ_dT7z3WuxYxjwYTLxZk
Message-ID: <CAHwyqnXk=Q=M6mZtF9QW4mjtuVtKt2zjqnMm85OeYPEVf1aBsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ci: fail the build if perforce, git-lfs, or JGit
 fail to install
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 1:08=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 26, 2026 at 09:54:25AM +0000, Harald Nordgren via GitGitGadge=
t wrote:
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 203e8401cf..7c3c6ad434 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -94,22 +94,25 @@ ubuntu-*|i386/ubuntu-*|debian-*)
> >               wget --quiet --directory-prefix=3D"$CUSTOM_PATH" \
> >                       "$P4WHENCE/bin.linux26x86_64/p4d" \
> >                       "$P4WHENCE/bin.linux26x86_64/p4" &&
> > -             chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
> > -                     rm -f "$CUSTOM_PATH/p4"
> > -                     rm -f "$CUSTOM_PATH/p4d"
> > -             }
> > +             chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> > +             echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
> > +             p4d -V
> > +             echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
> > +             p4 -V
>
> Isn't the && chain completely useless now, both here and in the other
> cases? We let `set -e` do its thing, but we don't have any error
> handling for the whole block anymore after we dropped the error message.

That's true! It would open up a lot of simplifications on the regular
git tests if we could drop '&&' there too :)


Harald
