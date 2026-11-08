Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794140671;
	b=FD2rEuGuthnsbfXaoYjPTFyFz9zJAImC3nPYVvtxW9Hw9pf7rWssGQlmpYzhNkP7zRaR
	 S3wXtG/wSLvyGKAJ8W7xMgo9XWPfKPz325gDTr6wuigmptbbD92OCl+h8WOvAJkiaJrtQ
	 Mf0oM2MlrTO5xoKDC+MsFBY7k+z7aKekG3wIU/luVdv5J8sywU94cPxqJUE0VprPAWh5J
	 kj3lqTjE188Ms8RTdWvi8gu3HL3Ztcq/HH9aWmSXYx2Q4f4hLfSxpY1cCybt3qVmsXtcO
	 gXZgxOBEwr13E7ipClZFFk/iE3CQvL7gg5AJQfKhAELUlbQL6cruYfm1vqqj4ZdbBSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140671;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=WHsaIIZ0wRJ5vHgMcdDqMuNnGfvH8LvjgASKTGwjTiI=;
	b=c5lAXzEDm3cl3ux1JwEBgwQaBv200rQoFffVFD8uS026zmrBL1YkvWWfo5ot0Kfe951m
	 D39r7BXpj9r5OsSoJSjdOz+OqcC4ZV2kakkz1D5udhv3HFsNakeCuKVSVnzC4evJJDUrU
	 ne6EWLlHDpklSsFNeSWij0pKUw+CHAJCE/8iD1pXmEG3EqfhGepGYbm961x4EXeq/xvyN
	 Aocg8zxZCZ+vmUoasYXHwzcTC879Pc93jyHPtdOszTROEKWUbNQZJSa8JJtO8Sa9nhV6r
	 I/h35hbsRF4oaQYJu8kiORKvfpffNDUYGy+1Y8y4E0mN9DDEE5Id1KGdH5OXY2cCFuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=InWKwxZt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B7606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 12:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 088B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=InWKwxZt
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso8813666b.3
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 04:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794140669; cv=none;
        d=google.com; s=arc-20260327;
        b=VIwhKVNInzpCRWl/GQJmVwD5Rs00ExhR49YMoVkmk9Uduyw/OTCdqPeHy6viextegk
         l2laYSfcQj1qWYMTSW9aWBdZuDdcn1aJwi3qEsC6xyCQCjSXBii29MIXQIRP12ORK2Pq
         swb53P9YGKUDiSg+NPc5LxLjt52ykVUqwTOSsNoKkEKeK9F5YNXiBin7cCtaicQaA1zs
         1l+QMxBFblmqcBWS/DCufDaiIthZHldpv1zlX1G0xYzlpm0WcPawXP54BAT6K5+Socv+
         kFjOH7TmZDomMx2hJ73SOSt4fAoeXPXUr5yMI7u+rQHkaU+o5MLrZFOtOAMvf/PnuKSW
         +bzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WHsaIIZ0wRJ5vHgMcdDqMuNnGfvH8LvjgASKTGwjTiI=;
        fh=Y4zOlNf95AWy1cd6blHl8QAsDwGtqbVjyuDcQVf+YPs=;
        b=PfJoOc2J/Wmnq/f3YP4Z6L10yXgYvYr3H831cxZnBAAAPFSIZ60Fs9Upe2NvVRiLB2
         CqevaNMTwl2lHgOVCUAxf5ooi/xAVzE/lyBZxwI90juys77qrPkKb2dC3IOPL/bOe+PD
         TNZAknPxvaiyiCu7cIPJ60GuYfMSjsiHMmZqAUFvkOBprKl1aeYGJgt4x9/UQ8pf+R/R
         ULaiQ+L5ulhx2p+pvPv4zFUXehrvOu3DNPR+HE7PdOBU5CtjfyLjI53VjMVQNu4MZ9IO
         wlCsBwo0jnn6q333jt0DHdXDTFLFHOHaeV1BzyWxdi1NM0WDmG0DOGF6dyA2hpoL0a/i
         tNug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794140669; x=1794745469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHsaIIZ0wRJ5vHgMcdDqMuNnGfvH8LvjgASKTGwjTiI=;
        b=InWKwxZt6p1lSYNC2Tv6orUu4RVMLt1yTqy3mNAiXA5HNY8iGovoY2rAWUEAKnUmFd
         iQbxLB1JtJMOOXZdVZ6oHvMBVj+MTkuC3k2bhrKyxsY2lyA64JCP5WmfAph7VMeqFyH3
         tt4JTtAYBryCeAg7oLrnsUDPBlA3wkOvdOwtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794140669; x=1794745469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WHsaIIZ0wRJ5vHgMcdDqMuNnGfvH8LvjgASKTGwjTiI=;
        b=IAZxcyAmDNEj0SfZvirFmLhiho5NsgYD5prvpESwEVoTkXm6lV1bYg1TWd+CAJ9kl5
         OYjkB6rsgKnRtulFg/rBGxjbOWpPZzsXeuq7cWsxfgklhXI8zBQ4SAQKpfavw0WYj17h
         yqwPX1xr2i1OKlh2Pjw6lSMI8tffE71o+VhljNXOL0oSyH8NNZuWVVQaLiEa6AoN7GLG
         0IWTgfiwHO8kxvdBW6yJDZi/SOMR+j5r4vaFUMXMx7LuLrcvABmJhZhSzydkaQy3o2nn
         t8R7WEbPDLeXblDCRG1+3UyRDUUOco7XaS6efWxQUJ4I5cuaCcSf/lLneC5qEOf1Hcu2
         tYgw==
X-Forwarded-Encrypted: i=1; AL+hErGbKRibzTZI6hFYEUEh8I5wqZ/ZBlwnZkQT1uOpYvfcFPkfqX5jWeIQqN49oGCCpCxniPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SzJZvhi/4A0jX2eBaCcV8nvs798kQ2Q4bBzpLN80FD0cis7L7
	/6urL2scnL66PldyGNCa2SGXY1RsDCRC8BQVat8rYeH4p8rxY6Q0MeHhPvzjh5zcDo7/kNR9Ebg
	lnsdUExKJc4/GcWaumC/7KyCvNQ21y53H1X/esSmzpg==
X-Gm-Gg: AYBFou0crny3xZVPe/wPs5sw53GORDzf4eoyZD4/9jdwfWkZqz1FXVXZ0E8yP5Z7z0U
	FFfNP6OsNMG1fsb91wFn5kYj9Eu8c214o9ZhZdKLpXzgP0cKo9JuvwQm2P7WpwH0OjOq3mKj2Tb
	5Kpp/YYrePLOLrJe6wcLB7xGz+XESkPW9WY89R+ufSRV8XR3uTSHCwpVmqile9gmpNuMCEosYMT
	AfeWJgFtvz01ENPFTy96oVYVicDHfSyFuJp8fnmgCJ/rHpLMehBjR/KNmzZMdy8JbYQsdJ9nxVM
	gaDEB7wiE5G8hJBUZLfsXANZycfF8A19WRejdteJBL2IsL5mKzlMwwDSkuIcWFTVxb60owWHwhM
	5nlMZtoNhLDsxtHP+23UCD6DawwealQjt2Xd1g8s=
X-Received: by 2002:a17:906:f58c:b0:c41:26b8:c49d with SMTP id
 a640c23a62f3a-c4d6d59a1b5mr108939066b.38.1794140669372; Sun, 08 Nov 2026
 04:24:29 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org> <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
In-Reply-To: <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 13:24:16 +0100
X-Gm-Features: AclHuK97USqafm47MRn-UlgaNAE9d0Il-Qr_go_FnLMICI8Quf2BHdwwUz1qzPk
Message-ID: <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Johannes Sixt <j6t@kdbg.org>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 10:35, Johannes Sixt <j6t@kdbg.org> wrote:
>
> On the other hand, the only case you really care about is the one that
> takes an insane amount of time. If you convert only that case to printf,
> then we do not need all this churn in the first place.

That's a good point -- if we want to make a minimal fix, we could
simply switch t4205 to use printf instead of "genzeros | tr".

-       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
+       printf 000000000%02147483640d 0 >expect &&

I tried this out and it works on Linux but fails on macOS[1].  What
happens is that printf only outputs the nine literal zeros
("000000000") there, and silently ignores the very large padding.

[1] https://github.com/gitgitgadget/git/actions/runs/42475956442/job/128717309586

The setup and the next test still pass, since the latter compares
against the same file, and only the test expecting the exact size in
the error message notices.  So I do not think we can rely on printf
for this, and I still think that generalizing the existing helper is
a reasonable way forward.

I think even if printf _would_ have worked, the end state of having
a uniform way of creating this fake data is nicer than having three
separate ways:

  - genzeros when we only need NUL bytes
  - genzeros | tr for small inputs that need some other byte
  - printf for large inputs where "0" bytes are valid

(And if we ever need to support large inputs with a specific byte
value, we'd get stuck again, though anticipating such a need is
speculative.)

Thanks,
Kristofer
