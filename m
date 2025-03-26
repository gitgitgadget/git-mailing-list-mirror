Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894B253F00
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 22:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029386; cv=none; b=GiCmfTe/5QevHZ1HB1mZPVGlWIjUK4gcE343obsy/YETdTpsNIsSH0P7D3PN8X2mE3c4BIbJSBHz6cDG3MtepEMmgzzdd7LcMHCs+1N904LaGuvZ+XHW2NjFhZ0QHPqmaUS0Pbud5Gu6D2D78j8Ajl0Q4DbZ7pa0KXVnk+EnK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029386; c=relaxed/simple;
	bh=Uskq5LCVKATCfJETdigV7uuOBq/xZHWJkp8xX0sYa9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlpyBnW5CcF5MlJeCG4yZwH/ytPgO+Ton7kEDvZJzKVVB5sJUpBoOgIwNhFz49QNhaxq1Dgp/e1Qh9JYI45AR9A2v0cc0I5V0oXDEoWMyyX2WfWCSeMGKaoeF8KkHc32y7WyRWPTpzJFnyAgnmpFLp42AcUT88Uzs48uAyFjcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e4231ae149so340606d6.2
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 15:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743029383; x=1743634183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zsg7UmV9n/JX7YnV2qndGXV88fac+Q4CgksFsbHSpEE=;
        b=u6qHVVANwein+i5RgHd+kZC1UQairuFC4wr+arhTYjmbOJpxaaACRj9k1Bn2dlc2xy
         L8tTHCWh8sIwJ5iB9HCjSwQIP7ScZ42WwLGNMvGF3cNOXubKMu/QcrVj0yuqwr9shUwh
         BemVw81aihUbh+x6RaPEdSSDf9J7YtBG0pPogic/Ndxpn8Q/3Og/AO6U2TvVQjirbp2r
         /q7ODYIxnT+D0BkDhchkWt++XuPeAGWiN/WVvp/ykE7nyfbtEU0oJZk760CH68lFZd5v
         fAsUMgBK9bovOtAsJhhKp7GU6upqbGKC3hsCBkVmgLR4P1UObPDhcqD3Jv5kHiV+oe03
         3+WQ==
X-Gm-Message-State: AOJu0YwoFuZ9mXbZvhncG5bcHt56acmqNhclFGegf0GGihVTWrX9FzWt
	lVxTDHVR7GSxF6GuLI9KvpFejLiyPmMIjp5nsCvd093gjvt7qubNg7BKmTngg1ntOxTYz0clcB3
	Xz54tsPd29iXjPjumBe+8UQXytDg=
X-Gm-Gg: ASbGncsIdoA+ixRqQZyiMpHMf1r1nQgG4yDdPyU3kq7YnQjh0/fq9W7RgkJ1A9D+W0M
	3dxPv86S9JlECRuTf4I/DS9jOLBLa7xCBwfvY2iaBmuu3wDnrKR5tHmZxZBhUv+kxkgJ2hjzvdN
	SOf3Ni7O05+W2nWVu0gzzdE/z4iAgmHsYZ1X1ez2/nN7cUTjCQuJEXhVlH5Q==
X-Google-Smtp-Source: AGHT+IFZVWucz1J1VxpZc7v0FFY5cKPub7h+TZf3dx9F13bpxx9k+2q9CbOMdvLEwre25ABX1lqvZiKXGecvSCijQCs=
X-Received: by 2002:a05:6214:c49:b0:6ed:2289:6623 with SMTP id
 6a1803df08f44-6ed25159cfamr4251846d6.10.1743029383299; Wed, 26 Mar 2025
 15:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
In-Reply-To: <20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 26 Mar 2025 18:49:32 -0400
X-Gm-Features: AQ5f1Jp7A0itb5XvhM7Sfwk2ZPYkyAk0HhX0NzwSa79x_bnvceoMEdo9vpDXVZo
Message-ID: <CAPig+cRLXDohGG0RLpC41hy=rTmbmNQ_qScFWMv2LP8pdM8_hg@mail.gmail.com>
Subject: Re: [PATCH v2] blame: print unblamable and ignored commits in
 porcelain mode
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, toon@iotcl.com, 
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 5:07=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> The 'git-blame(1)' command allows users to ignore specific revisions via
> the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
> flags are often combined with the 'blame.markIgnoredLines' and
> 'blame.markUnblamableLines' config options. These config options prefix
> ignored and unblamable lines with a '?' and '*', respectively.
>
> However, this option was never extended to the porcelain mode of
> 'git-blame(1)'. Since the documentation does not indicate this
> exclusion, it is a bug.
>
> Fix this by printing 'ignored' and 'unblamable' respectively for the
> options when using the porcelain modes.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
> @@ -158,6 +158,16 @@ test_expect_success mark_unblamable_lines '
> +for opt in --porcelain --line-porcelain
> +do
> +       test_expect_success 'mark_unblamable_lines with $opt' '

This test title is going to display literal "$opt" rather than the
intended option. Fix this by replacing the single quotes with double
quotes:

    test_expect_success "mark_unblamable_lines with $opt" '

> +               sha=3D$(git rev-parse Y) &&
> +
> +               git -c blame.markUnblamableLines=3Dtrue blame $opt --igno=
re-rev Y file >actual &&
> +               test $(grep ^unblamable actual | wc -l) -eq 2
> +       '
> +done
> @@ -191,6 +201,16 @@ test_expect_success mark_ignored_lines '
> +for opt in --porcelain --line-porcelain
> +do
> +       test_expect_success 'mark_ignored_lines line_porcelain' '

Similarly, this is going to display the same title for both cases,
which isn't as helpful as it could be. Presumably, you instead wanted
this (using double quotes):

     test_expect_success "mark_ignored_lines with $opt" '

> +               sha=3D$(git rev-parse Y) &&
> +
> +               git -c blame.markIgnoredLines=3Dtrue blame $opt --ignore-=
rev Z file >actual &&
> +               test $(grep ^ignored actual | wc -l) -eq 2
> +       '
