Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726A81F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 17:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdFLR7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 13:59:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32773 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdFLR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 13:59:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so7178164pfk.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=88DA9GRM2/aA8e5MWuDQcwBjKcjLivhfenrLcQGREvU=;
        b=o4KCiACwlKJQ7M1NHdP4lqE9yGC9IAXqVwCvpNW1A6abEDqKW7sS0VFeJ9iqtQA/Nb
         XYTa0ibfuRm4tcNKsMOZ8D6LC87nYnqhrMJ5dVwKqypLGdcnJtkPEA5xrHjbIMmKiPSf
         Z89HXXCqRW+2CJQwZvp8+8DB1LAcsz5WUHXliE0jq9R33QIF5OSpdFzumF1Pjvhdsq7a
         v6YMjyDwa5skMnrdAscPEU0t6EtnlPzJcsUQ7e7POnqphEjF738lVkKQr0O46OvXh2dD
         A4SMQS1+Ky/U7wmBtKgF8+8grCL+hHwsQTj+6b+/3v3tSl1iBtLfmeKBX+MkVpw+ZTw+
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=88DA9GRM2/aA8e5MWuDQcwBjKcjLivhfenrLcQGREvU=;
        b=IDErUIa/S6mBTapdWumkLrIHVF1bLrVT4k/ZTnyISk8mkHi6uHvcYoTnS8NY11cHqh
         8vHvNkZrZxntzirMWkcZlMbdzfauzkB4lqZRtVTWta3zwE0k3mxBDqpi0DwqJGk1uagI
         auu5NXQ01CGntpgPJUIbKeSGq/5ABx6HmyYdzwpD/f0Lg31/06UTK1ZDerv5yDkldbjl
         smiZ+Wdri5GJUMFycvTRX1JWoI9Ns9fql+nRepJ/urYSKAleIr45ga0flj7HFK4KPyPh
         xrdnUd2derfQOxsB0PhIryo6vQIpRwBdOqZ8bUZIJa7/YF3WJcHG9h2ABZW+V6UYkfjG
         wAdA==
X-Gm-Message-State: AODbwcCInrvlSVOwo4IRq15Y7+UuoZS1W11zsCILWAFIMQKqw0Q+GVsu
        kdb4vDaWh3nM1w==
X-Received: by 10.84.141.129 with SMTP id 1mr58396314plv.75.1497290348965;
        Mon, 12 Jun 2017 10:59:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id p73sm4269516pfd.79.2017.06.12.10.59.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 10:59:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Small issue with "add untracked" option of 'git add -i'
References: <1497278015.7302.13.camel@gmail.com>
        <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 12 Jun 2017 10:59:07 -0700
In-Reply-To: <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 12 Jun 2017 10:38:36 -0700")
Message-ID: <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> After prompting to get the list of desired files, if the user chose
> nothing, the message is shown.  "No untracked files chosen." is
> probably what the code wants to say, I would think.


Together with your other wishes, perhaps something like this is what
you have in mind.  The original tried to throw in a blank line as a
separator to help interactive users to more easily tell the boundary
of blocks of text, but it wasn't consistently doing so (e.g. "update"
when nothing is dirty was very silent, while "status" gave one blank
line that is supposed to be shown after the list of changed ones even
when the list is empty).

 git-add--interactive.perl | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6ce6..0ec09361b4 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -537,7 +537,7 @@ sub list_and_choose {
 				$last_lf = 1;
 			}
 		}
-		if (!$last_lf) {
+		if (@stuff && !$last_lf) {
 			print "\n";
 		}
 
@@ -634,7 +634,6 @@ sub prompt_help_cmd {
 sub status_cmd {
 	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
 			list_modified());
-	print "\n";
 }
 
 sub say_n_paths {
@@ -667,7 +666,6 @@ sub update_cmd {
 		       map { $_->{VALUE} } @update);
 		say_n_paths('updated', @update);
 	}
-	print "\n";
 }
 
 sub revert_cmd {
@@ -701,7 +699,6 @@ sub revert_cmd {
 		refresh();
 		say_n_paths('reverted', @update);
 	}
-	print "\n";
 }
 
 sub add_untracked_cmd {
@@ -711,9 +708,8 @@ sub add_untracked_cmd {
 		system(qw(git update-index --add --), @add);
 		say_n_paths('added', @add);
 	} else {
-		print __("No untracked files.\n");
+		print __("No untracked file chosen.\n");
 	}
-	print "\n";
 }
 
 sub run_git_apply {
