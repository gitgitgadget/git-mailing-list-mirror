Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF359BE65
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504162; cv=none; b=na0lIZ7cXV+K0TUMT7Klk2Xn2kPMDk+7qaRcHAsL8Y5T18ytAEJ/FG2b4wY5NcpJMkS8O+wZTwhzGZK48fqUJLW1lwQMNRoF+I2X77e3IsK7pC7zOEvM/betSXCH+SD7QR8mer+KRg/1XIPaQtxdY9BiRFOpinuBXc5XH8mVVQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504162; c=relaxed/simple;
	bh=bb7jkEEZNjgSidkcGYWlD/iy6gxqsOxLaonybRIpcfc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NcW+bkGV7HZRRngEbfKFl2pT7kx4tTPDLuA1mQkx1Yp5JLKeGA6HH1gVbucj2l4+S2yntuIaqH+ZnHG3sp+eYwTvGBfcCmvU+DFWB2nd+PumYYp5lhRVGMhkFPNWyY1orpdw0VI4r6QR7up83Jc8mcEGuL4Ic5hb5fGkWL+eDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTcnG7Yp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTcnG7Yp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso1771230a12.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504159; x=1714108959; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygbPtQMCV4vO9JumpWIKOn60QEJGrJYWuGHbfZ2sPsU=;
        b=aTcnG7YpSoKS3rfrFX4rB0N86LME5mDAPYUDJYvwp9//Qn2v7rCC4/nJsg7nDtU0rH
         EtyQ4fSL7c9Aetdh3xltLmjYDZnm79QGBncLbvM5yCVhTd5sM7CoNWMux7Tn3ekwy250
         0J0nU8ngduy7QEKQgIIyprDJqmpJSwEXzvidriDXf3mnbhfO3CgAJ0G+tf6iXWoDs9bC
         sIDXxBETQOY88uRi7dQNQ+2dySBDtAHjSFAmxIuiInNn9VJu1CorRlLKywQR9424G+9H
         GtcE0AD9d7A4zOMZzZsI8Ftgf0lBBnxr6lJo/YpXM5OJQQ6YRJihZQbZFWIMJGiubnLy
         0rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504159; x=1714108959;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygbPtQMCV4vO9JumpWIKOn60QEJGrJYWuGHbfZ2sPsU=;
        b=FnDo5epuSOaV48L6osR5FTfwMq2Gd4Mrzy3tkGI9SX10Lz7j2On73SwfwL0aPu8cl8
         vQopfRmPfLKf307/fy9Qa36e5v9Wz881V35nrw5TIEiUbzQGpKGzByVWNzDmeuvvKHMB
         C7BV5O8IS2Kr760XcLxCByqbblXb8kTxlWPpMTITWSCvMAeeZYm2Yc74gubOLqZBc9eU
         dvXnO+JtESel8edY3b/ppgt1vDLWB74DdnVPcZpIbLAhNWzGBdeha6RWL0Ngn5x9wAO5
         fXnsLJ31l/GlLW5nssSmnQne+57WeO7ivrJvM64lenr57t3kYdR+8YkMLS8BRZIqrbAc
         cWkw==
X-Gm-Message-State: AOJu0YztovjyOWz1j6ZatTdFeW6FCiv1vVr32YQP9Spqi89LPX/5iOWK
	SAK34+lpQZS0KqkZeazknXOSiKu9k9XsZ9Vn/9eNLcQUIhUC181g4iq94Q==
X-Google-Smtp-Source: AGHT+IGxglU4+X5Sxs9KZJ/WLr9MKtsf91YoNAHucgYblQbpeU0Kod17m5/hnHkwAmvsK/ku4Xl1Iw==
X-Received: by 2002:a50:8a8a:0:b0:56e:246b:2896 with SMTP id j10-20020a508a8a000000b0056e246b2896mr726489edj.3.1713504158759;
        Thu, 18 Apr 2024 22:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6-20020a056402148600b005702c757af2sm1666490edv.30.2024.04.18.22.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:38 -0700 (PDT)
Message-Id: <5520a98e2967401977dbc16f0d1ca77a8001178e.1713504153.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
	<pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:28 +0000
Subject: [PATCH v2 3/8] trailer: teach iterator about non-trailer lines
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Previously the iterator did not iterate over non-trailer lines. This was
somewhat unfortunate, because trailer blocks could have non-trailer
lines in them since 146245063e (trailer: allow non-trailers in trailer
block, 2016-10-21), which was before the iterator was created in
f0939a0eb1 (trailer: add interface for iterating over commit trailers,
2020-09-27).

So if trailer API users wanted to iterate over all lines in a trailer
block (including non-trailer lines), they could not use the iterator and
were forced to use the lower-level trailer_info struct directly (which
provides a raw string array that includes all lines in the trailer
block).

Change the iterator's behavior so that we also iterate over non-trailer
lines, instead of skipping over them. The new "raw" member of the
iterator allows API users to access previously inaccessible non-trailer
lines. Reword the variable "trailer" to just "line" because this
variable can now hold both trailer lines _and_ non-trailer lines.

The new "raw" member is important because anyone currently not using the
iterator is using trailer_info's raw string array directly to access
lines to check what the combined key + value looks like. If we didn't
provide a "raw" member here, iterator users would have to re-construct
the unparsed line by concatenating the key and value back together again
--- which places an undue burden for iterator users.

The next commit demonstrates the use of the iterator in sequencer.c as an
example of where "raw" will be useful, so that it can start using the
iterator.

For the existing use of the iterator in builtin/shortlog.c, we don't
have to change the code there because that code does

    trailer_iterator_init(&iter, body);
    while (trailer_iterator_advance(&iter)) {
        const char *value = iter.val.buf;

        if (!string_list_has_string(&log->trailers, iter.key.buf))
            continue;

        ...

and the

        if (!string_list_has_string(&log->trailers, iter.key.buf))

condition already skips over non-trailer lines (iter.key.buf is empty
for non-trailer lines, making the comparison still work even with this
commit).

Signed-off-by: Linus Arver <linusa@google.com>
---
 t/unit-tests/t-trailer.c |  8 +++++++-
 trailer.c                | 12 +++++-------
 trailer.h                |  8 ++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index 147a51b66b9..50c696b969b 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -119,7 +119,13 @@ static void run_t_trailer_iterator(void)
 			"not a trailer line\n"
 			"not a trailer line\n"
 			"Signed-off-by: x\n",
-			1
+			/*
+			 * Even though there is only really 1 real "trailer"
+			 * (Signed-off-by), we still have 4 trailer objects
+			 * because we still want to iterate through the entire
+			 * block.
+			 */
+			4
 		},
 		{
 			"with non-trailer lines (one too many) in trailer block",
diff --git a/trailer.c b/trailer.c
index 3e4dab9c065..4700c441442 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 
 int trailer_iterator_advance(struct trailer_iterator *iter)
 {
-	while (iter->internal.cur < iter->internal.info.trailer_nr) {
-		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
-		int separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos < 1)
-			continue; /* not a real trailer */
+	if (iter->internal.cur < iter->internal.info.trailer_nr) {
+		char *line = iter->internal.info.trailers[iter->internal.cur++];
+		int separator_pos = find_separator(line, separators);
 
+		iter->raw = line;
 		strbuf_reset(&iter->key);
 		strbuf_reset(&iter->val);
 		parse_trailer(&iter->key, &iter->val, NULL,
-			      trailer, separator_pos);
+			      line, separator_pos);
 		/* Always unfold values during iteration. */
 		unfold_value(&iter->val);
 		return 1;
diff --git a/trailer.h b/trailer.h
index 9f42aa75994..ebafa3657e4 100644
--- a/trailer.h
+++ b/trailer.h
@@ -125,6 +125,14 @@ void format_trailers_from_commit(const struct process_trailer_options *,
  *   trailer_iterator_release(&iter);
  */
 struct trailer_iterator {
+	/*
+	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
+	 * key/val pair as part of a trailer block. A trailer block can be
+	 * either 100% trailer lines, or mixed in with non-trailer lines (in
+	 * which case at least 25% must be trailer lines).
+	 */
+	const char *raw;
+
 	struct strbuf key;
 	struct strbuf val;
 
-- 
gitgitgadget

