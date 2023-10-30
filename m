Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050801B264
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+AZv5mc"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39E102
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ce4e0e2bdso2193082276.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697373; x=1699302173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M0SDKWdeLvHIz1oXZxbVau/0gtVulnIOCEwGuoIdM8A=;
        b=w+AZv5mc834vA9uFLRENHVT+TUU9foG2n3ozjGEfsQ0i629X6TZqHpgkkwJedXjDLR
         krm7dIcuse1fyVwlOl/nw6Jic5xvPxOaLeqjdMvTlrvOCbQI2anl6ajI33YYA7a6gRn3
         yUAHKRwAFvTwPv3UaHmQO3JYgnum7IbGu2AcOkEueO5DQK0jXuzwab4vtALx9xQ7tJYZ
         i0CyFb8FAOMUx9H+F3YsZ465U7gQTmaUj83RO20v4BCLpCTMJN/u8VaUhM7x4a5MYLKN
         uTYYthvWJO+9Hthynzr6OTNE9/rOW/mw50wH8AR026+IV6I6vovhkmCTMSc2WDJ+ZEDc
         RhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697373; x=1699302173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0SDKWdeLvHIz1oXZxbVau/0gtVulnIOCEwGuoIdM8A=;
        b=YcMASiXPf96d9jIGt4qYulgl3nA3qA275tEhPmCJ15VfiDzTAAAn0bawemi6fgOz6h
         WDRpy9u+WGEH7YIyOjopQe3wFkj+4xlOva/yCmdC1EdTxYwPXpVrtfFmaDytpytRR4Mo
         DFaURbcEIMhYQrGfv3+ZksowUHAx0REQA8sEHM2IH9IR4/vaB7Okoebo9hAmFzeHH29H
         LQnfWNEP50J9c19etWOUoYU/9kgEagBKdM/tpebDljHSWLJSizK6IzZ4PFyH7vWxZCTe
         +6I6ik/ngVQ8Dv8JalrWtWMcS5KnAyGVFSZJ0BZOCxu94yGOLFoSg8eL7PwpNgttOZT5
         B85g==
X-Gm-Message-State: AOJu0Yw6S0JgpgdukL/A73Vut43azuvQrTipmLl9vX6v+PTHNKV1Ig1G
	ucv31qEm1EOHRIDBLyusqDPTzxOGvzktBB6uqqkfpWEtrPPTsVgEJkJa2B/DbIvqMUrG87GB+eK
	XA/0kSBgVNy9e69WKCAkUizBlxNAbppodyqhbNiNxYotZaCKPrJhrPpaK0UxNcYmHg8SnKbJqhs
	si
X-Google-Smtp-Source: AGHT+IHvgJoCuzRAvA7EG6J4WqgmnDuqwzAL3XvDIzyAioN+FqZ9iQE3ruvmBj1IL+5ZoPJOrUX28qzKj8xteBK8nd6A
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3e1e:2bd9:a4cd:fa38])
 (user=jonathantanmy job=sendgmr) by 2002:a25:aac6:0:b0:d9a:5349:4bdd with
 SMTP id t64-20020a25aac6000000b00d9a53494bddmr213273ybi.8.1698697373090; Mon,
 30 Oct 2023 13:22:53 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:22:45 -0700
In-Reply-To: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <cover.1698696798.git.jonathantanmy@google.com>
Subject: [RFC PATCH 0/3] Avoid passing global comment_line_char repeatedly
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

> While I agree with your reasoning here, I think that parameter was 
> recently added as part of the libification effort - I can't remember 
> exactly why and am too lazy to look it up so I've cc'd Calvin and 
> Johathan instead.

Thanks Phillip for noticing this. Putting on my libification hat,
this was probably because we wanted to remove strbuf's dependency on
environment, so that we wouldn't need to include it in git-std-lib. If
we were to merge these patches, libification would probably still be
doable if we stubbed the global comment_line_char.

Removing my libification hat, I think it's better to solve this issue
by moving the functions into environment.{c,h} instead, following
the example of functions like strbuf_worktree_ref() in worktree.h
and strbuf_utf8_align() in utf8.h that, when operating on both strbuf
and a specific domain, are placed in the domain's header file, not in
strbuf.h. This avoids a situation in which strbuf.h contains everything
string-related.

The main issue with this is that by not centralizing all strbuf-related
functionality, some strbuf-related helper functions that could have been
private now need to be made public, but I think that a similar issue
would be faced if we don't centralize, say, all environment-related
functionality (some environment-related helper functions would have to
be made public, although I didn't encounter this problem with this patch
set).

I've attached some patches to illustrate what I've described above.

Jonathan Tan (1):
  strbuf: make add_lines() public

Junio C Hamano (2):
  strbuf_commented_addf(): drop the comment_line_char parameter
  strbuf_add_commented_lines(): drop the comment_line_char parameter

 add-patch.c          |  8 ++---
 branch.c             |  3 +-
 builtin/branch.c     |  2 +-
 builtin/merge.c      |  8 ++---
 builtin/notes.c      |  9 +++---
 builtin/stripspace.c |  2 +-
 builtin/tag.c        |  4 +--
 commit.c             |  2 +-
 environment.c        | 31 ++++++++++++++++++++
 environment.h        | 14 +++++++++
 fmt-merge-msg.c      |  9 ++----
 rebase-interactive.c |  8 ++---
 sequencer.c          | 14 ++++-----
 strbuf.c             | 69 ++++++++++----------------------------------
 strbuf.h             | 19 ++----------
 wt-status.c          |  6 ++--
 16 files changed, 98 insertions(+), 110 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

