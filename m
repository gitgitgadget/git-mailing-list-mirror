Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A841F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDUDNR (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:13:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35308 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDUDNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:13:16 -0400
Received: by mail-wr0-f194.google.com with SMTP id w3-v6so27411219wrg.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Bq7lnDUqIMwup3rBHf+JmlwccucH2S+eoL+3RRUz6+8=;
        b=tupnAqSS68NMFJrdhtvHWqmKvqNHCtrzrwB/XgAvzkpO/4+FVw/vORFhPOwcGfGLpB
         F2iLRVbdDAEFQy+x/k+4/pGlo3gpWj9wmoITaNU1GJsmh4m93Mj4W3M2GTKDYIIBTny6
         KOiOj/qMjs7RLpjQIkTDFwnGCE/nJEDxWwCpb988ik9UJSc3PVIjTCBj9hyn7P+bIw/3
         eeByFPfvDRG0LBWPXc+HHwxxYgm+vVV16ZN7UPO05pVE2mXuz682Oym24hj5wTqYygHb
         +v5k+/0waQZb9k95yYza+uReQRMy6chKtrHFZklNCbcFzhcaK9Mc05V0HwsEmydBoAor
         97aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Bq7lnDUqIMwup3rBHf+JmlwccucH2S+eoL+3RRUz6+8=;
        b=PKjMFNFW96GPYfS3Qw4son2G7p8typttimQWmJkweu9Fr8F62/Wdy6pfNV95XO1Do3
         HB6zJt86W7OzF7cwLnn4WbQZcjYIFlYorrXGmJSU3h+z4Buv0nrWRjSj8ehcufSsHISo
         Tu/Cq90z1NKcyg24mZTtGKMkJ1VJsK2nwmigbc2FmFzazeQjfakqpDMcab0nhzhrXC3P
         KBcyatp8XLEZwMyK2apescobPkXHWfDGMu2tPNHn8SupL+KLjYFjfH6WYmGUL/951CjO
         0PlY802F+9g3Tw9XxAxdmXKq+1ztPy7Eykh76E09DWhR+9W80NvISBn+79cgmDC9ok5b
         vYNQ==
X-Gm-Message-State: ALQs6tBXE1C5x0Irl5KSbCkmuluiDKpfgU9rChPEEn/hR/t3E37B60xc
        pB2EAgifsbyaq5nHEbhicUM=
X-Google-Smtp-Source: AIpwx4/8IXicolVPp/NmfiU02TYBiQwLMx4hqXnz8kcMjkMj28HA6v3BYMKkTXz16c30ii7tj/olJA==
X-Received: by 10.28.17.18 with SMTP id 18mr3555639wmr.125.1524280394664;
        Fri, 20 Apr 2018 20:13:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 55-v6sm13412476wrw.52.2018.04.20.20.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 20:13:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
        <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
        <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
        <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com>
        <20180420072701.GB13462@ruderich.org>
Date:   Sat, 21 Apr 2018 12:13:13 +0900
In-Reply-To: <20180420072701.GB13462@ruderich.org> (Simon Ruderich's message
        of "Fri, 20 Apr 2018 09:27:01 +0200")
Message-ID: <xmqqlgdhb6ba.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simon Ruderich <simon@ruderich.org> writes:

> On Thu, Apr 19, 2018 at 02:10:40PM +0900, Junio C Hamano wrote:
>> diff --git a/parse-options-cb.c b/parse-options-cb.c
>> index c6679cb2cd..872627eafe 100644
>> --- a/parse-options-cb.c
>> +++ b/parse-options-cb.c
>> @@ -38,7 +38,11 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
>>  int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
>>  			     int unset)
>>  {
>> -	return parse_expiry_date(arg, (timestamp_t *)opt->value);
>> +	if (unset)
>> +		arg = "never";
>> +	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
>> +		die("malformed expiration date '%s'", arg);
>> +	return 0;
>>  }
>
> Should this error get translated?

Sure.  The new test to check this codepath even protects itself from
such a translation by using test_i18ngrep, so this is safe to mark
for translation from day one.

Thanks.

-- >8 --
Subject: [PATCH v2] parseopt: handle malformed --expire arguments more nicely

A few commands that parse --expire=<time> command line option behave
sillily when given nonsense input.  For example

    $ git prune --no-expire
    Segmentation falut
    $ git prune --expire=npw; echo $?
    129

Both come from parse_opt_expiry_date_cb().

The former is because the function is not prepared to see arg==NULL
(for "--no-expire", it is a norm; "--expire" at the end of the
command line could be made to pass NULL, if it is told that the
argument is optional, but we don't so we do not have to worry about
that case).

The latter is because it does not check the value returned from the
underlying parse_expiry_date().

This seems to be a recent regression introduced while we attempted
to avoid spewing the entire usage message when given a correct
option but with an invalid value at 3bb0923f ("parse-options: do not
show usage upon invalid option value", 2018-03-22).  Before that, we
didn't fail silently but showed a full usage help (which arguably is
not all that better).

Also catch this error early when "git gc --prune=<expiration>" is
misspelled by doing a dummy parsing before the main body of "gc"
that is time consuming even begins.  Otherwise, we'd spend time to
pack objects and then later have "git prune" first notice the error.
Aborting "gc" in the middle that way is not harmful but is ugly and
can be avoided.

Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * marking the new message in parse_opt_expiry_date_cb() function
   for i18n is the only change from the previous round.

 builtin/gc.c       |  4 ++++
 parse-options-cb.c |  6 +++++-
 t/t5304-prune.sh   | 10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0edf..858aa444e1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -353,6 +353,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	timestamp_t dummy;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -388,6 +389,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
+	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
+		die(_("Failed to parse prune expiry value %s"), prune_expire);
+
 	if (aggressive) {
 		argv_array_push(&repack, "-f");
 		if (aggressive_depth > 0)
diff --git a/parse-options-cb.c b/parse-options-cb.c
index c6679cb2cd..0f9f311a7a 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -38,7 +38,11 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	return parse_expiry_date(arg, (timestamp_t *)opt->value);
+	if (unset)
+		arg = "never";
+	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
+		die(_("malformed expiration date '%s'"), arg);
+	return 0;
 }
 
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 6694c19a1e..af69cdc112 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -320,4 +320,14 @@ test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
 	test_cmp expected actual
 '
 
+test_expect_success 'prune: handle expire option correctly' '
+	test_must_fail git prune --expire 2>error &&
+	test_i18ngrep "requires a value" error &&
+
+	test_must_fail git prune --expire=nyah 2>error &&
+	test_i18ngrep "malformed expiration" error &&
+
+	git prune --no-expire
+'
+
 test_done



