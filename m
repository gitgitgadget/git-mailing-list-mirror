Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909837;
	b=veQf2LAVwYPOElAzGFIetpkMvco2J1K5QyiivPVcVf9NaU0vrXfkoVVYcaX0e3fr4yTm
	 XgV9g+lUPqmf3Y5gILZ3++FPeCIq28dVMNiOCBGCEj0nKt0mapvp16UHfoM5jSkhYp5f4
	 lD1Mnh8gweXna+BwbDmjibTtFSlccSHxEgumFe6qODBy+yXIDQGH4iLxwm5usp9ermXOZ
	 eqmz70CgfqzVQ6b7zUKdrNBi+Okz0ilqZCJn/hqBADXpmsSA+9fAgNHQyxLXsh/8NOdZT
	 r1m6adNs5LUh9+rTfa0u4LCksCXKywP4oX4cmPdN048Put2TZV8wG8z2s0qJ8Hoakyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:MIME-Version:X-Received:Reply-To:Message-ID:Date:
	 Subject:From:To:Content-Type;
	bh=r26yaOFbaH/u9tWXoPYop4CaRiitY3V3Qk70leIY7sI=;
	b=rlq9JxtcnNyaJqYDxzTMrU1YalNEgw1T0avGKITzVQqPxZaTibHtDnwpuhGVcHfaeyS3
	 y6SNcVJj2qROx9/ZAzEaBqcVaxvvDRxZEoQKNANXIETMxYR1ppzLJByqm1j8ZgktJrZdu
	 WkLVjHFokU0hsUmgm6JWs0iN0JkH1EBIXyqCOqvKwFqbrnOJvMDN7Hi+/8AJI2JSK9ZRk
	 +X80BKr9WGH2h6CGC7PGNmBUMaPm32NlvR6lKnUFUQP1wQcL05wz13T9pf6fvprpzxswA
	 rrtplLqrv7XaNP9XgKxb8ZITvoVRvZxxvL7KdNs1fm1HGGqMiT+scRuC3UI/B2oVejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBuWfrBP;
	arc=none smtp.remote-ip=209.85.128.198
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF89606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF89606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dBuWfrBP
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b30ffeb2f5so62499197b3.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794909836; x=1795514636; darn=vger.kernel.org;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r26yaOFbaH/u9tWXoPYop4CaRiitY3V3Qk70leIY7sI=;
        b=dBuWfrBPSnuzeR8/Blu+V/S9riHrI/H0d9oMxaIalj27xEtGtSuE1moU26x8sUm/FS
         rF8kmiSrFBCqRnJJ1BJfnc1/ArCYWy4dU4XYvjW+YxpRLku3MmP5GKnZUHj/juO1zpLd
         WrneHuifKS/TJgQ6+k0IscmP9YmP9h2ewz5iHA9lZErRZ2iI3dhJCkBoo/tJesHsqV72
         eAJrIbDQHjn+5oRtISTzjn8gEvN+z8JRsRZNEJeV+pG2pKc36ModvxJkM4hrJ+iz26kt
         3/ipgaeOlJyuaQ6hLMs/BcImS0Vr+AS/0PAgxhmKXRCNKYwVxkWonZ0kLjbAIhUKG1RW
         pBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794909836; x=1795514636;
        h=content-type:to:from:subject:date:message-id:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r26yaOFbaH/u9tWXoPYop4CaRiitY3V3Qk70leIY7sI=;
        b=rJ8idEn66zj2eQeJ5POu8eofmKJMDvRCz5ZR6OHcr5vWTlE0p/E8UCeHOXqWr1N8Me
         QQVCz9vK5kxSj1n61g5RssMAR/haVTgNPGFS9+U379VQba6JYUYHqQvCGRA7ZCIbboYU
         nPGONtLyks/wXuENHvwVwU3C1lcQOSytRlIpD9sguU/UQ9LWAEW+Krd+g+NPyoJXaOyi
         U6MvrBkYRuH1m67/z9Nosl/hZY8iBLDlQAguOx0C/Ypmha5lTGYxV56y3Bq6WMf9ZoEC
         ep/sxSEwzKFdKkmSYPyltu/d8i3nhvRRVrCYvXKSqFsNeAmMV5DcTUtMWeYMuMlZ8Idw
         H9hw==
X-Gm-Message-State: APuU4Z/v44tuv+FPjlRUpsVzmefW4Sra3vf2FljOlMvQ0dmhPcUkv8lc
	lgAr+CstIpvjHk6viWqDcIaw9FWQz5QS/ijz9zysrhOa9+/NsjXwC3Y2NEQBgz6KCARv25NJBdA
	dpUg=
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:690e:bc4:b0:67d:ae02:45fc with SMTP id
 956f58d0204a3-67dae025d9cmr3729417d50.45.1794909835919; Tue, 17 Nov 2026
 02:03:55 -0800 (PST)
Reply-To: editoricg@gmail.com
Message-ID: <autogen-java-72de0a4a-77fb-4512-9e6d-7b069f76981f@google.com>
Date: Tue, 17 Nov 2026 10:03:55 +0000
Subject: Could your research suit a Scopus journal?
From: researchvision067@gmail.com
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Dear Researcher,

Finding a suitable journal for interdisciplinary work can take time.

The International Conference on Geoinformatics welcomes quality manuscripts  
from diverse research backgrounds. The journal is Scopus approved and  
accepts multidisciplinary research across all subject areas.

Eligible authors may qualify for financial support towards publication  
costs.

Journal information: https://icoe-coast.org/

Would you be interested in reviewing the details?

Reply if you would prefer not to receive further correspondence.

Editorial Office
