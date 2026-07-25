Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285D361640
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980536; cv=none; b=oi7CGT9232JQXsU1Km7a+hCVjVAada7NzXL3XSVyhI9DpyMnKHqXqjxiNxMcqNIB3aw2L4mOHIzk/Gkkxg+zz/45vdUWLZAqOh9GlMDlHmL4k4AUGZVSjHJGqJwfcvHI6YF6FRloDo7SeZiw7EVl59vhJ7/FyXI7qRHzgHx0zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980536; c=relaxed/simple;
	bh=or64UX2e+Wfi7bqtQzl5s7uyXejx2VDdfqbOb5ay8fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKliJQQbq1ie/gH14+iJyaeadOxmzuMhc1ZYWwcrXCrD+bHd3yLPaUOKLwIWquxrvNXTwTRuSOh6C3DUmDfMG/ngcRJMSh3/760+wRi9cfVCiwnw2OiqjJOSpPhQq9Y7vtNiD4iRBG8VV2vCELpy39n3H0SQV51c1pQswgU8/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWQHCxI8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWQHCxI8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso6334295e9.2
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980533; x=1785585333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MXxNPCFAhQqDKvzt9ot2y0lc51ulozkfL+XRqMkWucU=;
        b=YWQHCxI8r+5f3lSOoMrTQto8gIC9OlwUocfmmRPsL60N82joLZyAQiVCgaVB9Jji48
         DhaV0lHzhRsE99AfZkBKsgh3cKaS34BXzaKljhnHZ6dUsSzThLGRRZxUZM45AYp03pVm
         Tt0Pp1IVS+w1cl6sw/AkHf6cTR7tkp4GOFfLW7YOESflA7zJFsW7m+1oLQYikQ/2VzyA
         wcxFFKeDzmZQUE7k0CBf/jzJZTmbl1ut5viUDp4Qa7quG1vRqPA9ni1QT3MIKv6nb9Ex
         Gq4gcmUQMvvp75RLfVQiR1ex1R0DjG6vy8LXBpZatUnxfz4XOXLJddLymNfU/eBbxALw
         d7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980533; x=1785585333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MXxNPCFAhQqDKvzt9ot2y0lc51ulozkfL+XRqMkWucU=;
        b=dMsoVcIPhDJ5StEmsbNIFGcssZyVGRSxkR5+lxYQvNetM5yQqbmB3MITogibONVbsE
         5SAQDtxzyGomS+G3CmiAVzaGe/k+9jvO3TA8RVGpMkQhTc5uTCB4bAHccigvXPuJL7Sw
         SLrDQXq6ZcfNTTjKPMKNd044zkitQeB56gPjDNZ3nuhB7nUzQy7MXpOPjzWTz6DAm/rG
         7lcldLb1wR6bA92bXW9y/biLvSrLA9p9VgD3xUtHqquF7/NVsx9am5X9WryDdGE/sh7P
         7BDP1LShjZ7Tc+RSrQrj0E4bMyscc/hlhLUGX05FIZruogQ5I6kaVEYtvcNPGoM0rlIi
         xuuw==
X-Gm-Message-State: AOJu0YwCLnyOxyDdoLXichxdR0y5hHcxVMhfn6sAuS1motKVemb1N92p
	BZATrVwJikjq5FOQHkNT2pcd0yFsjgWQaYNFrnQ1o5Ku+MrJJ6AooVlj
X-Gm-Gg: AR+sD12u/f23H4eok5cu4DpIhwbKNWY2VAFdITfb9HClSsMM1k9XCOKzOcvQH3iEqn3
	npiFrhrEES7FQoXqS3xdoChz9d+xqjVrft5xTZerohK52qZPNCYDoA69cXa97gFwy1NEBNrDb9s
	ffomXDm2AExifRTSyvmmYzxezZyE4Vl0ITYgjxJVlxrjOWLk2T41d8IACuy1pJ815mA3THTO7/a
	Q8IuPIJc0FpxaDP/YjcvaDD+KWlEv2biFCoSo4H7QaPbQfXIwQG5JK+ZBhSGNQLpgYk3do9r1KX
	R5ibCqzNTyO5u1z7gndX6bpXJ5nBvv2Joty56t8o/Be57CjF8rC1Vyhjn/ji91hx96VMHMFYY0D
	+pcnpOLsnN4C10Pf1miFAaJ/Wk0TAO2fadnqt67l+NR1/zmixZmpXZunywiGTcwhIPknzOZtLYb
	I/e2LRXo2tCX/lb6PlTsImlFP7kiYeLiUJ2WqUOwxtzpGsDD4nu9GOCRDP7OL/y6F/7NSUgq8og
	bZzfwuOWM877B2CuL05GRCn7chO+sJRXDJxAckhoCj/sTSNtQ1wO7gd6pQ/PenKf5BMvJMU8KhW
	HQwzTItRmuE4aSpOhwzkPGUtwvyVASSFcLdKM9d0zcMY4j2zJsiUOBBVOlKYYfl5xBqWRtf0GmN
	c8YbKoruo/5sbYaoI9DIFE6kDhrS/VMGNqzL3v9bSOrypNOUDBsuCaGFGJPZXZuhrZEB3lWLkyg
	==
X-Received: by 2002:a05:600c:820e:b0:493:e365:ace9 with SMTP id 5b1f17b1804b1-496b56e6603mr22295395e9.11.1784980533471;
        Sat, 25 Jul 2026 04:55:33 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 25 Jul 2026 13:55:03 +0200
Subject: [PATCH GSoC 2/5] fetch-object-info: parse type from server
 response
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-objecttype-support-v1-2-2d4ca3bbabf1@gmail.com>
References: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
In-Reply-To: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server can handle type requests but does not advertise the
capability yet. Prepare the client to know how to parse the server
response once the server advertises the capability.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-object-info.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fetch-object-info.c b/fetch-object-info.c
index ba7e179c44..cf6b94afb8 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -50,6 +50,7 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 		      const int stateless_rpc, const int fd_out)
 {
 	int size_index = -1;
+	int type_index = -1;
 
 	switch (version) {
 	case protocol_v2:
@@ -101,8 +102,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			for (size_t j = 0; j < args->oids->nr; j++)
 				object_info_data[j].sizep =
 					xcalloc(1, sizeof(*object_info_data[j].sizep));
+		} else if (!strcmp(reader->line, "type")) {
+			type_index = (int)i;
+			for (size_t j = 0; j < args->oids->nr; j++)
+				object_info_data[j].typep =
+					xcalloc(1, sizeof(*object_info_data[j].typep));
 		} else {
-			BUG("only size is supported");
+			BUG("unexpected object-info option: %s", reader->line);
 		}
 	}
 
@@ -148,6 +154,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 			    object_info_values.items[0].string,
 			    object_info_values.items[size_index + 1].string);
 
+		if (type_index >= 0)
+			*object_info_data[i].typep =
+				type_from_string(object_info_values.items[type_index + 1].string);
+
 		string_list_clear(&object_info_values, 0);
 	}
 	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");

-- 
2.54.0

