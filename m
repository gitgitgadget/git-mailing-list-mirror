Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0801F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 12:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJJTnt (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 15:43:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJTns (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 15:43:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id 63-v6so5490497wra.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ib5XtjnUcVO7Hz4nw1AwX4sPMvl2EIchXIRL9JgrfBU=;
        b=pzbSnh0NrhknS/Uwn1yU/qpvH0z2Rx2HDHR2hU6AE1InsA7GXOsRMzX+AhHVF7EKXo
         CIzP7AEiJs5yrcWqB6gZY8vGnNzRYlx7PpyVS05XGy16spqv5XfSBte/NmIWEF5lSDRz
         RON3/pBGmGLfFszv2gqWea7Sdeyi3+U26iL7oSj0SNGatm/kmj2Jp0W6rMQHgI+Ic5LS
         H4+GD2swWPoCwzbryeysItuK7uZC3mrMqKQZSLRSL1gh4g+vhUyGQQiFHCT1vp4J6yKC
         EVfUnq6ofIElpZL4unrAeSUBiUOF1r9XqQtGKxs45oFLp+LK29/jNOO8aHyXEVvqeJ9g
         OEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ib5XtjnUcVO7Hz4nw1AwX4sPMvl2EIchXIRL9JgrfBU=;
        b=TVM+yVhlMrMrtYGIVerLVDOCFpudwzFAEQV5Lfwiuwednsq/03YpKo9N/L48cF9Uss
         2fOwz3vvc4ENbE7sY6rRUixO13zUvU1W4QQGEvrZUAQQXkDGO936tKGzk2gFPM1739Zm
         bNpsAxi1m2/Yml5CaOiuqvv8wHLqbwa4mu2E1yZA+m1oCLXBTVoOEVM08R1inCM5el4H
         OG1yowOUgWpQT4iumeQXmNoXF9S6t0yvxCNK6Ykh0i0S+ZYPA+x51iyV6v1lCSExwCM3
         ze3nVXWNq4rP8St0tDXtRwaR8gtjteZi+dA0jgR15jyFqlEt11gVHr7VOnBNCJ6dLWt3
         0NcQ==
X-Gm-Message-State: ABuFfohkIvlMjkHFIrrOKou+T8qLcAVz3yI/ZZWb9Ij3JuSC4BiKowG0
        3sTqFP8pjfizn8FxgKZQpnOVooYMSkU=
X-Google-Smtp-Source: ACcGV63Lqqr630dbgvVD6fc8YMzLd7cGKuZsHNesNfecPpYER64cqzmJhmyNAayZfs3YZkDf4Kbueg==
X-Received: by 2002:a5d:6608:: with SMTP id n8-v6mr24257826wru.281.1539174110825;
        Wed, 10 Oct 2018 05:21:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l70-v6sm35719236wma.0.2018.10.10.05.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:21:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
        <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
        <20181009234502.oxzfwirjcew2sxrm@dcvr>
        <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
        <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
        <878t36f3ed.fsf@evledraar.gmail.com>
Date:   Wed, 10 Oct 2018 21:21:48 +0900
In-Reply-To: <878t36f3ed.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 10 Oct 2018 13:27:06 +0200")
Message-ID: <xmqqzhvmkn4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>  - We use this warning as a proxy for "let's not run for a day",
>    otherwise we'll just grind on gc --auto trying to consolidate
>    possibly many hundreds of K of loose objects only to find none of
>    them can be pruned because the run into the expiry policy. With the
>    warning we retry that once per day, which sucks less.
>
>  - This conflation of the user-visible warning and the policy is an
>    emergent effect of how the different gc pieces interact, which as I
>    note in the linked thread(s) sucks.
>
>    But we can't just yank one piece away (as Jonathan's patch does)
>    without throwing the baby out with the bathwater.
>
>    It will mean that e.g. if you have 10k loose objects in your git.git,
>    and created them just now, that every time you run anything that runs
>    "gc --auto" we'll fork to the background, peg a core at 100% CPU for
>    2-3 minutes or whatever it is, only do get nowhere and do the same
>    thing again in ~3 minutes when you run your next command.

We probably can keep the "let's not run for a day" safety while
pretending that "git gc -auto" succeeded for callers like "git svn"
so that these callers do not hae to do "eval { ... }" to hide our
exit code, no?

I think that is what Jonathan's patch (jn/gc-auto) does.

From: Jonathan Nieder <jrnieder@gmail.com>
Date: Mon, 16 Jul 2018 23:57:40 -0700
Subject: [PATCH] gc: do not return error for prior errors in daemonized mode

diff --git a/builtin/gc.c b/builtin/gc.c
index 95c8afd07b..ce8a663a01 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -438,9 +438,15 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	return NULL;
 }
 
-static void report_last_gc_error(void)
+/*
+ * Returns 0 if there was no previous error and gc can proceed, 1 if
+ * gc should not proceed due to an error in the last run. Prints a
+ * message and returns -1 if an error occured while reading gc.log
+ */
+static int report_last_gc_error(void)
 {
 	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
...
 	if (len < 0)
+		ret = error_errno(_("cannot read '%s'"), gc_log_path);
+	else if (len > 0) {
+		/*
+		 * A previous gc failed.  Report the error, and don't
+		 * bother with an automatic gc run since it is likely
+		 * to fail in the same way.
+		 */
+		warning(_("The last gc run reported the following. "
 			       "Please correct the root cause\n"
 			       "and remove %s.\n"
 			       "Automatic cleanup will not be performed "
 			       "until the file is removed.\n\n"
 			       "%s"),
 			    gc_log_path, sb.buf);
+		ret = 1;
+	}
 	strbuf_release(&sb);
 done:
 	free(gc_log_path);
+	return ret;
 }
 
I.e. report_last_gc_error() returns 1 when finds that the previous
attempt to "gc --auto" failed.  And then

@@ -561,7 +576,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
 		if (detach_auto) {
-			report_last_gc_error(); /* dies on error */
+			int ret = report_last_gc_error();
+			if (ret < 0)
+				/* an I/O error occured, already reported */
+				exit(128);
+			if (ret == 1)
+				/* Last gc --auto failed. Skip this one. */
+				return 0;

... it exits with 0 without bothering to rerun "gc".

So it won't get stuck for 3 minutes; the repository after "gc
--auto" punts will stay to be suboptimal for a day, and the user
kill not get an "actionable" error notice (due to this hiding of
previous error), hence cannot make changes that may help like
shortening expiry period, though.

