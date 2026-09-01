Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320783806DD
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272086; cv=pass; b=CGPOGnic2ke9EdJriLE8w9xhv+SSx0wjxtrE7cYSHB4pEv1heXRa9ogNOd0u4oUCsPaph+Us7c0lNW6AnCHTKwm8MAJN59bw0CqRYne4uC+bSBNjLvWL1NEQDT/kotqd8jkfUaJMZWRudyemWxx0/6UbH2X3JbyBx3dvXzgsNfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272086; c=relaxed/simple;
	bh=L22AWVUPOMXVZJxkuhuvGv8NhTmQ/UgfVgjaantsUSE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=qRYhIv3jMfpPT4oOd25jESsBYxYf0Kob5Iw4GeU/g2p5DvLx12KZwrf36OnfOvepxZBgxWAhgeETHGsKWfKHEvyVImrm/UGZlqeXyhGKcBvhJ0Eus2zRm6a3GiozSFF+2eAW0ESKGIuvfVj43qklxYv2aoZQi2dC8RxYaUiKD9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pj3z2Cle; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj3z2Cle"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97cc72fe0f3so753321241.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 07:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272084; cv=none;
        d=google.com; s=arc-20260327;
        b=Og/Zf6m0Jdwgbgkl6hukL4dF0iQspG3Sf6TOkUw/hUZlmD0M3OhCgJl57g/hKdqzt8
         UV3cUATMQHiZA5JZKGHOJsVUfaIxJcc+MMqHApYO1izm2yoPEuIV4AFDO1bRRi8KjhTl
         Jjec0g+c3LzptXKShFudRQGmUXEYV6pMhlhAoFb28XV8uqTI/bfF+k4mUt+h/cxLIaux
         UWJZZUzNI6OUFUWkfR6ZiO9zMZwhPN8Bqb0/UDgAhNkbNE5RUdWWMj4ROhl/Ip1/UHu6
         TJUmPnkXQAa2o1dVGMlkh0yCPWIDpGZJ7+SUR+chiIzmRD2TPgTj4as3er3MJaezzMkx
         xybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=miavuqzMHlEg0A+Te3FhheijUKakFZeG2tiXIdZ8FmA=;
        fh=RnSsTafJEisZfomr/Q5h/2ECwbzSvCHA8EocxLQU/mY=;
        b=W44Uvrh2A18Tne57HFFUebUXhnF9gckRxgEQVtcE+oueolxcssMeiLbOlwU7V1vASA
         l0Q40PddpKfph3s+PlE4w3Ak2fGHDfJZkgW6nIVVO6b6mN2R+kG8dMOh30WzWMvkkCGY
         fCas1zywKWffWqOSL2a3rE7qq8/xRkGDsiGVto1GPMLqIGemWoUwQXJTNjcEWHeeNHfd
         5zlNVih3Uw2S+LBaNdshDdp48vzpfb5DgDTccm+06SceVcXrJGp8G2NERRJSVD2bQehs
         sNM2x5OsE7VpLTYgw7I9N6Z5GjAZYl6L54iy0/T7dd9MDurY459l29utNZpm4yp9dCJU
         J8Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272084; x=1788876884; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miavuqzMHlEg0A+Te3FhheijUKakFZeG2tiXIdZ8FmA=;
        b=pj3z2CleK9fWUN6KIKaUPx9mTmmKlmGgRgRRYAald6b4zLjBaY9TmkVcC6iNyjgx7Z
         5ligUdLJpATCJX31X+WHalh3kQ9DKQE8entAqttKXaXeRUUwgQfWkgW81SNKX2Cbxlf4
         QVqF6dwh+ohB+EP8pvVnY5rQT73N8iRanZ7son4uAAjPyPDS9mdpX0xdTQDr6ZNuzecU
         0Q7BqrM439vZECmdbnEBtN1oKBP5VYyNHoIgmeR1H/Z8W9fTi9yDHMLTh2q0iUF1lmbp
         l9sMdFWuTkQ5ADCDsXLtmx74furZw0KfbunMM+bP0qCpzX3RRTWHx6KWsLdA3ZIYTKKf
         3zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272084; x=1788876884;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miavuqzMHlEg0A+Te3FhheijUKakFZeG2tiXIdZ8FmA=;
        b=W9ackE5PrEJGCAwbDHkxh7XvnGMUPeHn9zC5Aj1aqI3kpzvQPWeDGG2kP2sqU4Rv/P
         OXed+jBeP14CZ2uoz+wqzA3NcGxHd5hqRtj5yi+yuAMrd6ItKr/XB3G6bkD8nLK6pZcK
         nL9v0t6xdv1u8bhyhh9DH2m8nNv3YYXJULOr+Mws8tEf/xQ9HRFFCffB86eQEvr65H0w
         Ba+q1uMvSikf6I983dqoC212FYHKizDonYfWeW+G4DB6qPfAHu9xPz8boXCRq7OhER83
         ijr0DHX1WPZ9ZadRR2NZM4H5z+R5KGQ3ypznSnkAZD3UpwWWmQF9a6inqa7PmQpUgTqF
         xaRA==
X-Forwarded-Encrypted: i=1; AHgh+RrtYFOdr+qjX4U9t0Kv8XfrQPNg6yxXkiI/3i7S9xZP8nnAzs5eapn7VjFoQqg9vzsaIUY=@vger.kernel.org
X-Gm-Message-State: AFuF++ndAWSjJO7IsDYtCrSYTV9Easa0k1stAq1MiKVlRvsbI8c9gazF
	SEzBUjoqnll/jY9d8k2bPnVkFXfEatgH1REG2Y+ewRwQFOXoO8UILwX2i1HHhljs3Y2oR9b+QlB
	r3Q4epU2/0cuEjSivYFWP6WmQ17pRzwOL2SvM
X-Gm-Gg: AR+sD10g8mbBWLkMV9VDWVLbwBcr1IhaCGpjhZ1ltcEjZr6IPc0g6gJldI7wVoRBIG5
	CgR2x4W48gWpfo6MFib2L8i7GXX+c/Ga0aXhnAIWRCznE9xVLu8t1mZ14Vulm9RPwdWlF8EAG1A
	shPCpJFQBiNHzy97ho+nFEX5ZdGT3/xpEj0/MH3t1CL7H73GUmPm5sVbdE2he4yNmXf19MbLR4z
	UhatMjLx8R85BDFCE0Q8tjzHNzEB5AGTru/1B1FpLDrsXtZlU2fWfFCYz4AYX0wSzY39cjlwrED
	eYg3zlke8XIVP7KSDQmwPSiS+SBdlCMO5jmIAwpAe0T+ZGteapcm9phHicJ16BDgOAQg1IQbqFO
	I3RbGX7jRBiK8nh9hbqDE75Dqr+ArGNNcsAu40YhTqh+vvA==
X-Received: by 2002:a05:6102:41a8:b0:789:ec0f:3a03 with SMTP id
 ada2fe7eead31-78a0287d5c0mr1365090137.4.1788272083945; Tue, 01 Sep 2026
 07:14:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 07:14:42 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 07:14:42 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260830204835.1040408-7-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-7-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Sep 2026 07:14:42 -0700
X-Gm-Features: AcwNN1VHmzoqWFOtg_XkPdXVQX6f_uy7_qu-MU4PDOQH7CiU6Zz2sk8HcTaVbPM
Message-ID: <CAOLa=ZTHGAfRZJKjrB=u-AxiUWgL2p_5HijdfJmCN_wJCE8BqA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] checkout: restructure switch, restore, and
 checkout entrypoints
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000537f94065a6c8a95"

--000000000000537f94065a6c8a95
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> cmd_switch(), cmd_restore(), and cmd_checkout() pass their options
> to checkout_main(), which parses options and configuration,
> validates and dispatches to checkout_branch() or checkout_paths().
>
> Now that option initialization, validation, and branch setup have been
> split into dedicated helper functions, restructure cmd_switch(),
> cmd_restore(), and cmd_checkout() to invoke these helpers directly and
> dispatch to checkout_branch() or checkout_paths().
>
> In cmd_restore(), handle the --staged default from_treeish = "HEAD" and
> resolve opts.from_treeish into new_branch_info and opts.source_tree.
>
> This allows us to remove checkout_main() and enum checkout_command
> as they are no longer needed.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c | 297 +++++++++++++++++++++++----------------------
>  1 file changed, 149 insertions(+), 148 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2edaca5539..b18515ac7f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1341,12 +1341,6 @@ static void setup_new_branch_info_and_source_tree(
>  }
>
>
> -enum checkout_command {
> -	CHECKOUT_CHECKOUT = 1,
> -	CHECKOUT_SWITCH = 2,
> -	CHECKOUT_RESTORE = 3,
> -};
> -

Okay so this is how the first commit fits in. Now it makes sense.

[snip]

--000000000000537f94065a6c8a95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e0a40d73e347ded_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xVzNjOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3lWQy85aStzVktaVzJ2N2R0U05nMjZkcjlpWnVYUQpyQXdVNXp0SFFm
OHkxclVHZmhlSkVvalErNkE3WUY2OWxYSlQ2Z2VPYzVHWjVuZHhlZUN0OUtwNENSU0V6T2VPCjZ5
cEVBeEEyQTlnUW1kbjJROHNwajRtQVlPNkNORy9VYzNxc3EzMTUwL3ZYU2YwKzNrRFlEUExGZjl3
eWJXWXEKN0FkeW9OZlV6Smx4U05jc1ZpUWo3K01FQTBOeVJpWkpjWEpubTRraWFNdUdCb0hkUkU5
RVN6VklablZSUUtBbwpzRjJqTUl1TnBqZ0NKY3V6Z2kzakVDOU05L1lUd00wV3M4VW9zeXQrRWpl
Umx0SGdWUkhsSk96RjM0QU5ISzNpCm90clBWSmZKc3haNFhzamtwV3YrQVAvV2p2ZjBMYnp6N1JW
a20wVmRYdmJUQmhwbTVuZmE1ZzE4YlBRUXlhdTEKYUJGWXlnaWgzNjZCaVVwMEhRYmZyOE9HUWtr
ZHNId2NxSFA2bjc2SkhhM214eW91WmJvK3MyUHUyN1Rab1lJTwprTU9YUVJFRDFERkY1dTlLQTdj
QXVnRWJPNmo3Vm1DbkRYZjlNV0VCaFRJNkVhL1RjaTM4UEhLLzBIemJxOSsyCmFsYlRybUp6YmdB
cytmS3gwZmxyTjl2c2FpVG1FeWhrSnFLVVlPQT0KPVpyK3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000537f94065a6c8a95--
