From: "Patrick Doyle" <wpdster@gmail.com>
Subject: workflow question
Date: Tue, 24 Jul 2007 09:53:30 -0400
Message-ID: <e2a1d0aa0707240653x55dd82b3pf9e3986f5c3bb344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKpS-0004cT-HU
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996AbXGXNxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbXGXNxb
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:53:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:37804 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbXGXNxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:53:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2386188wah
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 06:53:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VNY+kjASlZrhWJ0k5yDKfOp4JngboVn2Jlkj76vXBer78eCbzriIC/q4OpmDxWupEBJsctNmMmr9tpagBANBmU/0jLBneWvRrXbtrJu7QARd/mI8cAt2M9xnYOL1lbkeQNMP/bMtcuX5iX2OHpWiOFpvqkRo//+oZnc3BngxKtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rBmXXJc8B9nMUJqNjTLA+ym8lKjLkU0h7WonzJOZ1BBsi7pUQWpgMNp8dhjmk7nUD5tA1o041ZJF1cA/F4p5IaoJHPEb9SnjGkRvgvs3OvPcVWr4W5w37Tp+xdU1GmqgV2VHhCXJy8lKmgWLIaTxhe5hOIbDy/1i3SYUjKjXnlE=
Received: by 10.115.23.12 with SMTP id a12mr4066457waj.1185285210154;
        Tue, 24 Jul 2007 06:53:30 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Tue, 24 Jul 2007 06:53:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53596>

I'm still trying to figure out how to adapt my workflow to git or git
to my workflow, and I've come up with yet another question or two...

I tend to work detached from our central SVN server, and I'm attracted
to the fact that I can work on my laptop, commit changes as I go
along, and later synchronize them back to the server.

On my current project, I am sole developer (at present) and the
central SVN server serves primarly as an off-site backup and
historical archive.

Enough of the setup, here are the questions...

1) I would like to make a (git) branch on which I can commit
hourly/daily/periodically as I add in a new feature (so that I can
roll back to the "Gee, I thought it was behaving yesterday -- what
does that code look like?" commit when I need to), but I don't want to
send all of the "commit as of 12:32 on Thursday" commits back to the
SVN server when I'm done.  Do I want to use a "squash" merge to merge
my changes back to the master branch before I synchronize with the
subversion server?  Or do I use the "--no-commit" option to merge?  Or
do I try something else?  The first/last time I tried this, I ended up
with a fast-forward merge back into master, which included all of my
stupid little commit messages.  I would rather one commit message that
read "Added XYZ feature".

2) When I don't fork a branch, and I don't commit until I've completed
the particular feature I'm working on, I can get a fairly good idea of
where I am and what I was doing last (which might be 5-7 days ago,
given high priority interrupts on other projects, summer vacations,
etc...) just by running a "git status".  I see that there are 7 new
files, and 2 modified files.  I know that, when I fork my branch, I
can use "git diff master" to see what's different between my branch
and the master, but then I get the diff of all of the changes as well,
which is too much information.  "git diff --name-only" and "git diff
--summary" are closer, but I can't tell what's been added vs. what's
been changed.  Any suggestions?

As an aside, is there an undocumented option to "git status" to
produce a less verbose report of what's been changed and what's not
checked in?  Perhaps a single line per file with a one or two letter
indication of the status of the file followed by the name?  If not,
would there be any violent objections to my submitting a patch to add
such a feature?

That's enough for now.  Thanks for reading this far :-)

--wpd
