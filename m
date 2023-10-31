Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89508D525
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OS6KEMDw"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05886F4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5b3715f3b41so12349717b3.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791318; x=1699396118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRLVergv8s2I+CrA0doIfYjBOMbaad5AvrrDgKUE/ng=;
        b=OS6KEMDwv6GIfOBoUDdcdyUfJKI8jyweWN3C0LrlkkPYJKwXZk4usVboe0uwBU/z27
         gh9b++4zBeLeBpp1kUAVEmu/DaIRQvQ6fuOZfQfBV7mRuKSSwUVtR8I5/Zo2jd2TN639
         0jWi17WcjroeuLhi+FFtDstn+abzL7UnlSs7Iahp9HMap0joiYcCWo6rkjRM8UiyXRc2
         mpUa43odS79C+xJrTKnL5DQEeSTHj7XIQwLJCvQZDzRvQzJxgjlZIKJNdymznsK/pjLL
         Oe3+X+p3GYPfrAwWAffTMuLMdfvt4nbPin3v+87y6b19nuOSO4O75D7TNB8+2w516/Qv
         VG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791318; x=1699396118;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRLVergv8s2I+CrA0doIfYjBOMbaad5AvrrDgKUE/ng=;
        b=DXRkJ9Za/kAcdvhzFAtseg759fkGsrppFnt7Jb17oZxv+d/CbkMk1rgeGJvZx3RfW1
         fwuSfdo9C4QU0lLZGTJ2kCkpqh/DEbWWwaZOXQi2/bbl72iN+BwhV5zcbOyL53+dk75f
         /pThQinKBbVYTU86BDDiOypXgdSOFdWqRQ7nMpoPGFPOzoHCP5waBJWe3y3sRGfOUu4U
         Ay1DczUQJXCXVSoMiHg0+MX8I8NGCXyawfqpIZe6s3c5FWXsY1+MkvS9TpZnFo+xN5gV
         898dIftZucIhMQ6qhHJj1Xfwigfu79oI3kXhx803ZAUrPP6Ee/K8BzLU+yShdvSa8Rsh
         XlhA==
X-Gm-Message-State: AOJu0YwxyqqdZF9h2dnh3AFa83fzXQzKEQ5S+3UeSkT5jFcG4HtCFjOT
	+722KcesM6/u/I3phKylR1xeX4aK0X14Cya+tGbBOtfz2k6JmT/3PT9OnwQOHp3gu4m8qHgbutb
	zp/uMmYndgJifKMafSGdPDyWS3IYQuqt6+AMDDxSlkXPZ+JaenzPI1Lk2Q2JZe92J+mxHBGUc4Y
	k0
X-Google-Smtp-Source: AGHT+IGzbYm96veQcAkLsj5dN+ysHkws3wg11LsLozlCZTnw+D5Gk5VNDDs0RXKOwe9g38cfVEPg6ZVG9x1MXL3Jp9HH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9841:0:b0:d9a:3a14:a5a2 with
 SMTP id k1-20020a259841000000b00d9a3a14a5a2mr289008ybo.13.1698791318201; Tue,
 31 Oct 2023 15:28:38 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:28:29 -0700
In-Reply-To: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <cover.1698791220.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/4] Avoid passing global comment_line_char repeatedly
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Dragan Simic <dsimic@manjaro.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Here's an updated patchset. The first 2 are the exact same as what Junio
has sent.

Jonathan Tan (2):
  strbuf: make add_lines() public
  strbuf: move env-using functions to environment.c

Junio C Hamano (2):
  strbuf_commented_addf(): drop the comment_line_char parameter
  strbuf_add_commented_lines(): drop the comment_line_char parameter

 add-patch.c          |  8 +++----
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 +++----
 builtin/notes.c      |  9 ++++----
 builtin/stripspace.c |  2 +-
 builtin/tag.c        |  4 ++--
 environment.c        | 32 +++++++++++++++++++++++++++
 environment.h        | 14 ++++++++++++
 fmt-merge-msg.c      |  9 +++-----
 rebase-interactive.c |  8 +++----
 sequencer.c          | 14 ++++++------
 strbuf.c             | 51 +++++++++-----------------------------------
 strbuf.h             | 20 ++++-------------
 wt-status.c          |  6 +++---
 14 files changed, 92 insertions(+), 95 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

