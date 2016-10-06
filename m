Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC92D207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 12:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbcJFMjZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 08:39:25 -0400
Received: from mail.javad.com ([54.86.164.124]:43070 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752180AbcJFMjY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 08:39:24 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 8068F613EF;
        Thu,  6 Oct 2016 12:39:22 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bs7xJ-0003Qa-26; Thu, 06 Oct 2016 15:39:21 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] Documentation/git-merge.txt: get rid of irrelevant references to git-pull
References: <cover.1475678515.git.sorganov@gmail.com>
        <b91ef5e97c60a85cce1a13f88a19218fd0f05655.1475678515.git.sorganov@gmail.com>
        <xmqqzimioc7s.fsf@gitster.mtv.corp.google.com>
        <87shsapjiz.fsf@javad.com>
        <xmqq60p6o4js.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 06 Oct 2016 15:39:21 +0300
In-Reply-To: <xmqq60p6o4js.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Oct 2016 14:43:19 -0700")
Message-ID: <87h98pps7a.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> So I believe this change is inline with the rest of the patch. The
>> reference to git-pull (if it remains) should be a side-note, not part of
>> explanation of operation.
>
> Not really.  The thing is, "This is the most common" needs to be
> close to "Often...".  "git merge" directly invoked by the end user
> is much less likely to encounter a fast forward situation; getting
> invoked indirectly by "git pull" makes it common.

Ah, I now see. I tried to keep the text intact as much as possible, and
only split it into description and a note. Well, how about this then:

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index b758d55..479400f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -135,15 +135,17 @@ will exit early with the message "Already up-to-date."
 FAST-FORWARD MERGE
 ------------------
 
-Often the current branch head is an ancestor of the named commit.
-This is the most common case especially when invoked from 'git
-pull': you are tracking an upstream repository, you have committed
-no local changes, and now you want to update to a newer upstream
-revision.  In this case, a new commit is not needed to store the
+When current branch head is an ancestor of the named commit,
+a new commit is not needed to store the
 combined history; instead, the `HEAD` (along with the index) is
 updated to point at the named commit, without creating an extra
 merge commit.
 
+This is very common case when 'git merge' is invoked from 'git
+pull': you are tracking an upstream repository, you have committed
+no local changes, and now you want to update to a newer upstream
+revision.  
+
 This behavior can be suppressed with the `--no-ff` option.
 
 TRUE MERGE

-- Sergey

