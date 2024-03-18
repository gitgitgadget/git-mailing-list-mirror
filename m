Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4F5224CE
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740400; cv=none; b=bcBAVfc5GF0VI0RMDpQxFghmPJRhbVqW4zlVezPsal66vR0j1Npn3RNz/aFSNbRERsVHM/RSo9NlyrU7UjsXd9Ny4OeIPqEw7odAEcIbA8PBWDuc2Ygk9UxDvgO5jahFKyUkvPqxxJwp8FG2ixjx2Kc/1DVw/l5dtANs2krGp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740400; c=relaxed/simple;
	bh=lBjQeX12RrFWkAUXlf+2j9fZ6S7BEiW+xZkhYv8WF9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8SA5kJQHfDJFLUteM5DR6CRi/jGvVkjVTtHe1RWd5uqEUXHdvcrnxHYmEoW5cZIZj22JUKTlqddXJ46SN3tuBCvhKyqe0RYeMkU80varU4PO35MVYRbtwnzycYhijpQ7aBHkRvHkNBECk7tVQegD0HbjDWi1RaH8eKo40qXVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx+MTtm2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx+MTtm2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6918a0edcfaso18827366d6.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 22:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710740397; x=1711345197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1iPl/3MngmmfjMeovF+aYcd8nU9MLp8nIAZxGWDdmQ=;
        b=Jx+MTtm2RD5bYKPgqbuX9IyaIC8O0JtCWY5mvYClqkTdStbZP5qkzsbamg8NqOOlVg
         lRqP/v8+Y36b9nP71d1mjKdE3pfzuJyvVS0Ea0LyzvdEVNvHrZK3HxsjMG+QuK/fdgzo
         j6gpjB2NDQXYafpzjfQBjAWjPHX7mVTjmFFZp1qH6MbZv6J0NcYn4PvyA7Teo0sGiZXD
         3evzNW0bUltOKMSl/g4eU2RwFqTXCtncGo7wafGjlMed11+RWBJxJp4hCddqJJ3R1URl
         74YyPd5+PuFIaoOmaIZaMQpZdvvOhSEJ4wNHqXkLwN2l8lBNIAj39ihy82Z8ukDYPFsr
         ic6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710740397; x=1711345197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1iPl/3MngmmfjMeovF+aYcd8nU9MLp8nIAZxGWDdmQ=;
        b=enxc4NugbLCXDEKBJ0oNH0/6GdSSxS4iIDVcVW5kVD2q8duMRAdVf/Ki6y51ZWNrCt
         JyE8hXf33D/Y+VH0slAjq/3hE/czoUGDoc20ckv3KAlT/Q1xBWrjhqZYo78Ou2i5pNX3
         NmlGniEpdXGM+ndb3swM5KR9xC2S64O9AZRATo3aLJoDzOXN6bg9zqnQotKyfMzrfmjI
         DfqwIQTf5j4QuBurcH1PlSbQfAAUkw7LRv4EunEUb/Vyu1PjsOHU1H71SZwYdO1ByrcB
         P7ZtdqlKG9yA49Yt2NmRjCPfwa9R3hdIW2T5dpuvJpruaFtHxCzEBQN68Z8Fo1W0mRe+
         wj8Q==
X-Gm-Message-State: AOJu0YyblTZJsdGrjAtQ/bDozoHHvTZuRveDam2ivX/PxMJd+5ZYTVMg
	ZzL+fOCOk5907aNqi+Z92N4qbX7wwSNu98P0AWjeICbBwy72+oaAtQ5qWkiM
X-Google-Smtp-Source: AGHT+IEATMEQ70LdaJTyE3v08xWNrkncBM1QWBa/xZIgXkDIE1XYpLCcfc0inNc8+KQnaiSJHwI/Bw==
X-Received: by 2002:a05:6214:4a04:b0:691:857a:1ef8 with SMTP id pg4-20020a0562144a0400b00691857a1ef8mr9077889qvb.61.1710740397192;
        Sun, 17 Mar 2024 22:39:57 -0700 (PDT)
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id jo26-20020a056214501a00b006961d023d2fsm792898qvb.17.2024.03.17.22.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 22:39:56 -0700 (PDT)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	linusa@google.com
Subject: [PATCH v2 2/2] docs: adjust trailer `separator` and `key_value_separator` language
Date: Mon, 18 Mar 2024 00:38:02 -0500
Message-ID: <20240318053848.185201-2-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316035612.752910-1-brianmlyles@gmail.com>
References: <20240316035612.752910-1-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The language describing the trailer separator and key-value separator
default value is overly complicated.

Indicate the default with simpler "Defaults to ..." language.

Suggested-by: Linus Arver <linusa@google.com>
Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---
This commit is new in v2 per Linus' suggestion[1].

[1]: https://lore.kernel.org/git/owly1q8a4qhh.fsf@fine.c.googlers.com/

 Documentation/pretty-formats.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index e1788cb07a..8ee940b6a4 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -316,9 +316,8 @@ multiple times, the last occurrence wins.
    `Reviewed-by`.
 ** 'only[=<bool>]': select whether non-trailer lines from the trailer
    block should be included.
-** 'separator=<sep>': specify a separator inserted between trailer
-   lines. When this option is not given each trailer line is
-   terminated with a line feed character. The string <sep> may contain
+** 'separator=<sep>': specify the separator inserted between trailer
+   lines. Defaults to a line feed character. The string <sep> may contain
    the literal formatting codes described above. To use comma as
    separator one must use `%x2C` as it would otherwise be parsed as
    next option. E.g., `%(trailers:key=Ticket,separator=%x2C )`
@@ -329,10 +328,9 @@ multiple times, the last occurrence wins.
    `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
 ** 'keyonly[=<bool>]': only show the key part of the trailer.
 ** 'valueonly[=<bool>]': only show the value part of the trailer.
-** 'key_value_separator=<sep>': specify a separator inserted between
-   the key and value of each trailer. When this option is not given each trailer
-   key-value pair is separated by ": ". Otherwise it shares the same semantics
-   as 'separator=<sep>' above.
+** 'key_value_separator=<sep>': specify the separator inserted between
+   the key and value of each trailer. Defaults to ": ". Otherwise it
+   shares the same semantics as 'separator=<sep>' above.

 NOTE: Some placeholders may depend on other options given to the
 revision traversal engine. For example, the `%g*` reflog options will
-- 
2.43.2

