Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082481EA84
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489374; cv=pass; b=MCqyin02U+Vg0zMx2PZ20AHLLK6Nj/QOBjE/5ClJUsK8HvBcGOlvtjAThsQDx6/MhV3rfo4CI9XFfBOZ075eOtJy9w7c90NqPOF+WRychYlAZ35haj01dyY0aPwBJKdaKEYs46mdG+EQHBbCYDmAxYnT4CA1Je1DrGectIKIqPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489374; c=relaxed/simple;
	bh=WSRPhQMCS6/vUJ7sJT7nHe3CyNiwgPNZlMEwmFBkTFQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2bMFY7VUd1EPkAe2RjLCUDHU2q9u5L7vBKdUuTKk+8quKXkjQeUGRHz5K/wLzbYYLMCtcRUdHnjVidAjashjwlJFmG/4lwdUgv+EfMaEquKk0RqfOv1pjZ6riD9sRMrlXtPvSUyP8JEvX94yJ4Sp7+lpaVbP+fliPS4DX05BcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXwf7BR5; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXwf7BR5"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59d6e44e5c8so2649784e0c.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 05:22:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780489372; cv=none;
        d=google.com; s=arc-20240605;
        b=P9ThveR4Xd/l2ljHchdW5UEPBn4M/hfIAHW7MfKbFBQzIbKEwZTUi5BUBd62vP3RPk
         3HGlBzfxFSJhopb4W1sqZkiAi0RBNyq73Ah3CIhlO7o5RDg95cYqnSoB+4Nu47slSmwM
         ghofiwLmlXbAm/tKNGTMR5vw0At4tuRRU229OuHV9L4aIfbp1EWh9osqe3jLfhTESG+4
         jKejOMdjh7o57jszkzDw1pVq02viHGO2EEayJtVojiOUiqiPozwZzF7jhAUJgEh5d+jU
         8smKIEjsv3QyTYe2vFa6bh3v05p4uRlna7pBJPhWOSNKy9YHCst22JHgPSvVtD+cVlsm
         nIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+6tntfowzE2R+6COKaXtMonFaapYYS9Wrj2EGnfS8SM=;
        fh=RWlTl3jndEVGP0dtkyQh2C9dNlmcwYxB9b5YUodo8RE=;
        b=BMq3Z2yqlkhGzhQ/dGeSiTijlQDzdcnFG57/LKBeX2tcZA8BfGJWKWMkxLISDcOz9I
         L7BisLdGjl946lzOEznzJYYyd9cFLyTOo9NBfn5poSS6eC8p0RlBsiiopJjR9HttTJZm
         gxKNR8u16d/XVYbCUnEvmfctoP8D6XMAMWA8cBekaAulNcMSQVow9DimD6Ev0l/ghXqe
         R7FyAGPobluV+Z6FX/wKctuOYUOXg+P60B12HukAELDwcwkdxzL5qaCLua+ZcvhHzCw8
         ygeNQmI2gssdWQ8wL0Y+rKOn/lySFb+rEkr14Z504tASgjEmc7d9iAovjTv++FqDG9Jf
         l9Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780489372; x=1781094172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+6tntfowzE2R+6COKaXtMonFaapYYS9Wrj2EGnfS8SM=;
        b=MXwf7BR5RqcQbzfzndxBL2iv9qMiBifP620NaQ0z9v44prWEzEcuaYz8uwRoLvML/W
         IGY3l7cvt4+Kd1T/mWWouM1BtU44+g/FohUrDdOHd0wYzu+hHxsVSU3ywTbbu7opPAac
         MPf4BMqKFD7c6+37lfRpulkxh2s6w3TzW0FM1q6YVnAeR+PeXmKU/eNoXvfxtSP9290S
         +Hnc1c3Y73PaMinjQZH9KslhFc4psRzIsG5ib4jcah+735rUXe9u/PWsyDUBjRGKYvgy
         mvXKiMkyPM932w7C0VVwGNuIYiiP2lgk+eBJp2fROzqduF3DH6PCOvPmtoO1PvXVQqQk
         vvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489372; x=1781094172;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6tntfowzE2R+6COKaXtMonFaapYYS9Wrj2EGnfS8SM=;
        b=pXDdsXpqlPnsnKyY0Dqm8A3oVJBKBdXVBOj3W06Ey9e40T8FZNfbB+U8DBKhC+Xmwq
         pv+/ffli6IZrhZwrQ5+OpPurjHXNUdPLg8lgXsPaa+jxCOrdKsPdYM/DJUFnn/I1Ia1a
         blsSpQDeMgkcaTFQEOdGRrpaTTTPSjxIdK1Y04RcC4MkJkQ/cM1RsWSzjZTwY+0nQsLC
         PG7nQZA7omxgeTmAnYP+ub57zQh2KVKaI3CtTUW+3iqjZA+Y9Srb/6p90oClPSPvKzV0
         a/y/jMs3rTBr3CHGxc5+6/UBu03pAB1TXy9TQwLTt9ViIUag2qDCJ1+OyC6V2FyEKCtn
         38fg==
X-Forwarded-Encrypted: i=1; AFNElJ+4yIu1LT9yrZj23SxctUBleDODfl4MG7qXZQuGXnFX0IBwajj0IThAK0QcVmjVIyknmdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9203hhAujmD7NUrhNnazUfWVzQNiby73Ob3Lrw3xcBBPtiW/j
	7cIsaeLLsFg0FgWPRs4d0E1cXRccSwaEGQINesUQBcS8/m+8AyN/XS/gSrMFEwQxJnc999LvCqT
	nhnChbc1jtTPZY9+B9APdXk2oZrHdYiDHZw==
X-Gm-Gg: Acq92OHoz532FAEOoPkCRAhJoIgcusuMMnaMWtmbuLazgBt5+PD6gfzyKt/XHmn3hv9
	KoNBT7s3hvlObjR24Z/Q+Otb+feCKuFK6AK5Bg5q14RIudpSSsU6X5A0fMEZLMX7dUuPLAwKQ1b
	vd31dt+uivwYnZPbyRxnIK94MEUqdimWmpYETNySab+kcpQ//9ZlJTzTN+RHiYsB0rYdc8lXK0k
	13KCSjRAUyPShX8r/+QTqDHNX88aJQvulWBxpl3DXPI/CFWpfWiQLgcQKPO3zGYuk5A5UXrToK8
	onSq2rwey9Us4tppDpzQAoKX2RmmxocnhVJunEvCBYsiXBW6c8RbooyYLkHL3FaJY7sH7no1/Re
	3r8MCK39r
X-Received: by 2002:a05:6122:e227:b0:55b:d85:5073 with SMTP id
 71dfb90a1353d-5a6e541ab53mr1768950e0c.4.1780489371952; Wed, 03 Jun 2026
 05:22:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:22:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 05:22:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260526-b4-pks-setup-centralize-odb-creation-v2-1-2fa5b385c13e@pks.im>
References: <20260526-b4-pks-setup-centralize-odb-creation-v2-0-2fa5b385c13e@pks.im>
 <20260526-b4-pks-setup-centralize-odb-creation-v2-1-2fa5b385c13e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 05:22:49 -0700
X-Gm-Features: AVHnY4L6M94nhuIfQn67BS0FRfISH_PqXdgVHeN-NkvaBFYuKtzDArrYx1I0VhU
Message-ID: <CAOLa=ZSeZrL7W_Q-qz0nn+pQATpaJ+8XP6L3rSWRwfWaoUjeXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] t0001: plug test gaps for git-init(1) with GIT_OBJECT_DIRECTORY
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000008ad5f10653587c77"

--0000000000008ad5f10653587c77
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In subsequent commits we'll rework how we set up the repository. This is
> a somewhat intricate and thus fragile sequence; there's many things that
> can go subtly wrong, and there are lots of interesting interactions that
> one can discover.
>
> One such discovered edge case was the interaction between git-init(1)
> and the "GIT_OBJECT_DIRECTORY" environment variable. When set, the
> behaviour is that the object directory should be created at the path
> that the variable points to. This behaviour is documented as such in
> its man page:
>
>   If the object storage directory is specified via the
>   GIT_OBJECT_DIRECTORY environment variable then the sha1 directories
>   are created underneath; otherwise, the default $GIT_DIR/objects
>   directory is used.
>
> Curiously enough though we don't seem to have any tests that exercise
> this directly, and thus a subsequent commit inadvertently would have
> broken this expectation.
>
> Plug this test gap.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0001-init.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e4d32bb4d2..e89feca544 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -980,4 +980,14 @@ test_expect_success 're-init reads matching includeIf.onbranch' '
>  	test_cmp expect err
>  '
>
> +test_expect_success 'init honors GIT_OBJECT_DIRECTORY' '
> +	test_when_finished "rm -rf init-objdir custom-odb" &&
> +	mkdir custom-odb &&
> +	env GIT_OBJECT_DIRECTORY="$(pwd)/custom-odb" \
> +		git init init-objdir &&
> +	test_path_is_missing init-objdir/.git/objects/pack &&
> +	test_path_is_dir custom-odb/pack &&
> +	test_path_is_dir custom-odb/info
> +'
> +

I was surprised to find that such a small number of tests ever use
GIT_OBJECT_DIRECTORY. This looks good.

--0000000000008ad5f10653587c77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: adec3d35722412b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ0hKY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm1XQy80eXN4ZkprTU1PQjBJSUE4anNRWHg3MGhNcQp4VE9vazkwOWJi
RWkxNU1LWFIyZWs1QlFzVHB3NGltWm0rSDdtOTVORVE5Z0pxa05yS3VRVzU0VHE0MjZ0UUUzCkJz
Y003TEg5VTREaVd1L0hUL3AvazFKRFRSOWNwT1RjVUMzRVdRWkZZLy8zVHRXNi9DT3dDMW1weUNs
MGY3b1QKdXMxTVRIVHBFTUZaV2gyK2NPUjRqMnR3eUFNSi93VlB2d2R2cndEOUVoYlVqcnJsbDFw
VCs2NG5KS2hNa054aQpJdHpubFplQnU0NE9WU3B6NTNsOTBlYkE0RnIralJsdkkzaEdSQWZQQWc4
L0VhZ2lGY0lNSDljVnMxNTdReGdrCmtmYlovYnpoVzhBL1BPdFJDbW1DRkNkZFo0M1hPcE9hcjZU
RzRTYmg3UkZ5eVlkYmxtWUR0US9zVWtva1Uxbk0KUU1EOVJiQ1NZQVhOWU1FQXdCR0QzblhWQ0wv
K0xKeFArbkphNG9YZTgxci9VekxSQ2lrWVVWYnVYdnp0R0xuUQpRZm1zaFdWaG45OHdXNW5WSCts
UHZQVHFYZ3RUb09DTHFwVC9YM2h3cnZEWUNGMnpNN2xGWEp3WXBGcHIwZzdqCi9maXFyS3BZRXFU
cDEzZ2JyTkt0SWNQUklqUXg1dDJrbUtqditmUT0KPWs1Rk8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008ad5f10653587c77--
