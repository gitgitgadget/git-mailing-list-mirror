Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52532107A9
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710570440; cv=none; b=f3sFTB46tyAod+F1P5zSi1c8lcW87je5oUeoWwuX3IgTnrVZ2Wd24n40YYWWF/wQCJcuNCiKm+P6Kff206MfhcN+P+u3tirXPErx0IruTghS1biEX5qi9I+7OFAX5LN32WLwHdJBheW0DpcvO78r545mj5smuNkkcCqd6CjgC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710570440; c=relaxed/simple;
	bh=jfbRNkQyvPEiLKTtOYB84JTK+sM4Ui6G4u+TROtkgDI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FQnmc+zruE6RrgtGeMV5L7SY7rGdaYwT8/g4VfnQMfUP4Q7peJEkC17DyWB+AaIgYx0tZ7qphlGfAL4gnjEMRQsSDYzq7+MJ37l+BEDh7SCgTUp0bYnow5axiOrn0gygepSNfGa9kPhgnU+KuiJwoNvxO9zVAaDhOj04siFPycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWkdu89T; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWkdu89T"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513d9176cf9so1629189e87.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 23:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710570436; x=1711175236; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1m6zhjdREPDDft/nFZ1Z7dW98zExW0HvemFKuR7ZvE=;
        b=EWkdu89TOE4nn3X0ortQZP0MQeRWETCwqAWeNVlmr725D+z70I29fFNnu6PWmGO/o6
         Qfw+1iL9bJ/+jUSs/wr2p3mcJQyaGpHxqTkFoTNdj7WWmVRgrjaqhSdjVT7VivI/KlDg
         0PYlSYL0zOefZg7swh+j2QAK2XNKSQeMDerEvx5vQmFgfn1oRkqwNMHo7WqLIKQ2kRjq
         3B6LpJjARjo/i4nSa+GMLUW0O8bH4NicFvcK88+o7kdTkM5YEgFevCxe62yDxqzYqeoM
         2xYplPBtTzTXvasGaM4hzFzKEJZlPKJTuz4Od75irJdfRFd+2aQklGDPSDK5985jNCL/
         SeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710570436; x=1711175236;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1m6zhjdREPDDft/nFZ1Z7dW98zExW0HvemFKuR7ZvE=;
        b=dJNF2ye6t7RqtomalZ5ruaWdk16c335bihBXDThJYdG1F44bZgMNn6BcWto0wSsEBl
         O/Gf7qt5hwQVhtRZXiWUvjWCnek3Xd35NL5fQMxI52p9FQVeyRj136ld8i1AtxxYJJ5/
         pDClXpuwdp1NiHpA0V47AmWurl2ELsZnVN17/vOE2M5nJy3s0y2ekJdj3bvnYnfnouR0
         4jxZ41QbczaZh/dlXmthGZfMh4cAt8JaQg+K1Vorlqwh5MTdIhTE7AYFN1TXsE7+MFnL
         OxIhFzTeFlTRQcxUlDrFPi2wT199DC16Uqb4q1Bw91iLgEuXGTUVVC8LD9g6er/CDhRm
         /6rg==
X-Gm-Message-State: AOJu0YyhWkSuZXfzd+PAtVlE8GQrSYqsvKG8SACG7A8Q++Xq9HwJg00s
	2ORXt+EeuOy04K1z7adMbEpE+vrvKjlJdMtP3xCG83mw8H6ort6v4SBv4JGS
X-Google-Smtp-Source: AGHT+IFBR5CW1HNuBWpJMPzYA7TD4fWD6NITtxEYCVUrYCL11z+OVweXCTj7LHwx3yWpq3xHj/Tr+w==
X-Received: by 2002:a19:f504:0:b0:512:e58c:7bf1 with SMTP id j4-20020a19f504000000b00512e58c7bf1mr3271568lfb.40.1710570435922;
        Fri, 15 Mar 2024 23:27:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b004132ae838absm7968575wmq.43.2024.03.15.23.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 23:27:14 -0700 (PDT)
Message-ID: <cf59dee506441a11b2b295d046a7bf255ca7c1cf.1710570428.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 16 Mar 2024 06:27:07 +0000
Subject: [PATCH 5/6] trailer: make trailer_info struct private
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

