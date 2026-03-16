Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22375223708
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643081; cv=pass; b=E1A7HqW7yCjUiKX2mAh0MEG3oTWua4BuqTetNsxq1ZT1KtBnBPjY4TDaWdpZmlCRpNH0uv1rcNsUYMvFxsaLEw6UPOhZHthZvqp64SbkhDyiHz/Z/ouHZdmXnN91jm+vJ1d+Ma+UApQ/DpNN+yqfQ0pOKN6XfZGfianNS+Jird4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643081; c=relaxed/simple;
	bh=cjGCpk8dwt2N3XmoISB5PpSHd6tz3CVaw96VHUGE6Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofKLJrtNweHzVF+aqtV8jrCvmCHzNi0HtJQpZYuUkr44w6KHGsvwYgXWtZoTeRuxUbmsF/U3CqCVjp0yraBByh4jA7ocjqrGdeyq43h8XgjcUE2xb+PCcKyoFFPH5XhJIfiOVH84ybdJzIMmQSa0ZI4Mi74HSCHwlQ1L+wP4Jyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0ba72d097so53632eec.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 23:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773643079; cv=none;
        d=google.com; s=arc-20240605;
        b=ViQvdLGfM5E2GwI2DsOOeZjderFB4AHzHi+g15aDNwp/Pwjk2/sGnT/vK9QPb9z7ST
         AALa5bgOv8p+N2jwrJqxuh0gwluQy0uxWktr77rnuO7WMgEweF6C2fhj2N2pJM6Z3Uqx
         PU2Bpm6tC1i4arE9tA8dmiwLZWki/v66LIqugGFqetp6DFzNwpkVwtW7m+0yQkm2XzLG
         33/9Mf2mjR3CwSHKwdIwn7lVpGNg2eLQLK28catOzV3plkdAOYLAIasSpzZtW2qk1iGc
         xip4wwesFc8Y6CNqqpzUBA5BWKOuDFPhtlHSheBjfZ4lY0t6sNYA6BbCtniFitDu3MYV
         Vrrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=LdwEoUKiCfzJtWU60jkHcKukZ3aT4jecPVqY9/lPGJQ=;
        fh=OqwB+JZBsSQT8s7W/1mPwK4nDn2/iMThoEkIEj0pAeo=;
        b=VzuMJPTUlX9xLnifAPLmeH2caxKZwW0u5V7ex5PVAbd7/3/5QGipZSpoMtw1xIP5lp
         aqYoivhuG428pQ0CRIiKYhaeRXkSaBP9HeOrHG/rAhQW489Jr4su2IgHDX8Eg6T/PPCK
         DM+UgUH2+2HpRDpJYdCAzANRo7vEzgJhFunH3QP+gGSufa5yi7hUB9ktWkHQH34sRwJO
         LzRyob0MecKtsKDZg7LlUzHqAtzGVhz17659Zywg8jfIAI3mdcRRCg0uaZ+dSr7P+pjJ
         0G3tAG2GHhaSKhMun9fHqo8vy6YixUfRC2eN3QIv5rgWk2tyn7Ugl1HvrYnCt/Kf6fKr
         kxnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643079; x=1774247879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdwEoUKiCfzJtWU60jkHcKukZ3aT4jecPVqY9/lPGJQ=;
        b=WKz+w5Hfckyv4CkuZNRP5qFP8IbfHnfJ9VIPCRWf0LKLM1kIsOFcsvGrl0e5uyTOja
         2AH2uznmeEduCy2UupSAz5f+i71KxKa9r69Gdjxxd0OJy2Mc5hqheQyfYrbHKRIk36Yn
         sqMxXtIjvl5WLGjSo0f3arWp1pdk6spyq/DZaZtVxpxZNwAukA9rqzys29eJ9+cg+s6i
         HAjJVg1cDr9mrAYSwwoEH3+O99RlyR9IgjHI1qClPQpHspVB5kDw5Rgcq/9IqpHFxEjf
         JNHmcfPGXdNkvqrRwlppM84rsFbWzpUNbrZuOLiqaf52lV1hCdO3tBNCEoct+woHqc2u
         wXTw==
X-Gm-Message-State: AOJu0Yw+WpUteihwfKXYjpHlYFrDLYrxpDkrZ1/xVTlPhfixPq/ZOYzy
	kb3V2g/wvQr5QEZ7eNGgLLLC8/82LYUO5ftdjtOTJdgPceznXqubjV8rbqZmLylo87Qgy0P6RH2
	Yi6nHLLzikR8K27RBYQpkelhZAgV66vY=
X-Gm-Gg: ATEYQzyhcHZ+UPBTmcgCDVHfd9bN40H6W23aMwviQ1bLU3RfqgF01DOQy0yvxukUp48
	Hy/0k9DmjJ7dNe/F5YXXrI1V4whX/eghTX2DaTfmKBxmm0EXn1yC1UvBbqGB7JFevk9SKMvqF4q
	EiaqwQCINcbaXAWJ3r9OgAIIp8OLQR2mXTueR/vopVPpabYKc5Qc1W91G8hYWKZ0W/LAYs3P4n9
	7Sa5u5GQWDlCt3uFbmD/h5sdnIpnM+EaijrggYZslraXBJHhI6uwYGOOYT/Q7taquPU0mNe3o5c
	vkfodc1sfUJZIu3JdwnZE5C3nC3UHmwSGyymBsgr
X-Received: by 2002:a05:7300:d0f:b0:2be:2912:ff65 with SMTP id
 5a478bee46e88-2bea54e9f14mr3053543eec.3.1773643079081; Sun, 15 Mar 2026
 23:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316042248.63278-1-prashantjee2025@gmail.com>
In-Reply-To: <20260316042248.63278-1-prashantjee2025@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 16 Mar 2026 02:37:47 -0400
X-Gm-Features: AaiRm516JG0OIM4MeQBYNJ03nz0rDFNw8wsam1UDv_9JqL_Sgs3zjldIsFvI7_A
Message-ID: <CAPig+cRp+U8gWT7JkUdoaeyVVXGvq_iB8X3Ppj9Q862CiJFZmg@mail.gmail.com>
Subject: Re: [PATCH v2] t4200: replace test -f and test -d with test_path_exists
To: PRASHANT S BISHT <prashantjee2025@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:23=E2=80=AFAM PRASHANT S BISHT
<prashantjee2025@gmail.com> wrote:
> Replace old-style path existence checks with the modern test_path_exists
> helper function that provides clearer diagnostic messages on failure.
>
> This conversion focuses on test assertions within test_expect_success
> blocks where a missing path genuinely indicates a test failure,
> rather than on control-flow checks (such as those in test_lazy_prereq
> blocks) where missing paths are expected in certain environments.
>
> Signed-off-by: PRASHANT S BISHT <prashantjee2025@gmail.com>
> ---
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> @@ -72,7 +72,7 @@ test_expect_success 'nothing recorded without rerere' '
>         test_must_fail git merge first &&
> -       ! test -d .git/rr-cache
> +       ! test_path_exists .git/rr-cache

Unfortunately, this conversion and all of the others involving `!` are
incorrect. Take a look at the implementations of `test_path_exists`
and other `test_path_*` functions in t/test-lib/functions.sh to see if
you can figure out why and what the proper change should be. (Hint: We
want test failures to be noisy and explanatory, while successes should
be silent.)
