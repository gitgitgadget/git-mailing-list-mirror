Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968541FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934205AbcHJTOU (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:14:20 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35501 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbcHJTOR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:14:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id f65so108126344wmi.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:14:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XevNCYKfzZSXquUv4F6DfPZGaptg2BEhrJmhir43aqo=;
        b=a/J+bwncpz+DFReC00LHlz8LwZHa0vBm9IwrtTsSQT+zr6v3PQe9dll/8PpISMnN84
         UiJ3UiHMMHK6typVq9cPpDW5T8UB0Ii0Yx97HMjjHD2Rt4hAwi1XjVBP5sL693Z/6ZNo
         aq+CSY3ZbmECv0eGQEgKjNsc9ohGZ1x+i7/L96o+a2L30tkPSyRiipRyrTEVudkrYe5M
         KKXvGgmOx8kfRZLSJN1tNeRUkPnPJMSLQYEkMDzsKrZi45TI6LLwSBqmfJAHuPYz8ItG
         NgS/Dmm+4rW9qJkK8pp7M87SVi1B9OLvUcb+VT39jfqRcpvfyPG5BKOnEOZ7MvcQR//8
         N+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XevNCYKfzZSXquUv4F6DfPZGaptg2BEhrJmhir43aqo=;
        b=Wd26+EFvwRg8gR6MnZIVW+xuXmJJiLiUDKpc1P5k+XlLU9xvHLdwXfNER4vnhJTMSu
         V57VP7L3yD/VvGFgY4fpf6r/DxxcpS4n/JfQInYwfibt0xzxthhqQRpBYpL/dSJK6UDq
         2bgSxsHZ2WywzfP9c4UW0rkhIt19kceS8O4j0b+J12Bl9K0oDKBmkH1lNJdql/qtaB4d
         wuQLNkqT5Ue4SdMnCXekJaTFaRuolZ96h5OX0eP4L7qCV94bXKiAXBG6+tGVjeQkKtSK
         3bj13RocVaTgr0d6bPqJWiZbEnhB6+5iwbVqDz2+8lgLlNsVTmzqrmVTOCUCY5nRLRDA
         O1yA==
X-Gm-Message-State: AEkoouvxS14gIN7TVtkeamqObOs85vxxOdQBw5wg5bE5XxNgQ2ekQVgWVNAHn9VdrNgYkNDYcSOCsZtEMRl62A==
X-Received: by 10.28.163.199 with SMTP id m190mr5133688wme.5.1470856455941;
 Wed, 10 Aug 2016 12:14:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.154.134 with HTTP; Wed, 10 Aug 2016 12:14:15 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608011107190.149069@virtualbox>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
 <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com>
 <20160726203041.GA4675@sigill.intra.peff.net> <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
 <CAH8BJxFvyEDuj-mm=N=ca3kxysopaBpro-HsuL-HZehqE_nxDA@mail.gmail.com>
 <alpine.DEB.2.20.1607271649120.14111@virtualbox> <CAH8BJxGPzpymSWPpxXRcCCx-OPckm5bVgENUEjVM-+9sr1T+6A@mail.gmail.com>
 <alpine.DEB.2.20.1608011107190.149069@virtualbox>
From:	Stephen Morton <stephen.c.morton@gmail.com>
Date:	Wed, 10 Aug 2016 15:14:15 -0400
Message-ID: <CAH8BJxE3f3HFVz5BSt_3mrcDPw0dhujNS9cS7iD0bbz_h=8dVA@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 5:12 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Stephen,
>
> On Wed, 27 Jul 2016, Stephen Morton wrote:
>
>> On Wed, Jul 27, 2016 at 11:03 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Wed, 27 Jul 2016, Stephen Morton wrote:
>> >
>> >> diff --git a/sequencer.c b/sequencer.c
>> >> index cdfac82..ce06876 100644
>> >> --- a/sequencer.c
>> >> +++ b/sequencer.c
>> >> @@ -176,7 +176,8 @@ static void print_advice(int show_hint, struct
>> >> replay_opts *opts)
>> >>                 else
>> >>                         advise(_("after resolving the conflicts, mark
>> >> the corrected paths\n"
>> >>                                  "with 'git add <paths>' or 'git rm <paths>'\n"
>> >> -                                "and commit the result with 'git commit'"));
>> >> +                                "then continue the %s with 'git %s
>> >> --continue'\n"
>> >> +                                "or cancel the %s operation with 'git
>> >> %s --abort'" ),  action_name(opts), action_name(opts),
>> >> action_name(opts), action_name(opts));
>> >
>> > That is an awful lot of repetition right there, with an added
>> > inconsistency that the action is referred to by its name alone in the
>> > "--continue" case, but with "operation" added in the "--abort" case.
>> >
>> > And additionally, in the most common case (one commit to cherry-pick), the
>> > advice now suggests a more complicated operation than necessary: a simply
>> > `git commit` would be enough, then.
>> >
>> > Can't we have a test whether this is the last of the commits to be
>> > cherry-picked, and if so, have the simpler advice again?
>>
>> Ok, knowing that I'm not on the last element of the sequencer is
>> beyond my git code knowledge.
>
> Oh, my mistake: I meant to say that this information could be easily
> provided by `pick_commits()` if it passed it to `print_advice()` via
> `do_pick_commit()`.
>
> Ciao,
> Johannes

(Finally getting back to this.)
Something like this, then Johannes?
(I intentionally print the '--continue' hint even in the case where
it's last of n commits that fails.)

~/ws/extern/git (maint *%>) > git diff
diff --git a/sequencer.c b/sequencer.c
index 617a3df..e0071aa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -154,7 +154,7 @@ static void free_message(struct commit *commit,
struct commit_message *msg)
        unuse_commit_buffer(commit, msg->message);
 }

-static void print_advice(int show_hint, struct replay_opts *opts)
+static void print_advice(int show_hint, int multiple_commits, struct
replay_opts *opts)
 {
        char *msg = getenv("GIT_CHERRY_PICK_HELP");

@@ -174,14 +174,14 @@ static void print_advice(int show_hint, struct
replay_opts *opts)
                        advise(_("after resolving the conflicts, mark
the corrected paths\n"
                                 "with 'git add <paths>' or 'git rm <paths>'"));
                else
-                        if  (! file_exists(git_path_seq_dir()))
-                                advise(_("after resolving the
conflicts, mark the corrected paths\n"
-                                        "with 'git add <paths>' or
'git rm <paths>'\n"
-                                                 "and commit the
result with 'git commit'"));
-                        else
+                        if  (multiple_commits)
                                advise(_("after resolving the
conflicts, mark the corrected paths with 'git add <paths>' or 'git rm
<paths>'\n"
                                         "then continue with 'git %s
--continue'\n"
                                         "or cancel with 'git %s
--abort'" ), action_name(opts), action_name(opts));
+                        else
+                                advise(_("after resolving the
conflicts, mark the corrected paths\n"
+                                        "with 'git add <paths>' or
'git rm <paths>'\n"
+                                        "and commit the result with
'git commit'"));
        }
 }

@@ -445,7 +445,7 @@ static int allow_empty(struct replay_opts *opts,
struct commit *commit)
                return 1;
 }

-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, struct replay_opts
*opts, int multiple_commits)
 {
        unsigned char head[20];
        struct commit *base, *next, *parent;
@@ -600,7 +600,7 @@ static int do_pick_commit(struct commit *commit,
struct replay_opts *opts)
                      : _("could not apply %s... %s"),
                      find_unique_abbrev(commit->object.oid.hash,
DEFAULT_ABBREV),
                      msg.subject);
-               print_advice(res == 1, opts);
+               print_advice(res == 1, multiple_commits, opts);
                rerere(opts->allow_rerere_auto);
                goto leave;
        }
@@ -964,6 +964,7 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)
 {
        struct commit_list *cur;
        int res;
+    int multiple_commits = (todo_list->next) != NULL;

        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
        if (opts->allow_ff)
@@ -973,7 +974,7 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)

        for (cur = todo_list; cur; cur = cur->next) {
                save_todo(cur, opts);
-               res = do_pick_commit(cur->item, opts);
+               res = do_pick_commit(cur->item, opts, multiple_commits);
                if (res)
                        return res;
        }
@@ -1021,7 +1022,7 @@ static int sequencer_continue(struct replay_opts *opts)
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-       return do_pick_commit(cmit, opts);
+       return do_pick_commit(cmit, opts, 0);
 }

 int sequencer_pick_revisions(struct replay_opts *opts)
~/ws/extern/git (maint *%>) > git diff @{u}
diff --git a/sequencer.c b/sequencer.c
index c6362d6..e0071aa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -154,7 +154,7 @@ static void free_message(struct commit *commit,
struct commit_message *msg)
        unuse_commit_buffer(commit, msg->message);
 }

-static void print_advice(int show_hint, struct replay_opts *opts)
+static void print_advice(int show_hint, int multiple_commits, struct
replay_opts *opts)
 {
        char *msg = getenv("GIT_CHERRY_PICK_HELP");

@@ -174,9 +174,14 @@ static void print_advice(int show_hint, struct
replay_opts *opts)
                        advise(_("after resolving the conflicts, mark
the corrected paths\n"
                                 "with 'git add <paths>' or 'git rm <paths>'"));
                else
-                       advise(_("after resolving the conflicts, mark
the corrected paths\n"
-                                "with 'git add <paths>' or 'git rm <paths>'\n"
-                                "and commit the result with 'git commit'"));
+                        if  (multiple_commits)
+                               advise(_("after resolving the
conflicts, mark the corrected paths with 'git add <paths>' or 'git rm
<paths>'\n"
+                                        "then continue with 'git %s
--continue'\n"
+                                        "or cancel with 'git %s
--abort'" ), action_name(opts), action_name(opts));
+                        else
+                                advise(_("after resolving the
conflicts, mark the corrected paths\n"
+                                        "with 'git add <paths>' or
'git rm <paths>'\n"
+                                        "and commit the result with
'git commit'"));
        }
 }

@@ -440,7 +445,7 @@ static int allow_empty(struct replay_opts *opts,
struct commit *commit)
                return 1;
 }

-static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
+static int do_pick_commit(struct commit *commit, struct replay_opts
*opts, int multiple_commits)
 {
        unsigned char head[20];
        struct commit *base, *next, *parent;
@@ -595,7 +600,7 @@ static int do_pick_commit(struct commit *commit,
struct replay_opts *opts)
                      : _("could not apply %s... %s"),
                      find_unique_abbrev(commit->object.oid.hash,
DEFAULT_ABBREV),
                      msg.subject);
-               print_advice(res == 1, opts);
+               print_advice(res == 1, multiple_commits, opts);
                rerere(opts->allow_rerere_auto);
                goto leave;
        }
@@ -959,6 +964,7 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)
 {
        struct commit_list *cur;
        int res;
+    int multiple_commits = (todo_list->next) != NULL;

        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
        if (opts->allow_ff)
@@ -968,7 +974,7 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)

        for (cur = todo_list; cur; cur = cur->next) {
                save_todo(cur, opts);
-               res = do_pick_commit(cur->item, opts);
+               res = do_pick_commit(cur->item, opts, multiple_commits);
                if (res)
                        return res;
        }
@@ -1016,7 +1022,7 @@ static int sequencer_continue(struct replay_opts *opts)
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-       return do_pick_commit(cmit, opts);
+       return do_pick_commit(cmit, opts, 0);
 }

 int sequencer_pick_revisions(struct replay_opts *opts)


------

Stephen
