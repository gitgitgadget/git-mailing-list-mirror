Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA9D91F404
	for <e@80x24.org>; Thu, 19 Apr 2018 02:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbeDSCQO (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 22:16:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33630 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeDSCQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 22:16:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73-v6so9709245wrb.0
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 19:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=56sVvVwErDrcTourArAhv/BVY3MHnHmWqLTosgbpmhc=;
        b=onqPM2R0ESqZvjTrfPipb4f5/hSgiiAYTXQivQmEXIvFo1hq5n6o3nLM8bK8WaRiq+
         x1UotnhOXzYK732gRlb5O9zvW8eeg0ObSNE9BZ5mn7C7jzIqg9bKgpxPK55HDe0XcSX5
         HLBpbCNxERxA5GhgjEkrUuwmK4/Lqu5knk4KX/uN/naqxFzoHd6me22EwHkc29V/W8h2
         fsR8zrpWcQq7+M26QIa6+WeNFhxT+k3C/qiKOrVsBiIJkqzzR/8EGlRT5kzHoTuVJ2z/
         YDoRgE1KZ9gOV6oYIV+WO+fkZPfkM5GUdQUovVGMAcWjqMINoMRnenv94AkpycqeXxjS
         SGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=56sVvVwErDrcTourArAhv/BVY3MHnHmWqLTosgbpmhc=;
        b=GFxa4Dxzzn7X2ile1mwVGjlxgAd2gYqS54qGTSXEwoDKxcZDGbNHgG0/sCc4KFIVTz
         6X8JWy9MnQCkm9PgTyXBV8PsXcIzVdNuR5sj9FnoE/JOha3lYln+KUIPhXBXMndOiOOx
         YnBlu6zhbTNyNmde4kyfQNeZw7UCXgVlch0Rk8c2FekZlKdvZMJUz9asAQGHjPJXdVE7
         EH3xhH/r2IAN3H9bhv4+gcbe9I2G+sNPIAKGwvr+uxEwISUQSuIKhh+qs9XQYbTW3qSO
         qT5RtRLk7COWSmODo9FWClq2stBdUabpKf3KZqfWUE1I22khE7HVQV3ixo1hyuUGcdv7
         1Fsw==
X-Gm-Message-State: ALQs6tDgy+BhCCQZyc2l+DT/Ki4aA0Hjc9I1H6BQ4OJY5FHICTpdefH/
        6HE59g1kyd06Ay0OkZMUn1ikf+oi
X-Google-Smtp-Source: AIpwx49pAd0m+i3YXz5uLEJ2M+OdJfjHHQzEVf4rLHjCp+9RKyyuIN7ClzKCJdDjyO+EcpEvhjJZew==
X-Received: by 2002:adf:e28c:: with SMTP id v12-v6mr2943057wri.188.1524104171268;
        Wed, 18 Apr 2018 19:16:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c4-v6sm2914470wrh.88.2018.04.18.19.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 19:16:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Apr 2018 11:16:10 +0900
In-Reply-To: <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 19 Apr 2018 10:55:48 +0900")
Message-ID: <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few commands that parse --expire=<time> command line option
behaves silly when given nonsense input.  For example

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

The latter is because it does not check the value returned from  the
underlying parse_expiry_date().  

This seems to be a recent regression introduced while we attempted
to avoid spewing the entire usage message when given a correct
option but with an invalid value at 3bb0923f ("parse-options: do not
show usage upon invalid option value", 2018-03-22).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I do not expect this to be the final version (not just it lacks
   tests, but I haven't even run existing tests with the change
   yet), but I think I diagnosed the root cause correctly, at least.

 parse-options-cb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index c6679cb2cd..872627eafe 100644
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
+		die("malformed expiration date '%s'", arg);
+	return 0;
 }
 
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
