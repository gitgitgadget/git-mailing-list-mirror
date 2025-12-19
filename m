Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CB678F3A
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171313; cv=none; b=Nw6oZOB/dd3LyVqfwEAeC7e/oqMU0p15Yj8c8+hIDz4fSSRzw3NLUzvrLovhHdwRePL7c4D8QiazoUdF5TAamdaV5LfgaaBXkEw2e959IZR8bCZWmoLe+BaAQskp+zBvSxQbImOdCJnkwbeDqhNL+YPOy13aD7was6DqQY1qKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171313; c=relaxed/simple;
	bh=vMeMsqqk/u2jMwm/LWkkA0aDc2ZEEZ5AXkzcmG1xOiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gduBNjRLJD4T/ea0/NUYRuMJDcFSJIXHSMOtvZDrsbxM5GXH/1jgI3XdO2V7FW+XW3qdiLwQH89tJJJ3X46gmWlkSSr5aK+vEBNUue9n2siIEEN9G9qsZxOiuLAwq7dg3e8FAgCcHVqWM96f9wI/JQ3cBcmckHJDW7EC8gGcL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3ImXl/F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3ImXl/F"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5943b62c47dso2176844e87.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766171310; x=1766776110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMeMsqqk/u2jMwm/LWkkA0aDc2ZEEZ5AXkzcmG1xOiQ=;
        b=O3ImXl/FRz9gkjwcFtDQcOKhKTxQkhfvVRg7kHdXsvd0ZftkhiG8IZ2DSz/O874ruV
         FMv1r6PSFBwS9lYAnkxb75UQLkP9yPOwM5p5ZDC4GtoRn38zYc3zOUhXkp33u2yc4yVN
         4dC4a6Nj/wuj+nx5z2rhp1UeIlbma1vSTk7O5VZ8bZdDenH85KjjTGT0xJWgH2dVDGHn
         0QIC2V31K4SsEIcH+wqE8TwPQazI5BxZQ7h9OJS2bEIzP90db2YY7kJzDQmMWe3fTC2P
         LeEW+pMVjMUt00t5juXNw2bdccFvLmQbHAq15CaBPN3ol0Z7Rk9pgjPVauj2+7jRCv/k
         C99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766171310; x=1766776110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMeMsqqk/u2jMwm/LWkkA0aDc2ZEEZ5AXkzcmG1xOiQ=;
        b=EifI5O+XqIxgmOdhJSv/vsbZH0yBZTWvIHVjpq88dmgCa8H/kq2s1v7SSJ5iBFok/T
         vAbZ7vONdH65uNqDo/kaBHiBHIlny6QR8YzxaCQY+HbaMdc/g9EoqQ8PnP4FBWkD+w2F
         CkSP5Y/aV4VwPPWx2joCODuH7aC4wsnzRi1eY6u0zrhfhQhcBScXO52XSWjwaoGtIR72
         aAKUMdBqMbltHz1utnuwn7nBWgDjBK/dB3iO6ORi1ZKqH009tFc3jOSp1tb6JeUlFzF2
         /OGdC2S1Z5wmz2MuqtRycUGDn5YLPGXTfqtfBVQIgjGSsYI5/VXOml+/5loJD9ivGYAJ
         d7Vw==
X-Gm-Message-State: AOJu0YyGYbhVXAwJNPp1E9HIK3GH/o65VXK7HZ3gMcojYBbCTRN89pNK
	yTNgJa2o6u9gZPQfYMNBpc7P8R42sL2zk7gx6+FQv9bFFSd6FOrNheN5
X-Gm-Gg: AY/fxX5B02H8HHqsWt34guor668GGbDxJiaY/xGgA+B2IuZCH+/HndismOoRVL2BT86
	UqL2BJtetOFw14iMktjKoejgKlzDTpnPPWofWGLROo1D2jm7wrRLDxyr8NSuahcCsXcnkPhlJx7
	Oi2AlQ7pyIpZSDShY9zl7TTwuq37ymuAjVNcFKwPEsGPfV9wfW2okOt0ayG7xhIS42i3V5ZExeM
	HmWvo+nLS2SOn1kq0GfT7ujGz7TNKPh6PsYO3lXVkVXORXvnb62QkpVe/ioIa+KsRsnEKYJeYMs
	Z86Ewcq2uopqYMm7867upGHIkEFGbQRcPU9D2QfzB2Y2pKgq74MIgcx6bKs+3a0FzrRmNMXVmyn
	4DQsemtps7Zg6+DzNP0+ltCqF3b5LiBvYqjBPMpSu3IXCzVfdgTpcvYb5FFazSQl6Jm03UnogNF
	4c8jeK/qV5iclNEM3fZuDZHHhYrZDnUeNDgMo/CcVHfy3lPDvg9eHj6GfLAftYeAibm7pJQGg=
X-Google-Smtp-Source: AGHT+IH4fN2Lh79m+s2CKKWPN92a8y3ynVMewIpmQjXy6I6QILp+i5q0BYFecmt4nNU+ihZPO0Z+jA==
X-Received: by 2002:a05:6512:32c7:b0:598:8f91:6d0f with SMTP id 2adb3069b0e04-59a17d58f83mr1519304e87.50.1766171309319;
        Fri, 19 Dec 2025 11:08:29 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm888939e87.72.2025.12.19.11.08.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 11:08:28 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] diff: add --no-indicators option
Date: Fri, 19 Dec 2025 20:08:28 +0100
Message-Id: <20251219190828.50839-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqq8qeywuno.fsf@gitster.g>
References: <xmqq8qeywuno.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mr. Hamano!

Here is my classic use-case: https://lore.kernel.org/git/20251219145037.17880-1-haraldnordgren@gmail.com/

I have auto-formatting set up for all the projects I work on in my daily work (Golang and TypeScript) so leading spaces do get removed automatically. But I agree with your general point, I can take a look at removing the leading column for this patch, it makes the code nicer of course! As you know, the current implementations of 'output-indicator-*' don't support empty string, so a little bit of extra work is needed for that.

Regarding "cutting from Nth column", I use macOS with iTerm 2 and I'm not sure if that functionality exists there. It's of course possible for me to keep copy-pasting the whole blob and removing the +/- signs manually or via some scripts, but seems like a lost oppornunity to not handle this from git?

Maybe I missed your point about GNU or BSD, could you explain more about that?

Harald
