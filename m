Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952223EA8F
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875770; cv=none; b=k9rrnbZus5pa0lPRC1enVwoHqkWRePcY9NlS6orv2VVWGGvyJd2+GSxj3hzn2nqt8F3WlMYDkhy/eVpVTw5WnXk5soCPCzcJqcfdFz5YJtqYPEdqv45XuC42zIiBR8mTLhopcLhkT9VpBtYNG+kDOMA8zFriJTKPgwMskfY5HyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875770; c=relaxed/simple;
	bh=waV8esdc6tiMhfkBpbo+6E3VrngMgStYVC0afpXDeFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In7QbC8aII+35C9/E9iqGnz1eCW00fxn/H5XXOGhbF8t7jE+jXEjQf/GXhSomHIl93tGs2C4s7wcrAEoJ6jPT7JpoY7gT6uga1sTkMUSWoRS0sbb7RZoaNqBA2WvOvjmM6tJ/EB2wHdLfQvfUeEbFgy+IXP4llV/Umoz7zL/UfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDyC4d+A; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDyC4d+A"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so3126363f8f.3
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 05:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760875766; x=1761480566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMC7XMrY6R8tXye44EcELVr5rWI4B89vPt9xDJfq9ks=;
        b=PDyC4d+AhchH6TDr6z/AgPo+tRhgVzpIY3aI85c0ZaYdEThTxZv9/R0B3dOkulI14z
         kPyIi+SqgjwM/KgjQ7WpglIVRz0K3ynworHlUL0wT2OMS3D98W4Sto3nbU0SY/83O2l/
         ouVDQOaCNcndgWL48FY5SV4Dq9e2LnpJeBE9qIiIAClIgZj6MTN3HEcNrc2/CnrUZrHY
         TXlEuBVJrRP8o/ekn+F2ULTw/+DvrZ5WFO/3Qn5tizog+PAaoMTEXA9av8YlG5RYuprk
         nX8HI+nYXPy8kg+Fdut5ludHeJ+YCQKH7KjI/551oDnW5iSqYZLTsGCI0mcqeOZu5FfV
         Nq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875766; x=1761480566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMC7XMrY6R8tXye44EcELVr5rWI4B89vPt9xDJfq9ks=;
        b=Ii9o7cJoiftaLDcl6RSJvLmy4OHAWR2VD1mZjPiEM9sJbmEQR+djj9d+58ywOb/SoZ
         nFkARyE4q/e+jwqKSgWGvErBWDpQeK7eBxI/e/yqxLugZYV9ipd/cLDaMir9tudvVvE1
         wiDaB/K7Elyh85VJ5/He2VdiFwKqyqbnz1ov9zIU04ud/kqytumSzWGFfVDKy4EXHno/
         +p8+hYYVR8SkcIzY397snYM5cUfQHy+v7CFdLsUAuknsLTTgnKLRdkUY09/X4p1kPPgu
         4g68Mm5NfxyvymEGCXckwY00cSWHqBlU/JIhmLC4sVXFyjYwZKxqr268Z78JICmBnVns
         YBDA==
X-Gm-Message-State: AOJu0YyiZcpUuC+RfCZSu/kXuwfp2E2BlMMQ0bXzhRoT3miZHiDGUeD4
	QjiNNhsnD72vHE734UTRkLc1o2YnwtKDk1oaZWEw1p0VJd3gkEXUi03U
X-Gm-Gg: ASbGnctef3ZHJ6wZM17h6PLXxdDP6YFI7tIwhgaVjcD9iOf1aSszAi/0Ji7WzxBUkdR
	l6RWHB+UWIuZCiLXijkUgIOrx3eIzeNMdr7HH024asJ/nAvOvekSJcbdrj0egxECeus0doXGNkP
	VKYYoZRGt+yAbIVDyAJnpkqSbhJ4khj9RO1Z3baqtPGXUSWAgqzk5YQuRI+qJ7v8X0VyKlxZrAy
	GzLXXUfo5txXIpg7UIAHTM2HzlJj6+w1n7xABiEUfeTGxu/P2srv3AMy6KnPTfz9JnIc8xcyZhT
	b0uo4Vqla67BB1G9dDoQUhczzScvjafIfB83TQ4OSRIvrRvha4fXHAUUnjOgmXDUhFfX4tZQcYR
	dTQw6Jz9tr1RvrkOgCBKKNWD8sMVUtazcIP1DEFLYyY/50U6DFf1x4GvqVZqFjCX4vXGG
X-Google-Smtp-Source: AGHT+IGUchd+cjeoC6pqS3CkFV9QMMORpmYXWGQRuJ2Aj4JHYK2l8KIVO3vvqmuIc+OL/D1WBLGpmg==
X-Received: by 2002:a5d:5f82:0:b0:40f:288e:9968 with SMTP id ffacd0b85a97d-42704db9eb7mr6356018f8f.51.1760875766301;
        Sun, 19 Oct 2025 05:09:26 -0700 (PDT)
Received: from ubuntu ([105.112.227.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a9a9sm10104707f8f.29.2025.10.19.05.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:09:25 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*() with string_list_split*()
Date: Sun, 19 Oct 2025 12:07:42 +0000
Message-ID: <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760869186.git.belkid98@gmail.com>
References: <cover.1760869186.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_ssh_finger_print(), the output of the `ssh-keygen` command is
put into `fingerprint_stdout

The string in fingerprint_stdout is then split into 3 strbufs using
strbuf_split_max(), however they are not modified after the split thereby
not making use of the strbuf API as the fingerprint token is merely
returned as a char * and not a strbuf, hence they do not need to be
strbufs.

Use string_list_split_in_place() instead for simplicity.

Note that strbuf_split_max() uses 3 to specify the number of tokens to
extract from the string, while string_list_split_in_place() uses 2
because it specifies the number of times the split will be done on
the string, so 2 gives 3 tokens as it is in the original instance.

string_list_split_in_place() returns the number of substrings added to
the `split.items` so for a successful split of the string in
fingerprint_stdout, at least two items should be added to split.items
so we can always be certain that the substring at index 1 is the ssh
fingerprint even if the key owner's identity part is missing from the
string in fingerprint_stdout.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
Reported-by: Junio Hamano <gitster@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Junio Hamano <gitster@pobox.com>
---
 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..cb182f4c11 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -14,6 +14,7 @@
 #include "sigchain.h"
 #include "tempfile.h"
 #include "alias.h"
+#include "string-list.h"
 
 static int git_gpg_config(const char *, const char *,
 			  const struct config_context *, void *);
@@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
-	struct strbuf **fingerprint;
+	struct string_list split = STRING_LIST_INIT_NODUP;
 	char *fingerprint_ret;
 	const char *literal_key = NULL;
 
@@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
-	if (!fingerprint[1])
+	if (string_list_split_in_place(&split, fingerprint_stdout.buf, " ", 2) <= 1)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
-	strbuf_list_free(fingerprint);
+	fingerprint_ret = xstrdup(split.items[1].string);
+	string_list_clear(&split, 0);
 	strbuf_release(&fingerprint_stdout);
 	return fingerprint_ret;
 }
-- 
2.51.0.463.g79cf913ea9

