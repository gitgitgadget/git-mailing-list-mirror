From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Mon, 10 Sep 2012 10:09:43 -0700
Message-ID: <7vpq5told4.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
 <7vd322ebsz.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
 <7vpq61dfn9.fsf@alter.siamese.dyndns.org>
 <7v8vcpdat2.fsf@alter.siamese.dyndns.org>
 <7vk3w5woc4.fsf@alter.siamese.dyndns.org>
 <20120910161904.GC9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:09:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7Uh-0006i9-CA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab2IJRJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:09:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab2IJRJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:09:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBB9A8F28;
	Mon, 10 Sep 2012 13:09:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CCGirJ1YZ4E/28+LTr2Je/ck1x8=; b=JCuFUy
	fMC7U0iNX/oHZ/6u/l5QX60wm4ul6wZIPiWmeZL2TOKEJuvu4jpCRcb4p6pyBxap
	tddDJ5isorPqTNbUF87SHmKfXmovJDAZK3u+PoMYqcoOSJVALdsQIO0ZDxnLVawg
	m/9TsYzPL1DJ4r+1Wy2PKO5zaUQc0pCoduUr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KCmmB9JqzBlIsPubtxrlFY2DbHMBK39N
	8e1pCKLWZZUuPEy7DbLAq0NjF2bmkQpm/EsbjmIZ9rNC/ZHYSFuN0N8p0rFY/3iG
	1rEtF0f+nWDA8CvsBnHe+lZEotcScXvDj8m+D0swDexcocacHAbdl782Il0Hvkn0
	WvZJZfxal6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7FD78F27;
	Mon, 10 Sep 2012 13:09:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 155958F26; Mon, 10 Sep 2012
 13:09:44 -0400 (EDT)
In-Reply-To: <20120910161904.GC9435@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 10 Sep 2012 12:19:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 518A675A-FB6A-11E1-A6EC-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205149>

Jeff King <peff@peff.net> writes:

>>  When writing a script that is expected to handle random user-input, it is
>>  a good practice to make it explicit which arguments are which by placing
>>  disambiguating `--` at appropriate places.
>
> Look at the paragraph below your addition. It is typographically outside
> of the bulleted list you are adding to, but it really makes sense
> directly after the prior two bullet points, which are explicitly about
> disambiguation between revisions and paths. Your addition splits them
> apart.

Yes, I noticed it and thought about different possibilities,
including making the description of glob the first bullet point.

> Does it make sense to join that final paragraph into what is now the
> third bullet, and then add your new text (the fourth bullet) after?

I am not sure.  After re-reading it, I do not think the fileglob
discussion belongs to the existing "Here are the rules" list in the
first place.  It should probably be the extended description for the
first point (revisions then paths) to explain what kind of "paths"
we accept there.

I generally consider follow-up paragraphs after bulleted list to be
enhancements on any of the points in the list, not necessarily
applying to all of them.  The existing structure is:

    * point A (revisions and paths)
    * point B (-- can be used to disambiguate)
    * point C (ambiguation leads to an error)

    Note that point B and point C taken together imply corollary BC.

So something like this would be the right thing to do:

    * point A
    * point B
    * point C

    Note that point B and point C taken together imply corollary BC.
    Also note that point A implies corollary AA.

or even

    * point A
    * point B
    * point C

    Note that point A implies corollary AA.  Also note that point B
    and point C taken together imply corollary BC.


So perhaps something like this squashed in on top of the patch in
question?

 Documentation/gitcli.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
index c70cd81..4413489 100644
--- c/Documentation/gitcli.txt
+++ w/Documentation/gitcli.txt
@@ -38,9 +38,9 @@ arguments.  Here are the rules:
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
 
- * Many commands allow wildcards in paths, but you need to protect
-   them from getting globbed by the shell.  These two mean different
-   things:
+Many commands allow wildcards in paths (see pathspec in
+linkgit:gitglossary[7]), but you need to protect them
+from getting globbed by the shell.  These two mean different things:
 +
 --------------------------------
 $ git checkout -- *.c
