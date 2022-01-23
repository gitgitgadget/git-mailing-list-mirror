Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E12EC433EF
	for <git@archiver.kernel.org>; Sun, 23 Jan 2022 20:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiAWUhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jan 2022 15:37:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54785 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiAWUhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jan 2022 15:37:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F17CB112D71;
        Sun, 23 Jan 2022 15:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        c3P7SmTG61hloePSVWZGQjQ/01omEbjRIkUdTSBUK0=; b=qh4GS87uK/W+po3KS
        dl1kDva6RHfQ89bJh0xQjBwa9AVQbj3psAZuGrAF4plOqi/EcYOZI8Z/PXCfxPsS
        4WgNxoKlwP7PWtN1VjP1/SEUG/x98eZtgq1B917sqmPrkeN7lkofapL/A8pAIpcS
        hyX3yfiWTLtukX1ah3NnZ3sVQ0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8F16112D70;
        Sun, 23 Jan 2022 15:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59190112D6F;
        Sun, 23 Jan 2022 15:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] Contributor doc: more on the proposed log message
Date:   Sun, 23 Jan 2022 12:37:18 -0800
Message-ID: <xmqqilua89z5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42742492-7C8C-11EC-9F50-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been thinking about making it more clear why we care about
the log message, and noticed that we have CodingGuidelines and
SubmittingPatches, both are specifically targetted for the
contributors of THIS project (not to users contributing to a project
that happens to use Git).

I think the first thing to fix is that we have the "describe your
changes well" section in the latter, as if it is not part of the
code that is covered by CodingGuidelines.  You formulate the thought
on how to explain/sell your changes to others, and you sift the text
you add to help fellow developers into the ones you leave in in-code
comments and in the proposed log message, while you code.  I am
tempted to propose moving the part about proposed log message from
SubmittingPatches to CodingGuidelines for this reason.

Independent of the above, here is a small update I would add to
clarify the project convention on the log message.

Thoughts?

---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 92b80d94d4..11d0c85988 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -142,6 +142,13 @@ The body should provide a meaningful commit message, which:
 
 . alternate solutions considered but discarded, if any.
 
+[[present-tense]]
+The problem statement that describes the status quo is written in the
+present tense.  Write "The code does X when it is given input Y",
+instead of "The code used to do Y when given input X".  You do not
+have to say "Currently"---the status quo in the problem statement is
+about the code _without_ your change, by project convention.
+
 [[imperative-mood]]
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
