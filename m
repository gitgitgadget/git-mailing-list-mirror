Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64901F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 21:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeJFEy5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:54:57 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:52564 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:54:56 -0400
Received: by mail-it1-f202.google.com with SMTP id n132-v6so3795452itn.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xf+QVDJQsMaB0ZnL+SRM93xLIaujkDIpSihhBBKdook=;
        b=UrwPWIghePAkmdCy8M9f3V9fIZhoiFXnHGWcK61/piQg8bSK5aJvEbotq6oYWTJbZF
         xx/yylndh15zt82jAJ5DuMXtOR3cin7fk/8hZ/kI2Zkgnl2euUgGnj8rfS1KKt2SrO3m
         KYuG2YgDSZ16hHSc/7vl/5fvv7BqMaJegNNhTdCY5KoXXE1WLZIvtoVlYPBDd4Wq16B6
         WZ4bWzvtEJwgSJYeMd+7oBQY0QtydioX+vedDIfI+89De2SUbuP2bhknYWjzoC4wQu+h
         leVNMokdtYZOGM08MTZLdofnq3WqxlpC09NfHUIjXI1ZDTaryGXojrE2k5EnHavvdoGT
         Db1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xf+QVDJQsMaB0ZnL+SRM93xLIaujkDIpSihhBBKdook=;
        b=dRDAV70uIYrpKKrhe6bO7KSq+6Z6zEukpaYaVi1drxTjvk0eMzY0gMl1q1lEaEYZnW
         3+N5fH/MLLwfjk2I++6JKXKnWcu6TqalVC9u8Tj2RqPxLZ+Uyr1+aq+Y3BP3uN3xBIBN
         kXR5+MyHGiHXJV/eHayljZ+FESt7+PF8yo3Dw+5kBxbliKYvlPa6Gciy5KVtMzA54V68
         L2K+jEeLrSjnQ0hZZhVJ+cGFsD63ZO0mKATu6rUtFb3Vd0oTnY0kKtrmFHfj3/pVagMk
         h3/MRgZxsBLpkmaCJmY3qQRxIYebGFTpl6we5ycJ8G5AuXoANS4WUEo6UF0YSgKvK9A+
         cjqQ==
X-Gm-Message-State: ABuFfoi1fJ9FhPm+CtgJW/0PfnOt6W1Au3eW+qUbQrfMW5iH1FqzY9F1
        AkSYXKWb7jv8fUvVdo0gDWZ6ROdIcEJYQgVlfyZTZ0Hg9COYmviRHmo5mchDqQy1epif2tpCBZD
        96Js5XPPrTDsMZCOjly/TTZzeaECfrxpJVSPpQagCdTeqy3sVZfxsY87pRos=
X-Google-Smtp-Source: ACcGV639/NhpTgwU0WRD2/uQ8+YnsnitZlUkxLzX0D7vTQZj2ObivxqLwiLRcfAXnIExCuyEzqKpH1RH4tY4
X-Received: by 2002:a24:10cd:: with SMTP id 196-v6mr9356007ity.21.1538776457564;
 Fri, 05 Oct 2018 14:54:17 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:54:02 -0700
In-Reply-To: <cover.1538775186.git.matvore@google.com>
Message-Id: <038311316a85dd1ca3bbe068e94ae6e305fdb740.1538775186.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <cover.1538775186.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v5 2/7] Documentation: add shell guidelines
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, peff@peff.net,
        jonathantanmy@google.com, gitster@pobox.com, jrn@google.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the following guideline to Documentation/CodingGuidelines:

	Break overlong lines after "&&", "||", and "|", not before
	them; that way the command can continue to subsequent lines
	without backslash at the end.

And the following to t/README (since it is specific to writing tests):

	Pipes and $(git ...) should be avoided when they swallow exit
	codes of Git processes

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/CodingGuidelines | 18 ++++++++++++++++++
 t/README                       | 27 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 48aa4edfb..72967deb7 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -118,6 +118,24 @@ For shell scripts specifically (not exhaustive):
 		do this
 	fi
 
+ - If a command sequence joined with && or || or | spans multiple
+   lines, put each command on a separate line and put && and || and |
+   operators at the end of each line, rather than the start. This
+   means you don't need to use \ to join lines, since the above
+   operators imply the sequence isn't finished.
+
+	(incorrect)
+	grep blob verify_pack_result \
+	| awk -f print_1.awk \
+	| sort >actual &&
+	...
+
+	(correct)
+	grep blob verify_pack_result |
+	awk -f print_1.awk |
+	sort >actual &&
+	...
+
  - We prefer "test" over "[ ... ]".
 
  - We do not write the noiseword "function" in front of shell
diff --git a/t/README b/t/README
index 68012d673..ab9fa4230 100644
--- a/t/README
+++ b/t/README
@@ -466,6 +466,33 @@ And here are the "don'ts:"
    platform commands; just use '! cmd'.  We are not in the business
    of verifying that the world given to us sanely works.
 
+ - Don't feed the output of a git command to a pipe, as in:
+
+     git -C repo ls-files |
+     xargs -n 1 basename |
+     grep foo
+
+   which will discard git's exit code and may mask a crash. In the
+   above example, all exit codes are ignored except grep's.
+
+   Instead, write the output of that command to a temporary
+   file with ">" or assign it to a variable with "x=$(git ...)" rather
+   than pipe it.
+
+ - Don't use command substitution in a way that discards git's exit
+   code. When assigning to a variable, the exit code is not discarded,
+   e.g.:
+
+     x=$(git cat-file -p $sha) &&
+     ...
+
+   is OK because a crash in "git cat-file" will cause the "&&" chain
+   to fail, but:
+
+     test "refs/heads/foo" = "$(git symbolic-ref HEAD)"
+
+   is not OK and a crash in git could go undetected.
+
  - Don't use perl without spelling it as "$PERL_PATH". This is to help
    our friends on Windows where the platform Perl often adds CR before
    the end of line, and they bundle Git with a version of Perl that
-- 
2.19.0.605.g01d371f741-goog

