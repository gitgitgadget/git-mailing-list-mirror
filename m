Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0164FC56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 17:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCBC22240
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GU62VAb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgKTRwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 12:52:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65068 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgKTRwa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 12:52:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3203CA04C4;
        Fri, 20 Nov 2020 12:52:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:cc:date:message-id:mime-version:content-type; s=sasl;
         bh=mbLIfzAeQt+Jed1KqG69Xm42nAA=; b=GU62VAb9c30KOylvYz3cKVsQthJV
        GUT6g+r+wmn9lg4pocm/r4qniHZbpqHZZ3Z2yNraKCBtk2A67uggKCEQPd5S3Zrs
        kVOaMxVtBgg+1V/lexn+mlz+bop4lSZUwpeLdDpk1Ait3HApzNTVnv/8gZYSMYNn
        nBl3/OHVp+kv9Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
        pVipq0jczO2y90JbBFHHZdT9fqVGwxYk6u85LfObR5/1LdTetS3GVvvn/Fs5n0wI
        VyJCpUUytuGKAtVWlb6MY9lsH7zOMfglqt/R6Cd8f8fXNaEWmLv+dPS7BJ36OV5M
        mys5cNKOxqvZ+qdYUVIH1T/kyDg2QoFnCT6utBSVMOM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2910DA04C3;
        Fri, 20 Nov 2020 12:52:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A32DFA04C2;
        Fri, 20 Nov 2020 12:52:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] myFirstContribition: answering questions is not the end of
 the story
cc:     Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 20 Nov 2020 09:52:26 -0800
Message-ID: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2754365A-2B59-11EB-ABD8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A review exchange may begin with a reviewer asking "what did you
mean by this phrase in your log message (or here in the doc)?", the
author answering what was meant, and then the reviewer saying "ah,
that is what you meant---then the flow of the logic makes sense".

But that is not the happy end of the story.  New contributors often
forget that the material that has been reviewed in the above exchange
is still unclear in the same way to the next person who reads it,
until it gets updated.

While we are in the vicinity, rephrase the verb "request" used to
refer to comments by reviewers to "suggest"---this matches the
contrast between "original" and "suggested" that appears later in
the same paragraph, and more importantly makes it clearer that it is
not like authors are to please reviewers' wishes but rather
reviewers are merely helping authors to polish their commits.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Something along this line, in a more condensed form, may also
   want to be in SubmittingPatches, but let's start with a longer
   form that is easier to discuss the intent of the addition to see
   if it is a good idea.  I've seen a patch that got reviewed
   falling thru the cracks without producing a v2 too many times.

 Documentation/MyFirstContribution.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git c/Documentation/MyFirstContribution.txt w/Documentation/MyFirstContribution.txt
index 60eed5edcd..bac4997e39 100644
--- c/Documentation/MyFirstContribution.txt
+++ w/Documentation/MyFirstContribution.txt
@@ -1143,11 +1143,24 @@ After a few days, you will hopefully receive a reply to your patchset with some
 comments. Woohoo! Now you can get back to work.
 
 It's good manners to reply to each comment, notifying the reviewer that you have
-made the change requested, feel the original is better, or that the comment
+made the change suggested, feel the original is better, or that the comment
 inspired you to do something a new way which is superior to both the original
 and the suggested change. This way reviewers don't need to inspect your v2 to
 figure out whether you implemented their comment or not.
 
+Reviewers may ask you about what you wrote in the patchset, either in
+the proposed commit log message or in the changes themselves.  You
+should answer these questions in your response messages, but often the
+reason why reviewers asked these questions to understand what you meant
+to write is because your patchset needed clarification to be understood.
+Do not be satisfied by just answering their questions in your response
+and hear them say that they now understand what you wanted to say.
+Update your patches to clarify the points reviewers had trouble with,
+and prepare your v2; the words you used to explain your v1 to answer
+reviewers' questions may be useful thing to use.  Your goal is to make
+your v2 clear enough so that it becomes unnecessary for you to give the
+same explanation to the next person who reads it.
+
 If you are going to push back on a comment, be polite and explain why you feel
 your original is better; be prepared that the reviewer may still disagree with
 you, and the rest of the community may weigh in on one side or the other. As
