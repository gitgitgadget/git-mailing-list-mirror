From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Wed, 28 Mar 2012 12:11:27 -0700
Message-ID: <7vr4wcv8v4.fsf@alter.siamese.dyndns.org>
References: <20120328164513.GA4389@odin.tremily.us>
 <81004880a876bb9b9f607129956363d3167bff72.1332956550.git.wking@drexel.edu>
 <201203282011.32148.jnareb@gmail.com> <20120328183712.GA5992@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:11:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyHP-0001Gp-Px
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756925Ab2C1TLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:11:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab2C1TLa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:11:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 698117375;
	Wed, 28 Mar 2012 15:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J9Nn+tDhm/PnyfhyAOfKKKBrM6c=; b=lhlIl/
	shAH9J+eUuKjUYK89yqLE8+PSCgHRpN8+7kUNqyG4esWWv9Y+NOd0ZrrCmOCYFxw
	GExbZ+LrnD8jPOKfSbre+yR+LJfjLEUIEqwcKo4MUxIuOm/s/DBGQUidlNCEqOub
	z/6/sxImDvKJJjzA9wBMZCIJPtbQSmSrCr5Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OKcsLxpXH+zWZTLPv8UNw+fA+4fupLFh
	gJRfKzVyADqJdQkHsl1eRul0RBUyW/sRsGzshWi/JDaDoyp/hPURUl7DqTcCmi9Z
	Uog/NkiMAkchcWHd9FPtNso1XquY5BrKFsrHzQmqWbKJTcwZckr6tz5K2lpiDE/X
	xFrR+5uxQqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FDD87374;
	Wed, 28 Mar 2012 15:11:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9C607373; Wed, 28 Mar 2012
 15:11:28 -0400 (EDT)
In-Reply-To: <20120328183712.GA5992@odin.tremily.us> (W. Trevor King's
 message of "Wed, 28 Mar 2012 14:37:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D26A82C6-7909-11E1-B762-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194164>

"W. Trevor King" <wking@drexel.edu> writes:

> Grr.  Thanks.  I'm getting lots of rebase practice on this patch set,
> but I'm still missing things…

How do you "rebase"?

It often is the easiest to check out the tip of the previous iteration,
fix all issues that were brought up in the working tree, eyeball the
output from "git diff HEAD" to make sure you addressed all the comments,o
and then make separate commits, using "add -p" to sift the fix-ups
according to which commit in the previous round they need to update.

And then finally you run "rebase -i" to squash these fix-ups in.
