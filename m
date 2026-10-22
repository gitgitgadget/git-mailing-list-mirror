Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664824;
	b=KZFhs5W+D8Agyq74xvQZFsg4ondIpCFbCsVLRowtkRfiVqiJL4HE9lMcs1wnBB+Mjl6f
	 fop18SleH6WOu0AYtMQjECnEAXvfzY8frG/ibEQV1ekHE/mj4wAePqSSTY8d6hoiGNH42
	 MXmaTpl3nGBB2yj58b5zqRwj5XdxPUoRVH1hFM/qw05ONEFhmm+vg0Ka3RunyFGf9geBI
	 NltrUsIBS0UKaU0s83tETBwghaqqmYKf5DQwdIVRca/JTM2ocsw3a349Krk4svcFpfofs
	 Q5ZEQ8AkeTlghamrsBkIOtUyc8xcZVSbiypZMz6PiSBdGzZq5ZnMX1bAb5OQkbfytqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pes12NKS0tI+mBjGB4uzkSw7aXCCdr+4kcm/2Vd10bg=;
	b=Ajgu2pMTxjE3pCBl4BH++IY0wCfDOPcF/GdtywnKZVSDdVtLmsGJjGODo7N3HpqCER0g
	 UVcNrKZhLn6eJ89ERZy9vqkxAAc5sZ8ufsxmWrPzj8hZME+e0Dr1+Uv1HoJnq8ISqvZcu
	 w0LQvI33XNla0I16ma+TXaETvye7MLV6AMgQY0a0pg2QDtcGON0afGe3n3+CSS0LWrBu1
	 xZvc4tHTw7i0yIYAFPe3d/b4vTQbn7ddVNO2QCtNPyifLg3lHTIXTsgqSrQTBa7DBaUKq
	 Qf1faXyGwYcCw9KzPgQugfKNOnSf0s5NWEr+7dGpipRHXQeCTt6zZbqLHyytML4Up8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k2jrqmlh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF260606A32C
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF260606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k2jrqmlh
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ab395abf79so15680437b3.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 03:27:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664823; cv=none;
        d=google.com; s=arc-20260327;
        b=CAFZDBkYSYlsBR1oMy7h1g+yamKTMkqqk0sFIBh3XH/jgQ/iCsRy5NiltjC+dKuJLZ
         Cn9drhe8+sK3CYOzTDZxWKul8G6i7xn2ahPINYvEhf9R+FXrY7CSxDet1TP/+GivNXY5
         KLbgyKZGFcd25zoE1Bb3kf/8v1eZHaNw9fpnUt7ChchBl410FusQ8HRaFghAhRslRjCO
         zLFOMLJv1S10ps7+03i5pPzMexvlX+3C5uDnD0v6Dq2+4qoXwI3cxc8lNxeiS7ow6fax
         tdv0zGmxTqKOXVWjCQZBa+OnbQ2YcQe6tMuSfWsG9k5a1f74hXBAalf+jazDZxN/y0M9
         e0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pes12NKS0tI+mBjGB4uzkSw7aXCCdr+4kcm/2Vd10bg=;
        fh=xct+iGG4b1LwuXoxK5VB4+y71YE7hTgcJFCPJmdmGL8=;
        b=B8JeLXOP9f2W0UkJEU4VGR/Qj96psAp15w2MqDsnGfzjhVfTkEDNQ/VjYzINZCmcEh
         jk8BAJwx8MV6AMgwvTI/yEVXp0yqBGBeoRa8gBQDfSQZNAWFVGt1KaP0z3EfqZkufj/z
         8940qFGcMf9iKz0pk+VWiVTRglccuBAsdL4T1fpBsI/LX+qAakQrnKR0kTFKcL0yLs+3
         QSgHzmvJAQehc8CK6zvrxLCsAMnLcyLtNJBk7HuVYPPqw9BJ9ox3xJ9XoH4Av3JwakQ+
         HyHh8UiXr7kILZIHfS6l3MHu0w1fmT6891gWkcsldn+nwR+WKBQEglugc+HovLYxQhv0
         CVJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664823; x=1793269623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pes12NKS0tI+mBjGB4uzkSw7aXCCdr+4kcm/2Vd10bg=;
        b=k2jrqmlhcFF4uQ3oi+mWwJw6LfG3vIH0FWwBwEHqOzjJuSvJ1Qyi0JLrvcermqL48G
         aB+EuSmN0XVbiUjE6QIrHYtWGbhsKSVDdUWYvZqdPzdi1DBcDTwArxGRkFOPQ6RMs8hw
         6QRG/obzlIwop9N71ckOwQOqNVqW7Vg3XD0sD4fZscZrCmm0XsbmbieoD0aqWaRBc6Fc
         OdPlPsW2JQ90h9f7c2njiipT+4CwZluwe4fDM8AaPFw3R3hrMe5kjpzOJOZ1bHGxCJka
         ideQfm7S6gjveWk1XmI1QX6gV8eb9FOlpccGuRRFX+Dh/K5aEW8/c7TDuWXR9TnbvwI+
         Ztrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664823; x=1793269623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pes12NKS0tI+mBjGB4uzkSw7aXCCdr+4kcm/2Vd10bg=;
        b=zVptnURZg6g3k9gXl9CqUgInJhWaN1T6hGLtsH/T8sAYSRRjQ/0opHJ5UpmwGDdKo7
         7M2idGtFZi4YTfIADa/JvZhakp3GYEjVodV/U6Kb9BEi/aem1yxsHHnAtJG23u/DUX7X
         ah+1MZAwFNdi6/A+lmW8Cea4AylrZ/bRESZnACnzEFoWlt76OMOD+GOrxd0+O2QRZKpu
         VHUsONQLIo09prGY18+nMyY0zcMI4KUAGNKVlSSGK/j5U46uWWnCxGKlWtYWJL1+/IyQ
         4zFRRs7R07OBZ5tzN/QpBaht8dgEawvJsy4+0fC9vQL1iiy5KeNt54BNTTbhKgIV5cjB
         U+Bw==
X-Gm-Message-State: AFq9FYJhkSbDNNDEX0qKVglmJQL+r/fsbR84jCGjcciHGGDwIVFce5WN
	ra1z0S5Kq9unQHwkzoc43KNPZLV1Mr1mu1qSuwC8IYVq5OKb9GKUhkOP5MaYl5wy8YxawIa7e1I
	BEHwKrZnBvzZkdxBwJ3Sde83bCPPI8Bs=
X-Gm-Gg: AYBFou3jt6GpWzir3vKBGutFsTBKlF5Bnu2w8s8v1RoUtsBp1oKBlC9aahX0pfl55L2
	6iVms34+0LOEO/W1uLIvZCHNytMmgq5lRUB1TWZXFF6bP2cTswPsXBrl9N2HljNDGmfQyjeklGm
	XaZqBcrBMCVo4t4309xyQm0MyvGn8GfFfuYXYtGtyA4Zg3DEy40Cxo4OmQV0s7cJfVg+b706D0+
	OqfyUT6bB3Mhp46yFqQxzDX2w51AJ0LAlCavblc7fKtf7PtXEwM/D14SyKpuCbSnbJ1lQNnTx5e
	XsMpg64k5GzWjHlWyFG9NorddlBBqYtqYxrS6cK0CYiJb05Y7FwXizlJiFsBSawNCut3oHnodEU
	sc0dyrzC0vi5oFF9rhc2u4zQVcU+Ysmazl8pFqwA1vbwhWOS5WOjErwNA7UwlmuzotIVgUTsa0t
	IVsEZfCMHihVxse93FiHyC+e+1d5HKcDI5uF1VeCXbUUZlYcYW7znD5I46K1YSe5doOAWh3NdQY
	0idTaFiacQhtf1gFW03QA==
X-Received: by 2002:a05:690c:660c:b0:8a8:6fac:21af with SMTP id
 00721157ae682-8b133c99130mr32686547b3.12.1792664822609; Thu, 22 Oct 2026
 03:27:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com> <CAPSxiM9fCTEoQDv09fX_NZCcLRXYaaCdWXPxDT7JZ+LCwT1YQA@mail.gmail.com>
In-Reply-To: <CAPSxiM9fCTEoQDv09fX_NZCcLRXYaaCdWXPxDT7JZ+LCwT1YQA@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Thu, 22 Oct 2026 11:26:51 +0100
X-Gm-Features: AclHuK8-t6UxJw4owzIm1PTy4LYRU6W5XNrRp6aoJmxy-V7H405oZg3eZteok0s
Message-ID: <CAFpMFfDhbadSn9gzQmfL02Qk_GKDzCCZKsmt_p6YPoGGHhrjjw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] checkout: use repository parameter in unique_tracking_name
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 10:41=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> > Pass the repository to unique_tracking_name() and through
> > tracking_name_data. Callers pass the_repository for now.
> You could be more descriptive more about the patches, someone should be a=
ble to
> go through the commit and sort get the whole idea of the patch, what
> was present,
> What changes and why ?

Thanks for the review. I will name unique_tracking_name() in the
message and explain what it used before, what changed, and why, so
the commit can be understood on its own. I will send v2 with the
updated message.
