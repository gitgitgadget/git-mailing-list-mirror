Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0499A1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbdDFOd4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 10:33:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36441 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbdDFOdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 10:33:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id o21so6845297wrb.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=DLrGiO/6kk/pimoFQS2jPF8MCOnkNU1RCgOiYRcFrho=;
        b=B/t88RV/EOR+UyUVidIIRT1U14u14ycukWonSy5JpGZlWPUfk+YSGwhkjb9Q9ns+GF
         YLZWKTEYsroJkSiD1wpm4foqqyAd9/T1FNi9R55TzGcQw/y9hyYCsQMUqioBakVb9V3a
         plE/iiY5GhrUrHOHxpSilL5WMJXyPT1JMwqla4aPo5vE1Q6s0myQ5YLdZKMMe86nzoct
         MxTSrcbQHmVA6U/quwuukUncpxh/ibFAbeSa/UFl/usH9N6xZpyqDkVz0H6lT4KbWJsN
         hIXcVR0fdOsTRo1bnvNKhT46iboU7dw+vuxWV32Kh5efaMjTYl9k5o7skEpf6MjMH8qM
         tWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=DLrGiO/6kk/pimoFQS2jPF8MCOnkNU1RCgOiYRcFrho=;
        b=nxRqPEd3IsbdFAk4m9PIsP5pynNXcqeiSJHm6WvzNpH1qxkz9NlQjmuRwT7V7FC5sE
         JdGQMCGntw6/P+9sFAr1ZiReeVZuObKXr/vCh9s6GTDq7UMGzYVN7Z6T4rUme2SK83eJ
         PpM1JNprl7xClHE1TpErNe8q60IJ5RZFSXg4FDe0RCdkVJBBWv24VY6shMzccTadCsb5
         4LI7VTctRO/pZh0daPRVul7LCowogA05Su90Xz5je/LdQ2YUVq/msZGyq+bCRoFYvrCo
         UgSkqXLRUxBqIUkz1zcK6HMwqVtowWCiN+P4wCernDzjmATUsJD3IpyOQYYQal9slZk/
         sxRQ==
X-Gm-Message-State: AFeK/H2Gmh6gFaPRiKORw7TKtqQQeoPw3pzayBGLSsyY3V4O+uEsAWmiIIHoE1blNR7efQ==
X-Received: by 10.28.213.72 with SMTP id m69mr9823335wmg.9.1491489233288;
        Thu, 06 Apr 2017 07:33:53 -0700 (PDT)
Received: from localhost.localdomain (x590e1a8d.dyn.telefonica.de. [89.14.26.141])
        by smtp.gmail.com with ESMTPSA id q31sm1656669wrb.3.2017.04.06.07.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 07:33:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] status: show in-progress info for short status
Date:   Thu,  6 Apr 2017 16:33:42 +0200
Message-Id: <20170406143342.14770-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <2c3c8028cd057428758bb1e21a064a264936de90.1490968428.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1779,6 +1780,31 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  	}
>  
>  	color_fprintf(s->fp, header_color, "]");
> +
> + inprogress:
> +	if (!s->show_inprogress)
> +		goto conclude;
> +	memset(&state, 0, sizeof(state));
> +	wt_status_get_state(&state,
> +			    s->branch && !strcmp(s->branch, "HEAD"));
> +	if (state.merge_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("MERGING")));
> +	else if (state.am_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("AM")));
> +	else if (state.rebase_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-m")));
> +	else if (state.rebase_interactive_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REBASE-i")));
> +	else if (state.cherry_pick_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("CHERRY-PICKING")));
> +	else if (state.revert_in_progress)
> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("REVERTING")));
> +	if (state.bisect_in_progress)

else if?

> +		color_fprintf(s->fp, header_color, "; %s", LABEL(N_("BISECTING")));
> +	free(state.branch);
> +	free(state.onto);
> +	free(state.detached_from);
> +
>   conclude:
>  	fputc(s->null_termination ? '\0' : '\n', s->fp);
>  }

This reminded me of a patch that I have been using for almost two
years now...

git-prompt.sh's similar long conditional chain to show the ongoing
operation has an else-branch at the end showing "AM/REBASE".  Your
patch doesn't add an equivalent branch.  Is this intentional or an
oversight?

I suppose it's intentional, because that "AM/REBASE" branch in the
prompt seems to be unreachable (see below), but I never took the
effort to actually check that (hence the "seems" and that's why I
never submitted it).



 -- >8 --

Subject: [PATCH] bash prompt: remove unreachable ongoing "AM/REBASE" fallback

Back in the day it was impossible to tell an ongoing 'am' and "plain"
'rebase' (i.e. non-interactive, non-merge) apart, thus the prompt
displayed "AM/REBASE" in those cases, see e75201963 (Improve bash
prompt to detect various states like an unfinished merge, 2007-09-30).
Later 3041c3243 (am: --rebasing, 2008-03-04) made it possible to tell
those cases apart and made __git_ps1() use this right away to display
either "AM" or "REBASE", respectively.  However, it left that
"AM/REBASE" in an else-branch as a fallback, but it seems to have been
impossible to reach even back then.

This ancient unreachable else-branch has survived to this day, remove
it finally.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c6cbef38c..d13af41f2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -411,8 +411,6 @@ __git_ps1 ()
 				r="|REBASE"
 			elif [ -f "$g/rebase-apply/applying" ]; then
 				r="|AM"
-			else
-				r="|AM/REBASE"
 			fi
 		elif [ -f "$g/MERGE_HEAD" ]; then
 			r="|MERGING"
-- 
2.12.2.613.g9c5b79913

