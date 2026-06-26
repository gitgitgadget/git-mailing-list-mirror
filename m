Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CD248881
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492252; cv=pass; b=OtnSvvF709n5fnS4da03OacsC5Cpf3rB37DauFv0os0Xvq+JqayvIcM3LCyT7lmnTnjA8rCz8P2WRpA1OmT07eHuDckb081pJj6N4pWmCKGwhPoWiVdk6yJXAf+2iwvcB/lIaGX5Y2d807DpbIpkmfCezwN1P52fVdxrkBuQDsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492252; c=relaxed/simple;
	bh=HUQvXIgjBAMAI/iJVME8damu1cOyW+mt3gxVl/bEyGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEkTPc6hz4Me+Mu/AxQ7PYSTGMUCRslEw14fC0KgJcAIA+4mkWI+vDS5QLL/6NUMflVRcSSLuf6RTj79Ggzfq1treth8JEOk3QaWQpAnucACIt+pLb1k7Bm1lOfgNRZAtKPPGYc9UHxIp8BBB82WaqPWr+5k8BLKJQR56gzPpAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Iayp8hJw; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Iayp8hJw"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66388bf3793so1277156d50.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 09:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492250; cv=none;
        d=google.com; s=arc-20260327;
        b=VunS0Z/I9ELT+ryxFJuJWHzObAdOfvkOCnCC0QwPs+pBpnfqUTrIT8gOgM3pslNoJg
         gWYRLkb1mgW3aNwZV4Ze8evJJ4UE2fXSlGKdix/PY5uMRgGE5tCr6xbOjqUbI3GrqLQt
         AL2uXrdjxLRb+kG+5B/R6FQb8Ovk3SJX2Llx5OyjlBHj2s382h45DmqVAX45TrU+lqrh
         nzlPvZqWTf2qkE/pxbHAv41HdGvtSSF6tG1S4iTub4hvrtqEvOaQ/0ojfVQmNDh2IZgF
         Gi+Rdqk4FYq9eV2KMV3nEd3gLXtrLGGYJ/xkOGHI5gucACsHLmrNAHLElfzofSiWWba0
         L8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yAK+eO3eYfBkXgIIJErUto6N7U5r6Icwzjv4ZNhW21s=;
        fh=ALU3uiAvoAJ5oCSd2HdFg6Gu0CbRV6NITCJM3W+Pc6k=;
        b=GiOh+nLqgq9Az2zt1ERMZiactbZrWchlk1mO/SLwpcA8TDWI9D8HHx09dHGZLdkiX/
         J1nXmQpd2cjZYCtttrH4vM9G2zfQH4BAQySdvf4pGcXcMDWcW9/kyg24spr17o281mXO
         gmKFOpId5JuRceh0+uXUJ2xlGjdO9XRCiEkLxXt5rz1GbWV/pqOGjatxrSZbo9i+tmUG
         cPEnfQMth+lz7dotT/c0DiLNGYZIE9TAUdiJ3rMk/ahcDIGOBj8m5LAcJZmD7PMMhAMy
         mfw3bTMUOXsWUjvQmDEasI+QIFcJcWOwp5TiLOpCd7m4Ge73kXaoGfYD/EnPgQyn3Ue+
         3jvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782492250; x=1783097050; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAK+eO3eYfBkXgIIJErUto6N7U5r6Icwzjv4ZNhW21s=;
        b=Iayp8hJwfBf+zBpl5+7N/WbQH8BNMyjOoCS8gOMF9Q6vW1aI04nHJAntGyqqAKJYb5
         YlplwGLR7muO4Ymk/HiaajO4jSylvPStj9xjtRVn8ddwkJeN4unj2wEo6fhUgnnhq5+O
         YlitUd/D+EgOtQa0t2sBMa/gQLEiCMG5hSdvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492250; x=1783097050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAK+eO3eYfBkXgIIJErUto6N7U5r6Icwzjv4ZNhW21s=;
        b=qgjCtwzcv8XLFbyZYoWyTIZCFY31A8ksIZUokT0vF08A98SG+zRFL6kiIcgMJiz15G
         yxmvIV8gB+Ns9x8STgEDbB8iSFwFqRxh+MA9XyBV0Xw34A36YWQc9z4v9o0p2ZK8kD99
         2GzQ/TSfjzVXQk+4ek3GIz7DJScEpUezwVFuwNfnkfxOKQhiSkCvvtnTF8AiwTzxc7Ap
         p9LCXx8nRfS5XIIGMKiZpPYgsAoodyCawTYFMFOjNuYptUKQ2UXNWDMnqyNs4Hp3JW/v
         0AmXOG8Fx3RRRaivqwezolLIz/xmsGImDJz/Qsbv7R/Yi3bRb62P6+G/EP4JFu1/+mzx
         PoIw==
X-Forwarded-Encrypted: i=1; AHgh+RqL10RKV5O9rhpmB3dF68EwV4o8dnKT6f0MtlWIHoOCs9nqgAoAj5daChs2rMikAWm4FIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpomtzkSDSwRkNOG6OZeOHPVfbZKd1QL5ev7EX2Jg+kguM+Ze
	/qMweSk6DSpFvzlfvQXaukUUe3xH/TyUQ6ipOiqwUIZuCNL2X38Ic6fcxC6VbSZe3zojqnIt7rY
	bymMfT1UFznOYqu6odq1vl5PM45m5JkyBLXNh9Sytug==
X-Gm-Gg: AfdE7cksDH63lsi3kBUdjLOrqm2lchNIKfgUzO1JcsdFcdasDN1pbI5vp5Y1tReNdgc
	epEZCLGy2cOVYuUDvkbLgaxyhe53pLEDX8s86gi5px6h63RyV4NZAb8W6LSHOxz6GUzLDBHhXpP
	BNNfzuRH6vNbnsc7GoqjQ30kSi9IFkdcahcXMweMGfnFqpX4iNmOxNUW5k+YetqfOrRo2nbth/G
	HTFoiqCAnPdWpv9XH7HakBS48o6jsPCTPQRPxyGdZgug81A510wLEOqVhU+YAg614wNq/IOkQ==
X-Received: by 2002:a05:690e:124d:b0:662:e26f:cd10 with SMTP id
 956f58d0204a3-66487dce322mr6072135d50.51.1782492249768; Fri, 26 Jun 2026
 09:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <xmqqjyrl8di0.fsf@gitster.g>
In-Reply-To: <xmqqjyrl8di0.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 18:43:58 +0200
X-Gm-Features: AVVi8CflZHoCEWFpGoP8AaaPDEsENDZmbROU-QwJOg52xA6jcGsqXyjZbInyyGk
Message-ID: <CAL71e4OT0brcmbNXBzKpZuxTh3=R0j+zgxWmV4S-weT3q=vpvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 18:36, Junio C Hamano <gitster@pobox.com> wrote:
>
> I am getting this failure standalone, when applied on the same base
> as where v2 was applied earlier.  For now I'll eject it from 'seen'.
>

Yes, I am sorry about that. I submitted it after having missed running t6600
and accidentally having introduced a bug. I tried to self-report it to avoid
wasting your time, but I only did so in the relevant v3 patch and
not this main message.

I will be more careful for v4 (and onwards)

Thanks,
Kristofer
