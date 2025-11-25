Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B32D4816
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055726; cv=none; b=toKBLHHRC+k1BeR16UUk7cQpFdFbsSBhJBC6ovdcVaaeAimNdh6s/+DnLUOX3/aULVetcddF5RwKqDwBatt4No01kDgCZ0/jte/9p0J9gOiTG7OHpF+onDeaz1AJsxaQZhG1owH/NSMMcq6yftWQ9loiI2+F2+XwfS8C9JJCQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055726; c=relaxed/simple;
	bh=Sad+QeMPHSoZmYMs0UO1JNo5lo9Hy4XWv2Tqs7hNfBU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=Gu5U+vszULKRGopKCgvnvSr0yEOqPKsIrhPGGSFTipd3G/VsS5T9z+4drCVLw8n1IDhnQLdJJA9MmjF9P7Od7fvTDWpmHHliAIDhQpKsz5Tnml4zDSGy0KauE4bjVTIbpx/qstUKjlLQSrfqv1TPuFAgeRe2PYjP12mxWwqfqr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItyPkXWW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItyPkXWW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bdb6f9561f9so1883660a12.3
        for <git@vger.kernel.org>; Mon, 24 Nov 2025 23:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764055724; x=1764660524; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCQGJ1Gc4FdHDNDiOjD9v/dk6WcIPeqOGU+bRBXqvzE=;
        b=ItyPkXWWO0gDelY5SMfu2m8nFnSt6FJ63ZAhhiPVduJ/hyXjPbhVNM1nMcrD592UVX
         M0kRCGkQyhAy5vAGtYuQGQ/7NWAm5ktSnPRz8wKwxrngG8eisuBCYdUdzp0mIKoI/BpQ
         6c4e3FNX2nj/QNQbZcdjY7bWKLgMcc0VbxdfmsvQdQfGNfH2hmobJ8T9OUfLt7Kfv3gF
         zBRXwdZ5Nptyv63tFQZTKxEiqJzURfgK8TziyoeL4Sj9G9fUM/DAtkOBmTh8pGmNb+DO
         LHslFWJud7u2cjTw4TJbRrrPBdfooxbhsWCXQk3Of6FWHhKn5EQOLuZYc5bPgYkhrOi8
         m3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764055724; x=1764660524;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aCQGJ1Gc4FdHDNDiOjD9v/dk6WcIPeqOGU+bRBXqvzE=;
        b=QYtQFilEfFkp/Bbsr3+zjk06Lu/LF9j1jzMWA3c+L8iFo9uHht2Smg6EwxsSyzYqMK
         zF03le13P0e2E1CBcKJL352mSfrD9PkqwLAyCiFBG02+FhRjlybSdze1rjrDhLg2kQmm
         4DJvXiUGAxkAKTxRf1kO8ZfiNKpzxo3wdRpr11ihNEo5DgYOhJcbXraeXdv1tzadIOb2
         DtGWTD/7vOuVVAbDvL+MivCN+HtMcxkV+q0ri3rawzvCcxCz5F/XDgN/2P820Ly42w4t
         nEsLl6qpYFtXIkGLMv9WCEnCBxrVbJEY/5DpnWyHjLCi1kg23mN5bSPmqlNjbDdHImU2
         1dWA==
X-Forwarded-Encrypted: i=1; AJvYcCVWHwy1H4K9wxHjm2fXj2OhBotfw1sKMZ68vmnzBZCpTkAtMWPlEDPQv7LDdpClfpeBfME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYK0YUx3wBLgVX3wI30OJfyM/Mto7ksZYi5dneWaRE/b3rkCsx
	NrVosEcSd0I63TAKBSGXcY1tDqWi7SdLmcSbSojSGHqd+hW/0rxl6AIt
X-Gm-Gg: ASbGnctX4raRsudygJUs79VvvOeachh3iLajppNRE3VSnlwxnLITUs9+XbilO2FB78V
	Kjn3r3YYmKXUqPHfF9vZE+3OrIjzCbY6IbbkeWWt9bc0x0reQet7LnL6LM2qyHxWbhe6Uun6qrS
	5NL0Sns12I0Z0kqqZfntaGo99ALd8rGaoAJKxUSJwxNU20nwgEllyZWcsGjC93eJkFbFNwWhqBd
	76jr2HVa9YNx1a4USrc+D+8Rht1ozUEh0jkK3fVrMvz39vq+/mNMlY0M1va0mSHL2J8YKPIX3Lr
	Zd9iH6Wx+DCeXcvOGsEA6DujSHCFcEWKuUtenjeHiURcGhXXcAWMwBONbQXo6E15RCRAVz9l6Vl
	qkNYrUTeEErRS55+DqyqtvZRA4MdITbfJLTYSWuSbgudANyMD4yA/eX86DzP2hocZMA5nQ2qiVH
	0v96Tbgb+TNpPayJMV2i9unAuEjEWrfJoyRDsROkmux8E2
X-Google-Smtp-Source: AGHT+IEGd3fkliyLSKn32vtJekkqU3HP8ti88rKUOTFz+21H+tiz1pMpWExBPbe0obnggBs1dIuaTA==
X-Received: by 2002:a05:7301:7105:b0:2a4:3593:96a3 with SMTP id 5a478bee46e88-2a7192bce18mr7610154eec.32.1764055723797;
        Mon, 24 Nov 2025 23:28:43 -0800 (PST)
Received: from localhost (c-73-71-230-225.hsd1.ca.comcast.net. [73.71.230.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db556csm79196871c88.1.2025.11.24.23.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 23:28:43 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 23:28:42 -0800
Message-Id: <DEHLKBB96BBI.3V74A5NGVTVZA@gmail.com>
Cc: "Chris Torek" <chris.torek@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
 <git@vger.kernel.org>
Subject: Re: Filter smudge for secret restoration: no disk access?
From: "Kache Hit" <kache.hit@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Kache Hit" <kache.hit@gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
 <9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
 <CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com>
 <DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com> <xmqqms4bw7f7.fsf@gitster.g>
In-Reply-To: <xmqqms4bw7f7.fsf@gitster.g>

On Mon Nov 24, 2025 at 11:35 AM PST, Junio C Hamano wrote:
> I do not think it is a total dogmatic prohibition, but is a
> practical piece of advice to be prepared in a situation where the
> file %f does not exist on the disk in the working tree.  Also even
> when the file %f does exist, its contents would not match (because
> it was smudged when it was checked out, and the user may have
> further modified it) what in the tree of the commit you are
> switching out of.

You're right, it can be tricky as there are several cases to handle. I
try covering this and other cases in the script's tests.

However, isn't properly handling different scenarios a separate issue?
Simplying my concept to "ignoring" instead of "redacting":

 * Clean: ignore certain lines, preventing them from being committed
 * Smudge: don't overwrite working copy of ignored lines on checkout

Then the functionality becomes line-wise analogous to gitignore working
on whole files. My local copy of gitignored `.env` isn't overwritten
when I checkout. I'm looking for the same, just line-wise.

On Mon Nov 24, 2025 at 11:35 AM PST, Junio C Hamano wrote:
> ... one of the things the checkout needs to do may be to remove the
> existing file from the working tree, and then create a file anew
> (probably in a temporary file) and move it to the final place, in
> which case, your smudge filter may be called during "create a file
> anew" phase, where the old file F or G may be missing from the working
> tree.

The old file being missing, being wholly removed right away, is exactly
what I'm running into. If the working copy was kept around for `smudge`,
I could achive a basic implementation of line-wise ignore/redact.

As-is, git's clean -> smudge filters can:
 * idempotent op -> no-op, e.g. identing or formatting
 * perfect mapping -> map back, e.g. git-lfs
 * add info -> remove info, e.g. expand RCS keyword -> unexpand

But not:
 * remove info -> restore info, e.g. ignoring lines, redacting


- Kache

PS

I've just found a case I'm not yet handling: at the end of `smudge()`,
any unused secrets from the "previous working copy" that haven't been
restored into the template would be lost. It is analogous to having
local changes to a file at commit `X` and checking out `Y` where that
file has been deleted. Git avoids overwriting local changes by aborting
the checkout.
