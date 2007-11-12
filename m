From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH,RFC 1/2] Make the list of common commands more exclusive
Date: Sun, 11 Nov 2007 23:26:10 -0800
Message-ID: <7vhcjr53hp.fsf@gitster.siamese.dyndns.org>
References: <20071111235819.GB7392@thunk.org>
	<1194829077-14320-1-git-send-email-tytso@mit.edu>
	<7vzlxk8apz.fsf@gitster.siamese.dyndns.org>
	<20071112062222.GA17462@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 12 08:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrTgo-0003Qv-6p
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 08:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbXKLH0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 02:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbXKLH0S
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 02:26:18 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57868 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbXKLH0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 02:26:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0DD092F2;
	Mon, 12 Nov 2007 02:26:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 823E894A13;
	Mon, 12 Nov 2007 02:26:35 -0500 (EST)
In-Reply-To: <20071112062222.GA17462@thunk.org> (Theodore Tso's message of
	"Mon, 12 Nov 2007 01:22:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64568>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Nov 11, 2007 at 06:21:44PM -0800, Junio C Hamano wrote:
> ...
>> I am fine with this list, perhaps except apply.
>
> I was borderline on apply, but given that people are familiar with
> patch -p1, the only real advantage git-apply has is that automatically
> deals with new files (which "git commit -a" or "git add -u" won't
> automatically get).

Although more importantly git-apply is much more strict and
safer than patch by default, that distinction will probably not
register with total newbies; not much would be lost if we do not
list git-apply, I'd guess.

> What did you think about cherry-pick?  Was that omitted by accident?

As "git show | git apply --index" would be good enough for
simple projects, omission of git-cherry-pick is not as serious
compared to ommission of git-revert, whose alternatives would be
"commit --amend" and "rebase" which are not suitable for
published history.

> My mental model for git newbies is that they would probably be pulling
> from upstream repositories (so I was tempted to remove git-init from
> the common commands list), but they would rarely be cherry-picking or
> reverting other people's changes.

I'd agree with that, but reverting and cherry-picking would also
be done on the commits the user builds on top of other people's
changes.

> They probably would be submitting changes back upstream using e-mail
> before they learn how to publish their own repository, so commands I'd
> be tempted to add would include git-format-patch, git-send-email, and
> git-cherry.  But these commands are pretty complicated for beginners....

I'd half agree with that.  People coming from CVS workflow will
be pushing and pulling from their central repositories, without
format-patch and send-email.  For them revert would matter more
together with fetch, rebase and push.
