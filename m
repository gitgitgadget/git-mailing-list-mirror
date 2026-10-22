Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630193;
	b=Rodt7nuBAcRPfTGLff83tQkpU7fIom2LlfmF5T5MHxS0xSVCJOnwuLYUBTl0H7klHcy3
	 7RqAAesuwfAYPy8EPaybXGn8hVZsjlWlcLi7GV6z2hoODX7RWs3y0Y8U/X+tPfCqDNoRy
	 4CAdi7MOTqIKI9dPHgHdcwxduKiVGRyGVOQ0iP5DlbBdqLJti5lqNrNaP/8kkIR1YSLI6
	 MPe5xU7vZLSFvC9XpLaoMTNUyHVp3GRxBGalrHmvZYuWUzfQXpvY5BEZcmTvT+XRIYwBt
	 iB901x1XzzEjkY3UAAS8MUL0t1oyH9hVLt4onw9mYzJo36uzK/E1O6lNGThb8WQEBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=unSXXtZ3MKtIPKO90+N4EQxTmjms9/JBuDYM7yCCGBg=;
	b=qN6LT3kFXC5vEDSzCPrCIP94iv6z3ClFIeKTcZy4Y4JAmLrVn8ofHUlguxLW9tm/9s0H
	 daziMamsSDqsjoGfRZNCTWwhRbxAXgGrADwTz9xmWyl9ZVPgtNP2ovEADzFMq1jZvFoIm
	 Qp0lwA4raOYiQD+HWsC73rA/r/lhF7j4rg1+kfyix+skvI8CHGH34XVm+NJMM47poz1CB
	 q55Mf01dtrBDu1XBvKNRoqQSv5FP4kBNcZdHGMFFSKtj0ayoG7HhNBItWA8+2eg6MmqRZ
	 4HTLlkLnVZ7aRR8Whbz39VhoPxXBzUmh1LmAfKCprIGOJooyOTJlJL6EC2EyNGY0N5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fieOWrbV;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B8606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 00:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01B8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fieOWrbV
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1145655e9.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792630191; x=1793234991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=unSXXtZ3MKtIPKO90+N4EQxTmjms9/JBuDYM7yCCGBg=;
        b=fieOWrbV399d83YmtDzIio6q4q9UvgvByBY46/NCYLLn7Maw4izLKP8VoFJj2bpsHw
         FEbwR382ozqXVinCFYD3QzfUy88Y0lDMHbfARYSM+qZBBSAmiZeRiepJ+q7OlHmOVrfW
         cqwTxS58eP+hxaD+GIeCKi/yJgco++1byMbAnPlzUcurR+90/xsxDUHF/gLa09YCZf0z
         kjRfm2o5szSxeOpa8Uy5O8otqwaf3Zj0i6qn5d6qbmQv1KNMK9Y269vd0AtSIiw71iDu
         rXi+TEMfof1Wkg6szFBZxmoclppj+Jtn1aoWdHsIBTqaUHPivqhPdzaFOGE5wGp8ISIy
         ZwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792630191; x=1793234991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=unSXXtZ3MKtIPKO90+N4EQxTmjms9/JBuDYM7yCCGBg=;
        b=kORm1ObhlpRCPkPCdVjS8aWe+dji5LfuEkCYkbg8ro77Z6GOVl7MIYlvOzAJF5sIUK
         EYgrewWIO6Y7ir3x05tI9CrqGRlb2UAMAVb9SXGHRAdWcjwwIHWlViVrPZmcxUkm8tkd
         q/TPCnmzkWRC4z2vixbSxG7CGX1V84PiCbgDHFUo+BLGmsc6X7BWUTmc9uk8ZEB40F4W
         WUMlorhrMZHKzq1ajP0Ud6voANQsg8XhcOIYaa7Su4hdSMbR1AeRD5yT32zKxL4SX7YS
         69gK+i1YrGiYKIqwrBbfn/UvnBv/e3HkZmA94RgH0oQEC6oy/K/ZVZMpU85qHwFeIIlh
         DSwg==
X-Gm-Message-State: AFq9FYJUNJraMpFCcUS3L5IR0uZmSSm2P5BiI2ujybDEma60umjkGgp6
	5mg4s7fqtQz2kcU0mj5FoCH6XxUbA0B9YNg5ioqNsEcg+WgHelAxCrJkjY9elO2F
X-Gm-Gg: AYBFou32PtpKlyRy5ob+C/zisTV2jIOaVkOJEM0zPQBt9oFd3PBSDS1k2AEIas1rYWB
	pcsay8hDnlduAxDNMamVL6Ob2J7DR9l0zM88QImXHOoTlcML1l9ui4FM0oUhLtonfwbO6ZDjzgB
	fQtiTE+cJhgcgEQQBRr9B4IY8IajrAOxv5OoqHqsKRZ5YvYozIB6/606W7eszIgTOFOaqtsx607
	XPIOCZ8gVeS+QWxf2NEyr1wBRpHK7aSr+ajtetLjc5HfVnxRVYai7ont7ZLss3TC/Ijqq1DZ/3x
	hBeajIAJWyj/IdtxsKoo6biX72KjeperNpTP+npDpNv/LwkLmwZKPkwyI2wdlHzGHotzJieZqYT
	RJkLj2kFS8p4SFzwt3cLNKytcW/Bc/XTaey+QNw+VIfycLUBTj67XdAiazl6mUOCM9ObSn3gguf
	U3WIVk+O9BWUKf1negnB5O4YWD/T5v/diZtpbUPw6PttceHVfCFOM5+2Wmf0Dh22KFhM3F6u8U/
	bvftOAnCqLIy3ArlujAJsTVOuQh609ECZyKv0KWQl7T5XqICF8IdeI29Y+zjus88dTSGQTrZwnj
	fpjX913wdNvIlViswZh4ZqhHm6ccmrTNdA4KdNX7Txusj1Z35ytDMB/TipOyjfm9ok62I3lwqd1
	ZJbC9sKA=
X-Received: by 2002:a05:600c:3114:b0:4a2:4ba:43ff with SMTP id 5b1f17b1804b1-4a204ba4471mr16932935e9.35.1792630190971;
        Wed, 21 Oct 2026 17:49:50 -0700 (PDT)
Received: from HP ([105.163.157.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258213cesm8814675f8f.11.2026.10.21.17.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:49:49 -0700 (PDT)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	taahol@utu.fi,
	ibnmuhyideen95@gmail.com,
	Tanga Joris <tangajoris@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [Outreachy PATCH v2] checkout: use Q_() for messages with counts
Date: Thu, 22 Oct 2026 03:48:34 +0300
Message-ID: <20261022004834.246892-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.216.gd573d5a65f
In-Reply-To: <20261021022156.119947-1-tangajoris@gmail.com>
References: <20261021022156.119947-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two messages in builtin/checkout.c show a count but are
marked with a plain _(), so translators can only give a
single form for them:

- " ... and %d more." at the end of the list of orphaned
  commits left behind when leaving a detached HEAD, and

- "only one reference expected, %d given." when more than
  one reference is given before "--".

Use Q_() for both. Translators of a language that phrases
"2 more" and "3 more" the same way now have to translate
these messages twice. At that cost, however, we help
translators of languages that need to phrase "2 more",
"3 more", and "5 more" differently.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v1:
 - Replaced the last sentence of the log message with
   a better explanation of the trade-off.
 - Also converted "only one reference expected, %d given.",
   as discussed by Tuomas in Mudi's thread.

Interdiff against v1:
  diff --git a/builtin/checkout.c b/builtin/checkout.c
  index 49239f029f..91b7c52396 100644
  --- a/builtin/checkout.c
  +++ b/builtin/checkout.c
  @@ -1491,7 +1491,9 @@ static int parse_branchname_arg(int argc, const char **argv,
   	else if (dash_dash_pos == 1)
   		has_dash_dash = 1; /* case (3) or (1) */
   	else if (dash_dash_pos >= 2)
  -		die(_("only one reference expected, %d given."), dash_dash_pos);
  +		die(Q_("only one reference expected, %d given.",
  +		       "only one reference expected, %d given.",
  +		       dash_dash_pos), dash_dash_pos);
   	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
   
   	if (!strcmp(arg, "-"))

 builtin/checkout.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d575a4f57..91b7c52396 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1085,7 +1085,9 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 		if (more == 1)
 			describe_one_orphan(&sb, last);
 		else
-			strbuf_addf(&sb, _(" ... and %d more.\n"), more);
+			strbuf_addf(&sb, Q_(" ... and %d more.\n",
+					    " ... and %d more.\n",
+					    more), more);
 	}
 
 	fprintf(stderr,
@@ -1489,7 +1491,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else if (dash_dash_pos == 1)
 		has_dash_dash = 1; /* case (3) or (1) */
 	else if (dash_dash_pos >= 2)
-		die(_("only one reference expected, %d given."), dash_dash_pos);
+		die(Q_("only one reference expected, %d given.",
+		       "only one reference expected, %d given.",
+		       dash_dash_pos), dash_dash_pos);
 	opts->count_checkout_paths = !opts->quiet && !has_dash_dash;
 
 	if (!strcmp(arg, "-"))
-- 
2.43.0

