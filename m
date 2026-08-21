Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30F39023F
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320511; cv=none; b=ant46IWQGRu6SxNphAGvFQK2nkXHLT/Z34/7J537C6l38QxzTM49mwMSGZ4/Jtc6pZr3aHyYeA5rMrNbugq/a8SmIKrK2LgB/j34xB3AsVHwtS2O3BeNIMh97CF9vjmnxLwuihrgP+P3Mx3CvwiMGR1IfHj8xze8hWx1dhcTTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320511; c=relaxed/simple;
	bh=ZR+vRl20FhvsxzsZ7DNtqmunWqByGIThQwceiTl5WK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeWqECjS98J5/VzQlLui0X6Xq6VF0Hk3a4smcAUyIPanLZrlnT9LoK68J1CohXUIWhSwwng/Yu1i3DXNmmlfbQmNtBnYYqSIc6TauFhBOiQfuJnjBo8KMs4ERWWjPz8bXrxirohRvHPAR9XclZCYeVH3J3dShd05rmhBGAmtgvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP5VJAGM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP5VJAGM"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1397936a12.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320510; x=1787925310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEvTOdh4HGR92nviZEf5V2b96kshEBaNXgKYm8j3T0M=;
        b=qP5VJAGMdtk8Ctmj4bWHvZGMuy/kRk7DZ0hRYzZeey4MQl62Naq2/Uh4g/wworAjAZ
         //2X96tS8x/hWpnMxLpstasb+PZpbS+aEaTGjfqqeQhJeDPz24fk8KxivTAGQ4eqr6ol
         Sk4pLkp+6Lhfbi4FDgRs1VnWtHoomevYl1vkGSt5vLe8uLanUC7Ns35BuNgbwE+0nbs3
         rfMVZakZKYaDlVZabObunltbduA8DKeKnYQ/LN2C8OPgT6ySL3NkY2cRmLwPMNUuPLlD
         7GLJ/SOE53lIT2T0mmOBGBDKV+Z/4DedA0Ik9A9npE/47niijUswl2xRbsZoQMJROq2Y
         sM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320510; x=1787925310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pEvTOdh4HGR92nviZEf5V2b96kshEBaNXgKYm8j3T0M=;
        b=irRuJNKb+LT7pIe4YPr8GyyudbVjXJ0CIgnD7spRvvpkajDu2WetfqmmulU6tJtBWM
         h48tUPmhTaKuKpt/0/NUtpuU91APTJRuo18Auyli47ufkLn+Fpvvw21hU5oYi53SU39d
         47Sq/d/wzmjpZtCBru6Ya6wOc/5YnBCsXfDU7TSLCsGsobS6WEX7UFHvC0he4Cq/wWsc
         2U6S5cu1VFZUr+Cl1Fu1Ebc8r9No5g0DyXvK4W7i9NcESmZGv/2kjrY9+lWqwAdNbidP
         zihr+rNwX94WFnXxmBl0dte3a2/+fRASeSo8ckRT2sLk4OGPwAWIyLbg9Ll4JeMmxsMV
         31VA==
X-Gm-Message-State: AFuF++kwSU/0se9GH+b4BH0mpEJ5TT1Mb3+NjtV6w/TR850OayuKoqsi
	Sf3oG3V0PZXn5KYkoEVvEaFPijAuDDYDBHDRioJnpMXm/+a2+YDFez2f+mnr9w==
X-Gm-Gg: AR+sD12tj9JT6vYRbLU2Q3hd8gdSpizQU0oF2LzW13OfeSLW4yJBDgtbM7fk1dkcWj4
	26IRImzzcPdMcft/GQFhQ/YC6V9ofvArJfwmr5M22RO/bo5+qsKg1qEoKXS4877fZVoUil1ZiWx
	/gqOoZRvmuAG1CZCaQMuwIVKJ+kkgdsE4u9di26rJbLWMepk74csdKlGYIej13PZoUyQH8fWAcR
	IoO6NlAVOojFyF8n7iCFBadQjibnrpI8kslr9g/jI7G4zQIPS6ZFPNysvXvhoZadDKdPaTF98N2
	vczYmEQl3OdHhl2RloRdikZPr47BV/c6djQY3SJnPRhDXtFbvrLVyz6ZjlSFoW3zX1hnRD1Acad
	Y2WODMfL+SFryBFBBVAR2dE3oqU0rNGG3OhcNA4ihXmhUdZKmccY0qPJ4L8ibrrpJcatlMZZcxk
	IrLzq0W3jzmHd6tsQRrUoueudKMjvrIMBm7HedTLe+0CKJR8I2IW6VGFv3fMq2uO+SnyvE4xvxG
	X9gkqcjuFW6WItc8Moico7tneI7NeJaX4/3np91vRzns4uupdN9WuVJnhn4Acko01zSoZsrjwwo
X-Received: by 2002:a17:90b:54ce:b0:394:ed5c:ff9f with SMTP id 98e67ed59e1d1-395a06c097bmr18825467a91.17.1787320509849;
        Fri, 21 Aug 2026 06:55:09 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm31969308eec.4.2026.08.21.06.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:55:09 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 1/2] gettext: fall back to env-derived charset when unset
Date: Fri, 21 Aug 2026 19:23:44 +0530
Message-ID: <20260821135410.429698-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
References: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`is_utf8_locale()` relies on the static `charset` variable, which is
normally initialized by `init_gettext_charset()`. That initialization
only happens when `git_setup_gettext()` successfully locates the locale
directory.

When running directly from the source tree without `make install`, or in
other environments where the locale directory is unavailable,
`git_setup_gettext()` returns early, leaving `charset` unset (NULL).
Because `is_encoding_utf8(NULL)` defaults to 1, `is_utf8_locale()` would
mistakenly report a UTF-8 locale even in non-UTF-8 environments (e.g.
under `LC_ALL=C`).

The fallback that derives the charset from `LC_ALL`, `LC_CTYPE`, or
`LANG` was previously compiled only under `NO_GETTEXT`. That left
gettext-enabled builds without a fallback when `charset` remains
uninitialized.

Make the fallback conditional on `charset` being unset rather than on
`NO_GETTEXT`. This ensures `is_utf8_locale()` accurately inspects the
environment-derived charset regardless of whether gettext support is
enabled.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 gettext.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/gettext.c b/gettext.c
index 8d08a61f84..5376a0de0f 100644
--- a/gettext.c
+++ b/gettext.c
@@ -141,19 +141,23 @@ int gettext_width(const char *s)
 
 int is_utf8_locale(void)
 {
-#ifdef NO_GETTEXT
-	if (!charset) {
-		const char *env = getenv("LC_ALL");
-		if (!env || !*env)
-			env = getenv("LC_CTYPE");
-		if (!env || !*env)
-			env = getenv("LANG");
-		if (!env)
-			env = "";
-		if (strchr(env, '.'))
-			env = strchr(env, '.') + 1;
-		charset = xstrdup(env);
+	const char *c = charset;
+
+	if (!c) {
+		static char fallback_charset[64];
+		if (!*fallback_charset) {
+			const char *env = getenv("LC_ALL");
+			if (!env || !*env)
+				env = getenv("LC_CTYPE");
+			if (!env || !*env)
+				env = getenv("LANG");
+			if (!env)
+				env = "";
+			if (strchr(env, '.'))
+				env = strchr(env, '.') + 1;
+			strlcpy(fallback_charset, env, sizeof(fallback_charset));
+		}
+		c = fallback_charset;
 	}
-#endif
-	return is_encoding_utf8(charset);
+	return is_encoding_utf8(c);
 }
-- 
2.55.GIT

