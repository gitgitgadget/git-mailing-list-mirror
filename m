From: John Wiegley <johnw@boostpro.com>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 00:26:10 -0500
Message-ID: <m2fwrvta4t.fsf@hermes.luannocracy.com>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
	<20110210225428.GA21335@sigill.intra.peff.net>
	<m2oc6jtg8o.fsf@hermes.luannocracy.com>
	<20110211044539.GA2071@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 11 06:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnlWQ-0008Bq-KK
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 06:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab1BKF0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 00:26:15 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40045 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1BKF0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 00:26:15 -0500
Received: by qwa26 with SMTP id 26so1311643qwa.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 21:26:14 -0800 (PST)
Received: by 10.229.213.146 with SMTP id gw18mr60941qcb.211.1297401973820;
        Thu, 10 Feb 2011 21:26:13 -0800 (PST)
Received: from localhost (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
        by mx.google.com with ESMTPS id nb15sm332731qcb.2.2011.02.10.21.26.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 21:26:13 -0800 (PST)
In-Reply-To: <20110211044539.GA2071@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Feb 2011 23:45:40 -0500")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166538>

Jeff King <peff@peff.net> writes:

> OK. That's certainly the conservative answer, and where we should start.
> But I wonder in practice how many times we'll hit all the criteria just
> right for this feature to kick in (i.e., a cherry pick or rebase with no
> conflicts, followed by one that would cause a conflict). But I think
> there's nothing to do but implement and see how it works.
>
> After thinking about this a bit more, the whole idea of "is this
> cherry-picked/rebased/whatever commit the same as the one before" is
> really the same as the notes-rewriting case (i.e., copying notes on
> commit A when it is rebased into A'). Which makes me excited about using
> notes for this, because the rules that you do figure out to work in
> practice will be good rules for notes rewriting in general.
>
>> The problem with an external annotation is that if developers are sharing
>> feature branches, as a branch maintainer I want to know whether commits coming
>> from those feature branches are already in the branch I'm maintaining.
>
> In that case, I would suggest putting it in git-notes and sharing the
> notes with each other. The notes code should happily merge them all
> together, and then everyone gets to see everybody else's
> cherry-pick/rebase annotations.

The more I've talked this over with my friend, the more we discover how
difficult this is to get right in certain situations, and also how rare the
actual use cases that require storage within the commit message are -- but at
the same time, how valuable that information is when those cases occur!

This may be a bit more than I can chew right now, so thank you for bringing to
my attention the depth of this problem.  That's exactly why I posted here
before beginning to punch out code that might solve just the naive cases. :)

Thanks, John
