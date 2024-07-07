Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB926AC1
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720366542; cv=none; b=ajD5jh/1ikxga4vLGsxNrXbtEtO/WEdyTdcxONCnzVTOB1mTl9SzwchRQLamizkUNSz2sY74Kl2zIYGBatirz/z6y794zhncV4YeJUSht5hInwDT5z+z90+CdkvLQtC4dqNby4xpjr9IvPTgt9FaFYu2yRtuPVEGvaUNr1Qd5+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720366542; c=relaxed/simple;
	bh=ffU98VNpuz1qcg2+WeN0IwO+JnUG2VdJFvElgpoJsaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tihzkZvxz5G7UYw8AKzX9FO2DaUWRWlx3nvjoadiT3zhhdSZfnNTgM9q2RwYaW7y4t9voI1TNM0OGt9FPJ/8q1i9uFICqm70GoJIrCdwzTl+rErhccAqS+W8YlTQ3K9YEmi36IvPxgGc87cm5xNC3lXUtg9+G2v8bMwbFvs+nMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=xDfVz00B; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="xDfVz00B"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso247848866b.2
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 08:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1720366538; x=1720971338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xsa4JiIBiwpZKey+YGXg60seRw06R/aQpl4JQAabgI=;
        b=xDfVz00B5F15RbwtjjrtgHwhcxEmOiuhojONz7Y7GwJ006d4jrDfYRsjSsqolmhbRa
         eqnwDjzAS6iYD9xuT4CNFnKDIWFic6rtIatJ8RJqmhxS3cWsmAFcpx0a7wal9GGHtiTJ
         fO1xs0FtgF+DDvHP/7zTRDbQSQ9TJspHmTt6sEd8yQMUYyXOi8NRKuaNZBOKK5zCxB9t
         bSmvFuXJggAk7xSasnL1yT8MXkBQQCQ4NesUGcNQGNoCkzk3hIM6N/YtzqOVshFMIike
         I2RIzFU2h6Haeams4vvlNcVs8ARspiZ/BLRp2zQFuVCi/kdmaYnJlrmYhN5gFG8ld+4L
         BZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720366538; x=1720971338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xsa4JiIBiwpZKey+YGXg60seRw06R/aQpl4JQAabgI=;
        b=H8XToNpeVSYiSdb/eFn3SjtgRhHu9uFFtmVJioVaxGfOLZ4S0bQ5uFxhagb5wcrpfS
         oS7+fk1vcxfKoxagRrtriuSpwdtV70aboWcVWbFy6c7E/YVeAPu9Fskhy3WZVS0ntwth
         PmLIbTJEwQzzki/BzAz3MxcAMs3w4kcgWib5Jp6O9Qe93qwpNCZePJc8SwApOk/T/3Uh
         4qkP9yOkrT1pXLtShwvXi50Ll0hmZ3HOyNn6BgaMrQAUOodE2hsOKOHewmhPvsXqaD+y
         bsExdOePotg2tmycTFsIZksw/SOeFbGzJ5RUcMbMPUF6DAWpB90R68NeIt2bkpL9fFQ4
         QK4w==
X-Gm-Message-State: AOJu0Yz7t+S6ZImXsKyodIK3XHzEPdu56CcLO1RQRCrKLSZnNkN9LzDS
	aEL/WB1qeJVLaN1qjUhXHFa1FdSKTSsHvY3xlRL1PGwkljveYkm2zdqyXXcWy0zpMlODdlGsMcu
	9XKRGzZzI
X-Google-Smtp-Source: AGHT+IHYt32Cj3VQ7P0xC0h0BGFwB03vLzdLgDCxZ2iC3e4zB6ftoc90RWwTdNBoOq6YFDoeEkIoXw==
X-Received: by 2002:a17:906:7708:b0:a75:3c31:4f58 with SMTP id a640c23a62f3a-a77ba46fa2bmr598155966b.32.1720366537749;
        Sun, 07 Jul 2024 08:35:37 -0700 (PDT)
Received: from localhost.localdomain ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77db2b70a3sm189178666b.81.2024.07.07.08.35.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Jul 2024 08:35:37 -0700 (PDT)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 3 0/1] parse-options: localize mark-up of placeholder text in the short help
Date: Sun,  7 Jul 2024 17:35:22 +0200
Message-ID: <20240707153526.97984-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <xmqqttij86lc.fsf@gitster.g>
References: <xmqqttij86lc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio & Jiang,

I am submitting the patch taking into account the feedback you gave last time.

Just to quickly remind: this allows translatability of "<>" chars in:

  OPT_STRING(0, "author", &force_author, N_("author"), N_("override author")),

displayed as:

    --[no-]author <author>    override author


@Junio:
> ... above explanation ... should replace ... log message
Done

> The explanation after "such as:" needs improvement...
Improved and closely follows your suggestion

> user's language may use a convention different from ... [square brackets]
> ... to mark an optional part ...
I decided againgst implementing this:
 - None of the translators have indicated such a need and adding it makes
   the whole thing more error prone
 - There is a tiny difference from what I did with the placeholder characters:
   I am actually skipping the characters in the Bulgarian translation (rather than 
   substituting them) which leads to shorter but still clear messages.  Skipping 
   both "[]" and "<>" and will lead to confusion.  "[]" are not as dangerous as
   "<>" for shell
 - If translators actually request it - it can be implemented when the real need
   arises

@Jiang
> ... with only one commit... not necessary to ... provide a cover letter
I agree but I am using the cover letter to remind what this is all about
and point what I have done with the code revew.  You can't remember all
interactions.

> ... people don't like the markers ... "<" and ">" ... have special
> meanings ... in shell programming 
I have added something to this meaning in the log message.

Kind regards:
al_shopov

Alexander Shopov (1):
  parse-options: localize mark-up of placeholder text in the short help

 parse-options.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.45.2

