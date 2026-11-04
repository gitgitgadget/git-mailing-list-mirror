Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813684;
	b=N9afSTn09JobjemAKA8rOAYoGyvkWF1DDnlgi/EOhpzBQFI563E+ieA09uERUYFsjsz6
	 JfYqOB1iSlMKlrhAX7OMfoWKHaWhSGcsjckz7pEv7tx+ykxAmqO5Z8rs+svWZFdx+7yUV
	 ijvj4HamsJRu2Degg85XLy40m6xAH1Ln13n+jfJx8YJjlqZUmN+hHtd3qYy7o/RVWnKHW
	 xo27asQsCw6obs+/ddpKOzugbT0K6evQ1FaFcln/HBuz7gppzbwYiWGL0uT8018JcaKbe
	 6ifARIg0H8v82bCcjSlDJARMTBRGtBVLBCCeLL/dRe+TgCSREOtRvQx/Fmjr4G+lCIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813684;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zkLZ0ePoRixEUuUPmsiqRi79gAv9EREAaFFpgzToE6c=;
	b=uP9oM8PEoTVjk0D43sNjjm2KNkY89vK/v8C14dgHeSolOGwa0QcmiuzwaivB2+js2wWe
	 3592bMGIle95LU6f2cQ1/Cl1Sw+Yxj7F6rVtvwt5CnN5W0Qk+pIW/B1pnNQG6xi1wzd/5
	 XH0wlwIQW5Y/cHe3Q/cp26Ob2FvT2J8QmH6yR7/ne3kiYx+UVU0LMmMXsVGUfRYri2yA0
	 0OwPiGV3Cemdh6jBmPTT3UBK6tFLK5+Hr8PlnKn03vJfCmISA/L6dBFDQ/FPKnqijK/VV
	 t12i8gdNwV46TR0qu7sgp7cnGl1H/sPGaOguc9shI5gOPEw7YhBuWSpJrUuGBMfna3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j5ulKsz3;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C0606A32D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 755C0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j5ulKsz3
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-18818daa3e7so339115c88.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813683; x=1794418483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkLZ0ePoRixEUuUPmsiqRi79gAv9EREAaFFpgzToE6c=;
        b=j5ulKsz3eWkFBw2+IyLTHtuCogOftXkP8+I4UVtAW2CNX7RosEyS0SbgCowMQb5OUY
         frocpVAKXiHtWAnIVakSumtzMqsQIZ51zHyDT+3ZNyqdjojdiLuOGx+MGbeak24RfqmB
         r4bvYt59UiKyKzgqGlK3sE1bjZqOZe3tMnRapBszkUPjhFSWqcdmNbP+4vGVvzbPuPCk
         u6WyIl3D3FvmVrEUk1j3/gDim5Q3NSvyU3ZkiQ6GicGLF+J4KltqS3XxgdWWpm34Iw18
         h7wYgEgOOpGj3wnugXhY0FtmKbuMoeEcRyv4VIoCKgcWBMiqp7qjzePkpc0E8UguI31o
         QjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813683; x=1794418483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkLZ0ePoRixEUuUPmsiqRi79gAv9EREAaFFpgzToE6c=;
        b=CbECXXBRXoOdr8nrjmRMInQxGiYfTVbnt+jjnPQadBb/16mX9ZImWMXaRMbdgFsatK
         csQ7l94Q3WEw0Bl5CkpJgsmbmzHhZAOBG/WvDbP3xAk0nCdDzDz8x090OU+U1v3yS1vt
         DJvJxO8V20eZ+yUIdyPMqy5kTrSRTbIP4tJg3O5D46chAc7sNZDE9sbgimEouVrzpVtt
         iB4JmmRBExGo0i63OVArUB0gD6oOq0jVsQgPNsonwMM7dkQqtxvJnv3qvVGe4oavc0Em
         Bt/fFORdEHDa14Eua1zBe+q4SuuG9qhIiGuaArk68dlf1mZK/toDwT57dTSLHm1KMcW/
         26lA==
X-Gm-Message-State: APuU4Z/j+kXEV7CCpBl1jxKwAivQFs6S158ulbiRMJeCYq0qwT4V0GPW
	Cw0bX9CRwyTad6NI29Kyven4r/CkrSbllWCECzLKimxxnwdNGFTnp8uDqd12Yw==
X-Gm-Gg: AYBFou3LVczTlzG3HvmPzBtSN2LGEmWxEYCh3e/qODv1R2whRYPr0D9XfaI13s/0etd
	aR8u1jLfyYJQUd1hUUe7VlNAWGbtj9xGCczUX25DsRsbYACrz/Pnf86s5WAnba3qLyT+Q+wyBdA
	9mx3lk7HeCj8R+x1emMw3pHX3LcYLlbhEjq8RqrTbSe5D9b0P5jXxzYBkHhKfPPQ3kmxGWieHth
	yVVnxBpqwj0UyKSN7anzszIGJ1OU2LlankAb9GgjuMvHHvPiorUu1gHB8Npl8xcGMEedYbQQFBC
	nbFq62WyrNHgiTbx9QsPhjxf5C9MHRQUTGpqX5WXqoKJl2TkstjvU5CErfm3Zm4gv7PB0GrFupR
	rb9/Hu/IS0xBhC42qOV94BV1smJFQYJxuptcmUlboyblUW0StVjud1oDmAAbhTE0NOddbY0Vn7o
	f+I+h/lcXHDj58FHZ6PC8CbBQ46ytMBnVUIiw1/d5Fuy4+yHn4oCdxtzCv1kD5XeDwj859RsDcy
	sNIIt7YDI4Tfw8MOKNQ0dLCog58RuLxMNRbZB8MPwZNsF2Dc5CxZY0Ki7i7fYiRv0H53Lyfrtjm
	gYjs13v6oYpgHkgWrhhETRBlHYoqXA2b5sbQPAbrLzxaxyCJnPQ+EOnIYs2oaOnjxQ+xSXI=
X-Received: by 2002:a05:701b:418c:10b0:1a7:4c5f:57e9 with SMTP id a92af1059eb24-1b24f4e4cdemr173108c88.27.1793813683286;
        Wed, 04 Nov 2026 09:34:43 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm13520264c88.17.2026.11.04.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:34:43 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com
Subject: [PATCH v3 0/2] maintenance: improve lock acquisition failure handling
Date: Wed,  4 Nov 2026 17:34:20 +0000
Message-ID: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
References: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series improves how "git maintenance" handles failures to
acquire the maintenance lock.

The first patch changes the handling of lock acquisition failures
so that manual invocations report an error and return a non-zero
exit status, while automatic invocations print a warning and exit
successfully.

The second patch adds a Trace2 data event to make it easier to
identify cases where automatic maintenance is repeatedly skipped
due to lock acquisition failures.

Changes in v3:
- Split the changes into two separate patches: one for lock
  failure handling and another for Trace2 instrumentation.
- Use `strerror(err)` consistently for reporting lock acquisition
  failures in Trace2.
- Deduplicate the diagnostic message construction while preserving
  the distinction between warnings and errors.

Thanks,
Pushkar

Pushkar Singh (2):
  maintenance: report lock acquisition failures
  maintenance: trace lock acquisition failures
