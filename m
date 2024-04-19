Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BC10A28
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504167; cv=none; b=i6zNzAP33Y1JMynKBEFBXF/PFFaXfP4dlbP/ga6g0ixzfZnBTeO5zUbVu3rvq60v6Nt84YiVwE/0gHpT/kgHJxqCWntfgHbgVLPLMGNzbVl3qB+nWoJmoSMOEckbUiQlMomcBE0zAWmEzuWjTprZkWoaO6skEcyCJ0uZnz1X0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504167; c=relaxed/simple;
	bh=jfbRNkQyvPEiLKTtOYB84JTK+sM4Ui6G4u+TROtkgDI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=byJ0UAXrA+GJ4Dw0RUEuKKD5RMYJNFsF/DbhaVg0fdwSzd9dUFCQQvfgxnnhWT4qGUzWp3vo7AfzJuxPKVZjB0BWOpE9TG1nygruRM0ZrTMG7LY0xrhnrhZ0gFFfzR+14hxjSx7MRBVWEo6cYcDA7RiLrUjVTMjDvHoObjBRWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcZvZHIs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcZvZHIs"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a557044f2ddso159780466b.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504163; x=1714108963; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1m6zhjdREPDDft/nFZ1Z7dW98zExW0HvemFKuR7ZvE=;
        b=JcZvZHIsQhlFezxwoiZRdVu9TyUYYG5tJQ8EdxmrfivDDCsyD4SCCJFOTlmZBzgVSl
         GYieaERkTiraZn78r1xVMVyAhGuWlqXMABrED2EkYo/fraKHwvhoSBgRPvlSQc5UoBeT
         EuEFu26a56QRVPPi08uxPplpYObRid2JPAno2dDAzAJcMnAj2VX8RoHJqKkkEmMVt/3k
         UBBSrnCu3GALYeBhnX8K6GU774QfEROm/KqyWHdu8cJHmRmmLP6JlCFfpmoosa84462H
         x24pR+NveXfDfcL8ieoxBR9w3ByMEpH+SL2+95Wt12UKlj30/dFmCqHOZ6GwG4T0qwWL
         cBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504163; x=1714108963;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1m6zhjdREPDDft/nFZ1Z7dW98zExW0HvemFKuR7ZvE=;
        b=GTTIT0RA+izhCiKfEZlMk13yfWz0PS47ZN4y8t4H9/GNJpSfqYcfbgkicxRvh0YFbO
         uSaZ1/pBMnPywtHb8xj+b3CN5CmheCqldf4JqxTfC2HNFHld9F7gVvHfVL55uXx0Mg9q
         GKQKg36csPQ11S3dPxGZifrgHgAFMQeuaFELQZoTu6mudaj6uEGoEeJcxh1o7Uzfnnx7
         CmW043yIPqm/pqGt307xyfXzncOAtNQqvJReqoRDSxxnQe4ewQt2AuDssXUTNZC+1yZ9
         SC5Woo4OGfafrCG0XjcNoD7lZrFQVZgW4M8Qiq+DNU9awgqbz9leLzf/O09NTulaSPTZ
         jRpg==
X-Gm-Message-State: AOJu0Yyr8Aj8zgmhoSMpVnHUl29I2j6ObXBpsxuHbNnlZuO9KiL4eb7t
	6+hl+BA7DZm6hRVfFoKaoPiJXr3atUIeqyfv3esCdiCw1eIgcFfCwWi6rw==
X-Google-Smtp-Source: AGHT+IGj+Iub6ivOMfOi/PQdC2GXYswUKo04ELWdLggGUEck0HaGTnARyNbcLSD3KPmH/HcFiMXnWA==
X-Received: by 2002:a17:906:f148:b0:a55:5e89:a158 with SMTP id gw8-20020a170906f14800b00a555e89a158mr713016ejb.68.1713504163412;
        Thu, 18 Apr 2024 22:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090657c700b00a4e07760215sm1727687ejr.69.2024.04.18.22.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:42 -0700 (PDT)
Message-Id: <0e9ae049b8861fecf49c097e8d52e734f7a9c9b3.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:32 +0000
Subject: [PATCH v2 7/8] trailer: make trailer_info struct private
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In 13211ae23f (trailer: separate public from internal portion of
trailer_iterator, 2023-09-09) we moved trailer_info behind an anonymous
struct to discourage use by trailer.h API users. However it still left
open the possibility of external use of trailer_info itself. Now that
there are no external users of trailer_info, we can make this struct
private.

Make this struct private by putting its definition inside trailer.c.
This has two benefits:

  (1) it makes the surface area of the public facing
      interface (trailer.h) smaller, and

  (2) external API users are unable to peer inside this struct (because
      it is only ever exposed as an opaque pointer).

There are a couple disadvantages:

  (A) every time the member of the struct is accessed an extra pointer
      dereference must be done, and

  (B) for users of trailer_info outside trailer.c, this struct can no
      longer be allocated on the stack and may only be allocated on the
      heap (because its definition is hidden away in trailer.c) and
      appropriately deallocated by the user.

(The disadvantages have already been observed in the two preparatory
commits that precede this one.) This commit believes that the benefits
outweigh the disadvantages for designing APIs, as explained below.

Making trailer_info private exposes existing deficiencies in the API.
This is because users of this struct had full access to its internals,
so there wasn't much need to actually design it to be "complete" in the
sense that API users only needed to use what was provided by the API.
For example, the location of the trailer block (start/end offsets
relative to the start of the input text) was accessible by looking at
these struct members directly. Now that the struct is private, we have
to expose new API functions to allow clients to access this
information (see builtin/interpret-trailers.c).

The idea in this commit to hide implementation details behind an "opaque
pointer" is also known as the "pimpl" (pointer to implementation) idiom
in C++ and is a common pattern in that language (where, for example,
abstract classes only have pointers to concrete classes).

However, the original inspiration to use this idiom does not come from
C++, but instead the book "C Interfaces and Implementations: Techniques
for Creating Reusable Software" [1]. This book recommends opaque
pointers as a good design principle for designing C libraries, using the
term "interface" as the functions defined in *.h (header) files and
"implementation" as the corresponding *.c file which define the
interfaces.

The book says this about opaque pointers:

    ... clients can manipulate such pointers freely, but they can’t
    dereference them; that is, they can’t look at the innards of the
    structure pointed to by them. Only the implementation has that
    privilege. Opaque pointers hide representation details and help
    catch errors.

In our case, "struct trailer_info" is now hidden from clients, and the
ways in which this opaque pointer can be used is limited to the richness
of <trailer.h>. In other words, <trailer.h> exclusively controls exactly
how "trailer_info" pointers are to be used.

[1] Hanson, David R. "C Interfaces and Implementations: Techniques for
    Creating Reusable Software". Addison Wesley, 1997. p. 22

Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 21 +++++++++++++++++++++
 trailer.h | 23 ++---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/trailer.c b/trailer.c
index 9179dd802c6..6167b707ae0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,6 +11,27 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
+struct trailer_info {
+	/*
+	 * True if there is a blank line before the location pointed to by
+	 * trailer_block_start.
+	 */
+	int blank_line_before_trailer;
+
+	/*
+	 * Offsets to the trailer block start and end positions in the input
+	 * string. If no trailer block is found, these are both set to the
+	 * "true" end of the input (find_end_of_log_message()).
+	 */
+	size_t trailer_block_start, trailer_block_end;
+
+	/*
+	 * Array of trailers found.
+	 */
+	char **trailers;
+	size_t trailer_nr;
+};
+
 struct conf_info {
 	char *name;
 	char *key;
diff --git a/trailer.h b/trailer.h
index b32213a9e23..a63e97a2663 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,6 +4,8 @@
 #include "list.h"
 #include "strbuf.h"
 
+struct trailer_info;
+
 enum trailer_where {
 	WHERE_DEFAULT,
 	WHERE_END,
@@ -29,27 +31,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
 int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
 int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
 
-struct trailer_info {
-	/*
-	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
-	 */
-	int blank_line_before_trailer;
-
-	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
-	 */
-	size_t trailer_block_start, trailer_block_end;
-
-	/*
-	 * Array of trailers found.
-	 */
-	char **trailers;
-	size_t trailer_nr;
-};
-
 /*
  * A list that represents newly-added trailers, such as those provided
  * with the --trailer command line option of git-interpret-trailers.
-- 
gitgitgadget

