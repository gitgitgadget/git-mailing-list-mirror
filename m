From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Wed, 24 Aug 2011 08:54:12 +0200
Message-ID: <20110824065412.GA10800@ecki>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 08:56:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw7OA-0003PK-NB
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 08:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1HXG4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 02:56:34 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:12787 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751411Ab1HXG4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 02:56:33 -0400
Received: from localhost (p5B22C8F7.dip.t-dialin.net [91.34.200.247])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E1D4130082;
	Wed, 24 Aug 2011 08:56:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179989>

Hi Nathan,

On Tue, Aug 23, 2011 at 02:26:48PM -0500, Nathan W. Panike wrote:
> 
> Is there any way to change this behavior, e.g., so that rule 6 becomes
> an error? Say, by setting a config option?

I know you're trying to improve git. I do not want to discourage
that. But with little UI annoyances like this, it's usually not
worth it.  Git has countless magic tricks like this.  It's a bit
like perl in that regard. Assuming that we agree on what we would
like to get rid of (which is the hard part), it would still break
backwards compatibility. Maintaining a switch, on the other hand,
is overhead and in the end it would make git even more complicated,
because now the behavior of core commands depends on user
configuration.

But once you accept the fact that this is what git is, you can
tackle the problem in a different way:

> A colleague at $dayjob recently caused corruption in our git
> repository by accidentally running the command
> 
> git rebase origin stable

Ok, mistakes happen. But that's exactly why you have git: To be
able to deal with mistakes gracefully. So use git to review and
test changes before they get declared as a stable release (stable
enough to be used internally, at least). Then mistakes usually
become a local problem and can be undone using the reflog.

Clemens
