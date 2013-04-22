From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 19:40:49 -0700
Message-ID: <7vmwsrqocu.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 04:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU6gb-0002nh-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 04:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab3DVCkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 22:40:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab3DVCkw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 22:40:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B2ED10B97;
	Mon, 22 Apr 2013 02:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HiIZ6ED/XI3EGcue7hwHdwYTFPI=; b=sAtbTH
	CnHkBSkDXKVdUizVIFueN+D5rZT6iu/Hs0R1V15xy83WK4Cq4/ctGi8CrdMQ8VX6
	FLkIrQjcrI4E5ll+2kqy6TaGeRWSEktCcKhdaDZGU5l07ENmGtp7mAEZLn0o+f00
	G5lwuj1sEQQHoS4FOAua1bHMnP0x2OGK5bFEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N3atYIb4pqYHCthLm7WMPHoxQfYNdra6
	aFePL+9mks2bP+DzcejNBTBD9UiqBQSCq/KoItpFEQ0lcOfMSTeGELMLSEZHN6Qj
	eYuhv9FibR/wtCFPQVTdWWJzIHZqvA4YkAE9blmlAYO3fJK0fbAVOQgACnrvVCso
	pxfLaENTI64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E0D910B96;
	Mon, 22 Apr 2013 02:40:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2BF410B95;
	Mon, 22 Apr 2013 02:40:50 +0000 (UTC)
In-Reply-To: <7vtxn0wf4j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 20 Apr 2013 23:51:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BA75720-AAF6-11E2-8026-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221986>

Junio C Hamano <gitster@pobox.com> writes:

> Two other things I noticed with the current text are:
> ...
>  * The part with the new "-L" option seems to be throwing the
>    overall formatting off.  Its second paragraph "<start> and <end>
>    can take..." is not indented to the same level as its first
>    paragraph "Trace the evolution of...", and the following items,
>    like "--full-line-diff" and "[--] <pathspec>..." are indented one
>    level too deeply.

This is a minimalistic patch to fix the formatting.  I removed the
extra sentence after the enumeration and moved it to the end of the
main text, but somebody may have a better idea to persuade AsciiDoc
to format it in a more reasonable way while keeping the sentence
there.

-- >8 --
Subject: line-log: fix documentation formatting

The second paragraph of the added description for the -L option
"<start> and <end> can take one of these forms:", and the list of
forms that follow the headline, were indented one level too short,
due to the missing "+" to signal that the next paragraph continues
the previous one.

Also "You can specify this option more than once" is about the -L
option, not about its various forms of starting and ending points.
Move it to the end of the main text.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-log.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 4850226..0959f9d 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -76,12 +76,11 @@ produced by --stat etc.
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
-
+	You can specify this option more than once.
++
 <start> and <end> can take one of these forms:
 
 include::line-range-format.txt[]
-You can specify this option more than once.
-
 
 --full-line-diff::
 	Always print the interesting range even if the current commit
