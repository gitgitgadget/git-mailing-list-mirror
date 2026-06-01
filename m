Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A33191D0
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331193; cv=none; b=PCq29+TbrVKymo53NDEmohdjjvqa4YRTuE5EXnE/nAwHq8iYc0aERjEjGo2Mpa73MJ8JSoeDQJnV+2F+dcalhhIE9nfdFjO8KBkowhly0VkvY99gM9zrtJutRTYIPBw8QbBL/e1WbISTUtgqrF8OB7O5e0PalznF57UvB6y/ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331193; c=relaxed/simple;
	bh=qx5CWUnSaxZzHWQUQaRZTA7wkL0gLElf2XzkYaFSGAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=L23vE67tx+UP2png8y8P2fIDWz60U5E7ddstVnMeu7xSNQLJ0QzWR8tzpwfZvb+jsAE+rhWPpAJ/yqKNPwgaAFAwaTYVBicc21qkTZW+IrLOXIYVnOG7St8y57ITjVYlQWEan9nRWyvtZqejQAVOx+phqMSK3Nt/zsVMYOIyBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeYaOBJS; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeYaOBJS"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59b24523cbeso2052326e0c.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780331191; x=1780935991; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQDHLAEc8Z+TDhO39V+bR9xiS9Fe/MRVl4Te6E/qbT4=;
        b=qeYaOBJSZyJQfKjQpCQHZG3enC0zNplMNszEnRPACcBQQDDBQxB97bWXgT1/P6PAyg
         6KTvr5UESAOpNkw9K9Ph/EFegY6N5R1SuuFUeNhTL51nSkX04H6UOSGVmBP46xcsMLqz
         N+iDMSPmuyL7rifj521F2wml+Eh2cPp63Finr/QKG7J44H9hUpld0Uars+YRY9UYjBcZ
         4jOk56HPDTgw/sLtiyfjEqpUgdBz8f8l6TtB19h1MfYJ6Pg0dgxBG2kzPoWNFQZXrkXa
         ryM4T0DuZejT4eLTM4zuu1yq/sfnhNTFfQUIzQbgP+plKmP3YT/MYnLliPK+MAkYYIYQ
         nOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331191; x=1780935991;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jQDHLAEc8Z+TDhO39V+bR9xiS9Fe/MRVl4Te6E/qbT4=;
        b=rlFM9p374LF6KenBMyT4RIAgfW6/7t7OYKgM4tqmFvbeu1uBXC5uMkLnXGnIm5wbfa
         H6zGZFARgaB7h4WqfA+BG9JCDgHtzw7vEFTMLWjKZ3aYafqX4bwLsYo9ZLlrdyQAFW4j
         Qi0uz9YkW8GTLPNxWfEsbjDAa/78JarGwJVDxYBakDle2mbjFRFSlkV8gP3UdTc1GsRo
         7FKA75VUmwhStW6DFTAUPH6EYl8y0iS2llJA3imNCBB0FRpzXSEpnBM7VDP0LLweTaXK
         1L87ol9qzd3saK2xx+c1waWTxXdOcOFcS1ZT5w+DIIbsQgRCOMjZ4xarLh1/vSpQiuEU
         X/zQ==
X-Gm-Message-State: AOJu0YwjdZnODu8Xn1x3zJMn4yNeoWG8T1abVasqEC+A3Dc5QdCt7pA8
	2Yl3jpSP1dmOpf+tx82WcoUafTP25SpZ7dAYS2toU31bUmJSgYu7M+ST
X-Gm-Gg: Acq92OGu7Fmo7D4DX4bCmQTZTOw555jgKlxgvbB9bmmFmFlh9V44ZkyKH0PQ5ABWjPS
	7pqbEvCaA9dC92zD2De/gOdR1OpEQp2hZduGow8qSMJF8JQpjRnmaOBC/WLM4htDyAO7V6FEJqL
	ZKqZrb5hGIBT36OPXtsMKV48rIY5Wao0eP2xaZ/BZUkSQzev9Pabcb6Dvebn6y5IpzY0++qRvWz
	nnPyqgrvM2G1xQS7Rm4ev1Pw/n6+mu30ua9sNZbneJ2qiiy2UUmbfmND3x4J+mn6pDhPkd3hOPA
	YO1TaSjsEqQWZvZQGJEBvBg77wJwqvtWbm7gzSkfIFfbSiNIH/ejj8uhKXYArloPRJQ+CukD/M9
	H78Q/yA8qMJLIzPnhQ3wcEjhABgxJzDFPmaGoprV6zSbOQ5JPE2cqCL5KO8XGpe+6/1PVPmOi5S
	hV4UUPtaUuIC0Ou1oZvOGbXpDbkqWcemTF2vQZzPyHVEED66kiWUoO6Pkd486gpNNz0j3YPPvyr
	A==
X-Received: by 2002:a05:6122:514:b0:57f:a2f8:d2a with SMTP id 71dfb90a1353d-59bf57c28c6mr5921957e0c.11.1780331191385;
        Mon, 01 Jun 2026 09:26:31 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-59b7521675bsm7089233e0c.13.2026.06.01.09.26.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 09:26:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC][PATCH 0/4] teach git repo info to handle path keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 1 Jun 2026 13:25:16 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <289C2CFD-EE70-43E4-87D9-DA3393A572C6@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> 1. Should there still be a --path-format flag?

If you specify "absolute" and "relative" in the keys, it won't
make sense to use it.

> 2. Should we consider a default option?

Some pros and cons:

- Pro: some values make more sense to be in absolute or relative
  format
- Pro: it's boring to always add `.(relative|absolute)` to the
  paths
- Con: it will be perpetuating what git-rev-parse does, and we
  don't git-repo-info to be git-rev-parse with a different
  interface. It's our chance to learn with [1] for example.
- Con: the user will need if the value is relative or absolute

> 3. Is printing both absolute and relative in a single call
>   using --all acceptable?

If you're providing both keys, I think it's not only acceptable
but mandatory. `--all` should mean "all", not "all, but ...".

> I have discussed these changes with both Justin and Lucas
> internally. This series is presented to gather opinions from the
> wider community before moving forward.

I probably sent the same comments internally, but I'm sending
here to share my opinions with the rest of the community ;-)

[1] fac60b8925 (rev-parse: add option for absolute or relative path =
formatting, 2020-12-13)


