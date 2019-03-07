Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AB6202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 09:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfCGJ6b (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:58:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46068 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCGJ63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:58:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id 125so10614007pgc.12
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=58VpSs3lV+H3+f3DKLzajymDpXUrsjMnfsi1WhvK/BI=;
        b=u9HN5qf1bKiWAPYzGa1qEzPGNwF/l6iimhfN/PLyPXJAuCyjK4VlR4KJT8WlmpJjVf
         NFrbKqYUf6l5GuJo+53DI+ylusk/XkyBKE8pD9H39Wsga5waFNsjo2Eg3q/XIL+IagKA
         H1QQpsFDqCRp/JBAwD7vXPuLJnEVtGSLTcv6GdHQAYq05+41qErCHo89ufFyogSHRmjo
         ehnfTIbjBcO59bkglG8lTqXgzRWnwDojD/bylNUjDuHKaI7AAsvmtDA4jubPPj+kBYV1
         f9Xy7/0aJy3yY2frohpqeQ7U9uo5wqI4P9oZfRgI2vugqqlrwaK1SzTCiPq8VFa9PJMt
         RSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=58VpSs3lV+H3+f3DKLzajymDpXUrsjMnfsi1WhvK/BI=;
        b=AByjzgfjzbtvrA3qSOVLoMehlNk3K+gxOEDkPOvICkXLOU3IWszF82uSRTA08oF0r7
         MoVgiBdtB3F6d3jiX+VMSDpo7pZPsYVZi0vZgg7KtwEr3mFsNsfgFJoeVxS4gJ1+VSiY
         kt9GGjXfIWOvotBsBYNwsXUALP4bGz1s0QzdVZ5AhKYTgAZDSkAI51LXr/M8aLEmh35o
         5s/hiBvu85iQT3ZHOr3LXIwlWHy+JJQ+BIND84Nh+WWpmub/xbNWxYmF0RXCKX4NKIuz
         3VQdTGk+t6/cJGsn+l51HfB6cMVnP+wA8XAXVnVOVQITaAz7qrzYXqrxq4lM+r/hWo8r
         rSTg==
X-Gm-Message-State: APjAAAVaMThmoFvFHutPUUXA39clGkGo47ZhvuY5HQzGDpRRi3sly284
        4iQFRvGCNUDNPSpqJovXobOnond4
X-Google-Smtp-Source: APXvYqwSRwg6XLDCK5WDCQqY1mJSeIC1+p1Ggd7z03TfRI7iIHh+/7EDHJB8JVTV9WB0DwVa+K7kSQ==
X-Received: by 2002:a65:60cb:: with SMTP id r11mr10753570pgv.143.1551952707573;
        Thu, 07 Mar 2019 01:58:27 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id w17sm7021862pfn.63.2019.03.07.01.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:58:26 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:58:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/4] cherry-pick/revert cleanup scissors fix
Message-ID: <cover.1551951770.git.liu.denton@gmail.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551940635.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As I stated earlier[1], I discovered today that git revert (and thus,
git cherry-pick as well) do not place the scissors line properly as
well. This patchset adds a scissors line when conflicts arise in both
cherry-pick and revert, which fixes the same bug present in git-merge
earlier.

This patchset should apply on top of dl/merge-cleanup-scissors-fix.

Changes since v1:

* Address Phillip's concern of calling get_cleanup_mode with use_editor = 1;
  only set to 1 if we are calling for revert or cherry-pick, else 0 to maintain
  original behaviour (for rebasing).

* Do not die if provided an invalid cleanup option, instead just warn and
  fallback to default option.

Changes since v2:

* s/prepended/appended/

* Use $OID_REGEX instead of self-made regex

* Don't die if bad config option is given, otherwise die if a bad
  command-line argument is given

[1]: https://public-inbox.org/git/20190306014143.GA2580@dev-l/


Denton Liu (4):
  merge-options.txt: correct typo
  t3507: cleanup space after redirection operators
  cherry-pick/revert: add scissors line on merge conflict
  sequencer.c: don't die on invalid cleanup_arg

 Documentation/git-cherry-pick.txt |   7 ++
 Documentation/git-revert.txt      |   7 ++
 Documentation/merge-options.txt   |   4 +-
 builtin/commit.c                  |   2 +-
 builtin/merge.c                   |  15 +---
 builtin/rebase--helper.c          |   2 +-
 builtin/revert.c                  |   5 ++
 sequencer.c                       |  40 +++++-----
 sequencer.h                       |   5 +-
 t/t3507-cherry-pick-conflict.sh   | 120 +++++++++++++++++++++++++-----
 10 files changed, 153 insertions(+), 54 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  1076d4c451 merge-options.txt: correct typo
1:  4eee16cc5a = 2:  6bce4d4722 t3507: cleanup space after redirection operators
2:  8fdc5bfb15 ! 3:  14672ce10c cherry-pick/revert: add scissors line on merge conflict
    @@ -27,7 +27,7 @@
     +	This option determines how the commit message will be cleaned up before
     +	being passed on. See linkgit:git-commit[1] for more details. In
     +	addition, if the '<mode>' is given a value of `scissors`, scissors will
    -+	be prepended to MERGE_MSG before being passed on in the case of a
    ++	be appended to MERGE_MSG before being passed on in the case of a
     +	conflict.
     +
      -x::
    @@ -45,7 +45,7 @@
     +	This option determines how the commit message will be cleaned up before
     +	being passed on. See linkgit:git-commit[1] for more details. In
     +	addition, if the '<mode>' is given a value of `scissors`, scissors will
    -+	be prepended to MERGE_MSG before being passed on in the case of a
    ++	be appended to MERGE_MSG before being passed on in the case of a
     +	conflict.
     +
      -n::
    @@ -233,8 +233,7 @@
     +
     +	test_must_fail git cherry-pick picked &&
     +
    -+	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
    -+	test_i18ncmp expected actual
    ++	test_i18ncmp expected .git/MERGE_MSG
     +'
     +
     +test_expect_success \
    @@ -254,8 +253,7 @@
     +
     +	test_must_fail git cherry-pick --cleanup=scissors picked &&
     +
    -+	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
    -+	test_i18ncmp expected actual
    ++	test_i18ncmp expected .git/MERGE_MSG
     +'
     +
      test_expect_success 'failed cherry-pick describes conflict in work tree' '
    @@ -272,7 +270,7 @@
     +	cat >expected <<-EOF &&
     +		Revert "picked"
     +
    -+		This reverts commit objid.
    ++		This reverts commit OBJID.
     +
     +		# ------------------------ >8 ------------------------
     +		# Do not modify or remove the line above.
    @@ -284,7 +282,7 @@
     +
     +	test_must_fail git revert picked &&
     +
    -+	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
    ++	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
     +	test_i18ncmp expected actual
     +'
     +
    @@ -295,7 +293,7 @@
     +	cat >expected <<-EOF &&
     +		Revert "picked"
     +
    -+		This reverts commit objid.
    ++		This reverts commit OBJID.
     +
     +		# ------------------------ >8 ------------------------
     +		# Do not modify or remove the line above.
    @@ -307,7 +305,7 @@
     +
     +	test_must_fail git revert --cleanup=scissors picked &&
     +
    -+	sed "s/[a-f0-9]\{40\}/objid/" .git/MERGE_MSG >actual &&
    ++	sed "s/$OID_REGEX/OBJID/" .git/MERGE_MSG >actual &&
     +	test_i18ncmp expected actual
     +'
     +
3:  f3af8000ae < -:  ---------- sequencer.c: don't die on invalid cleanup_arg
-:  ---------- > 4:  68ec2b7cd7 sequencer.c: don't die on invalid cleanup_arg
-- 
2.21.0.370.g4fdb13b891

