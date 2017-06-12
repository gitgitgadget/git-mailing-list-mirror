Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F5B1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbdFLS3A (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:29:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33397 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdFLS27 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:28:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so7279675pfk.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pnrWrLr/gzqZc6Bqb9aNJ7LSNwe1dfwmhEp1+RN5sqw=;
        b=dpgGdLOkSO2ZKGKy+ywk2jfeK0D+Po/lj3bxMqbBFsEkeGUiHjkE7ocznDDB3e17b7
         vicJWCkFYxAxGc+UIEp+1HhhkIyi8OCP/KmAmH87+9yuV8S8sAR1cpJ8kN8bhFsq7vf7
         64DCLk1iMUOn5w4uhTVhQ+zaBLQLtq7YdTzVSwh2Rt27raeqxEn+RKaTlR8ooV6HXm+k
         5CheIDEEhLLhKh5sdEjpM1djQbOVzdMDBslA2xah/yjki36BXyyqtZ8fdJoPhNG33kTY
         wiwAqIHrGrU91hYCAD9p5yOgbhcYSt5H3nbM04jSPWR8l5RGiJ0Zib7y+O7T9jLTRBUi
         OKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pnrWrLr/gzqZc6Bqb9aNJ7LSNwe1dfwmhEp1+RN5sqw=;
        b=imqtexoDZKFlaPpjHv6bgBADhDLkMuimk30OAIIQJm8x10R718lCp98pt/Btp2AqUX
         LiitzcsdI0WlgUIWKNKyR7pg2HqqdnLnJga+Ye7rIiUaCDo6K5mJFapYO0nHCCxqa1V3
         BTkzr2yfCJwuSVVxTlLMS+x7MwQyofJxEmeNvtIAHV1I25EwHBQw+uixGyUvyFJfKUQq
         6j0URg+bHe98cjVl3MBr6SruhMEdziUaoPTlLBgdxP+Ge915AysyTH0D6gm/OU5Vzx4+
         G/oRiWvq6wmou1Pnjbs4C5LQCGziGzcjJWabzfbBPWEok1R6da90NnGWYVkWrRv0VdGZ
         SHiQ==
X-Gm-Message-State: AODbwcA99ct9bUxHMlBjUjCcYEZ1ZQpgI7odB9M7uTqrDUG4zNUjKGfL
        Jem3IJxJsieoEA==
X-Received: by 10.84.216.23 with SMTP id m23mr57568150pli.268.1497292138452;
        Mon, 12 Jun 2017 11:28:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id x5sm20294041pfi.103.2017.06.12.11.28.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 11:28:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
        <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
        <1497084241.8531.2.camel@gmail.com>
        <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
        <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
        <1497255003.1718.1.camel@gmail.com>
Date:   Mon, 12 Jun 2017 11:28:56 -0700
In-Reply-To: <1497255003.1718.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Mon, 12 Jun 2017 13:40:03 +0530")
Message-ID: <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

>> Adding a bit to "struct wt_status" is a good first step to allow all
>> three (i.e. in addition to "Initial commit" and "Changes to be
>> committed", "Changes not staged for commit" is the other one that
>> shares this potential confusion factor) to be phrased in a way that
>> is more appropriate in an answer to the question "what is the status
>> of my working area?", I would think.
>> 
>> Thanks.
>> 
> It seems that the current change has to be discarded altogether and
> further the change required doesn't look trivial. This seems to warrant
> some bit of research of the code base. As a first step I would like to
> know which part of the code base creates the commit template. I guess
> much can't be done without knowing how it's created.

Perhaps something along this line (warning: not even compile
tested)?

 builtin/commit.c |  1 +
 wt-status.c      | 15 ++++++++++++---
 wt-status.h      |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index da1ba4c862..ffb2d71d3d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1652,6 +1652,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/wt-status.c b/wt-status.c
index 25aafc35c8..006aaf9e76 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -196,7 +196,10 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	status_printf_ln(s, c, _("Changes to be committed:"));
+	if (s->commit_template)
+		status_printf_ln(s, c, _("Changes to be committed:"));
+	else
+		status_printf_ln(s, c, _("Changes already in the index:"));
 	if (!s->hints)
 		return;
 	if (s->whence != FROM_COMMIT)
@@ -214,7 +217,10 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	status_printf_ln(s, c, _("Changes not staged for commit:"));
+	if (s->commit_template)
+		status_printf_ln(s, c, _("Changes not staged for commit:"));
+	else
+		status_printf_ln(s, c, _("Changes not yet in the index:"));
 	if (!s->hints)
 		return;
 	if (!has_deleted)
@@ -1578,7 +1584,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commit yet on the branch"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 8a3864783b..17f72f2346 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -77,6 +77,7 @@ struct wt_status {
 	unsigned colopts;
 	int null_termination;
 	int show_branch;
+	int commit_template;
 	int hints;
 
 	enum wt_status_format status_format;
