Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB6261B80
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658309; cv=none; b=gIXdttgljXsehI4tuiPn4DsKgdaqIsrxALDrL9cfWVT0vmVskVH87P4pQnw0cSpbdLkWBnou108FEpvdrODK+27LH09bltgIRwUBlsT1WzTLjj82A+7xvjhYKLHuKPmgrPGECXmPGLf8AYYpVW0DWCqUpL0Yx8FxjCGtsy193g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658309; c=relaxed/simple;
	bh=ndxRmBFxj6EW6uD0L3py8mikNh9RBdeZ2B7ggY2tUyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqQORlyZWdnNwE4qXk/C0Y8t2zbIli4OwKIlztO69MQOjcU1phat8p+2NWfx3SUw5IZJzK4zm6e6tg6QEtCySp3GQxlo/PqB733G3KUusiJQeoVifH1WNaV+vxwfSK8Rwl7emQSz3GJsWTB+2PwdZYAlAV4PeRuuwIAtYW35WPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNz6uuf7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNz6uuf7"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a929245b6aso28034955ad.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 09:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770658308; x=1771263108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndxRmBFxj6EW6uD0L3py8mikNh9RBdeZ2B7ggY2tUyw=;
        b=cNz6uuf77Z7FUwdOg1yXryCGS8+3s4On98iHiudQgUE3xAvfUF8H6I16aw0xBFP7a7
         eKlZ+RsvPB1d+aipe0DUWnUrPY8YrSDoUe0q6azUx4yh4EQGS319C07t2WEslO79r6pE
         PTN6PDQPkBh6XGXJQU8vYqVJhxmmqizvs+VflZZorXwLCrAz6f80tklRZpPiCeRdhLPP
         qf8Y+6kUndtpzWj/++3Mw9KwP2UZLE9Y54p+rRHYSymdlyihyibJIbpFaleEICj6TMTP
         NNeuskNKKjU2qHgXKV4xAS3Q+g6IXQRYOXaXtGj5hac3zV2hTGFcuRf9kIq2WhRQIO8I
         Qu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658308; x=1771263108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndxRmBFxj6EW6uD0L3py8mikNh9RBdeZ2B7ggY2tUyw=;
        b=CuLxvXvnnwjVyZyGV5XtH8Uh2uo09dE2v9ptOFAAl0HSMWZMEra75dV25ZyzXq8IBR
         ent+Hcj/pfL7Gokkf4tr2JrpXWqJnCM6RjzCh66pQcM0JICv3OVhfcUjfv0+GMfm2i0u
         pR22fNnfkSDqZdYfmzdVWgTS6Mr8UheqndgD/tfExMd3ynRG6IY5dfEnotOfGuQpcHnU
         3I+QOr8Ldv+lYpeU0XJC/17QSpreKlT9IhQQ39EfNT2LyF0uBjvVia6YAgEDjjBcNTPX
         2IUw7MiWSewEumcDJMu6lT55TrstMQx1g6SeujkWBzBypXKRmQ49E0R+yynil6KUMDdk
         pdLw==
X-Gm-Message-State: AOJu0YyPM+vnSWSwlO3OmsID7GjniwFjqI+UmEI3EFM0PYah16RHKfPu
	0yx+hIuMKJ++z14+h/ksNVhlkiDSFuWL5EjnsQFgZfqagX03AJqksN5j
X-Gm-Gg: AZuq6aJboWbKGWLl2bT6Rm/k+NWFJPNn3uomOdHWftGkJVY9cHJAh7+XuiPzrEvu0cV
	liZ8KubV0pK7+jmFx7ufoQKCfqoCgBXSovcmw2iGA5WNfPB+IMVyO01pqilVUgLNqH3fuP2y+qP
	l+0f/ZZ27SHeaE8pdq7pVSow0TvyraeB4oFaLXlZrUxjeY3+xyfQxlyXJKXjV3ErMfCz9tLC7hw
	WaiL4dcfyNEjIka6Kzoa/FOqsuz+MKanmWrz/wH2e98WEBFay00c5ewGwJawyRHaIybYdcJaaeJ
	cBCF4t5q1L13oV2jKZExE2Pxt8tUWkIDs7ndhH8mypSr03LpWFwjgLCopDA6RvFjdY2TBWmf/wZ
	OZw7K3QqtzMyo2dEOM1VKXUob8S1xs4X+vbCg8BJL+H035HvkUAq8GH4Jct14hFjBa1t/f7n1Xl
	Qb6Qs7VkQGTxXuUR5WZXOmR7qt6vStFjlZqBIpeWFuvd4JfnsNSbL1kXk66Fma/oN2cR4Mo0pje
	cg2qb395r3BbfLVnx6VangwM5n8ROSB/T2oAlsND5OdE83rADzYx2SHF2A4VYlyWaSz
X-Received: by 2002:a17:902:d4c7:b0:2aa:e0c4:c076 with SMTP id d9443c01a7336-2aae0c4c3d7mr59372525ad.54.1770658308237;
        Mon, 09 Feb 2026 09:31:48 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:8:69a7:859:b7cb:71f6:672a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a644a6sm156203885ad.8.2026.02.09.09.31.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Feb 2026 09:31:47 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: j6t@kdbg.org
Cc: git@vger.kernel.org,
	pushkarkumarsingh1970@gmail.com,
	valusoutrik@gmail.com
Subject: Is adding 'dart' to userdiff.c a valid microproject?
Date: Mon,  9 Feb 2026 23:01:39 +0530
Message-ID: <20260209173139.39707-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <51aca4e7-3115-4dc2-aa59-e648c2958f64@kdbg.org>
References: <51aca4e7-3115-4dc2-aa59-e648c2958f64@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> But be aware that it's at the challenging end of the spectrum for a
> microproject, if not already too much.

Yeah you're probably right. Thanks for the feedback Pushkar Singh and
Johannes Sixt.

I will try to do more focused and smaller contributions.

Thanks,
Soutrik
