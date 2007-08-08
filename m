From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn: commit author x commit committer issue
Date: Wed, 8 Aug 2007 19:13:23 +0200
Message-ID: <20070808171323.GD27703@xp.machine.xx>
References: <46B9C92B.3000000@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard MUSIL <richard.musil@st.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIp6P-0005SS-Td
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 19:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937203AbXHHRNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 13:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937185AbXHHRN2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 13:13:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:48882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936769AbXHHRN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 13:13:26 -0400
Received: (qmail invoked by alias); 08 Aug 2007 17:13:24 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp044) with SMTP; 08 Aug 2007 19:13:24 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/FBMlHI+TFKDGnM1pNq/XWLUlB5tuheNRzs60Lg6
	FjWfKbCMPm8NFP
Mail-Followup-To: Richard MUSIL <richard.musil@st.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46B9C92B.3000000@st.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55332>

On Wed, Aug 08, 2007 at 03:46:19PM +0200, Richard MUSIL wrote:
> Normally, when patch is applied, git distinguishes commit author and
> commit committer (relying on info from patch).
> However, after the patches are committed to svn repository using:
> git-svn dcommit
> author and committer data are set to same values (or at least time and
> date, I cannot verify it for names).
> I wonder if there is any reason for this behavior, because I would
> definitely like to keep original commit info (which came from patch) in
> my git repository.

I think it is because in SVN, you can't differentiate between author and
committer. And git-svn just commits every local commit to svn, and after
that, it throws away your local commits and uses the info from the
reimported svn commits to recreate those thrown away commits. Thats why
you loose your author name and also your commit date.

Ok, this was a little too simplified, but describes roughly what happens
if you dcommit your changes.

-Peter
