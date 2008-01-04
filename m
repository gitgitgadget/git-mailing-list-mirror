From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 04 Jan 2008 00:35:42 -0800
Message-ID: <7v63yam1i9.fsf@gitster.siamese.dyndns.org>
References: <20080104081429.GA30635@coredump.intra.peff.net>
	<7vejcym21q.fsf@gitster.siamese.dyndns.org>
	<20080104082842.GA3300@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAi2M-0008RW-Uw
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbYADIfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753127AbYADIfv
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:35:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49573 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbYADIfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:35:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3251C4E77;
	Fri,  4 Jan 2008 03:35:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B3394E76;
	Fri,  4 Jan 2008 03:35:44 -0500 (EST)
In-Reply-To: <20080104082842.GA3300@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:28:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69562>

Jeff King <peff@peff.net> writes:

> I'm not sure what you mean here. Are you saying that it is the desired
> behavior for "git-diff --color" to use my color.diff.* variables, but
> for "git-diff-files --color" not to?

What I meant is "git diff" without --color can be colorized
because of config but we should never allow "git diff-files"
without --color to be colorized by user's config.  I realize
that you were talking about the choice of colors, which is a
different issue.

I do not much care ;-), but I guess we would want to be
consistent.

> Not to mention the other bug (that diff-files _does_ read the config,
> just halfway through).

That one _is_ a bug.  diff-files should not be affected by
"diff.color = auto" or somesuch in the config, even when the
user uses custom function header crap.
