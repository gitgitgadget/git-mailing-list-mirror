From: Junio C Hamano <gitster@pobox.com>
Subject: An incremental update to "What's cooking"
Date: Mon, 13 Feb 2012 23:22:23 -0800
Message-ID: <7vk43p98wg.fsf@alter.siamese.dyndns.org>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 08:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxCie-0006FH-1n
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 08:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab2BNHW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 02:22:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab2BNHWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 02:22:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C20C30F7;
	Tue, 14 Feb 2012 02:22:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KQzYRV8/ZknLkYm+P0e2mm2J2gA=; b=cu8xQl
	7R4AvbN0Tq7OItLM/ezXlRxABUqjhIR9NhaPffJt4JeSsFFsswNIdRwpi4z1fCc2
	PgcJIhOaIjObSjKeSPgEk4xfYwl/tchYdsA0e/DYxUdrsHIKI7PO5p0gR3YrMJs7
	qE4eyShyVVb4ulTjxYiObPMKILthBJaAJmpoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ka6OHFcDua1sJrwNNRs/tpZh1VIDSyVz
	0jXWu0DPWL+nxAYivWjMESfQ9nqBDO/amFhxUO6RfsfA0Gm4umhlm4QeERBWLzw0
	m7+UlnlrBWo6Fsk7TOmbvahH7VIUaMwoIHUucUh6NS66AybmXWoc+9MaMLC2EzFp
	mRgr8q/j5uo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246BB30F6;
	Tue, 14 Feb 2012 02:22:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 820BD30F5; Tue, 14 Feb 2012
 02:22:24 -0500 (EST)
In-Reply-To: <7v4nuuea7r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Feb 2012 12:42:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A43347E8-56DC-11E1-8591-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190707>

Here is the tonight's snapshot as an incremental update to the issue #5
of "What's cooking" for this month.

I'd like to merge jn/merge-no-edit-fix topic to 'maint' and release the
first maintenance release 1.7.9.1 soonish. The topic is merged to 'master'
already, and it is very much appreciated if people can test and eyeball it
to make sure we fixed what is broken in the vanilla 1.7.9 release without
causing regression in unexpected places.

Thanks, and goodnight.

----------------------------------------------------------------

Born topics

[New Topics]

 * cb/maint-rev-list-verify-object (2012-02-13) 1 commit
  - git rev-list: fix invalid typecast
 
 Fixes an obscure bug in "rev-list --verify" that skipped verification
 depending on the phase of the moon, which dates back to 1.7.8.x series.

 * cb/maint-t5541-make-server-port-portable (2012-02-13) 1 commit
  - t5541: check error message against the real port number used
 
 Test fix.

 * cb/receive-pack-keep-errors (2012-02-13) 1 commit
  - do not override receive-pack errors
 
 One hunk and the word "override" in the description were a bit iffy.

 * cb/transfer-no-progress (2012-02-13) 1 commit
  - push/fetch/clone --no-progress suppresses progress output
 
 The transport programs semi-ignored --no-progress and showed progress when
 sending their output to a terminal.

 * jk/diff-highlight (2012-02-13) 5 commits
  - diff-highlight: document some non-optimal cases
  - diff-highlight: match multi-line hunks
  - diff-highlight: refactor to prepare for multi-line hunks
  - diff-highlight: don't highlight whole lines
  - diff-highlight: make perl strict and warnings fatal
 
 Updates diff-highlight (in contrib/).

 * zj/decimal-width (2012-02-13) 1 commit
  - (sign-off???) make lineno_width() from blame reusable for others
  (this branch is used by zj/diff-stat-dyncol.)
 
 Refactoring.

 * zj/term-columns (2012-02-13) 1 commit
  - pager: find out the terminal width before spawning the pager
  (this branch is used by zj/diff-stat-dyncol.)
 
 Fixes "git -p cmd" for any subcommand that cares about the true terminal
 width.

 * hv/submodule-recurse-push (2012-02-13) 3 commits
  - push: teach --recurse-submodules the on-demand option
  - Refactor submodule push check to use string list instead of integer
  - Teach revision walking machinery to walk multiple times sequencially
 
 The bottom one was not clearly explained.

 * zj/diff-stat-dyncol (2012-02-13) 2 commits
  - diff --stat: use the full terminal width
  - Merge branch 'zj/term-columns' into zj/diff-stat-dyncol
  (this branch uses zj/decimal-width and zj/term-columns.)
 
 This breaks tests. Perhaps it is not worth using the decimal-width stuff
 for this series, at least initially.

--------------------------------------------------
[Cooking]

-* ld/git-p4-expanded-keywords (2012-02-09) 2 commits
+* ld/git-p4-expanded-keywords (2012-02-13) 3 commits
+ - git-p4: more RCS tests
  - git-p4: initial demonstration of possible RCS keyword fixup
  - git-p4: add test case for RCS keywords
 
-Waiting for reviews and user reports.
+Waiting for the dust to settle.
