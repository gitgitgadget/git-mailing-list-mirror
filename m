From: Bill Lear <rael@zopyra.com>
Subject: Decoding git show-branch output
Date: Fri, 19 Jan 2007 07:12:35 -0600
Message-ID: <17840.50115.999227.260259@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 19 14:53:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7uB4-00025T-3Q
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 14:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbXASNwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 08:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbXASNwi
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 08:52:38 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60721 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965142AbXASNwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 08:52:38 -0500
X-Greylist: delayed 2380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 08:52:37 EST
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0JDCuH06136;
	Fri, 19 Jan 2007 07:12:56 -0600
To: git@vger.kernel.org
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37184>

If this is an inappropriate forum for this question, please let me know
and I will redirect it elsewhere.

We have converted from cvs to git recently and one of our developers
seems to have made a terrific mess of things.

He is seeing "fatal: protocol error: bad line length character" when
pushing from a one of his work repositories to our main company
repository.  He is seeing his git merges vanish (he can't find his
code where he thinks it should be) and is apparently having trouble
doing things we thought should be very simple.  Personally, I have
had little trouble with git, but now I'm trying to figure out what
it was he has done to get himself in this mess.

We are running the latest git 1.4.4.1, under Linux (a few flavors,
Centos 4.3, Redhat 4, etc.).  Our company repository is on Fedora Core
6.

I thought I would use git-show-branch to try to unravel some of this
mystery.

After doing several commits, our company repository looks like this:

% GIT_DIR=fus git-show-branch --more=20 --topo-order
[master] Merge branch 'master' of source:/repos/git/fus
[master^2] Add more timing of Tbar components.
[master^2^] Add more timing of Tbar components.
[master^] Tell git to ignore more stuff.
[master~2] fix to pass on gcc
[master~3] Merge branch 'master' of ssh+git://source/repos/git/fus
[master~3^2] Merge branch 'master' of source:/repos/git/fus
[master~3^2^2] placeholders for 1.0 release
[master~3^2^] recursive_binomial branch merged to master.
[master~3^2~2] More Tbar timing statistics.
[master~4] with this you will be able to do help on any command
[master~5] help for commands
[master~6] add echo to try and track down intermittent failure
[master~7] fix stupid typo
[master~8] fix stupid error
[master~9] add removal of files to prevent affecting future test runs
[master~10] Merge branch 'master' of ssh+git://source/repos/git/fus
[master~10^2] Merge branch 'master' of ssh+git://source/repos/git/fus
[master~10^2^] update to report output when gen_run.tcl fails
[master~11] Merge branch 'master' of ssh+git://source/repos/git/fus
[master~10^2^2] Integer type fixups to suppress warnings.

I'm very confused by the syntax above.  What does "[master^2^]" mean?
Ditto with things like "[master~3^2^2]" and "[master~3^2~2]".  Why
is the order 

[master]
[master^2]
[master^2^]
[master^]

?  I would have thought [master] would be followed by [master^], not
[master^2].  Obviously I'm confused.

I have read the May 2006 article in Linux Magazine, "Embrace The Git
Index" by Jon Loeliger, and tried to make sense of the "HOW TO READ
COMMIT SHORT-HAND NAMES" box on the sixth page, but can't seem to.

I'm used to visual representations that show things in chronological order,
from left to right, say as

                                   H---I---J  second
                                  /
                         E---F---G---K---L  first
                        /
                       /       O---P---Q  third
                      /       /
         A---B---C---D---M---N  master

or:

                                   H---I---J  second
                                  /         \
                         E---F---G---K---L---R  first
                        /                     \
                       /       O---P---Q  third \
                      /       /         \         \
         A---B---C---D---M---N-----------S---------T  master

(third merged onto master, second onto first, first onto master)

But I can't seem to make the mental leap to map the show-branch output
to something I understand such as the above.

So, If someone could help me grok this, I'd appreciate it.

Again, apologies if this is not the appropriate forum.


Bill
