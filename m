Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 229811F597
	for <e@80x24.org>; Tue, 24 Jul 2018 01:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbeGXCbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 22:31:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50365 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbeGXCbI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 22:31:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so843731wmc.0
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 18:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RzT1JWBiciuBMGhyu01GLgPAFsg75eKlC6s6MT09RAY=;
        b=TLUyADeLbCwWnuOeu//41NMHMhUvolEuJoOYl2iNyAei4PIuYDz+enZuWJq7mfhNeX
         yFKHAce5+7zqod/tqPt0mQhaFF7dAMzXbhSDpjej7nAx2hR7QDtYb+aFf05uZJKt8pOT
         PJH5LJQJvleY2cFF+96cfeqmKOAWSOtWOoJBAIZ2WbS6ZQWQC/wEJIt+Oc+0oaOssmgL
         Psi/oHPpV0eX1GXIKyGCNOXTV0C4EA7tJrImE8f06+qxrNCgYRrCnz5na4riF9lWMvhP
         HaZb+GhoMOMkJBJUWsw1Lg8MwetIXbWYtOhpUt66AIk7ZJigwge/gyEaW1lzEinhSHfT
         APEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RzT1JWBiciuBMGhyu01GLgPAFsg75eKlC6s6MT09RAY=;
        b=flZ/BpeMwY9erXY4dHnAXU+trNnnbkQz9T4Y80cBh1f2f3UHEBu6/cb3NUTZBeBgB/
         mYKQorxqacFYojCc5J/V1U4admRrEEtcS6s0h5KefZsansQaT8vp9JvRvofYoXDD7qo1
         3TpA64npyIywMF6XXxJ5FJF32wtWohIaC6W6SCb1bhJFWu/gF0MbY8m2ALWm+LfjIw6M
         Rl75CPGbqE1VgjF2KOvWXWxpeYHg5CKJst/2ORl6W9WhIozsQGLs9gwQ1wbMHnt1JHt3
         DGv5US/V3utGCVly8LEMIfWAx7Rzcub7BXaKQrEMSRYivgR4T0LmF/7EZBz7nObmVQqR
         0LkQ==
X-Gm-Message-State: AOUpUlEV3wd1p8ZBqWNkpHOrtYzD0VViC6ZfvD68zC/wiVfpv2oBsV/U
        EXo1R4CtPVidsVzBFQA5v0g=
X-Google-Smtp-Source: AAOMgpdPMmPkWnUEe4FZlrQFS7MQO0xN47+H6sBlYPnW0QqCYW4GsX9ZTdZbmYsQ+w9FmQrulGgzhQ==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr606996wmh.48.1532395632202;
        Mon, 23 Jul 2018 18:27:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w4-v6sm8074396wrt.40.2018.07.23.18.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 18:27:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 16/21] range-diff --dual-color: fix bogus white-space warning
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com>
        <xmqqtvop37c1.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 23 Jul 2018 18:27:10 -0700
In-Reply-To: <xmqqtvop37c1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 23 Jul 2018 15:39:26 -0700")
Message-ID: <xmqq7ell2zkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is pleasing to see that with a surprisingly clean and small
> change like this we can exempt the initial space byte from
> SP-before-HT check and from Indent-with-non-tab at the same time.
>
> Very nice.
>
> One reason why a surprisingly small special case is required is
> perhaps because we are blessed with the original code being clean
> [*1*], and the fact that a line[0] that is not ' ' will not trigger
> any indentation related whitespace errors without this special case,
> I guess.

Having said good things about the patch, I unfortunately realized
that we weren't that lucky.  As we do want to see whitespace errors
on lines with line[0] != ' ' to be flagged.  So "... will not
trigger" in the above is not a blessing, but something that further
needs to be fixed.  The special case should also be made for line[0]
that is '+' and possibly '-' (and I also suspect that the changes in
this patch may mostly be reusable with little tweaks if any).

Imagine we start from this commit that "git show" shows us like so:

	 int main(int ac, char **av)
	 {
	 ________  printf("Hello");
	+________  putchar(',');
	+          putchar(' ');
	           printf("World\n");
	           return 0;
	 }

I've drawn a horizontal-tab as long underscore to clarify in the
above picture.  If you have "core.whitespace=indent-with-non-tab"
"git show" would paint the line that adds " " as violating (as it
types 10 SPs, when it could have been a tab and 2 SPs), but it does
not highlight the line with "World" or "return", which is sensible
as they are pre-existing violations.

Then imagine we did "git commit --amend" and "git show" would give
this instead:

	 int main(int ac, char **av)
	 {
	 ________  printf("Hello");
	+          putchar(',');
	+________  putchar(' ');
	           printf("World\n");
	           return 0;
	 }

That is, relative to the previous attempt, we stopped introducing
new indent-with-non-tab violation to the line that adds " ", but
added a new violation to the line that adds ",".

After such "git commit --amend", what do we want to see in the
output from "git range-diff @{1}..."?

My quick test of the current code does not show any whitespace
breakage for either versions.  I *think* what we want to actually
see is

 - just like WS_IGNORE_FIRST_SPACE logic shifted the column by
   incrementing written (and final condition) for the loop in your
   patch for line[0]==' ', detect the overlong run of SP correctly
   by ignoring the first column that is '+', and complaining that
   the new commit is typing 10 SPs before putchar(',').

 - Earlier I thought that lines with '-' in the outer diff should
   become exempt from whitespace-error highlighting, but I think
   that is a mistake.  If a line in diff-of-diff that begins with
   "-+" has whitespace violation (e.g "-+" followed by 10 SPs), that
   is "the old version of the patch used to introduce whitespace
   violation", which is a useful piece of information when we look
   at the corresponding line in the same diff-of-diff that begins
   with "++".  We could either say "and you cleaned that mistake up
   in your newer patch", or "and you still have that mistake in your
   newer patch" (another possibility is there is no whitespace error
   on a "-+" line, and the corresponding "++" line has one---"you
   got it right in the previous round, but you somehow made it
   worse").

Here is the reproduction of the sample data I based on the above
thought experiment on.

diff --git a/script.sh b/script.sh
new file mode 100755
index 0000000..0090661
--- /dev/null
+++ b/script.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+git init
+git config core.whitespace indent-with-non-tab
+
+tr _ '\011' <<\EOF >hello.c
+int main(int ac, char **av)
+{
+_  printf("Hello");
+          printf("World\n");
+          return 0;
+}
+EOF
+
+git add hello.c && git commit -m initial
+
+tr _ '\011' <<\EOF >hello.c
+int main(int ac, char **av)
+{
+_  printf("Hello");
+          putchar(',');
+_  putchar(' ');
+          printf("World\n");
+          return 0;
+}
+EOF
+
+git commit -a -m second
+
+tr _ '\011' <<\EOF >hello.c
+int main(int ac, char **av)
+{
+_  printf("Hello");
+_  putchar(',');
+          putchar(' ');
+          printf("World\n");
+          return 0;
+}
+EOF
+
+git commit -a --amend -m third
+
+
+git show @{1}
+git show HEAD
+
+git range-diff ..@{1} @{1}..
+
-- 
2.18.0-232-gb7bd9486b0



