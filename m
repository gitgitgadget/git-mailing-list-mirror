Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 448AC1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdBNWLK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:11:10 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36135 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751638AbdBNWLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:11:09 -0500
Received: by mail-it0-f65.google.com with SMTP id f200so7590163itf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qb8REV+WLq6vZc7BWzpiIpRb7Cm0z1L3+IanM4EwNYU=;
        b=P6CZ7FuXCSPYQrp1KarwZD1BckRq/E927vhFvZ0PzAKOyDr0zEFfX7PvQCu9nlYXK/
         qXf0b8EbsoiezKUdKXox5c++zBp3Mrhjc8JpBTnSUvT/0ZPh4/jWvVX6/HefFS/Z7Syh
         9TCmHRdArfL63TBJvSa+EZujROyhMETwIZ7Q0A7JmI6DHcALmHl2pqUVunjBS3FiMwEG
         Gywa5wfR3kCzFNoqvwH1YiP7Ww2Tu+qmZQ8zDM6NVaNcUuarDedEx9j4/vIGADOdzlaG
         Bdxlu17OlQz9aLc5Xw5/CL/uY8EFxAU2buMJ83aUPAMM+XhaKgdg5Tga6eU60GrmqWUW
         89kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qb8REV+WLq6vZc7BWzpiIpRb7Cm0z1L3+IanM4EwNYU=;
        b=nPcROLrOHnJVBPIhSYF8TMGzfLQy1k5tKcXXBDY9YuSnWy7S0neaGDTL9M96jjd033
         wa97ze7Syyh2mbNlngf6YamJV1wSi3beBPGKQQdVjk4FXIvQKIYrN3eHsFDUP9vvJnGE
         TJzNEYDJ8Ls5YuX+84RrZ0QRtjkDUL4MimxV3nXeO8avapbBTWKzn3scC5P9DWsBAnXv
         q3kOgBAKjx3LO5jTtGKKH0s7SuQ43KFtsPaKX1ugG5bngu+QOcfv7E3evGcJTsjD4Lfo
         dte86Q82qtGcFxAlqsAmFgN39tfYXw1QcEu7/h6tybeyFeaX5HmOlxl6IPivWgSIlHma
         VjYw==
X-Gm-Message-State: AMke39lD8YbvrfldTryauSLLkk8N6IHcTFgPTwZrUlhUmyzzkuUkGWf3WsUXOQveP/sb/A==
X-Received: by 10.84.162.204 with SMTP id o12mr39280594plg.132.1487110268300;
        Tue, 14 Feb 2017 14:11:08 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id 191sm3069348pgd.40.2017.02.14.14.11.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 14:11:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
        <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
        <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Feb 2017 14:11:06 -0800
In-Reply-To: <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Feb 2017 13:01:49 -0800")
Message-ID: <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  We'd need to update the tests that expects the old style
> output, though.

The updates to the expectation look like this (already squashed).
The --source decorations in 4202 are also shown at the end, which
probably is in line with the way --show-decorations adds them at the
end of the line, but was somewhat surprising from reading only the
log message.

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 48b55bfd27..dea2d449ab 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1353,9 +1353,9 @@ test_expect_success 'set up --source tests' '
 
 test_expect_success 'log --source paints branch names' '
 	cat >expect <<-\EOF &&
-	09e12a9	source-b three
-	8e393e1	source-a two
-	1ac6c77	source-b one
+	09e12a9 three	source-b
+	8e393e1 two	source-a
+	1ac6c77 one	source-b
 	EOF
 	git log --oneline --source source-a source-b >actual &&
 	test_cmp expect actual
@@ -1364,9 +1364,9 @@ test_expect_success 'log --source paints branch names' '
 test_expect_success 'log --source paints tag names' '
 	git tag -m tagged source-tag &&
 	cat >expect <<-\EOF &&
-	09e12a9	source-tag three
-	8e393e1	source-a two
-	1ac6c77	source-tag one
+	09e12a9 three	source-tag
+	8e393e1 two	source-a
+	1ac6c77 one	source-tag
 	EOF
 	git log --oneline --source source-tag source-a >actual &&
 	test_cmp expect actual
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index b972296f06..08236a83e7 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,15 +44,15 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
+${c_commit}COMMIT_ID${c_reset} B${c_commit} (${c_reset}${c_HEAD}HEAD ->\
  ${c_reset}${c_branch}master${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
- ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
- ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
- On master: Changes to A.t
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset}
+${c_commit}COMMIT_ID${c_reset} A1${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
+ ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset}
+${c_commit}COMMIT_ID${c_reset} On master: Changes to A.t\
+${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}
+${c_commit}COMMIT_ID${c_reset} A${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset}
 EOF
 
 # We want log to show all, but the second parent to refs/stash is irrelevant
