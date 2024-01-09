Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23B3DB83
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu3scSMz"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbd029beef4so3377904276.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704830058; x=1705434858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vT2yeB4H+vUIvaQYSMK7JGdRM+jIU031sNmimb7c5BM=;
        b=Wu3scSMz6A+LmI1w9vUr5aPbhdIiaEdAJYNDiTFyZyk5wu1X29Mf2b+3GURJcI/RGQ
         2u3z8uG7saGG6G//sjs5x8YQ4/YmxhHIV5kl1KWZoHexvXM9M4DDAi9g05yjYZDCNG7R
         TNoPOsa7Zyo4I159U2q8QPfzjg/kQ2JzGuu9HfuE6FPy80rPOvNGtBvXR74h88tYixEt
         ICBry0c+Mv1xEU2vJ0ctFbSwhSFd8c1i26h3w1FCgewM9LidlfBzrUCndyIlCHNtfHvu
         S8B16CGLYUsstTMwN2yvR7hCMGxqVXFm7eWkRNfs8qDr+pjBvnfzOI9IVYgMEulMUS3N
         M5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704830058; x=1705434858;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vT2yeB4H+vUIvaQYSMK7JGdRM+jIU031sNmimb7c5BM=;
        b=XhpibyDSTs/lH27cEqsMdIsn/iLF5wc2hIPA8N8eoQ4ZPgyJo0bbdYsFSukofHYYby
         WAdWRlf6IukB3E1vArMFYBDzkMgfTgT+dmxzJCNObjIlpIMcXP7xr6vrRtk770jX119O
         wxfSOkVnLReDivE5Vfon90oB0CMoQH/ZTWp0JVs+fa7yDdv4lGnQ9XVKRCM1xGUjW8DP
         YN8WXOMea2jH996E25ze2vKr6xWOhhFgLm/hdu+skzUO/ROOoeAJ8umRiNO9HI46Mqkp
         LOxouGg8yFxLkdB1CgEQZyQHw+Tl8JeUB14KTFEXS2UHAJzU6tEfKMpdoFkbwjNyELx7
         M3qg==
X-Gm-Message-State: AOJu0YyJS5AwHJHhVrE6MUcjPdx8rAwemPNqTG9Ur3DcKHMqEp3uNoUG
	Oa9cdmds9HzCM+2b6KesdRCbZArV5RcbO+Oz8cSpHcIsrps1WAFc
X-Google-Smtp-Source: AGHT+IEm4wYVWJaLl0xIFuQjgscBa0sBGuXfAP1MW7J7oIC0KxyUotacKm2fbMJhX+Zyy4YiOvR1pbIxHBu2QHpG538=
X-Received: by 2002:a05:6902:200d:b0:dbd:2ae7:f363 with SMTP id
 dh13-20020a056902200d00b00dbd2ae7f363mr2308ybb.4.1704830058577; Tue, 09 Jan
 2024 11:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergius Nyah <sergiusnyah@gmail.com>
Date: Tue, 9 Jan 2024 20:54:07 +0100
Message-ID: <CANAnif8L3+CoVdvcUntWz_JoDvubityXPsouLqgvca=BrtqR8g@mail.gmail.com>
Subject: Add more builtin patterns for userdiff, as Microproject.
To: git@vger.kernel.org, "gitster@pobox.com" <gitster@pobox.com>
Cc: newren@gmail.com, l.s.r@web.de
Content-Type: text/plain; charset="UTF-8"

Hello everyone,
I'm Sergius, a Computer Science undergraduate student, and I want to
begin Contributing to the Git project. So far, I've gone through
Matheus' tutorial on First steps Contributing to Git, and I found it
very helpful. I've also read the Contribution guidelines keenly and
built Git from source.

In accordance with the contributor guidelines, I came across this
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
