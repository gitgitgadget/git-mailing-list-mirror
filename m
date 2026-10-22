Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792663689;
	b=kthE4e3VUUS0xShpdxCEQOYsozGBQDdtRi9hoOcg6Q0AhVsI4A8L/H7q3cld40ovrBSz
	 sUpbvqPVYw9nNr6wS9uLNWrrULCMmRh6RW1dUKLwSsrGokrryg4/R2Vm8p8+hBFVea4ZC
	 30NsL/X35iCmVAw6vmfBwFoAa48HFbgK8/1yoGOSs56fqGVOvicOOvHwnush7B5xll1qk
	 2eSLVHgLcpd19f1UVYVMzs48ygzuP38hmmmvjjfa94RIF/Pq69E729lgnBdZtTXqOAZ32
	 EzVWb/1TErKGpOi7OxOOFakYThLHjXzMRM+vHHNuNh3ka/6NpSKla23uj2bXL0UYnxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LdYr/U9z7Zko2iuA3SMxnNWV9g4tdQ7OyMXS+9yUJCU=;
	b=EKMVklWZnuzeqRhQyrPG3PL0ox+QDDWoqGoDTOPedWgMKQseZi5lPzACZ5dUiLHLiAmm
	 SrjC/e7kC8UI2pgzBWtPn3YrjNx7BgZfvBcrK2CKfPzh1ep5F0AyzfJLmXb+7jS4jP2x5
	 PgbvWA4B34hoS81x+GcjkGI9K7VJLIA1EwbkvCIurtdElCmxfZGqOO6iTzfvGkOtsnHFn
	 zlgp050l2aNrceLqKJVhlxEfHI0p2e/C+0hdZe/76cTitHmXepLd1PLLG38TcSTjlQ794
	 kHY9UtmY6QPy74ukHI3GhfCxDBFE41xpma33RgBYt4phKAHXQsKBBIlBlXJvoK1DhjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XciWEdfj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321B6606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XciWEdfj
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c169ae1cb26so121116466b.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792663687; cv=none;
        d=google.com; s=arc-20260327;
        b=liyFZLv92UDxPtnutiE8MSALhNqoGSgVw0IdsL6D0togYfvC3UVJR5mdHXlisLG0al
         rzyMKaQqykgKB/BqJuV0JVVUeaDjHtCxNfYSjk/eAbM6/iFQS0WY2/lfJSbRLr/VEdwL
         aVeZOpabvVajQhuT3Px2Lk7zyKAue2GpH/XjqHDRSkrHQrdgKpsRPaNyB2kXOVU6R/Ao
         V/e1fyM6Fb+U5w16m+Tjur5iNiEpGI3fIbVWp3uq7z4eOGmbwjZZkjDDaAoGQwmSri+l
         PXefVD1nyPV3sZFlFk4muwHuYqywjfKdOlh3ZYzrPIQXE8H9kpbMCtZP0wfUeCEOgiUS
         H63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LdYr/U9z7Zko2iuA3SMxnNWV9g4tdQ7OyMXS+9yUJCU=;
        fh=/d2VJR5ocNeYO2aOV+S4fbh62XnlNNo6OlqVnr7mibw=;
        b=MqkmHK85gPRv8hYT30q4fAbu7QsV6SDd04cVYtRpzMobnJIjYl8xRmdaHE1cPsOv9V
         GVHN5AzYru/ka24B9HNXAOQWu2KHTf241x2ul48NPlSSAsrFt2RcZD/mIbZF47Jeb2Dp
         Z5GfkBZcMZz2tGKB9PCK22JDO0lyhSFKXe/NMw3qiKi+adiSRhO+3VRhddbpsQwn1eAO
         8O/i8MK2Rl7GXwzxEuiguWcOFWGhKN+og1OHLEt3X3rX4z3IxkHT3QPsf6hjc2gGOdgF
         /oh9PwEpp0GJPTP0z7+2qVz2vReR6zD04iG6meVnSmTmQ10lIrJqg951lHQiA7E8e6zp
         HywA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792663687; x=1793268487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LdYr/U9z7Zko2iuA3SMxnNWV9g4tdQ7OyMXS+9yUJCU=;
        b=XciWEdfjm9T5McJYhZ2h15VGs28kSH6mfSowYN1dT3c795kTTlWpWo6tMP6AAVbo2Z
         D1DHZcqj/XCVNhAelmfMtH9YPyHyR/nRhJojm3Duy4yjOnUH/DWy9j3aa6ZNltfQfeVQ
         Bep9jVn04jc/LzbFnG6F6FQeREu0PYTiw+BEHtttKdBRSGOVTIBfxM80n2HWgWNJRbft
         mY/N9cJ0fAKAO3feD/2EwiFpyQIe5jrvkINFmZHOLUl2r9doKeI0DQ83ijfOpbUeZhQa
         CUpdfgDl31UXfQkfg1aMvx0obThP223zS6llFi/YVwOaOcjEi0jjNDyh/fK1+ZoLw/FS
         1CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663687; x=1793268487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdYr/U9z7Zko2iuA3SMxnNWV9g4tdQ7OyMXS+9yUJCU=;
        b=EmkrIvmygDxCKEjex6zhdyNx7ZeTKy3Qo8yj6zra4qgf+HZpccTChUBWcMkcGXC1kt
         RbY5gnbN4hx3vbpJdCge+Stq9zov5edZXRsMj64LuPyXZUps7Ik8M4FRQjvfJKjkd95N
         Z1tseGco6mbV3rdTLqi67tJTSQBrOZgV2bM2sdfZXeOCau8Fp6k4plIFfbY6FgJxPerC
         ajsQep+WXqo6IUrxJZfqj5kTgBPURpwQTdoM2Tei2NI2dG5We+DsaJwjxJ0Xro39ndmA
         cuYfMx3aGx4yXEQz+5YpUdXVTRTNsvZqhstbiE7FY8quxynmPemk+aOLncMkqp6bHfzb
         iOWA==
X-Gm-Message-State: AFq9FYKeafHh0sxFmvOAvlfYGwbf2kcdfwmydHu1qQ9PBnAoGMOkx/Ww
	fy4dO+NPB2g9EbllFC/hvBZMN7Cqxj+1EW+rm0Pvr7E6jSoLRRouc70yxo33VpNpAEMI+wPWvq+
	N0SOJ706R3KcNICdUI5UIB3Et5Z2Ho3U=
X-Gm-Gg: AYBFou2jmYM/xxHHCrpC5f6kOJgSFOwJQvN1AgC+Xris3HQlOV5u/ROnQo6E3YvhdKX
	NEEnHhCLtjI76K+mRBOiGTSIho+Uhm7yvXCqOLaDMgtfb12BMq5eSpv9wghjMnU+RIb2pM0OwMv
	+m8TAXDw+fV8ngwAtr5fmCOuJB53XNI2bdvzSRj8SKWx5vacAG+cL9la5SQawwdM6A1RZ9SslaR
	QuUPghdgsU6lp1IXTM5M2YEgszShLbqucSDDiy8InARgpPiQUj3ddcPmlOxvZ7XDChcy4JGZ7ei
	ITuep4wal/GMFVkc3jYUZ6o6EWizzWNlG2au6NuQLWuZzLRkD1mpCdSZYGx9niZ1Xfv5HbiF7fb
	6AzJN0CSsfCefSjJzmp6Hh+JO4izK49iufP+FZIrM21IKMUEfpXq8liPBB8M8VWF0xy3R
X-Received: by 2002:a17:907:d22:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c468d794de5mr224551066b.11.1792663687538; Thu, 22 Oct 2026
 03:08:07 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2274.git.1792582249420.gitgitgadget@gmail.com>
In-Reply-To: <pull.2274.git.1792582249420.gitgitgadget@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 22 Oct 2026 11:07:54 +0100
X-Gm-Features: AclHuK-IXPzD9dpW6AuybZnqkv6wjBURz_-r88GijNq1HUY8mab-70qdDdSI8c0
Message-ID: <CAPSxiM9SuRiRA6Xixp_zx=fFf_a6S8Mp327FP82Pg7mJdzQ3Kw@mail.gmail.com>
Subject: Re: [PATCH] t3429: use test_path_is_file helper
To: Joy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder>" <christian.couder@gmail.com>, 
	Joy Gundu <soniqjjj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:30=E2=80=AFPM Joy via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Joy Gundu <soniqjjj@gmail.com>
>
> Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> ---
>     t3429: use test_path_is_file helper
>
>     Replace test -e F with test_path_is_file F in t3429-rebase-edit-todo.=
sh
>     to use Git's semantic test helper and provide better diagnostics on
Why is the commit message down after the dashes, isn't is supposed to
be at the top?
>         todo=3D.git/rebase-merge/git-rebase-todo &&
>         git rebase HEAD~1 -x "echo exec touch F >>$todo" &&
> -       test -e F
> +       test_path_is_file F
This is wrong, the initial patch is testing whether "F" exists, not whether
it is a file. The appropriate function to use here is test_patch_exists.
>  '
>
>  test_expect_success 'rebase exec with an empty list does not exec anythi=
ng' '
>
> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
> --
> gitgitgadget
