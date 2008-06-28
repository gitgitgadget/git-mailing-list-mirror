From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: Make test on AIX
Date: Sat, 28 Jun 2008 10:35:05 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F7943013D8B@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302389D09@emailmn.mqsoftware.com> <20080628051500.GF9451@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 28 17:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCcT7-0007Ma-FZ
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 17:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbYF1PfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 11:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbYF1PfH
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 11:35:07 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:19569 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYF1PfG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jun 2008 11:35:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Make test on AIX
Thread-Index: AcjY4BIndKwJrf/+RhSkjKo7pPA0YAAU6+fG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86723>

(I apologize in advance if the quoting is bad, using owa since I don't want an outlook client installed on my home system)


-----Original Message-----
From: git-owner@vger.kernel.org on behalf of Jeff King
Sent: Sat 6/28/2008 12:15 AM
To: Craig L. Ching
Cc: git@vger.kernel.org
Subject: Re: Make test on AIX
 
On Fri, Jun 27, 2008 at 04:13:41PM -0500, Craig L. Ching wrote:

> The first thing I encountered was that because the tests all use
> #!/bin/sh the exit code was not what the tests expected.  So I ended up
> running 'make SHELL=`which bash` all' directly in the git/t/ directory.
> That seemed to shake out and work for most of the tests except for
> t/t7502-commit.sh.  Try as I might, I could not get SHELL_PATH set to
> anything but /bin/sh except to hard-code the SHELL_PATH in this script.

> > The SHELL_PATH actually comes from the build options for all of git. So
> > you should be able to go to the toplevel of your git repo and do a "make
> > SHELL_PATH=`which bash`". This means that we will also use bash for all
> > of the script components of git.

Well, I swear I tried 'make SHELL_PATH=`which bash` test' and that *didn't* work, but I just rebuilt adding SHELL_PATH to even the build step and the tests are running.  I do know I upgraded bash somewhere in between trying that and now, maybe that had some affect, the bash that was installed was fairly old.  The tests are running now, I'll post back if I run into any other problems.

> > I don't know how necessary that is on AIX, but it certainly is on
> > Solaris, where /bin/sh is unusable.

I didn't have this problem at all on Solaris, the tests ran just great apart from needing to install a pretty hefty GNU tool chain since a lot of the tests wouldn't work with non-GNU equivalents (e.g. patch, diff, sed, etc.).  Not a huge deal, just glad to see it building and passing tests on these platforms ;-)

> > -Peff

Thanks again!

Cheers,
Craig
