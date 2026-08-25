Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C23CB8E2
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687088; cv=pass; b=TAXjwi+s6Xx+tv6HynV3Fa+i/29d0JkzFa9XKMCS30PFM7qi73J4nS9IuTjJ9BPdusudBQwTaW2/vFCvQLapvWKzebgzo8PxbWr/F0trNRIcZ1RxabSe2lEOMUT8ttEWU2E4iV1P3Jw2ybwrtcl4533CHAbmB1TIlDNT43Oz1cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687088; c=relaxed/simple;
	bh=SkVsjIHUwCiH5gHDv3AQsh50WmUYkzGL0adWq6AKq0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tS864YKkQcK7Wj3csU7MPbURbkGq0InK2fkf+DqNMYqkdiib3i7BzadVCfTP613shbpWZeoeurvKPVhPCz3n2TIS88uaqox4LvGEpRmncogOf0SJJhJlZNSvsoc/dDZNv/nT/tqOuiVsWeRQQY1PomdoPsgWLuBX1VnCGnLdVoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR8PhCgf; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR8PhCgf"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b28d9537bcso199516b6e.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787687086; cv=none;
        d=google.com; s=arc-20260327;
        b=YpIQipe8X2cQBGXEaBr8Kk0BXoxQn2uQQQrBWaos1slnhMcUdxU8vOEZs8XPBanpQ5
         9KTai9lMXxS4pYIm7Iqh77eEpjBVjp5OdHvveag+HlWNV+aRvaBkhr9TBP8mLlQYs2Zv
         MLXeKBgZneYPYFiTLJTc5gReNRCyK2MoBLCrFyNaAAzn2fBqCT14Gg5uykwrocReW6St
         NigZUsnSVsEig+1NUjvM2BwXLmbaMviOuC8x5AKIVQOCK15ZvYbpHtRHp7aU6CKaiRMZ
         LCIi/qSpn5mWnQqXcgTFbobliqnzk6pjgdXyYcKZxz5hkHyxJzfbfEgU2K+W+rMD7ZYc
         nAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cPqolBjDRCxxrCpkLZ7FRgcV1RRPDA0KJCpTkNhKog=;
        fh=+4VZ6tdlnaiSiUvxibrIWqeIRNRmZ6y4CAINKUCullM=;
        b=fjxPXsWQ9D2zjl1f7oAzqj03nPjPzJkv5zhgjLnQboO2t+9dmdx9c5yKNmLWiN+knz
         EBHnW/XickAk2WZmBIQFWyBWosFyHHOdGSLPaXdZVri1Oq9VQEZse9P2u3Cjxtra0BJZ
         jzKIet3VosrQEx3op8YeSro45XkqL9p+fKAwrO59USd6Nx+eF3r2xEfprNj7BxbiYspE
         VfyHqAfmx5xvHbltMDN6TfQcMBQHjxe9lSgycCj774lZX+v9wSBWYc5xeJPYVUCGTJUq
         yz4DkRU+ng0Nu7a8r6wShPFwJ3nEUqpA6ZlofooTc3lVf6PPzk08ORjChZUMMyw4EtXZ
         WjHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787687086; x=1788291886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cPqolBjDRCxxrCpkLZ7FRgcV1RRPDA0KJCpTkNhKog=;
        b=nR8PhCgfzjbOowAWyNXLM48UM/yiUeAtWVlcdI0wNLYTquPFHyKlXxQ7E9RkKg+pml
         tcxZ27Axbi5V2Tz6RRUQ/rLeSBnIhUayn5QNx/dKyZ64p8PbIyS/hhJuKK0T13nVcY5E
         wfvdtgUZs4NroZSOXa6r0Egw9zEFx3dPrm2HeasejBQ84gjWfofk7E/4nbBFwCD1eHka
         zVn+187AUO4JmTGStSfRiLTJBBI9Ro6hbDdhAEFXj8IiIsqY4BrQK1garEDmtrn1zDwC
         73n4ByLXV65E53QWeRvDhGLz6nmExppH7y8ELXZrOOKt58sEE6fb7mvTyUkoQkRrAi39
         eu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787687086; x=1788291886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cPqolBjDRCxxrCpkLZ7FRgcV1RRPDA0KJCpTkNhKog=;
        b=B2SRebE468LDuJq/GEg72WDNJU/7U3sNQGXrFNBvU/Fmal5gMThRQsAr75EqaQeKK9
         ZWgQZrerFOyuU2cLy2pOzdr01C3RMoxTlR6Eu+jTQVcchIlGg5U0QuF8i+9dZDXFgXM1
         YfLvOTIDMINcpPzELibC7gvYz4l47cp1wnNlxN0gS3KcvuJRWA6lKZnQ8QAYTTAG18sb
         OdhP096mnaHN/82kKiCJuZ+ZBU8tuMkkzXIdQBcXbNADENP7Cv/zxrC5OscFviXBPsUh
         5I5SKkqlvVFljHUX4J5SOmseaoIL+eGahQ1GIppxg8+vm8NhQMuWWwdqAKyJ02DlGFb+
         pE1w==
X-Gm-Message-State: AFuF++mDViHQlZFwiqKmo6fTkVqUQK2NcdVjzlrsCC9PtjKPkvhY4nL4
	7wkSFii6gKDPCNHsTSWHeydMKwqImbUtVOmoSqZNoqRiqQYxqKqBc8nTGOkcPwTXV7lESHYMjBj
	bnlWUxUSimr/Mxp9M3PVM01MtYoR0m7JYMjMo
X-Gm-Gg: AR+sD12u7WsYSDhk6V0Lc4fylLDxIV1XfzcN+P7rl9QeFItLbQgglfeeh7J/kBz+DNf
	Den59IaOe3gunPM2/FwXPjZdZXr8sPdL22g+gIQ4qzX89i0B/gG7O+4hJd4fl12ijAT9KmOK+0G
	3lG6BiagOPCj5gREm7UMQxBK4HKpsCdNeWLgItnOSnW9oYf/eo4jJ8578a04eM+jTcOUgqZVgsf
	NrJeNQ2Qj5fnHneY0aHSNNa00wN8madghN4l5vW6Pq7KTaytARY8XofIHrfk6dUbac/2PCq8eAq
	hVStTLEHyPpDmLzBLImLvKjoAJU9R4+7hn2VmFgHKszYQ21M2hUSJU05Ro3h0tUzONn2dGXEDkR
	hvRo4ccK+ZyYCoQvDsQBc89G+EqW6s9fCDYHi7IbJadgN9mmhI5zvQtbqIMlP
X-Received: by 2002:a05:6808:4f07:b0:4b2:6691:b019 with SMTP id
 5614622812f47-4b3501fe004mr7096264b6e.3.1787687086122; Tue, 25 Aug 2026
 12:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729233215.398654-1-sandals@crustytoothpaste.net> <20260729233215.398654-6-sandals@crustytoothpaste.net>
In-Reply-To: <20260729233215.398654-6-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 12:44:34 -0700
X-Gm-Features: AcwNN1UJXjRjh3g8G_l3r8V3xMUfryJ8E7KlvHBhWLqKmBxDABpZVJY7KVbnatQ
Message-ID: <CABPp-BFDaWdahoOnNRGQjshzQXin1YLuROv94W_PrajnLWDAuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] object-name: use hexval
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:33=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We've open-coded a different implementation of parsing hex values here
> when we already have a perfectly good one in hexval.  This
> implementation will almost certainly be slower because it isn't
> table-driven, unlike the other one, and since it's not constant time it
> has no other advantages either.  To tidy things up and prepare for
> future work, switch to hexval in this case.

As Junio noted, you may want to call out that your replacement drops
the case-normalization that the former parse_oid_prefix() provided.

[...]
> -               unsigned char val;
[...]
> +               int val =3D hexval(c, HEX_KIND_OID);
> +
> +               if (val < 0)
>                         return -1;
[...]
>                if (oid_out) {
>                        if (!(i & 1))
>                                val <<=3D 4;
>                        oid_out->hash[i >> 1] |=3D val;

hexval returns unsigned int.  Is there a risk that someone "tries to
fix" that discrepancy by changing val to unsigned int here,
inadvertently causing the `if` immediately below to become dead code?

In patch 1, in hex2chr, you used a (val & ~0xf) check together with an
unsigned int val; would that make sense here, or is that overkill?
