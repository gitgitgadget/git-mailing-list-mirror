Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71DB666
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102905; cv=none; b=D/wLIWOWjcJY4na0fTRYTm71kUbxqju4rKZuJ4UjJvwP39cwqQ/K74yYpUprsbMAN/62qPpSpmQQ8NIpmzb8l6jxE2NR9gBrY4qmGkc2+Txz/bWU/LApDaWKvyFg95AV/rLyC1LpoiIqxR02TdMgOAiO9lRegzN9wAuNclKxwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102905; c=relaxed/simple;
	bh=MH0WvfnA2g14fdgPiE/dAj9kL1iUR5axRNzg47LqmHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CbDxAghMrongjfXwGVI3SOM0pGXQAQ6hsB7TGCxMZ2Jc3JPDLkIgFfiMmgUUvEfsfWsJOkH0uuBTELxu3y2a9b8Q8M8fRLtDdifCNHF8p869CtDadJ2f6SS/mn6DCh6/3NlIPJKdVfWJ6J4LcJxqtZMxQFtcCjHUcoi5sSUHOwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2srdoRy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2srdoRy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so11984975e9.3
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102902; x=1716707702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H90gQHGmZuShwEUE2pmjiGODQ2MWPxUcZ64pIH74gUE=;
        b=g2srdoRynzOHjOpsGXFR1mYVtliVyYTYLi0F+ThDscISt8GjW8cMMNnowYAB08UKDx
         NKAW/0Kf4ad6sVIPDGosTCvVsuP4soaEbrEwrE+xO+z28TdFzOA7Velb1crDwYxNsIx9
         32CpPgoF8YNqr5U7TWr7U0tFcaZHM66KZCnvDrPw7qad7y9VEDrjv8XPXllfEUtM3Dpe
         N6eq2T1A73hX2xGBHeqVOUnWSWKEWjto/rBw6lsqfsaf95p8aaKZQBGAiaL8uHhV6mME
         bRB9OUu0qPC6OXIYxss31Vn09FrzL6TBpkAjm3WMSQAUSmPF2cVSLhX5cGiKalO1vSd8
         rs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102902; x=1716707702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H90gQHGmZuShwEUE2pmjiGODQ2MWPxUcZ64pIH74gUE=;
        b=Ad5+8pwHywNZ0cYujTMOYkk9FDp/BCq0p6Ix2z8ofYILFzSngwzAi19xtF6h3CcQDv
         UjzqYcOEKS4Bn5zDo+HPsCnftKKq8bRfHzpxvWUsr++a3PPYxnaLlKVUdpZ/XcFnfQbX
         4F0MfGrn0X/gj4j7UiYmv3Btbr3jCvNx1XCj7ut3yZTlfi7thx87Y8YOW7+S1SAmySK6
         n4O6PEUnWU9inBX134VZpeCqQ5+avD2lrkJxUu4Yshr2do48TSLCKWh6vwPq3UkUK/ND
         t5gpqNY1EmcD2EZrs++sTDJpYtLHgl9wIcDo7FuTGNq47VGK5tyQRvFUKb0EyvLAGYKF
         LN9Q==
X-Gm-Message-State: AOJu0YwP/9T8upiZf73uJuWWgfkQgXCBHIsTNY/K9+w8yPLhAeV5H3xb
	ArLm29wa46YyYLX7g9jRfQqfwosfmMwVUumVR63bGUh8JQLmZrSxv3mjJA==
X-Google-Smtp-Source: AGHT+IFYf3/wyNHCqM24XGPJOUspRvQYu9PFxOd03I6smn9CArlJvoM8a8AnxL+fUETQtaLJRStJcQ==
X-Received: by 2002:a05:600c:198a:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-41feac5a3damr185502885e9.33.1716102901970;
        Sun, 19 May 2024 00:15:01 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f9bsm374570995e9.6.2024.05.19.00.15.01
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:15:01 -0700 (PDT)
Message-ID: <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com>
Date: Sun, 19 May 2024 09:14:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 5/5] add-patch: render hunks through the pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Invoke the pager when displaying hunks during "add -p" sessions, to make
it easier for the user to review hunks longer than one screen height.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 add-patch.c                |  3 +++
 t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/add-patch.c b/add-patch.c
index 2252895c28..cefa3941a3 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
+#include "pager.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "strbuf.h"
@@ -1448,9 +1449,11 @@ static int patch_update_file(struct add_p_state *s,
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
+				setup_pager();
 				render_hunk(s, hunk, 0, colored, &s->buf);
 				fputs(s->buf.buf, stdout);
 				rendered_hunk_index = hunk_index;
+				wait_for_pager();
 			}
 
 			strbuf_reset(&s->buf);
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 52d7830de2..6c4af8904e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -558,6 +558,27 @@ test_expect_success 'print again the hunk' '
 	test_cmp expect actual.trimmed
 '
 
+test_expect_success TTY 'print again the hunk (PAGER)' '
+	test_when_finished "git reset" &&
+	cat >expect <<-EOF &&
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
+	PAGER  10<RESET>
+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
+	PAGER  20<RESET>
+	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
+	EOF
+	test_write_lines s y g 1 p |
+	(
+		GIT_PAGER="sed s/^/PAGER\ /" &&
+		export GIT_PAGER &&
+		test_terminal --no-stdin-pty git add -p >actual
+	) &&
+	tail -n 7 <actual | test_decode_color >actual.trimmed &&
+	test_cmp expect actual.trimmed
+'
+
 test_expect_success 'navigate to hunk via regex' '
 	test_when_finished "git reset" &&
 	tr _ " " >expect <<-EOF &&
-- 
2.45.1.209.gd5886bf9cd
