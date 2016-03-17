From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Thu, 17 Mar 2016 13:47:44 +0530
Message-ID: <CA+DCAeSoyKyO+SVYuY7oYF-2YK4pgvQEKpe7FpU6=5Ag+KeT-Q@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:17:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agT7v-0008HG-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 09:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbcCQIRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 04:17:48 -0400
Received: from mail-qg0-f65.google.com ([209.85.192.65]:35385 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932713AbcCQIRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 04:17:45 -0400
Received: by mail-qg0-f65.google.com with SMTP id l11so2925309qge.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZEHnQ1Pt4b4PQO0otmfb64SfGpfuu+4zojZCVQgkMlA=;
        b=yZiCVZRqjdSHcRwISiYBKegkffLb8XNt+RMRDCePE3emRVs4VAfdQeb2b5lyYMxlit
         6O/gXgjLPwfBqcA3hBsx4TVsze0uzB3u4p8tOYvH4GF+VaTM6b0T33FsSi05klCvjMF2
         VVUmd3KwVmMdLW7mMy6p0AuvPtVKUFX29rCcPUxW2dL3rK8Qd8kLjAPH8uX1eNVg9HRZ
         YSlI166O3CCW8WiRBfiUHajcGkbJdSPU4zZfXeosX4k+9zt0Z7QvelZJ2dtWpLO3RNLQ
         WcMNYIMIWAKyqNB/4rTY1T2zYAOMhpxQBt8+PnO1BgkLG+NADqX057hB0roud6auhO5X
         hbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZEHnQ1Pt4b4PQO0otmfb64SfGpfuu+4zojZCVQgkMlA=;
        b=RtNNySq4LSK5FsDaAqTsd7lezelbAb9cN6tXqzoJAeh/YFX9YsjQHPykeiqfb974Fk
         bTs47EgqnHupfQxhyju3H31fdZUFcdosW38RIWhCNDeskfV2eSINjnYI7SQ2Z7/kefAG
         mrt3vhG4Z+z0FPOggN25VeAwrdoBSzVNJqTu8eLDIZ8P1vyJQVD0qw2bBiG1BtF0dKqx
         ueGXZO8AUoulCjY3j33nd2CUDTsQn3cXjt90EjBigNArd9bKXlvybnn4DgseSR3wE3Tz
         tPJZjrWmavJRAJCkLv7sMtSjKusMeRww8bIqXQ770pk5GgIx5DwCyyG8bZFlmSW8DK+B
         tXDA==
X-Gm-Message-State: AD7BkJIXHT5n6beQOEiHMrk/buzc6rkDGUFhBEwoxl5R511C1+ipp8k4+Xe4R9lUpOsQgWPGSfGvmiova/l+EQ==
X-Received: by 10.140.157.7 with SMTP id d7mr12966733qhd.17.1458202664742;
 Thu, 17 Mar 2016 01:17:44 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Thu, 17 Mar 2016 01:17:44 -0700 (PDT)
In-Reply-To: <CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289089>

Hello Eric,

I tried out this approach and here's the result.

---

diff --git a/builtin/pull.c b/builtin/pull.c
index b5b0255..0ce007d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *opt_ff;
 static char *opt_verify_signatures;
+static int opt_autostash = -1;
 static int config_autostash;
 static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
 static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
@@ -150,6 +151,8 @@ static struct option pull_options[] = {
        OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
                N_("verify that the named commit has a valid GPG signature"),
                PARSE_OPT_NOARG),
+       OPT_BOOL(0, "autostash", &opt_autostash,
+               N_("automatically stash/stash pop before and after rebase")),
        OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
                N_("merge strategy to use"),
                0),
@@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
        argv_array_pushv(&args, opt_strategy_opts.argv);
        if (opt_gpg_sign)
                argv_array_push(&args, opt_gpg_sign);
+       argv_array_push(&args, opt_autostash ? "--autostash" :
"--no-autostash");

        argv_array_push(&args, "--onto");
        argv_array_push(&args, sha1_to_hex(merge_head));
@@ -846,12 +850,20 @@ int cmd_pull(int argc, const char **argv, const
char *prefix)
        if (get_sha1("HEAD", orig_head))
                hashclr(orig_head);

+       if(!opt_rebase && opt_autostash != -1)
+               die(_("--[no-]autostash option is only valid with --rebase."));
+
        if (opt_rebase) {
                int autostash = config_autostash;

                if (is_null_sha1(orig_head) && !is_cache_unborn())
                        die(_("Updating an unborn branch with changes
added to the index."));

+               if (opt_autostash != -1)
+                       autostash = opt_autostash;
+               else
+                       opt_autostash = config_autostash;
+
                if (!autostash)
                        die_on_unclean_work_tree(prefix);
---

This way of implementation looks a bit less clean to me than
the previous one because we are using "opt_autostash" to pass
the "--[no-]autostash"  flag to git-rebase, thus if user does not
specify anything about stashing in command line then  config_autostash
value has to be used ( i.e. opt_autostash = config_autostash).
To do this an "else" case has to be introduced in the code. This
might effect the readability of the code because the reader might
wonder why "opt_autostash" is used to assign value to "autostash"
in one case, and opt_autostash = config_autostash in other case.

But I agree that this way I won't be touching the changes I made
in patch 1/2.

I would like to know your view on above mentioned issue.

Also I made a mistake in patch 1/2 which I will correct in the next
version along with other changes suggested by you.

Thanks,
Mehul
