Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB1349AFE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210850; cv=none; b=oMWkeW+/kzoRtPZ78hF5d9AueDXnEaKdGvYFzmoUe/QlCMDvrl6CtrhiwagiW2/FYF82btiksby+SWdPaHIiVi0bolq/YzReg33h75jpTMqT/cA/6OsnW1XFPrzguMRco+GSHJGUIAx7UFKC1nqShZUmFGnOx3b+frMbqZmDwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210850; c=relaxed/simple;
	bh=6C591FMHuV+PSuRuxDQnYWzkH7oDoupC1uY8/frSUus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki59SNgOCS8eNsCQJAwJcXVg02b/g+TuKvldVdT04r5DxqxHe5+GkwMSP9BGTo/YroPtceqNuTuf3bkrNyzoo6TyucpIMbxIkFnjaJXKeYblh4lUhQgFCIlLeBeS/InJdedFssKUHW8CM1SMWKijWwDZtfLZqW6abtsD8YNrwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UegL0aP5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UegL0aP5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29efd139227so43964535ad.1
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210845; x=1768815645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfcuB1V8GRuezmn23y7MZE0UrjCssT1aBeaKf98s79I=;
        b=UegL0aP5+JQVr42RsKGWiWJlj3uVz0JiBDpX/amiM3aUpqd7o9XfWcNGWp113wNH8l
         oc+q+tLTgnMFxTuBvslb3xR/RDE5TalzOaAF1bPLkVFSakYoZGoOn7jWQYYcqaZyOz3x
         VNhNvmAY4MmLzySOxvSQtRF7tvYo4ArNi7UW+wQPThs3kmJT5WT52JgSFIsNh7J/zYwA
         KmtvMTrJMM8cOblO/+btUOV5nTB+b99D+M0qOsED7HJNjGtbWiX8MODG3nvX/LHdaeuo
         3+JSdWpJlJXSDC78yMGGyCgYFkpnBzMmpwgj4B0VLuoFDeWBMGoPALzky7IFFgC9lBYg
         aa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210845; x=1768815645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfcuB1V8GRuezmn23y7MZE0UrjCssT1aBeaKf98s79I=;
        b=JxfQCCIb/U+gH4X3Nbb9pO2fzBhWog4jen3YHBND8Qh+3xSOYbGwg7PavzGZMhPP1n
         ZzlOeFGU75pHsP93rAplm1KAfVCE85gPruLrDJB6gq1sM3IhqigQeMvG3np/TCzEn2KP
         ZlCzM5M1C0jx2kwnuU88V6UgffZE9I1urCNZCTh7pl1oVRydJQelKvSdCkl0b0WwA0iC
         zIRoCGmf4VJmsH7GU7Vn/KamC/fShjkHn/1M8cm7HK478arRHisaQoFrY5ZuCJTl47Gu
         +RLKgkbkwX/LSuhs67YsFGRYqeguqrwY8xbmDcVKJ36vT5sW2zMPlJeOYPdXMyVFsMeC
         avGw==
X-Gm-Message-State: AOJu0YwLO7kEHPoGauiIVuBaRNpgmAspxyLSEgFRYkvXAmblRKD/lKY0
	SVPmO1W09OeIAudNKum95JkNUM4NmsNSOzhiDd4QnSCqZDKBe7/8XnnD1PUFcQ==
X-Gm-Gg: AY/fxX6iwhaF1jaqyrnXh0Yb45ZvVmPgIRuFfUhdgN21m1s4XfVgLxc0s8V4CwJ7a5b
	u7wDlnPxGAY5WF2q6wZnYNbJpcoU+SDqFLMXGilfBdMIDM7piY6ka+N/viImUQXN07YRDRLg/J0
	Yj97qxvHx2IrVnPod+cJlRYMOvqMGIf0yujVynMby8zeE7s5q6zOt3WJiZ4k7IxOSIYn7mcY8Yn
	iphmBHPD/Ir1BRyvLmKayomgKdzmZZhC+UylELYWx0OQGR5N6/1j05n4t//9uYBNRHV/9iJd9uc
	8sexDy3sTeMz8j1gDYe2+1+m6MfTcWZ6TpoqZ3j/ln7amfuqgZ1dg3r7WV/vc2eUeYuzVGZvEeu
	Yg+ai4H71Wf8zIYaTI73PPPSkYF8MpHeAmYLLRlMBc611tzT5+y3KcjnX8kHQKGOJiAf66mF3kk
	kjWK/fSuKmPzndwdEJFtSHZ26lRKkeDovbvvCMbqXN8sLR0WLN33vuTmDR
X-Google-Smtp-Source: AGHT+IHHSQPGPyovG0DHk7ryEEIqbyxDTE9BwF1cytU09bDyodvxg9VDOTvf3utQcVi35Gpog09yBg==
X-Received: by 2002:a17:902:d544:b0:2a0:fe4a:d666 with SMTP id d9443c01a7336-2a3ee432db5mr154698505ad.10.1768210845298;
        Mon, 12 Jan 2026 01:40:45 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:dd74:7b39:2154:bc0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc88f1sm167252675ad.78.2026.01.12.01.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:40:44 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] doc: MyFirstContribution: fix missing dependencies and clarify build steps
Date: Mon, 12 Jan 2026 15:10:23 +0530
Message-ID: <20260112094030.314203-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108174651.1618874-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260108174651.1618874-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several issues in the MyFirstContribution guide that can lead to
confusion or test failures when following the documented steps.

* Add missing header includes in code examples (environment.h and
strbuf.h).

*  correct manpage synopsis formatting to prevent failing documentation tests.

* clarify documentation build prerequisites, particularly specifying for DocBook-XSL.

* specify the use of parallel test execution with -j$(nproc), noting that
it runs tests using all available CPUs and may be adjusted.

These updates improve accuracy and make the first-time contributor
journey smoother.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f186dfbc89..38f2a23e77 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -331,7 +331,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"` and `#include "repository.h"`.
+Add a line to `#include "config.h"`, `#include "repository.h"` and
+`#include "environment.h"`.
 Then, add the following bits to the function body:
 function body:
 
@@ -429,6 +430,7 @@ Add the following includes:
 ----
 #include "commit.h"
 #include "pretty.h"
+#include "strbuf.h"
 ----
 
 Then, add the following lines within your implementation of `cmd_psuh()` near
@@ -504,7 +506,7 @@ git-psuh - Delight users' typo with a shy horse
 SYNOPSIS
 --------
 [verse]
-'git-psuh [<arg>...]'
+git psuh [<arg>...]
 
 DESCRIPTION
 -----------
@@ -531,7 +533,7 @@ easier for your user, who can skip to the section they know contains the
 information they need.
 
 NOTE: Before trying to build the docs, make sure you have the package `asciidoc`
-installed.
+and `docbook-xsl` installed. See `INSTALL` for details.
 
 Now that you've written your manpage, you'll need to build it explicitly. We
 convert your AsciiDoc to troff which is man-readable like so:
@@ -726,9 +728,10 @@ $ prove -j$(nproc) --shuffle t[0-9]*.sh
 ----
 
 NOTE: You can also do this with `make test` or use any testing harness which can
-speak TAP. `prove` can run concurrently. `shuffle` randomizes the order the
-tests are run in, which makes them resilient against unwanted inter-test
-dependencies. `prove` also makes the output nicer.
+speak TAP. `prove` can run concurrently. `-j$(nproc)` runs tests using all
+available CPUs in parallel, but the job count can be adjusted as needed.
+`shuffle` randomizes the order the tests are run in, which makes them resilient
+against unwanted inter-test dependencies. `prove` also makes the output nicer.
 
 Go ahead and commit this change, as well.
 
-- 
2.43.0

