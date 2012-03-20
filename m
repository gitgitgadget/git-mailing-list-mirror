From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Tue, 20 Mar 2012 16:07:29 -0700
Message-ID: <7vobrq50su.fsf@alter.siamese.dyndns.org>
References: <4F63205A.6000202@seap.minhap.es>
 <vpqlin0n8w5.fsf@bauges.imag.fr> <7vty1oivub.fsf@alter.siamese.dyndns.org>
 <4F63571D.4070405@seap.minhap.es> <vpqaa3geiso.fsf@bauges.imag.fr>
 <7vpqccipuv.fsf@alter.siamese.dyndns.org>
 <7vlin0ip9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 00:07:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA89S-0001aA-9u
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759407Ab2CTXHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:07:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab2CTXHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 19:07:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEAD9776F;
	Tue, 20 Mar 2012 19:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5ikkzSo4rt69Yyqvx7NXYiAff9c=; b=Sx/wPEJWAVXKYUncBirq
	Dh03UxRC0fv6H350Awl7UcN0ntv6ZDJ2hJyEqzd2884tY2lD9HjoryTYciBiXgLT
	sihXJn1VKS66S/Pf5GeaJj8NdIZs4XBUBE5OsBTpTOPexhS8e4NUqgyb6vmdeyOG
	ITDkzOuBAfUGD3yct5snL8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Hv5dYNhgjAvzLI7QLh9ohx3QUtZBEBWhQR9VBuWoDvDP3n
	RLNOJClzYHOWgur9HJuqBoLa6/FGInD6C6koBKjydfcIY93nCriGrWdUX8geF1PF
	gnn4lth17jWwnMF7PmChk9yXaTSXO6VPcKS+95w/HDKsCrWGwgHD0uDcOXQfw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4FAC776E;
	Tue, 20 Mar 2012 19:07:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54BDB776D; Tue, 20 Mar 2012
 19:07:31 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 788D9D98-72E1-11E1-8A9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193548>

Junio C Hamano <gitster@pobox.com> writes:

> Having said that, I do not personally care about this too deeply.  Let's
> queue a reworded Nelson's patch so it is not lost while waiting for others
> to chime in.
>
> How about this?  I avoided phrases "applying commit" (incorrect: you apply
> patches, and you replay or cherry-pick commits) and "history" (to people
> who know, it is redundant; to people who don't, it is vague mystery), but
> added one more useful reminder (top to bottom).

I didn't hear anything from anybody on this one, so I take it that nobody
deeply cares either way.

I'll queue this to 'next' so that we can start the post-1.7.10 cycle with
this patch.

-- >8 --
Subject: [PATCH] rebase -i: remind that the lines are top-to-bottom

Nelson Benitez Leon opened a discussion with a patch with this in the
note:

    Hi, I was using git rebase -i for some time now and never occured to
    me I could reorder the commit lines to affect the order the commits
    are applied, learnt that recently from a git tutorial.

Nelson's patch was to stress the fact that the lines in the insn sheet can
be re-ordered in a much more verbose way.  Let's add a one-liner reminder
and also remind that the lines in the insn sheet is read from top to
bottom, unlike the "git log" output.

Discussion-triggered-by: Nelson Benitez Leon
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..2b7eb6d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -846,6 +846,8 @@ cat >> "$todo" << EOF
 #  f, fixup = like "squash", but discard this commit's log message
 #  x, exec = run command (the rest of the line) using shell
 #
+# These lines can be re-ordered; they are executed from top to bottom.
+#
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
-- 
1.7.10.rc1.63.g3c4e6
