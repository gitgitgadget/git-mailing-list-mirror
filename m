Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD3273F9
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515168; cv=none; b=usdDWTR4KOK4a/VwrGzbu7BU/Ik4mofGLqMTkS+RjfanNKe8rWyOyQYugk3MzdBUaKEiMAxqseO6vtDBXAPCVN5/Fx/S834JLOuganNrhPT4KLIaAF2s0EQK7x8kfHTM4of2HrpxlVjEDzrQZ6C07PkCKRuNMtWZhqZZn7EdoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515168; c=relaxed/simple;
	bh=94i0pyGyKqoetI7ONTG/8Mu4edOjnT+mB+RsKLenx4U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qWc/WnGOd+kXpWTagFw5l+2b8TSb2ekCNPor0Wc9cJl/f51MRxOcz+xZdyoQQkTqoW1DYPTuA/2G0bxROGHge7aqWt08SHNwqIH0gIrH6pbXnZ7vI9iC+N9IsDXQwnoIGDaUjkLvP+nlQjwC7Bgvd2xFn+btsH/3GNH2o/jJVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laX52rH9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laX52rH9"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso27916775e9.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2025 07:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764515165; x=1765119965; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K6Rj1CRD13fjWj3+jz7YoMKtrPzClIAIRRdOX366EtA=;
        b=laX52rH9XY3EcPirQoCqHZsmn5ufMWYK6NHuYPwbZTPOjQ9oNttUDyBjTXmxtN5/4k
         sZj8hsVMYQCX+b7EBS7RjS6CpJ+apt4aWlISRcNCp1Vl9wOdsEWRmo1TxKo28Uk9Il9E
         /fjz3HSr120zYmiPjGSkJg4IcABseH8sVxrzctv8GnAULikBRmuGrtATxmB6MyWHKqbi
         BSU+FsgkLDhWaWtbW5KniehEmJJ8LHRcW9/DNjw883UEQ5CArEwjoMNNqNyD3FoPMZeL
         Wy9Mw+KAbEeAR9xLTg/0pA8fJol8wjeFZkfER9rUlGURD2aKRCtwppTIlbP65TbdTkRX
         E8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764515165; x=1765119965;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Rj1CRD13fjWj3+jz7YoMKtrPzClIAIRRdOX366EtA=;
        b=MBTjHKPuLn7yh866Jtf3ZG1P/bfhr2CYzFwcDJ86v7Ra30DRKV8KmAQWIf72pUwQoU
         uft4y79HyseRks2M2qgOsyt0nUnToDEF2xTm8hbse5mC+BSsnBnyUMEgJvLqZWYR97ml
         pdmHJzMSdQaJqIuirCbwr4aNxiQ1hLaOUTcXsZaN+Aiesl8tCN8u6v2LOI6evOpV4BCk
         VJGTKo5nf4vUo8dkK7VNDkrB6tQK5Gct1egUSJzoFWFU1q1C3TFjReQPNUKZylXkil46
         WcjhVdTXlkSt8l37mzBUicTmcb4L6j3rPrgJLRoyu1+7V9EES+O1YKKv/LgfXmt8Y4E9
         NooQ==
X-Gm-Message-State: AOJu0YxbDrb9Ax8MVo5MiobzmyuSNuJ6aiJulFh5pdb2SSmjy7oQfG/d
	cyPlpx1bfFLS7hFoLZxJzsg8B2TkEUuW7FhxFb3wGrVlDGFtuujzjWXO+LvqzZU8
X-Gm-Gg: ASbGnctHrWmkFH2KN/b6DeiCb8wabxjmS/EXLUZqc4LQ7dzwj2/yH0P4nq7/0z5nJcR
	IJIQSRjxmzwvYaW5vOFxcaQUZZu4+JaS8s7L56E7vTaBmGIUQYzhvduTQC+z2kklNZqy1m8hrZ+
	h6brxj3JXuV5eck1+6OZe7QNuhmBtgNitu7Lcvw3MSWlJlrf0i2jC12nvRcq9fNf9hEr/GykDNn
	DIJsDT8itmFq/JTWKcESjZhsoq9cVZ3Q8V315wpjmz+D+EQLYA48mvMdEiA2y1S0IAelPbNjxwN
	IHEHdkHuBQHR/2e8GF7kv6X7mn5RaCKg2EgGhq1KKQZ2xAxtb58sw5YCYiQXVWYKtKyaac2pe/M
	ooa/f/Djhq+f109YPCBcbU1hLQlkilsahMlKoVwZaNF67MLG0kG8bKfEM7UHnBU5VnfrO3z+l4y
	wngmWyqHfg84bYa1kw4yUTNpwWQCdw
X-Google-Smtp-Source: AGHT+IEOpM6jA3Gxrhl6hirkH2baACVsdO31wly+a1mMT6r51SfcGUPRSlohdX6ak9IA1Rv3VYS1Zw==
X-Received: by 2002:a05:600c:b52:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-477b9ea35fbmr262339665e9.4.1764515164715;
        Sun, 30 Nov 2025 07:06:04 -0800 (PST)
Received: from localhost ([105.112.233.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791165b1fesm189371295e9.15.2025.11.30.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:06:04 -0800 (PST)
Date: Sun, 30 Nov 2025 16:06:15 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add -p: show hunk selection state when selecting hunks
Message-ID: <aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When selecting hunks to stage or not to stage, there is no way to know
if a hunk has been selected or not when navigating through the previous
and next hunks using K/J respectively.

Improve the UI to show whether a particular hunk has been selected
or deselected to improve clarity and aid the navigation process.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 173a53241e..e70e390506 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -45,7 +45,7 @@ static struct patch_mode patch_mode_add = {
 		N_("Stage mode change [y,n,q,a,d%s,?]? "),
 		N_("Stage deletion [y,n,q,a,d%s,?]? "),
 		N_("Stage addition [y,n,q,a,d%s,?]? "),
-		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
+		N_("Stage this hunk [y,n,q,a,d%s,?] %s? ")
 	},
 	.edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
 			     "will immediately be marked for staging."),
@@ -1564,7 +1564,19 @@ static int patch_update_file(struct add_p_state *s,
 			      (uintmax_t)(file_diff->hunk_nr
 						? file_diff->hunk_nr
 						: 1));
-		printf(_(s->mode->prompt_mode[prompt_mode_type]),
+		if (prompt_mode_type == PROMPT_HUNK) {
+			const char *state = "";
+			if (file_diff->hunk_nr) {
+				if (hunk->use == USE_HUNK)
+					state = _("[selected]");
+				else if (hunk->use == SKIP_HUNK)
+					state = _("[deselected]");
+			}
+			printf(_(s->mode->prompt_mode[prompt_mode_type]),
+				s->buf.buf, state);
+		}
+		else
+			printf(_(s->mode->prompt_mode[prompt_mode_type]),
 		       s->buf.buf);
 		if (*s->s.reset_color_interactive)
 			fputs(s->s.reset_color_interactive, stdout);
-- 
2.39.5 (Apple Git-154)

