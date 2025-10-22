Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0B34404E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136838; cv=none; b=tOLf//U0amLOqcH/qQpg3wM7phkznS9xNnZPMkjVdel/QvAzxts/RZKS4VJP3PD58jYYUbYxv+FcdXn+QcASb8d4ABlPEDmuLPdAPZLO0fUlaIbcIr2xKGPnN2HYq06xDx0DbUfUqLQa+crxSKau5t6recuB9Ob85QcykEscCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136838; c=relaxed/simple;
	bh=MsQ0cu+FDeCzJi5wdwhgpWsH3boCgtXdDB31LyNs0PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdpaBeKl6cSgNUug9nF4/R+XXHEb/BvGGTNQ2JrUF7RtDF4OZi385JRzFIQhdOCEA5XYrPVfOXNKFw3ur7usgRlAsQgAI8upaW21iFreP1MlFDqYEQwLQGpVcUT5PT3xkt6c28mBLzFvAJUXjcBOmEnh11C6/40U/N/5oCSjgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMhLxhRj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMhLxhRj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47117e75258so34579845e9.2
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761136835; x=1761741635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdY3gzEcajOYPj7QsgC7YkUA+kOL0Yp2HCl80FPrhh0=;
        b=GMhLxhRjcto5FzPJm8CkG6PICt+rjQcj3PPyAWMuDGAj/JyF3+NQHFLXsVd6onYKXa
         p/U4a/y8C+akZfytgizLDxiivK55/tEo78rTn0K2wGB+1JJXpcqMKA7Tsr6pG6881GwC
         yCESuYSqV9hpzayjuSLCTSPJ7pSSE4i5/AQzTk1ENDxTHTHv/i4/UlaLpqZI3vjjP+gq
         /YQnK2UP2VzLxv5UfmHoWe+ygJB+kAS/Wgcsx77c5IbgUJSFr791NLmzxwA7uhUcvGTN
         JOe3LfjRwH0vXZTQSaVjgg9ehj+5Z0I+cycvlvzfYBJoDnPSyetTRUlxXwPRLPTA+ro4
         19yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136835; x=1761741635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdY3gzEcajOYPj7QsgC7YkUA+kOL0Yp2HCl80FPrhh0=;
        b=NoFSQE0bOaJ+T+RXuweTr7IOdkSCaVqBs7b7Otpel3hVup6C4VsWyp2DgIROT7Ep8W
         56NZcxqSWc1sA7Vu1GV3P7qNnolvqQFdUJ5bFp6FJD68CqEFv8FZeRK6ax/o9t7hOWx0
         2sKd9cflBG5SlY6QKFan6ba6+fSMiXJWafrWZtM/JanBiN8dazoCsHXRXXUe9skUlbco
         dg/MQlG31q3vlllQROl9xFh0iFy3ZYWeBHntfhW+O9rcHMUuEpJo5e8dmR8+C0J72Xa5
         Y71ZztohyNT0v+lhjo/BAKfH9QUQ23XtomarZci8BH/4vjo7xBIynKCCAD+0cnWCblfB
         +DpA==
X-Gm-Message-State: AOJu0Yy4WTuBzr9u1kZ4vh86NIrsSa5hSZEnXnpaMGX5AOf7plj+4S5v
	7ex/wD4z6MVOIsgXEL+yE5GETxA4aF2QK8Eu5OdLKGwcxUF9AS4b5jpYmEYMlbkTVD4=
X-Gm-Gg: ASbGncuNVvn68XabuLnMV7k4X08/oA9IgthpqgJSNPkh6WYZ1iKFSgbHMBuQ7sN2N8K
	TLZy+yblLSPPIy8U9F6G2fCOxEHBfX3/tl9i08/mFUxC8xM8HurwG3PR/TM719aKudIkACyrI05
	LgHzseO847HIKoBSVKep2bDmAA7gKCSPQik067C7jxGYYN152MYc++yv+WKSya0guv83cLRVxRJ
	mCP2MWbHb65UQKTT0OWTKRc+TZQzlaUpU14EGmA9lFr9n+dPY8EcohXyt6D4sXFTINaMYhcqO9p
	M2EIoijha7Np6JfWzYYO3g1Da4CUuWJM9Hn9CgduoaYWjxYs4A0SCYQLfRK97epf8AoGi4QHIxa
	yT/8CpEQcT5B6dEutHnmyk7e0K2yxlm13sgb36pHlUoJ/ie4ixu2HnVgoGVRv19SS0c7wMKqZzo
	Fk6pi/NnHMZTgKWQ==
X-Google-Smtp-Source: AGHT+IElNBkxjfoOWgh+1NE8rorCqPgIO/0ZMgx5k+akcJmZNevxBC8wdX+VC9clcHiKvbyudZcOcw==
X-Received: by 2002:a05:600c:458b:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4711791cb4cmr181026295e9.32.1761136835230;
        Wed, 22 Oct 2025 05:40:35 -0700 (PDT)
Received: from ubuntu ([105.117.1.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342946sm41516075e9.10.2025.10.22.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:40:34 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v5 2/2] gpg-interface: do not use misdesigned strbuf_split*()
Date: Wed, 22 Oct 2025 12:40:20 +0000
Message-ID: <5df667227b8b8951bad6c3cba54230ea8f6d3830.1761135129.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1761135129.git.belkid98@gmail.com>
References: <cover.1761135129.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout` buf, which is then split using
strbuf_split_max() into up to two strbufs at a new line and the first
strbuf is returned as a `char *`and not a strbuf.
This makes the function lack the use of strbuf API as no edits are
performed on the split tokens.

Simplify the process of retrieving and returning the desired line by
using strchr() to isolate the line and xmemdupz() to return a copy of the
line.
This removes the roundabout way of splitting the string into strbufs, just
to return the line.

Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
---
 gpg-interface.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 917081abac..ad6ce58da8 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -865,12 +865,12 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
 	char *default_key = NULL;
 	const char *literal_key = NULL;
+	char *begin, *new_line, *first_line, *end;
 
 	if (!ssh_default_key_command)
 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
@@ -887,19 +887,22 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+		begin = key_stdout.buf;
+		new_line = strchr(begin, '\n');
+		end = new_line ? new_line : strchr(begin, '\0');
+		first_line = xmemdupz(begin, end - begin);
+		if (is_literal_ssh_key(first_line, &literal_key)) {
 			/*
 			 * We only use `is_literal_ssh_key` here to check validity
 			 * The prefix will be stripped when the key is used.
 			 */
-			default_key = strbuf_detach(keys[0], NULL);
+			default_key = first_line;
 		} else {
+			free(first_line);
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9

