From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: git-svn: surprising behaviors/bugs?
Date: Thu, 22 Nov 2007 14:37:27 +0100
Message-ID: <bf7b2dda0711220537h3f37c84ag899b74daa9a8fe1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 14:37:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvCFW-0003TN-So
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 14:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbXKVNh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 08:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbXKVNh3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 08:37:29 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:2583 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbXKVNh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 08:37:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2378755rvb
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 05:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=R4ac4H+pV9hPZd1dJOBYRjWBpvaoj13TfE8Z/m2AMok=;
        b=qYK92OIr5b47DFg9yd6xJVVeOKg/WCEtANkaMF/p8tv2dvIwLP0gWWH442R0f47YNswmvOysan+1wPHAvg3y3w3n7KPwoDyAmRtT6KfTpKF1raSKkhEV0OUgGVrNF0IIiuC9SeTJtpLeBd7cScjKxzdehtHOqjMpBvzS/HCnnBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AfoI/5q4+WLF9R7VBKQ1sGVUccD8kyEXWyh//dd6ID+cLEyVAchJeuRSPKoSfRJQWkXH/pgQy7SKBvbVQCTf//+Rqnu3NqriYxA95NNWaysAQG3/+Fm7qFhLnlETO2ycg2t466Ol8cjvHBeXxbtUK6nu6mk2VE/Olp4evYW7goY=
Received: by 10.140.249.20 with SMTP id w20mr3929482rvh.1195738647509;
        Thu, 22 Nov 2007 05:37:27 -0800 (PST)
Received: by 10.140.173.1 with HTTP; Thu, 22 Nov 2007 05:37:27 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65822>

I've been running git for most my stuff for some time now, and am
really pleased with what it has to offer.  However, all my coworkers
aren't gitified yet, and therefore I sometimes have to work with svn.
I've learned to appreciate git-svn for this, since it lets me utilize
the strengths of git and still allows for my coworkers to think I use
their svn setup.  Thanks to all who contribute to this wonderful
tools!

In my work with git-svn I have stumbled upon the following two
unexpected behaviors.  Basically, am I doing/understanding something
wrong, or is this buggy behavior in git-svn?  (I'm presently using git
1.5.3.6, but have been experiencing these things for a while.)


1.  I don't really like svn's committer info, so I got an authorsfile
set.  This works great when I'm fetching/dcommitting from the
top-directory in my git checkout (the one with .git in), however, if
I'm in a subdirectory the authorsfile doesn't kick in and I get the
svn commiter info.  This is not a big deal, but a bit surprising and
my history gets a bit ugly.


2.  My second problem involves getting the support in git-svn for tags
and branches to work.  Having a standard layout of the svn repository,
in this case
   /source/project/(trunk|branch|tags)
svn clone -s only works as expected sometimes.  Sometimes I only get
the revision history, not including any actual content (ie none files
of the files under control turns up in git) from the clone.  When I
get this problem I usually clone the trunk only, and add tags myself.
This is far from optimal, and also error prone.  Other times, the
clone works as expected and gives me the tags and branches and all the
content.

I think the problem occurs when I'm not the owner of the svn
repository, and only have access (read/write) to the
project/(trunk|branch|tag) part, and don't have any access at all to
source.  Ie, svn ls works for /source/project and
/source/project/trunk etc, but not /source (where I returns 403
Forbidden access).  All svn access is through a svn-server that I
can't control myself.


I've had a quick look in git-svn.perl, but the code is to beyond my
limited perl knowledge.  I'd be happy to provide more details if
anyone is interested in looking deeper into this.  Any ideas or
comments are greatly appreciated!

/Gustaf
