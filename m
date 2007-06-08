From: picca <picca@synchrotron-soleil.Fr>
Subject: interaction between cvsimport and cvsexportcommit
Date: Fri, 8 Jun 2007 15:42:22 +0200
Organization: Soleil
Message-ID: <20070608154222.56870830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 15:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwejU-0004eR-LP
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 15:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967658AbXFHNmZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 09:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967835AbXFHNmZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 09:42:25 -0400
Received: from dns.synchrotron-soleil.fr ([195.221.0.3]:41833 "EHLO
	sucette.synchrotron-soleil.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966776AbXFHNmY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 09:42:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 60C677C278
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 15:42:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at synchrotron-soleil.fr
Received: from sucette.synchrotron-soleil.fr ([127.0.0.1])
	by localhost (sucette.synchrotron-soleil.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQbSnn12UAyY for <git@vger.kernel.org>;
	Fri,  8 Jun 2007 15:42:19 +0200 (CEST)
Received: from venus.synchrotron-soleil.fr (venus.synchrotron-soleil.fr [195.221.0.131])
	by sucette.synchrotron-soleil.fr (Postfix) with ESMTP id 542647C275
	for <git@vger.kernel.org>; Fri,  8 Jun 2007 15:42:19 +0200 (CEST)
Received: from localhost.localdomain ([195.221.5.120]) by venus.synchrotron-soleil.fr with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 8 Jun 2007 15:42:22 +0200
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-OriginalArrivalTime: 08 Jun 2007 13:42:22.0313 (UTC) FILETIME=[D743F590:01C7A9D2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49474>

Hello

In the institut where I am working www.synchrotron-soleil.fr, the
"computing department" use CVS for all their projects. As I am not from
this department (I am a scientist), I can use my own tools and git is
one of them.
Nevertheless I need to interact with them (I am writting a C++
library to control diffractometers) so I use cvsimport and
cvsexportcommit.

The point is that I find this over complicate compare to my git
day-to-day experience.

I do not understand why cvsimport and cvsexportcommit do not
interact nicelly to ease git <-> cvs.
For example as a neeby I expect this to work out of the box
after the first cvsimport

git cvsimport
do some work
git commit -a
git cvsexportcommit

and that's all

Instead of this we have this:

$ export GIT_DIR=~/project/.git
$ cd ~/project_cvs_checkout
$ git-cvsexportcommit -v <commit-sha1>
$ cvs commit -F .mgs <files>

or even worse

$ export GIT_DIR=~/project/.git
$ cd ~/project_cvs_checkout
$ git-cherry cvshead myhead | sed -n 's/^+ //p' | xargs -l1
git-cvsexportcommit -c -p -v


what is missing in cvsexportcommit and cvsimport to lower the git <->
cvs barrier.

Thank you.

Frederic

PS: Sorry for my poor english.
