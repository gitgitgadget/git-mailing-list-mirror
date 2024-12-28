Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F0156886
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735386160; cv=none; b=hUDVuocWEIkbWL49WTez0ySlOz+J5H/te17/CzCgT0A0v9kqRTFwzTVw895HxFr4br0l9hLr7LDdelhQTpX59qq5vMKl2CoXZ6pDKXd+F7+jprS6dfpY5/ku4uTLf556UAOohatVu4cVine5XonuXAwO6tLdAYYeLiIZ0l4P52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735386160; c=relaxed/simple;
	bh=ssCkZVwTZ/7VR1sEJiNe9AdN+l7Mac2kQ5vrMNbZUjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5j198GA5irf37aaLa6V2kp5vPX2ST6VmlpZ7pIQPf6mFTzyLPXaULZTv6TwcrH0cL1W++cqcFY+LqC6u60iyzPaEzEu6kvI+6HhMGCFivpaJBMty5DSnjdpl3xJVTcXYhkdMgyNfAKJWpecU5EcjIGTsfsdaa9H0fligHLGQ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=Q1py4vP+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="Q1py4vP+"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaeef97ff02so611893666b.1
        for <git@vger.kernel.org>; Sat, 28 Dec 2024 03:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1735386155; x=1735990955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbSdW1vsH23n3kpHtk6MmSnVjssG/+w3O41gKlDgmb8=;
        b=Q1py4vP+I63s4CbzzDTDJhvLphzz1+R198T0C6Hk+GuXC7OThPC7tzR0drTk7T6OEc
         J9nd4Sr4q4h5U+QYVuZtoz1pJGrZx4wzo0Uim29rg+gg2JSbZgF7e6G5QTd7t9sJLN6W
         qkKHEx44pUTzzy6NSNu7cP2FuFJvOOH7aK768hVjMke/urXUeIIjL/kWL/GR3Y5fkzRF
         8zZrTgilwqROtPIcuqjJDYMN+vQgqm19RBD7V7PF7Eeqp9kaBou20FL7wHXEssUGew1k
         4z7jXdVr2KNLdbTFAN2XZk9n07S5ofwXJs0ReZBnigMSk1IbJr/lBZLjEmCOM/F2h3kO
         g19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735386155; x=1735990955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbSdW1vsH23n3kpHtk6MmSnVjssG/+w3O41gKlDgmb8=;
        b=e9MDR75FYIg1+MuOX8Eh9JEZ7IBRHbJAUusNbarq0Vt3mgU0WHfa3AodFDg04n4HVg
         exR/Jtannxk5jkKG9MaRRQ3CQ3ETX5fcw9dtk3dH8kXanLVCD4v0u9zXFPJjyDFZZKVI
         Wxhd1bc29QjJrqdHqemvvC+DOpuvg6SnNOcoMjK4ps5nvzRFoZfQ+10oYU0DxUd18VWR
         5FmIDAz4SdeVKxszQpa9y4zILlB9r2+iCGCuJYcRIrdoXFxFCnEKHPU4C/Cy6qI4Homr
         N7/fQaWxcYIh8HVFRclhVFitbVbHkIDcaQXWA5Ir2At65Nt656e78FmtmTqX/uJsqcqM
         FDCg==
X-Gm-Message-State: AOJu0YxgjtnMOj7IXr4Zb0KMUUNH59zB25r5AhlOtt3tYFoMyWkSxd6X
	d4SDC3T9mSJMkp5fdraOccPcX1Sz7Z3z9bsSF5bQ9Xq7b1qM/IeO7F/dCU2r73ong9KO2rMr2zC
	M
X-Gm-Gg: ASbGncuhxa8pzPO4XdqAlzlLNh6W7SyyqislKrzfdAclyfP0YWHgTlooUSJ1wEQC1nq
	Z3Xq6u1Gi8REp3fe1fIkQfTrGWCFWSAwcPFdWqHdmAVpBxO1RBUdVRnkSK0WzuElrrS0joX0a0W
	SZ9j/J5j+SbO2UuztLVOkZegeZM0cwnU0/FKlPX8+irLYc8RSB8JIoxkzXskIL0LBNCLozesSBk
	1pesRIZNyfz0ZuUbkOCRoSqEmcL9gHkFOylu5rfz42ZSWgfWi2lDZ8twfYVVbrugvGLynIS2I9U
	DfDs
X-Google-Smtp-Source: AGHT+IF8Uyj+4IVWPaCoT44tVjtXKPoB3iNtY7wgeAjsKQGOZ6mT+U+G/8WkR1ir1X5hqG3z+XKFXg==
X-Received: by 2002:a17:907:7f0f:b0:aac:1e96:e7cf with SMTP id a640c23a62f3a-aac334425abmr3020568666b.20.1735386155422;
        Sat, 28 Dec 2024 03:42:35 -0800 (PST)
Received: from localhost.localdomain ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe4988sm1251511166b.124.2024.12.28.03.42.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Dec 2024 03:42:35 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 4 1/1] parse-options: localize mark-up of placeholder text in the short help
Date: Sat, 28 Dec 2024 12:42:18 +0100
Message-ID: <20241228114221.10351-4-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <xmqqjzhm7jgl.fsf@gitster.g>
References: <xmqqjzhm7jgl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i18n: expose substitution hint chars in functions and macros to
translators

For example (based on builtin/commit.c and shortened): the "--author"
option takes a name.  In source this can be represented as:

  OPT_STRING(0, "author", &force_author, N_("author"), N_("override author")),

When the command is run with "-h" (short help) option (git commit -h),
the above definition is displayed as:

  --[no-]author <author>    override author

Git does not use translated option names so the first part of the
above, "--[no-]author", is given as-is (it is based on the 2nd
argument of OPT_STRING).  However the string "author" in the pair of
"<>", and the explanation "override author for commit" may be
translated into user's language.

The user's language may use a convention to mark a replaceable part of
the command line (called a "placeholder string") differently from
enclosing it inside a pair of "<>", but the implementation in
parse-options.c hardcodes "<%s>".

Allow translators to specify the presentation of a placeholder string
for their languages by overriding the "<%s>".

In case the translator's writing system is sufficiently different than
Latin the "<>" characters can be substituted by an empty string thus
effectively skipping them in the output.  For example languages with
uppercase versions of characters can use that to deliniate
replaceability.

Alternatively a translator can decide to use characters that are
visually close to "<>" but are not interpreted by the shell.

Signed-off-by: Alexander Shopov <ash@kambanaria.org>
---
 parse-options.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..8904345c07 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1076,11 +1076,23 @@ static int usage_argh(const struct option *opts, FILE *outfile)
 		!opts->argh || !!strpbrk(opts->argh, "()<>[]|");
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
-			s = literal ? "[=%s]" : "[=<%s>]";
+			s = literal ? "[=%s]" :
+			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
+			     Change only the `<>' characters to something else if you use another convention for this.
+			     Most translations leave this message as is. */
+			  _("[=<%s>]");
 		else
-			s = literal ? "[%s]" : "[<%s>]";
+			s = literal ? "[%s]" :
+			  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
+			     Change only the `<>' characters to something else if you use another convention for this.
+			     Most translations leave this message as is. */
+			  _("[<%s>]");
 	else
-		s = literal ? " %s" : " <%s>";
+		s = literal ? " %s" :
+		  /* TRANSLATORS: %s is a command line argument name, `<>' prompt the user to supply a value for it.
+		     Change only the `<>' characters to something else if you use another convention for this.
+		     Most translations leave this message as is. */
+		  _(" <%s>");
 	return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
 }
 
-- 
2.47.1

