Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719E13AD26
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876323; cv=none; b=WPkUDT0CJALF9U1lNkO/s4/MeOjNIOgjp9YvPezHL4AwxIUNmTOWOXfm+mJ0awkkc3J5YLVWeoYA28mXD+eKoNFXS9Dg+5jpaZ2YI5Ja4+b3E2aPpKEbuRx2ggnVjVfMoGZXYWHVSpvX6WXVGXxmEvPLo7gFEPzIoZlfq4nm7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876323; c=relaxed/simple;
	bh=DU5vO1rm0CHVJOHMAWbSWFTuz4d9xtelnmyX7EU2jkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFzyQfGlyaqYRAYb+Mfpp/BemyE5CEP6esRuhjlY/SKQInBPEHzrAQjry+8oJJUbuG+p+KTNv1oyuns/5uZ9jv1yNzOTq+Z3oDjqaEu0xlWlvnS+lTvIburQvUVFKFEy58N7Kw57DW4prXmNTLD+pZvnqcofi4oiGENmPoyJMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH7ggt/Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH7ggt/Z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fec34f94abso85774205ad.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876321; x=1723481121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3kLHL33M9LOGwT/r4LGJ9nevWsQqK6sbAQ+FttyaPA=;
        b=KH7ggt/ZZwIHFYfiyqGaF15qyM7amSs8/D4GFVGeTtg/hVKZKt0sDlqO0peKpoNEAP
         dek9VHUQTiiviISPKBlVHDh9lmMskbm4YnOo/4qffxVEQk0nrfYiWfcaJGikhpvqci4u
         JS3+6Q0aXG+a+0Mut6WujPB8gogv+EVwBjTQULHkm6pY6qwSMLIEEC7leLBHhWBmUuJe
         v5fe1aTZUexWYFne0NCFo0x2IxNR/Rtkd8nigjIHsGotYX13w4ixH6tH1Sto8xLbt0hI
         938DEhMnSsK+3aCs6KnPFwz/jdUkJxfkqk1gRAFEAfC5TsCl7r5S/R3MEsTEqGtquXdl
         /seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876321; x=1723481121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3kLHL33M9LOGwT/r4LGJ9nevWsQqK6sbAQ+FttyaPA=;
        b=YHtxoCpvx6mq5IGUHS+/c6FHHaAwlNHnmoyy/3n1TkB7r11nQ9lJh218Y6uH9m+6V5
         31lY8ph/35zGT6VDNeeP7sMZiQvinHqGbp+7qwYSZfC5dNQTvlNr9dCa1cxJ6LU3c8oG
         6cvRt9EF3etWd0TtmFP4linfhycbgL0Tu3kD71g7veT5C9ZHmyhUXFqJDHeNrDJwT2RT
         TjoGP3kWuadeQeu5kMzTsTA94LouYVqerIyA3t06i5rQm6SCbZMZbrJDHdjJnT9hQdSM
         uv60mMlglByrlu1Vmc8lKktQHRUHk4GTToWkbb+uO2PVE8Cxr7RdMNpQ8zP6omOdMSz7
         thJg==
X-Gm-Message-State: AOJu0YwMCxH4pfwsX7l7a2y5DbyAXKddeh7/EdCuq2pXwy3O1Qkhvn/v
	4925OsKPA9rJaK8UpKnunUo4hTaXCWPXKA/PUVWRsBZ+QrAqCUnKOOUOVg==
X-Google-Smtp-Source: AGHT+IF56LnhhQ18mlqn7/Pq5dYqQujXGfd9qzSM5NOPQdvXEfgtKg1WuxC8oASxckTAcBbeFvMeZg==
X-Received: by 2002:a17:903:41cc:b0:1fb:46a7:dbda with SMTP id d9443c01a7336-1ff573c0001mr120606615ad.47.1722876320712;
        Mon, 05 Aug 2024 09:45:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592acd2fsm69933465ad.286.2024.08.05.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:45:48 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 4/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZrEBvB9Urj8mG4i-@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

The static function "report" provided by "fsck.c" aims at checking error
type and calling the callback "error_func" to report the message. Both
refs and objects need to check the error type of the current fsck
message. In order to extract this common behavior, create a new function
"fsck_vreport". Instead of using "...", provide "va_list" to allow more
flexibility.

Instead of changing "report" prototype to be algin with the
"fsck_vreport" function, we leave the "report" prototype unchanged due
to the reason that there are nearly 62 references about "report"
function. Simply change "report" function to use "fsck_vreport" to
report objects related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index cca6ae144f..3614aa56a3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,16 +226,15 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+/*
+ * Provide the common functionality for either fscking refs or objects.
+ * It will get the current msg error type and call the error_func callback
+ * which is registered in the "fsck_options" struct.
+ */
+static int fsck_vreport(struct fsck_options *options,
+			void *fsck_report,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
-	struct fsck_object_report report = {
-		.oid = oid,
-		.object_type = object_type
-	};
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -243,9 +242,6 @@ static int report(struct fsck_options *options,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, oid))
-		return 0;
-
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
 	else if (msg_type == FSCK_INFO)
@@ -254,11 +250,31 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, &report,
+	result = options->error_func(options, fsck_report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
+
+	return result;
+}
+
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	struct fsck_object_report report = {
+		.oid = oid,
+		.object_type = object_type
+	};
+	int result;
+
+	if (object_on_skiplist(options, oid))
+		return 0;
+
+	va_start(ap, fmt);
+	result = fsck_vreport(options, &report, msg_id, fmt, ap);
 	va_end(ap);
 
 	return result;
-- 
2.46.0

