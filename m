From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage 
 string.
Date: Fri, 18 Sep 2009 12:11:52 -0700
Message-ID: <7v1vm49ifb.fsf@alter.siamese.dyndns.org>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
 <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
 <a4c8a6d00909171506l6c4b6a49i22d7b337a0c6cfa2@mail.gmail.com>
 <7vd45pgjhr.fsf@alter.siamese.dyndns.org>
 <a4c8a6d00909180802r713d7644mcb4e98ae4352a03a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:12:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoisL-0004eQ-Vp
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364AbZIRTMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 15:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbZIRTL6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:11:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbZIRTL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 15:11:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B8C3D37C02;
	Fri, 18 Sep 2009 15:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Y4B4WqmX2Z5zC7lR7rtgOkvXJgQ=; b=e+4B7+ifYTCKdzYAMzBZDCP
	gYevhZRMykD2CtkfB4BvA1ESXCp0XLOWPtB9fTR7tscN3kMKtOQVjBdlNUbf3KnM
	JYsImBCcetUblgXvSmBzuigMLX1lkS8ctfnNeojUykbLgPsbXetzp0MgdLZbn8Yr
	yK9GI6FUvdd/jWE4JyjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=e+OHad1oSvlf7EUXAGuSs6yuL/otyEx9ZXFmaMMmuFYbKmFir
	XyY2QnBctrpxgI9LNgKmdJe5tUiMOzqLQeP9Mz9cRIA71mmKRGB+F57VQU3C/Giz
	hnbbctUDk0Fyz5a45Jtx0y0BDF+ERxLgT/VOZFuhmMKfsYMW7kAx/IpmXo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E05A37C00;
	Fri, 18 Sep 2009 15:11:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D963537BFF; Fri, 18 Sep
 2009 15:11:53 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 220886CA-A487-11DE-8348-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128806>

Thiago Farina <tfransosi@gmail.com> writes:

> This release candidate freeze is a period that no one can send patches?

No.

After -rc1, only fixes to regressions and severe bugs and trivially
correct documentation patches will be applied to my tree, but all other
kinds of patches are still sent to the list for discussion, so that the
proposed changes can be discussed, polished and then become ready for the
development cycle after the upcoming release.  I often even pick them up
and queue them to 'pu' and possibly 'next' as time permits.

> Only you
> merge the patches into the master branch? When someone send a patch,
> you get it, make a topic-branch in your private repository, and if it
> is good it will be merged into 'pu branch'?

"A note from the maintainer" I send out every once in a while (also can be
seen at http://members.cox.net/junkio/) explains how things work.

> And what did you mean with code churn?

A change primarily for the sake of change without urgency nor real benefit
in the longer term.

It bothers nobody if a long literal string is written as a string literal
in a dq pair with LFs quoted with backslashes, or as a run of multiple
string literals, each of which ending with LF, to be concatenated by the
compiler.  It however would bother somebody who actually wants to modify
these lines for a real change, and that is the best time for doing such a
clean-up.  Reasons for such a real change vary; to fix earlier mistakes
(e.g. one line being excessively longer than others, or an option is
misspelled), to add a new option, or to make the output of the program
easier to read in general, etc.

>> A real improvement patch from that somebody _could_ be to remove the
>> trailing whitespaces from the output string, and in that case I would not
>> mind if two patches (one preparatory patch which is this one, and the
>> other being the removal of trailing whitespaces) were squashed together.
>> In fact, in such a trivial case, it probably be better to squash them into
>> one.

> If I understand correctly, do you want a function...

No.

What I meant was that I might have said it is a real improvement if your
patch also removed the trailing whitespace from the literal string, as I
hinted in my original response.

Such a submission may have looked like this.  Notice that the changing of
the style for multi-line string literal is "while at it".  I called a
patch whose only change falls into that category a needless code churn.

-- >8 --
Subject: [PATCH] pack-objects: remove SP at the end of usage string
From: Thiago Farina <tfransosi@gmail.com>

These spaces immediately before the end of lines are unnecessary.

While at it, instead of using a single string literal with backslashes
at end of each line, split the lines into individual string literals
and tell the compiler to concatenate them.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-pack-objects.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 7a390e1..02f9246 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -22,15 +22,15 @@
 #include <pthread.h>
 #endif
 
-static const char pack_usage[] = "\
-git pack-objects [{ -q | --progress | --all-progress }] \n\
-	[--max-pack-size=N] [--local] [--incremental] \n\
-	[--window=N] [--window-memory=N] [--depth=N] \n\
-	[--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n\
-	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
-	[--stdout | base-name] [--include-tag] \n\
-	[--keep-unreachable | --unpack-unreachable] \n\
-	[<ref-list | <object-list]";
+static const char pack_usage[] =
+  "git pack-objects [{ -q | --progress | --all-progress }]\n"
+  "        [--max-pack-size=N] [--local] [--incremental]\n"
+  "        [--window=N] [--window-memory=N] [--depth=N]\n"
+  "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]\n"
+  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*]\n"
+  "        [--reflog] [--stdout | base-name] [--include-tag]\n"
+  "        [--keep-unreachable | --unpack-unreachable \n"
+  "        [<ref-list | <object-list]";
 
 struct object_entry {
 	struct pack_idx_entry idx;
