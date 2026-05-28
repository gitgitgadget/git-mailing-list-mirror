Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C44366072
	for <git@vger.kernel.org>; Thu, 28 May 2026 08:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956098; cv=pass; b=doPSHcdQLrj92ft6iHVg6ToeTCm/qX7t/hn2RG3rBxm4OI1TjPL+iwbeLKU0sERIyRckTOw5rjM6VZgIAZBqaN2aDRNGOambt5GuL7y9gnZweunH9VLjqGYrcE2Py2To3Cxlcgf70pXDhDQjzQ/Ujuu8LHE+rSKT80zroWpAiLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956098; c=relaxed/simple;
	bh=cZVnWLb4f2HpkbsKMSi4ZGMPBJGTVcqpMkyK5PDifMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ub89YaZgQndo6hDQ18dbo5m+4q5Qd8RWbk9ouSC/sz/dQGHGCdXwrlL73pGXlou+tnFCFVMysOugK6dmsF8108bxapK0rJq5MFfkH40pxm8+z3vGtnsG6JeJBF+jWFSZMBBaCR48ltbpSrPBsRONvA/dc57w6l1gn7vdrku5Fac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8VB258G; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8VB258G"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68abd694c1fso1063825a12.2
        for <git@vger.kernel.org>; Thu, 28 May 2026 01:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779956095; cv=none;
        d=google.com; s=arc-20240605;
        b=f7F8pcf43Pzjcn0D0MItrX+waZdqiNAKed8RTief3yhKGXPQtZupnuS6IbwflBHKHc
         z0MiMjAHvITFqFh2eCegBuKMZuUWxRvh/n4u3Af+HysvvmO6QVKTdS3AEQIylfx0R/TU
         smaPEg3y5sNYWL7bURIQPGRMTwWskQLUDclx7BNOgZcanTyqWm6PYEKU6OoN0xlcDA4i
         7rWy9Yp2trI48NYj6SFN/4ngkMCmgpMWfz6P7FzBBaZNKdL0bTt9MVVK6Uzeor+owiy+
         3QXjsyEKuYuNkBdxLZzIptE1yw9vk7RodrLFCajiJid3nCL8/xCd4whs7eg84vFlVcCJ
         QhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dyk9ubzC1jo/J3Wpmii2lwlOmguh7D/B11gFqLU8yoM=;
        fh=ouPrBrWwm4N5POGwdJPNRkNGFZpP50DNWYdvtwo8LTY=;
        b=RaH4UVPXbYyV3VWvvM3WzNNSIHsMu3780loniqdNzA0MPndfOZYu6EF/nf5VqfJUSH
         AnHtedQEz1gOqhtJhJBeWrRMKq1UG5A+K5E9sPSXG7sf5Lo5vEufsnDrawbH0HjWRMpj
         ufEhajtJCQFtZt0E+CEKUKXpT/ZbECmK/7qzFMF0e3xeVadF9H2C8pEU4Gi+A9i5JdQJ
         ipp01RCFDBMoa7XNyHqfdBlqFkHCfXR5dbHedFrX6RVJkFKnaIMcLy1spZ6bBxaAazfp
         req70Y1OqOyTtHZZhm7G+UyeNn0WGe/CdT+SF5iFfJHRKc2RDWAEM/iJYjTA4bML2lAs
         4thg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779956095; x=1780560895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyk9ubzC1jo/J3Wpmii2lwlOmguh7D/B11gFqLU8yoM=;
        b=J8VB258Gf8QBOmLa+gW7fHX0JJY/IUo2+Kr/2W2jz/qLtBOv/6Uo4fc4poR+8H8blO
         COhe0pOMthBjt8tju9JCNycK5nPv79ia41EySJ7bZguNZjP4pVS2eOYZWVv7bb6n0uYO
         zrzGiLsNAt924Op3sy8rZoqQhYxTsRdzEp52IsJ1KCqa1FY5ra0Kk8oQ4Pa5cXj2bCkg
         /2uOxrVjAwA6BTwrxvph6wjxMrg/oTFW1OW+C6E76NaFNcNW4D3BxHdkORY6HMjVWlKS
         yBOOcTCGk8LMVlNMuczGNGt5Wvl9J5oYSyCrlAO4b10IjBIBQVa3LdVzM8XePo7C2QFx
         hJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779956095; x=1780560895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dyk9ubzC1jo/J3Wpmii2lwlOmguh7D/B11gFqLU8yoM=;
        b=i7k3iNUlLxIRICIWjrbJtyNLIM9xrwmnZpjQd6L/HX+k/ys9xibjajeE5N30QXg2pn
         0nmRH6WnCEWbO/ahm6HWOub/XostBK4X1lAUV0PhiGEWUTKkVdZEDr+zQAzFlhqyULuo
         849zTFcV2X2wWKyMmLnJ1ogzHwbxYZiAduQRbIgo3mF7S7h8bi7cqb+wJ4wpn5C/1A0X
         Jc6rH2L69DUnvuF5CEnmUgz9w46UAucmGzDdVHiXaNubHThbR73NmZDgtoRcQrrwvjJc
         Wn4wOGpInvTVHQ6aiKVrXBhhCB5Z1ooCCRO++5RmQ6EDrEoimbzbeq4oMJ9nBsFbXnIg
         8kiA==
X-Forwarded-Encrypted: i=1; AFNElJ8QYIUAkgh1C246svBO67GVczeJ87JsgoaRAv45UpIudMur3vMpLY+DeSk47Z43OT/z2lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhNnUwsT/xU9ff+1C4E7+znqjV8l9Jg7GdQtZn6M/AaN1GD6j
	9DpjMkTlaHbXay/o2Or6RD0k1C/50exQvm+efitxMFlBDcXyMnOAMlJwdFJlwCC0Y0mZ4w8unsw
	3KyNqvDCJfRJDsKjN7TbEZqgiG+XVp2c=
X-Gm-Gg: Acq92OGlQ8Tq03Dvjz4RT26F8IEC30Wk1msF9EszgYDKKc6aHj+xST81GTJYZllb2aS
	wOJZYURmF+8LfJevu/8xYecDFvfoLrv8HnkOQIqPi40yR/QGFw5sCGdnkVYBxr7A8b1qUT1mq+6
	hCayb/XLpvNGfyq63T3TyfCgi8UEIAUawd+M5yWpzyukJqWIqFnfYcsZZo6Mq9yqTJTZ9lVsOBc
	WKO9Rw9PwJrtldtekSlbibDTDN2CSj/zRoUd7pmBPrPPOPJPGuKkHZC8sHdW42UFM2iFI2p06Rr
	/rQU2l0B9MyCs2hC/A==
X-Received: by 2002:a17:907:94c5:b0:bce:259:3d64 with SMTP id
 a640c23a62f3a-bdd262d11a7mr1540518166b.37.1779956095149; Thu, 28 May 2026
 01:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
 <xmqqse7cjku5.fsf@gitster.g> <CAHwyqnWjHTpWfbMcBHOabny5NQN7xTZmxew2yDWWu3AoosngWA@mail.gmail.com>
In-Reply-To: <CAHwyqnWjHTpWfbMcBHOabny5NQN7xTZmxew2yDWWu3AoosngWA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 28 May 2026 10:14:15 +0200
X-Gm-Features: AVHnY4JghVEO98GNUbE5GEGKNiTDHjKfCqbyb5linD5Lgv4fon5aD3jgw2zNB8o
Message-ID: <CAHwyqnXgxnDNiq0UWyAsz6CHvroYPZ36EGbaUn=-OmP6w3gsWw@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: initialize packet_buffer to avoid macOS linker warning
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So maybe we can do something like this then?

```
+       # Silence Xcode 16.3+ linker warning about __DATA,__common alignmen=
t.
+       LD_MAJOR_VERSION =3D $(shell ld -v 2>&1 | sed -n
's/.*PROJECT:ld-\([0-9]*\).*/\1/p')
+        ifeq ($(shell test "$(LD_MAJOR_VERSION)" -ge 1167 && echo 1),1)
+               BASIC_CFLAGS +=3D -fno-common
+        endif
```

Harald

On Thu, May 28, 2026 at 9:40=E2=80=AFAM Harald Nordgren
<haraldnordgren@gmail.com> wrote:
>
> > According to Internet, Xcode 16.3 or newer introduced this insanity,
> > it seems.  How about adding -fno-common to your CFLAGS?  If it
> > solves the issue, then we can think about teaching config.mak.uname
> > to detect macOS with problematic versions of compilers and add the
> > flag as workaround.
>
> Yes, this works:
>
> ```
> make -s CFLAGS_APPEND=3D"-fno-common"
> ```
>
>
> Harald
