Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D3D54B
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVLw3FTh"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db3a09e96daso2612334276.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704830156; x=1705434956; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NGMQ2pLdmqaeBRVc+nZZcNGbWjqvItdJ8PvBcTu9E2g=;
        b=GVLw3FTh7M81Jdx0LgF9huV/ml/67BocmLUVsuKRcK5occpfm0Xn+fjmdp8fFPa5op
         BA8YACFG+aRcu5oiaYIIpgd2dqu3Qgw9sRn2dbFTj7zCNxlnGpLvPasMbvOmxdFyJqwm
         rOo3xBXIqmDZsbqvK5g7osKBhjW/tlQy0HOB1sIo7bw89fiW6rpZhYRLHckzzZYWSW+E
         EVubbINGPlDgZ7+Mwx+Cd6kNFBo1s74gtH/CxON8YYEk0Ie4bqESXzz3Ee057FnfhH5f
         zuBOqwI0opw2qjtBhrfLIjddQVbJYwvcDN0mnXtjun97Qz7l5cabFFLbtcLxcInhI7Tg
         Z7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830156; x=1705434956;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGMQ2pLdmqaeBRVc+nZZcNGbWjqvItdJ8PvBcTu9E2g=;
        b=OI/GA2XbD5x+x9EY+T6ZxtJqR4kkHVm9W1+/VWBoBelkSg7CjYsd/7xT9Bs9nvQ6CZ
         /+4mrutRabMbUYP0ywce5eSzUlqfzCw7eN9x0geKSOMc1kVl2sKgr5pzHIrTW/04gy+5
         awRuSyTFI2ncJhOV7LIU5k0ZIbz4igw41QGm7CapJlX/GmuGXkxgYf/0ubS3ISgfBbjb
         nSzJmNydqaisboDaxFrKkKWqf45ii3KZUOL/JEOTkbDEDBtUZ3YNPrjUQnAroCf5n7c3
         sPPzWwHekx937RKecx9mqMY3PVvofNO5/H3ndrh+3b0ZdHGlQ0b/b0Nxw1HuPE6wZJbl
         3xKA==
X-Gm-Message-State: AOJu0Yx0oW5lJdjFNJD9LyyEVMTnKop5GghsVSCLZHLns2O2XgJAUIPv
	Pn53aXJlzFsoz0AaiXjVVby5QbPMcC7f+dGWsJLhllRNigz152tI
X-Google-Smtp-Source: AGHT+IFmi0qqOPeRVAuS68YVB/nRxtrS0cAyB4NGDhqEh6JIURxrdd6Nq5axv5vAgUh+c6snG7v1Il026QwVZlom7Rc=
X-Received: by 2002:a25:8801:0:b0:dbd:ab80:8490 with SMTP id
 c1-20020a258801000000b00dbdab808490mr2918636ybl.11.1704830155709; Tue, 09 Jan
 2024 11:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergius Nyah <sergiusnyah@gmail.com>
Date: Tue, 9 Jan 2024 20:55:44 +0100
Message-ID: <CANAnif95ux=vCNCKbVw0q_vYamQRkbFqSa9_-u6xRvK6r+2a+Q@mail.gmail.com>
Subject: [GSOC][RFC] Add more builtin patterns for userdiff, as Mircroproject.
To: git@vger.kernel.org, "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,
I'm Sergius, a Computer Science undergraduate student, and I want to
begin Contributing to the Git project. So far, I've gone through
Matheus' tutorial on First steps Contributing to Git, and I found it
very helpful. I've also read the Contribution guidelines keenly and
built Git from source.

In accordance to the contributor guidelines, I came across this
Mircoproject idea from: https://git.github.io/SoC-2022-Microprojects/
which I'm willing to work on. It talked about enhancing Git's
"userdiff" feature in "userdiff.c" which is crucial for identifying
function names in various programming languages, thereby improving the
readability of "git diff" outputs.

From my understanding, the project involves extending the `userdiff`
feature to support additional programming languages that are currently
not covered such as Shell, Swift, Go and the others.

Here is a sample of how a language is defined in `userdiff.c`:

> #define PATTERNS(lang, rx, wrx) { \
> .name = lang, \
> .binary = -1, \
> .funcname = { \
> .pattern = rx, \
> .cflags = REG_EXTENDED, \
> }, \
> .word_regex = wrx "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+", \
> .word_regex_multi_byte = wrx "|[^[:space:]]", \
> }

In this code, `lang` is the name of the language, `rx` is the regular
expression for identifying function names, and `wrx` is the word
regex.

Approach: I Identified the Programming Languages that are not
currently supported by the userdiff feature by reviewing the existing
patterns in userdiff.c and comparing them with some popular
programming languages.
For each supported language, I would define a regular expression that
could help identify function names in that language. This could
include researching each language's syntax and testing their
expressions to ensure that they work well.
Also, I'd add a new IPATTERN definition for each language to the
"userdiff.c" file, then rebuild Git and test the changes by creating a
repo with files in the newly supported languages then run "git diff"
to ensure the line @@ ... @@ produces their correct function names.
Then submit a patch.

Best Regards!
Sergius.
