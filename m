From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #05; Thu, 15)
Date: Fri, 16 Dec 2011 16:39:04 -0800
Message-ID: <7vfwgkf2vr.fsf@alter.siamese.dyndns.org>
References: <7vd3bpl6i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 01:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiJ0-0001bq-BW
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 01:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672Ab1LQAjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 19:39:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab1LQAjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 19:39:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA8926C6F;
	Fri, 16 Dec 2011 19:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JrrKiKOarcuJFSc2iFiEprF1N4g=; b=SvYlgJ
	DtzngosfBdsxXCmyWDn6NhXrEY3DHkCHOaCHLQRnznoF7rYbO3A51fbNbGltP4ar
	XrsdTbQ7PVQ1gHQdokTULzqd2uLgrEaUN1jmZ6Jmv+F4mAbvJkfeV06iaQtO377Z
	h2h4q4OL0m78/MUiDMGVWCgG2gUEgWy/iDwag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RImHR5X0+lB+Ieek26e2KbOy1xKwR4ad
	04AFwciU5nrCr6rRZO5Wa1eOS/kZezCtWy39D1OZqdasQptStPOqXYJRti3wi/gO
	t24nJLBjdcmkICxWMcjQSK6DTLFSi9MMRkByuMz7cU/6cHp5BpyD31D9YpmtFqUF
	ziIi1vRPoWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C29EC6C6E;
	Fri, 16 Dec 2011 19:39:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B2B56C6D; Fri, 16 Dec 2011
 19:39:06 -0500 (EST)
In-Reply-To: <7vd3bpl6i8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Dec 2011 16:11:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 867BB492-2847-11E1-BDA0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187338>

I don't want to do issue #06 yet, so only differences from #05 are listed
here for today's updates.  Extra sets of eyeballs on commits in 'pu' are
very much appreciated.

* tr/grep-threading (2011-12-16) 3 commits
 - grep: disable threading in non-worktree case
 - grep: enable threading with -p and -W using lazy attribute lookup
 - grep: load funcname patterns for -W

The second one was updated to include thread-utils.h in grep.h

* cn/maint-lf-to-crlf-filter (2011-12-16) 1 commit
 - lf_to_crlf_filter(): tell the caller we added "\n" when draining
 (this branch is used by jc/maint-lf-to-crlf-keep-crlf.)

Fixes up an earlier fix already in 'master'.

* jc/maint-lf-to-crlf-keep-crlf (2011-12-16) 1 commit
 - lf_to_crlf_filter(): resurrect CRLF->CRLF hack
 (this branch uses cn/maint-lf-to-crlf-filter.)

Builds on top of it.

* jc/request-pull-show-head-4 (2011-12-16) 1 commit
  (merged to 'next' on 2011-12-16 at bea51ac)
 + request-pull: update the "pull" command generation logic

Fixes up an earlier update already in 'master'.

* jk/doc-fsck (2011-12-16) 1 commit
 - docs: brush up obsolete bits of git-fsck manpage

* jk/follow-rename-score (2011-12-16) 1 commit
 - use custom rename score during --follow

* jk/pretty-reglog-ent (2011-12-16) 1 commit
 - pretty: give placeholders to reflog identity

Three fairly straightforward patches from Peff; will merge to 'next'
soonish.
