From: Erik Iverson <iverson@biostat.wisc.edu>
Subject: simple git use case
Date: Wed, 04 Feb 2009 22:52:03 -0600
Message-ID: <498A7073.4060206@biostat.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 06:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUwes-0008Cw-E1
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 06:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbZBEFRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 00:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbZBEFRl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 00:17:41 -0500
Received: from pegasus.biostat.wisc.edu ([144.92.73.35]:53163 "EHLO
	pegasus.biostat.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZBEFRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 00:17:40 -0500
X-Greylist: delayed 1532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Feb 2009 00:17:40 EST
Received: from [192.168.1.117] (c-24-118-170-198.hsd1.mn.comcast.net [24.118.170.198])
	(authenticated bits=0)
	by pegasus.biostat.wisc.edu (8.13.6/8.13.6) with ESMTP id n154pxCH010072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 4 Feb 2009 22:52:00 -0600 (CST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
X-BCG-MailScanner-Information: BCG: sysreq@biostat.wisc.edu
X-BCG-MailScanner: Found to be clean
X-BCG-MailScanner-From: iverson@biostat.wisc.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108498>

Dear all,

I sincerely hope this is not an annoying question, I promise I have tried to do 
my homework here, but am stuck.  My use case is simple.  I have a desktop and a 
laptop.  When I go on the trips, I'd love to be able to bring my "git-test" 
directory with me on the laptop, code some, and then get the new revisions back 
on the desktop when I get home (bonus if I can get the revisions back to my 
desktop over the internet while still on the road, in case, for example, my 
laptop gets stolen).  No one else will be working on this stuff, it's strictly 
for me.

OK, so here's what I do.

Desktop (dt):

dt> cd git-test
dt> git-init
Initialized empty Git repository in /home/erik/projects/git-test/.git/
dt> git add .
dt> git-commit -am 'initial commit'
Created initial commit c150815: initial commit
  3 files changed, 14 insertions(+), 0 deletions(-)
  create mode 100644 test.R
  create mode 100644 test.sas
  create mode 100644 test.tex

Looks good...
Now over to the laptop (lt)!

lt> git-clone ssh://myip/path/to/project

And great, I have the three test.* files, looks good!
So I make some changes to test.R on laptop, like I'm on the road. Then, on laptop:

lt> git-commit -am 'an update'

Looks good.

Now I become a mouth-breather...and need some help :).

My instinct was to git-push from the laptop,

lt> git-push

which succeeds, but then a git-pull
from desktop says:

dt> git-pull
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

OK, so look around mailing list archives...I try, without knowing what it means 
at all:

dt> git-config branch.master.remote .
dt> git-pull
 From .
  * branch            HEAD       -> FETCH_HEAD
Already up-to-date.

Hmmm, so it did something, but not what I'd expect.  How about:

dt> git-checkout
M	test.R

So it realizes that file has been modified...

dt> git-checkout -f

This gives no message of any type, and now I see my modified test.R file on my 
desktop, so good! I'm happy with this, but I must know, it this the Right Way to 
use git for my use case, or am I doing something silly?

Thank you for providing this software.

Best Regards,
Erik Iverson
