Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA4285045
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666672; cv=none; b=RXaqrdFjkRCFO5Lm2hpPg+b/zWDiQbvouniF2FRM8TEBIkpprfGzejse1D5aitAuZBAQLysiAuCGi0szFeofwShwLTb0gK5yCOPvrjsd8VnPwP922OjRARbpUDOAgeSN31DCHaq1z9ycEhTl+5mSb37cDt0e59Lds4ZjgBkYFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666672; c=relaxed/simple;
	bh=nrIt2fttpgyprNnARBQ766EMc03jdNHJA0MR4BePaRc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rPaRjyMBmmVOaoS0ytq8tNZ3wSxNmcLWF8px6AEmMVOuyBrYV32ljZVjR+Sb8zQXbo9b4olWszTZroUTFiMKqMN/7wWZ3LUMp131CavXJP3UjXlXUFvuygagvI9GwF29oOFI5vDFKslAx5X6+HElWpq8T7MKOL9ujA2J2JJDfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJy1t0Cf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJy1t0Cf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso14556565e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754666669; x=1755271469; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtqeVltDD/AP+y8YRdUSruk+ZzOch4HXDtuOdVeiHG4=;
        b=DJy1t0Cf14i2p5zt7+kMmUV5d7hE/6q0opfx/WY3i3GifF5yTN4EXrnRROy5xsQOrE
         4bZ5iy9G4ycPtiWFxzhaligMAjj9smozv1b71gSM98M00saxLctUw+8RMNT0ax+fu+2i
         VczKP9WlPIjZewkOXZVeKzAA7Z0atZ9l47rtzZ2ClHMpFVsbALfFmFHFxjFXuz6SrfXQ
         dTySEz2VbAO38/zjPB/J0ryAE31DVgU4QD7CnuaNqs1RrxIWBzOfkJtAe26VG1UMdUNm
         1jkKY1RlYx61Oz18v6iGp+Hwz55DpV7ByBE7wbAG9NZ8dtl1PGKR9A8OJMy7zop69Re5
         xYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666669; x=1755271469;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtqeVltDD/AP+y8YRdUSruk+ZzOch4HXDtuOdVeiHG4=;
        b=kJP+GEl1JXwRATaM34nt2zWPWIQIS52zCI6vv5DmkQgn1+BtbERKKeNgsSuBmNjTb6
         m2EbZOAC0vwNSVwVlLHaP+HaS22R7mVmS6gZOM6hqnhpXyRCpsRYIBkGSy1XgVU+mfDL
         FBz+y9zO7BQ0wi6tNQq2X4Bl1i0iJDm/oIz0KMuSesT8Me5WrbLdY5IHKcKUVYzT18+L
         HiB6YhVXuwli4P7nihe7XtA+QrL4AKf2UGR2I8FkyhUjdTfGzF/lxK2IslUto3fHslbi
         2GlWhtc3C3oJ3LlNHZ+jSgWzR2qR7S0Jatu6VqvBvFGpFifws+rDpZT13qgpeusb70ed
         i4WA==
X-Gm-Message-State: AOJu0Yzngxuvk54AcsouePSfJbvArieC8hxbo/C3qWfItxclcvcdCvQ7
	6cxfWaS8o7nk8HPRFTmvhpWA5ppDcm7O4UnaokH0ZvtwClk4EQR72ZnvtjLkfA==
X-Gm-Gg: ASbGnctO7RCZBI5YpjfORu6k137tXZfbEltdp1+OfJ5LJkYa0vZ7GKmeiKhljUfHvT/
	Gqr6eCb/95YtDpYJ5/PkfZTcMQ78c0jmjrreC6lv71NfbAizzsmxJ2TMiXXtpPvah3WhyHUjLOk
	0yjZMtd6bo0OOqGYXmopcb8M9KPoGLhICbDu60vAG3t9SJxTTkrMomqSvGCv/yyqJ/eFE99RSND
	qnvl8qvTpcFTGyIW1d8M9ZbVokpb8Mo4zBbu4NCk0VXlpTI1qTneyNA0/yRBhGpI1wzXakWVIXK
	OCxAbsdTO6g8USLJkYVp+fKbFykCOSgSAw9Uk8fz3RDXdlFyy9CLPMtH61FvKTmDM5SZ8uYotYe
	1MCsLX/SJRwBEqBErR7HQpJo=
X-Google-Smtp-Source: AGHT+IEPPbnD6tFOvL0Wc6xK3ffjtLoy72D1qYhRhoxvxDAAjrvtmvkLpZ9bTBEZyXJN0Hs8YJEwPA==
X-Received: by 2002:a05:600c:34c7:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-459f5a98622mr25657845e9.6.1754666668536;
        Fri, 08 Aug 2025 08:24:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm230890365e9.29.2025.08.08.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:24:27 -0700 (PDT)
Message-Id: <b27117ea19a41ec544d3e721e3a188ceb6efbedd.1754666665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 15:24:23 +0000
Subject: [PATCH 3/5] doc: git rebase: clarify arguments syntax
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

I found this extremely hard to understand as it was and this seemed like
a clearer wording to me.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 3087e558b509..ada9f6b2614b 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -58,12 +58,10 @@ first problematic commit and leave conflict markers. If this happens, you can:
 
    git rebase --skip
 
+`git rebase <upstream> <branch>` is shorthand for `git switch <branch>`
+followed by `git rebase <upstream>`.
 
-If `<branch>` is specified, `git rebase` will perform an automatic
-`git switch <branch>` before doing anything else.  Otherwise
-it remains on the current branch.
-
-If `<upstream>` is not specified, the upstream configured in
+If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
-- 
gitgitgadget

