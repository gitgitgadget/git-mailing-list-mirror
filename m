Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559841F453
	for <e@80x24.org>; Thu, 20 Sep 2018 16:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeITWDs (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 18:03:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40632 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeITWDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 18:03:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id x26-v6so8901446lfi.7
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=niUdpwpKqNmWjWz7EcmAKvYtbhaCTq43jBA2uBtsVY8=;
        b=Fw6pdD5rg8YiD/UpGvrXSwmqMv5U6ZDP7S2I1bWbzas1XFo02H2Cy82miXvcNqQew0
         6T4t2ztm6VASbE4TK34+PrnweytP8z7QzU0yN2LAkKcuHFDD0hGbLmwuATkZa+eaLDw5
         UmSe46bdmqevMfpcqw1ozN8re3WaUXLTMPXfEaWJ+O3Xkw9h4xVZr+FM/IyyLakZh15/
         +o9UELyXP80aiiIioVL7tPmVf1KD/GTZqECCzToHgEI6oDIHDEqSUHL/agcMub17F8+e
         NUAY9isfmbE5nd9T0KJcY5BxMAPdw955g5iv7LhTHg/rReTyhOZXKp28Pi9JGzN4occ3
         tXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=niUdpwpKqNmWjWz7EcmAKvYtbhaCTq43jBA2uBtsVY8=;
        b=is9Iy0efErgSq8FzBDx8lTSnNh2Tw2KIeXusF2XRko9qu+YvLsrzmlluAigMXf4VZ+
         f/XtltAgDKfUDjfbm3Hfk5e7HfiXiO0xopxK3prdGA94ZsbmHY7xlgKo97YjR4PHeEjL
         erSxzYp9JAiXXm+OhOcOs9yw6HeVo7nGc1K2lqDEAR8W8cTKCJsyxj52EzzhUr53mcxE
         Ui4Skgaisi6ouM0Jzl3kvyKvYsSn8EGz1wff/zgnjkQ03EXPOHAaG8DgN/Whvl8KcYl5
         CDp9sGvfZn29XyGm5LW5Z7Yj5IAKx50BZbpIZ+EZzb8CdK7uNSLXicEIGRyFzLUhjMvl
         TwvQ==
X-Gm-Message-State: APzg51CqIP0jbCiNfCIxAMsun9fbkOw7K4TZLsZqQXmACTc1g5VU3YNU
        fpjlNbW42PoEUABMm+P0qA9DYgUF
X-Google-Smtp-Source: ANB0VdbrAfVq31UZPqbCCt0FAY9Nut3JobRgYte3PUpaQyj+t2zdc5BEr/LVwe2EgwVYa4mWFQUZPg==
X-Received: by 2002:a19:645e:: with SMTP id b30-v6mr3998081lfj.5.1537460372626;
        Thu, 20 Sep 2018 09:19:32 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n26-v6sm4470435ljc.7.2018.09.20.09.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 09:19:31 -0700 (PDT)
Date:   Thu, 20 Sep 2018 18:19:28 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog expire: add progress output
Message-ID: <20180920161928.GA13379@duynguyen.home>
References: <20180919141016.27930-1-avarab@gmail.com>
 <CACsJy8CX8xspbsW7Ta3aOD6LHh55ZaJ0tdrYeWDP_Vyw70NXtA@mail.gmail.com>
 <87tvmljtaz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvmljtaz.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 07:22:44PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> @@ -225,14 +226,20 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
> >>         struct commit_list *pending;
> >>         timestamp_t expire_limit = cb->mark_limit;
> >>         struct commit_list *leftover = NULL;
> >> +       struct progress *progress = NULL;
> >> +       int i = 0;
> >>
> >>         for (pending = cb->mark_list; pending; pending = pending->next)
> >>                 pending->item->object.flags &= ~REACHABLE;
> >>
> >>         pending = cb->mark_list;
> >> +       progress = start_delayed_progress(
> >> +               _("Marking unreachable commits in reflog for expiry"), 0);
> >
> > Maybe just "Searching expired reflog entries" or something like that.
> > It's not technically as accurate, but I think it's easier to
> > understand by by new people.
> 
> Or "Pruning reflog entries"? I was aiming for some combination of a)
> making it clear what we're doing (pruning stuff) b) that we're doing it
> on a subset of the counter of the (very large) values we're showing.
> 
> So the current one has "a" && "b", "Searching..." has neither, and
> "Pruning..." has "a" but not "b".
> 
> Maybe making a && b clear isn't that important, but I'm currently
> leaning towards keeping the current one because it's not *that* long and
> makes things clearer to the user.

OK

> >>         while (pending) {
> >>                 struct commit_list *parent;
> >>                 struct commit *commit = pop_commit(&pending);
> >> +
> >> +               display_progress(progress, ++i);
> >
> > maybe rename it to commit_count or something and leave "i" for
> > temporary/short lived usage.
> 
> Good point. Willdo.

Actually I'm still not sure if it's valuable to show the actual commit
count here. Some patch like this could show "activity" without the
number. But this is tangent.

-- 8< --
Subject: [PATCH] progress: add api for displaying a throbber

---
 progress.c | 29 +++++++++++++++++++++++++----
 progress.h |  1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/progress.c b/progress.c
index 5a99c9fbf0..fada556bf0 100644
--- a/progress.c
+++ b/progress.c
@@ -36,6 +36,7 @@ struct progress {
 	unsigned delay;
 	struct throughput *throughput;
 	uint64_t start_ns;
+	int show_throbber;
 };
 
 static volatile sig_atomic_t progress_update;
@@ -81,11 +82,13 @@ static int is_foreground_fd(int fd)
 static int display(struct progress *progress, uint64_t n, const char *done)
 {
 	const char *eol, *tp;
+	static char throbber[] = "\\|/-";
 
 	if (progress->delay && (!progress_update || --progress->delay))
 		return 0;
 
-	progress->last_value = n;
+	if (!progress->show_throbber)
+		progress->last_value = n;
 	tp = (progress->throughput) ? progress->throughput->display.buf : "";
 	eol = done ? done : "   \r";
 	if (progress->total) {
@@ -104,8 +107,15 @@ static int display(struct progress *progress, uint64_t n, const char *done)
 		}
 	} else if (progress_update) {
 		if (is_foreground_fd(fileno(stderr)) || done) {
-			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
-				progress->title, (uintmax_t)n, tp, eol);
+			if (progress->show_throbber) {
+				progress->last_value++;
+				fprintf(stderr, "%s: %c%s%s",
+					progress->title,
+					throbber[progress->last_value % 4],
+					tp, eol);
+			} else
+				fprintf(stderr, "%s: %"PRIuMAX"%s%s",
+					progress->title, (uintmax_t)n, tp, eol);
 			fflush(stderr);
 		}
 		progress_update = 0;
@@ -193,6 +203,14 @@ int display_progress(struct progress *progress, uint64_t n)
 	return progress ? display(progress, n, NULL) : 0;
 }
 
+void display_throbber(struct progress *progress)
+{
+	if (progress) {
+		progress->show_throbber = 1;
+		display(progress, 0, NULL);
+	}
+}
+
 static struct progress *start_progress_delay(const char *title, uint64_t total,
 					     unsigned delay)
 {
@@ -248,7 +266,10 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		buf = xstrfmt(", %s.\n", msg);
+		if (progress->show_throbber)
+			buf = xstrfmt(" %s.\n", msg);
+		else
+			buf = xstrfmt(", %s.\n", msg);
 		display(progress, progress->last_value, buf);
 		free(buf);
 	}
diff --git a/progress.h b/progress.h
index 70a4d4a0d6..9d23ff242f 100644
--- a/progress.h
+++ b/progress.h
@@ -5,6 +5,7 @@ struct progress;
 
 void display_throughput(struct progress *progress, uint64_t total);
 int display_progress(struct progress *progress, uint64_t n);
+void display_throbber(struct progress *progress);
 struct progress *start_progress(const char *title, uint64_t total);
 struct progress *start_delayed_progress(const char *title, uint64_t total);
 void stop_progress(struct progress **progress);
-- 
2.19.0.rc0.337.ge906d732e7

-- 8< --
