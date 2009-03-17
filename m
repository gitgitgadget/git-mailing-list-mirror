From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Preemptive EOF when pushing (using Msys git and PuTTY)
Date: Tue, 17 Mar 2009 13:25:53 +0100
Message-ID: <49BF96D1.9000508@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 13:57:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjYqn-0006PM-EF
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 13:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbZCQMz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 08:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZCQMz0
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 08:55:26 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:54043 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZCQMzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 08:55:25 -0400
X-Greylist: delayed 1735 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 08:55:25 EDT
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id BABF325AAF
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 13:26:26 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 08833-06-3 for <git@vger.kernel.org>;
 Tue, 17 Mar 2009 13:47:49 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 81CA225A5B
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 13:25:54 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113466>

Hello everyone, and thanks for all your dedicated work with git.

I have used git for quite some time now, mainly on different Linux
platforms, without any problems.  Recently we convert the office's pet
project from svn to git.  Many people at the office use Windows (Msys
git 1.6.2 and plink), and I have stared to see (only from Windows
people) problems when pushing similar to the following:

Counting objects: 422, done.
Compressing objects: 422, done.
Writing objects: 100% (379/379), 77.77 KiB, done.
Total 379 (delta 310), reused 371 (delta 303)
fatal: early EOF
error: unpack failed: index-pack abnormal exit
To jkoehler@serv-4100:/git/argos.git
 ![remote rejected] jk/ellipseFit -> jk/ellipseFit (n/a (unpacker error))
error: failed to push some refs to
'jkoehler@serv-4100:/git/argos.git'

There seems to be no problem with the repo, neither local nor remote,
but for a specific setup the problem is reproducible on several Windows
machines, but if I move the whole local repo to a Linux machine instead
the problem is gone.

I suspect the problem is that a ^Z EOF gets embedded in the pack to be
transported, and that somehow interacts poorly with PuTTY, but that is
just my guessing.  And if so I don't know how to handle it.

Has anyone experienced anything similar?  If so, is there any simple fix
to the problem?  How would I go about to try to debug this?
Unfortunately, this seems to happen on a regular basis and affects the
git experience in a negative way, so I would be really happy to be able
to resolve the problem.

I'm thankful for any help that I can get.

/Gustaf
