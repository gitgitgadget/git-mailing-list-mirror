Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59943D0BFB
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541239; cv=none; b=dxcm5Ru0Fq1ZpGZGkmv5FpqB7rZ7LsF+AsbbNOhT1YxotRqMP4ZfM7XMejsbL5oLMqhz5J6tCq195ttAuRc5TvIgJN58Hj6jQWPJWZ8C3jESWVGvT4jKrbW0yXga0PcFlUMbWDlVeuDvdSr2kChHvQu/9b8hs/VQRNAbXRQRM08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541239; c=relaxed/simple;
	bh=nFcvRUFk8ZCJGwzuSPxodCEFdasw4iYo8bI4SgOLzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWnplmUYbYphtW6/OTsgngOPTett4uzmseE+lQAnaAuG07obvwrZItykFkf8OPRLIAyMYHhjOQyXJjcwGDx1TnYNm79dvO9RFRl6xUtHxJVyAe1+dgmIcEDP0Q8sxxzqfwRsCckUpTLDCQh4/CsRQYb/9N7RStS8j1+PkpHDLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNZxeSSc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNZxeSSc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf52d15d88so13206015ad.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784541237; x=1785146037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PmcIS1CBmizGcot1skLlKVBff3JGI0HFX0dtFMhEhHk=;
        b=kNZxeSScWH4759p5+ap7b9TEx2p1l0H4L2Ygfna53E0EURF2uVLs7lgGPV2PLBEF9i
         5U15Zwt6/ZYgX3F8pjQzQmm7+cYJodkVlpMPDgAthPADseXZaYWPBNo4ElVFfs0CsiMo
         2kQ+NjYl1/yeeivKy5JfswshmVl2xqxJUO0rvBz2pnOjB1qSMqsl4gJWwypsyBA+RKcA
         0DOsRwjWEDd4y4coNmU1EzVJhkaeMyaY/X0z6GFDk7JJzffZyLsCs4C+BxR9B/JGwKB+
         FD5qwDeXYe9kz98Ps4MJh5vU05551fbI+QmB05OUJ6mm/MNpDDlIJmsmLMDRPyCnrrFu
         +GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541237; x=1785146037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PmcIS1CBmizGcot1skLlKVBff3JGI0HFX0dtFMhEhHk=;
        b=d4eTalqZXXj3J9A51lOgifF28HE+WQM5aNJLAo8xbcq4w4Nmu0dGXWON1DmSH1TNzc
         hHlCojQvIceGVkPSgLLP51ZzXIiX4I7MlumMkuf2pZinpkVGI99b0GZYm4XdsBQbvmID
         3HalkFiOfgJjC6d2teYH/GjdgrtOel5o7W/x0unKr1WWlmgyFW66IbToGa4/n0gFdebZ
         4hbQZldSeGi/AWMTQzkGjSqb55YAhoS3db4HTqs0tv1qqikmdCAzjRhGEV7fzPLg1DpH
         hTg/L4RVffkWGRFZw5RrHv17BuVv86M5fPXM3Tf3Z06v9fSD72tOAaejn3NJU/Lcd3Rt
         ffXA==
X-Forwarded-Encrypted: i=1; AHgh+RoFaamrtqhvVTuc2VPhVxwDQRuDKA1vDT/4KhRqP54ehbhc8kpdiFIDS2SQW5feDJV2bJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyslX8ragvdic4slLFJe4KX3bQ6KfFO3BHTrybg1LTq+dlC6BTU
	jmsm5PiTCYE/ENWfnxfo9B+3oPMNKfDwR6hYfbX5fti8no8QZS8EsUaS
X-Gm-Gg: AfdE7cl6TQzHztNJlycLjNokWXR2hkGOqTGO6QG61iW2JHNkGUQB/gB2nrNJwwMNNU5
	mu4pXlWC9dzmEH6/ZMSbDLObpT9j+9dcUd9HIjSAAy4jsdS/g/S4GnQ4RMXyPhkJObSVjr3RENm
	Y8r+ruaXDaH9QZncZuCdKDdValhN4lfrnHuOVeSyLYWqD2jFE9n2ooIBrLGTfWgBLnPeW5qzK05
	x42dN74DL2P/XShelPQwuXdsZmK3krcjCABo0o4Pd5xjbe7cc9S/3dnpbEl98UdUJBO+NlKRKtt
	bobX9UdFbPD+DfxLLARhr3+J/FacllO6PHleI8RpHG9KErQTTHnYyKojn3rZgLuySiOjIR7MWaU
	GAQQ/XI2SoSuhk/S0hGVpIuXh0Th0Gku9TTAkIIQIYG1Znp1+5lQPvr60HeBEU22GigyO/BTGNl
	UncpG4ivuldYM/R+gHclmfBoJ2KC4=
X-Received: by 2002:a17:903:440c:b0:2ca:1594:451e with SMTP id d9443c01a7336-2cf3496b583mr155314695ad.31.1784541236828;
        Mon, 20 Jul 2026 02:53:56 -0700 (PDT)
Received: from localhost.localdomain ([14.141.116.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1ddeb6sm39294021eec.20.2026.07.20.02.53.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 02:53:56 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: j6t@kdbg.org
Cc: Shlok Kulshreshtha <diy2903@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Scott L. Burson" <Scott@sympoiesis.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add support for Swift
Date: Mon, 20 Jul 2026 15:22:28 +0530
Message-ID: <20260720095335.66241-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
References: <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:
>>  - attributes, with or without arguments, whether on their own line
>>    ("@objc" above a "func") or inline with the declaration
> AFAIC, the regular expression does not match attributes on their own
> line. What relevance does this statement have?

You are right.  The pattern only matches attributes that are inline with
the declaration.  An attribute on its own line is not matched, and does
not need to be, because the declaration line below it matches on its own.
I have reworded this.

> This test contains "RIGHT" twice. This is not good, because we do not
> know which one is picked.
[...]
> Again "RIGHT" twice in a harmful way.

Fixed in a coming v2: swift-init, swift-failable-init and
swift-generic-subscript now contain "RIGHT" only once, on the
declaration line.

> It may be worth considering to enumerate all keywords and permit any
> run of them:
> 	(public|final|etc.|func|init|...|actor)[ \t(?!<]+)+

Noted, and thanks for the follow-up on this one.  I did check it anyway
out of curiosity: with that shape, a line that is only modifiers and
never reaches a real declaration keyword, such as

	public var counter = 0

would still match, because it merges modifiers and declaration keywords
into one interchangeable run.  The current pattern requires a real
keyword at the end, so that line correctly gets no header.  I will keep
the current form for now, and can revisit if the backtracking turns out
to matter in practice.

> You could just throw all of them into a single pattern like this:
> 	0[xXoObB][0-9a-fA-F_]+
> except when, for example, 0b1_abc

Right -- that is why I kept them as three separate patterns, so the
digit ranges stay correct (binary [01], octal [0-7]); merging would
mis-tokenize "0b1_abc".

> Is ".5" a correct floating-point number?

No -- Swift requires a leading digit, so ".5" is a syntax error (one must
write "0.5").  Tokenizing it as "." and "5" is therefore fine, and it
does not occur in valid Swift.

> You do not have to account for single-character operators; they are
> automatic. Drop the "?" from the first "=?".

Done in a coming v2, thanks; I had not realized PATTERNS appends
"|[^[:space:]]".  It is a nice simplification, and it only touches the
word regex, not the funcname pattern.

Since neither of us speaks Swift, for your ease of judgement I have also
put together some coverage numbers, which the coming v2 cover note will
include:

 - Grammar: I went through every declaration form listed in the "Summary
   of the Grammar" in Swift's own language reference (func, init incl.
   failable/generic, deinit, subscript incl. generic, class, struct,
   enum, protocol, extension, actor, operator methods, stacked
   modifiers, attributes with and without arguments, "where" clauses,
   multi-line signatures -- 26 forms total) and wrote a case for each.
   All 26 get the correct header.

 - Real-world code: I ran the driver over the last 200 commits touching
   *.swift in seven different Swift projects -- Alamofire,
   apple/swift-argument-parser, vapor, Kingfisher, RxSwift, SnapKit, and
   pointfreeco/swift-composable-architecture -- and checked every hunk
   header by hand. Out of 20454 hunks, 15310 got a header, and 15296 of
   those (99.9%) named a real declaration. None of the empty-header
   hunks turned out to be a real miss (they were things like file
   comment blocks, imports, or Package.swift, which have nothing to
   attach a header to).

These numbers are unaffected by the changes in this reply: the funcname
pattern is identical in v1 and v2 (only the word regex and the test
files changed), and both measurements are of hunk headers, which come
from the funcname pattern alone. So the coverage above still holds for
v2.

Besides the fixes above, v2 will also carry the reworded attribute
description and the changelog explaining what changed since v1, so the
full picture is in one place when you look at it.

Thanks for the careful review.
Shlok
