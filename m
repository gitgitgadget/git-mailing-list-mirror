Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252029ACC1
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314725; cv=none; b=mG2co9ZzdT1KAFWvBuKQS10fYJEezKlH2a8r0jxJVC7WNJYzKisofW8TTSEtWF3ZpoBIkwOPmBunUmuLmi+AQ9CVdat9O4MJvlVHIb9FM++Ce7m3Smeq8r9LA+HpZg0ua3gzPmSltc8390nwkKIfsRF/4ivsxh8m4R1nj2On8/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314725; c=relaxed/simple;
	bh=C7Vu2f6Q0fQ1DjRwn2r3DAq+G9mbYa2El0JhbVxJhZ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XymBty/e06JXvySDioFtnt8gJKLp07ftnCEEH2km4+3hbBUyM67zA2UsXOG+HRqTlKfrtiD5QCCWEz5G4r+r+AqGfe3LpBxmL+UwDxqmq4dBgvigSPnsufQ0lr257OcgS98DX7Cpa2zq+71YPXN5ApF5OoB/urcvpPtAU+3lZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS+AAePJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS+AAePJ"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so10076495e9.3
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314722; x=1747919522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Nxn9igznSx8L1tHycTiTZx1gc8iaTMYZyf0w22Vfw=;
        b=mS+AAePJVTjkY+MfPP8xjON/T3mXIbqAMoSiauLdV9kwUqoS12oCTDvPPhkHYFp7Pc
         LaKAM4UFGc55c1nHdyMxFUGrie1uhMWVZl1srLG7rwVO3s6Rd+WI0ckpEM0ao9ctb0BQ
         GdiPRuQBIOcE4NI8W/iq0IpAIs5mRWGnfrutKVrc8gJdaGne51PlZJvoojTWTly23NK/
         BzcrTPPZr/mLJ/cnLuXBXYJ/FA5fCPrNbtd4jsciPkgTQdyrJYI6b9bbJzp6Qp1O8E+B
         u03oZ4xA7dKK0qjzE8IT1HsceAqig/RF/h6VjETmPpfm7BtaqpQvuuIDzQZQqbnk6yIS
         4I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314722; x=1747919522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Nxn9igznSx8L1tHycTiTZx1gc8iaTMYZyf0w22Vfw=;
        b=Pnr+9MCVjJYr9MrwxVK6wjDftsFu6T4mZSl5Apk/kVegEmBEv+ee87eRMIIabEvCOR
         iLTNCrJF6WEsEA0Vv+nuuosMY0TJB0ZeXsvzsPbZczqHKzyTnBtifQmn3Bd+3Th8T2G5
         nM7tV8Oh2ejqwBLuq2fUNNC8bVfoC01CNNmdIB7X1QCAdtJEW9UZpBQzCABCr0gughlo
         9ZtdemoCJAUspEI+4J4H4097C2MfkjHNyXLwMFT2rYpHRqq0+dg8J4tSuJxz1bMeEjJU
         lZMA7h/uXQq0Si2nQVW872KOSrLnqjAn+4MiOkRC3nuAvVgCsnakBgeuvHGmESyR9WCQ
         eGvA==
X-Gm-Message-State: AOJu0YxhEK6R8QjB7m8gcTc70B1xRddFUHlRWMHPUCV5/+3tWhxCC7nN
	59pYPEgAL2mzwnTj5D3MH7SfLyPMP8Y54TWL0rXe91sV+diTiouo5BbaCQ==
X-Gm-Gg: ASbGncuIFZC892cMJ6bIzIQW5RA+3N/Et88KiNPI7BSawFKF4uftSYPevwGpUvfSXmQ
	jKJIh8sJjGOoHQoCTADoUKUIQFbihFj/KC91BYV2KCWZxe3RMJVJIefurjVwblwHtnP413WeycL
	hqn9s+hDQsp8aHY33fWpYhJCIo4KvbsiNJkTPi0lqF23Ot4tObUk2JFX0++Zw/nZLAemHDtpfUo
	11AvMcM06NB+Tj12+0tMccLqJKXiDlQRKmwmsUpxMzuGWcbCs0qg4q6M4Fn9m1VJpklnpArovrH
	Y2DZ+bHShOpvFpuAgknxIjsWhrUB5quhmoFO2ROKqqa+3G4xLkl+
X-Google-Smtp-Source: AGHT+IG4LvZ7Nmom1RljsAWc5U9aaBd9InrKFf0SUlo82TlpZ03SEH5pxQl+2YM3U31ERA8iAfMgOQ==
X-Received: by 2002:a05:600c:3d05:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-442f96e43c7mr22368185e9.6.1747314721424;
        Thu, 15 May 2025 06:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm67756995e9.20.2025.05.15.06.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:12:01 -0700 (PDT)
Message-Id: <7a54005bd26ac17cb6d99a2e18932f97575d4aca.1747314709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:49 +0000
Subject: [PATCH 11/11] sequencer: stop pretending that an assignment is a
 condition
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 3e81bccdf3 (sequencer: factor out todo command name parsing,
2019-06-27), a `return` statement was introduced that basically was a
long sequence of conditions, combined with `&&`, except for the last
condition which is not really a condition but an assignment.

The point of this construct was to return 1 (i.e. `true`) from the
function if all of those conditions held true, and also assign the `bol`
pointer to the end of the parsed command.

Some static analyzers are really unhappy about such constructs. And
human readers are at least puzzled, if not confused, by seeing a single
`=` inside a chain of conditions where they would have expected to see
`==` instead and, based on experience, immediately suspect a typo.

Let's help all of this by turning this into the more verbose, more
readable form of an `if` construct that both assigns the pointer as well
as returns 1 if all of the conditions hold true.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b5c4043757e9..e5e3bc6fa5ea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2600,9 +2600,12 @@ static int is_command(enum todo_command command, const char **bol)
 	const char nick = todo_command_info[command].c;
 	const char *p = *bol;
 
-	return (skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
-		(*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p) &&
-		(*bol = p);
+	if ((skip_prefix(p, str, &p) || (nick && *p++ == nick)) &&
+	    (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\r' || !*p)) {
+		*bol = p;
+		return 1;
+	}
+	return 0;
 }
 
 static int check_label_or_ref_arg(enum todo_command command, const char *arg)
-- 
gitgitgadget
