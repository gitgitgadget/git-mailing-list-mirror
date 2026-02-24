Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AF33BBB1
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970923; cv=none; b=lfYVOPtELDCxD5x3h2ieRATCbJ2Qinn/RV//ybPt0AElN/cVwCK0eUbD3owZHlxRaItqxU9rSqsttpGzMMS5+eoeffnvSsi1sMHRABdkio/b/Z64g833nWHritQvk4/2SuU50HnvFSVdRhHaRS7R/GsxBW0lP5JISdFMqJchN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970923; c=relaxed/simple;
	bh=Eih/icQW+Qxf+dEKluQwLPJulJBCz3zChCVevFoIIRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSfKCXusq2xVRp68fnVwRxs+ySKzoxReg9qDelXo69QkAROXofkMEvFuUHNlGEn6WaPy3zElrgxiwUWvroc/JEnKNIut2MftDIX8szMjBUVkruCzY5k8OR69YW1mo6rqamSmtmigEZUpPRXvUX89GQ+0emO3rQcf6F7JN3LGa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcmO0tmG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcmO0tmG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso8911595ad.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771970922; x=1772575722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia6jEQG4YhKd4h/MEAygoJasSA4Ct9/TtMuEdonmZng=;
        b=LcmO0tmGHoxELRUtBJ8ZFRM94HIB2D5vAktnftOkYMIQ1NEaE5J9fqwl9DjZBikrUw
         9llHwmFqtIGEqnHT7VHKLK6GSmGfpgs1QZRlKPHIWJEX8IWzTfHxnpImbppcFUdwi9k+
         qDzUpwhLMo/Ec2Jq9RyuzAnjUZbe/aoQ5JT+vr53pPPaIxBJjAD5qLH26dROWi/LRFV+
         Na6asXFhiZaAhXhzq7B4a4O6ia/GHfQBuqzW0MWqlCcpaJSzMWOqUzu0SBBEFrUdVoBd
         SlMkYLhzaPfCnwxR8Ss+vgbCVcWcl+kbmiW+eS7DeTPlG9PDG5gO56kG91Oqo+tGPcTt
         A+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771970922; x=1772575722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ia6jEQG4YhKd4h/MEAygoJasSA4Ct9/TtMuEdonmZng=;
        b=miQD6etvI+KxjgeAKwR2ArAHpLgpUZSR0kk1A81c2tCgUuDTDJNQLICdGzdmvtd9UH
         /50MdLsPH2PUxKOZ8EEMf0uLYZEJewOC5ac83wA4kBBUPGTN1ISZRxeSNTAryyUJILkA
         tfG+/h97hvBspL1x2FMuC/PvOhyUYF1gI5vXWZU9p8lCtWqQIm3yIn5WUhl/wyJoRYDm
         bNr27xawPT4kphvhT4o6cGEAsy34711nCSr84MvPRCtiJq3l5xCjgGmWA82WTDofVVl6
         uVAVFSj/K6q2Y89Ao0VgvPE6gyQnSdbgjcQ9CC/glFFSCbQ9kG3yQq4tPlHP3Dc3o8zW
         p4Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUM+OGWriUweTUBQdDDp0rAm0WqtMUG3M3nMEPbn2D30pYs8W9yTFqSty9gkvG8IapRvYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpOD7/ZmMGQXS0fegxD4U4M/ECKSwFLuvy6ho0BAC1xENU6CD
	uk28WjX1M63+KUE7LLIL3Z++rrQ0P9BZ80pr7gmkNR3rf3mjzNdrs1Mp
X-Gm-Gg: ATEYQzzFdumLS3OaddTOPXP6PSWJ9GxQ76K8xZbb/IMAwCt9BwStJGLimo67b4lyobL
	rVFe/dRiz8PC1ZSSmgb49OexqMDDhbKat1sdDHa1iHRxnANRsMpG+6zSoTs49IUgXZ/VbcAMqNF
	PKyJNns5V18adaT4b5chFbNhdGonXZzxjPnbY/vaSY1i+0961Q4gppC8/Nscc7fM6HOLfPUQIeu
	vobWq0hhfwxKQb3Zt5VH1I8EscrFHqN2GpiYr6KtPOYqnqnU56vwN9C0hL6ozJv+1c5rekcKOqD
	SIkfslTfmnvIqNT8pFFg8YFMKCXW8naVxrjPv2zRXMNnLuBDB/DMNyF0tzpI6l51mlHO4lsz6+k
	j3Bs2WAlfcM39uHqTVstIxmZu37v5bI/7E8+4w5m6je8v9g9EUSn/RxwOs+wOiTjj6Sv2rdvJFz
	bHwKZKzEcc0RJzL3+8k8GgIhEUAaM2En5PZeTukupso1UWOTcs1OzY8MxthQaOm+CMp2+9Im4xK
	FiGOw19OF3TPnik27ZuK+zFcqzdA4MBeIdamVJMWdKFaXqF088Qe1S0SjvYXQYVpx7dH8Y3SB71
	QZoAEXAZ
X-Received: by 2002:a17:903:1a2d:b0:2ab:253b:3941 with SMTP id d9443c01a7336-2ad7455a42emr129928345ad.45.1771970922051;
        Tue, 24 Feb 2026 14:08:42 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:1019:ef66:f559:688:b6ad:cb04])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dd7asm155406845ad.28.2026.02.24.14.08.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 14:08:41 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: gitster@pobox.com
Cc: ayu.chandekar@gmail.com,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	lucasseikioshiro@gmail.com,
	siddharthasthana31@gmail.com,
	valusoutrik@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to show all fields
Date: Wed, 25 Feb 2026 03:38:33 +0530
Message-ID: <20260224220833.17730-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqq5x7lg7ip.fsf@gitster.g>
References: <xmqq5x7lg7ip.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> They do not matter plumbing commands intended to be used in scripts.
> What matters more is being predictable.

My bad for this ... I did not know about plumbing commands.

> And it is more predictable.  If you ask for two things, you get two
> things.  If you ask for one thing, you get one thing.  If you ask
> for zero things?  You get none.

Got it.
Thanks for the clarification.
