From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Tue, 1 Dec 2009 18:08:25 -0800
Message-ID: <BLU0-SMTP487572F057CC9D30C837D7AE950@phx.gbl>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:14:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFejw-0006y4-ID
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 03:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbZLBCOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 21:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbZLBCOh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 21:14:37 -0500
Received: from blu0-omc3-s33.blu0.hotmail.com ([65.55.116.108]:30376 "EHLO
	blu0-omc3-s33.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750876AbZLBCOg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 21:14:36 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 21:14:36 EST
Received: from BLU0-SMTP48 ([65.55.116.73]) by blu0-omc3-s33.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Dec 2009 18:08:34 -0800
X-Originating-IP: [96.49.114.151]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from localhost ([96.49.114.151]) by BLU0-SMTP48.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Dec 2009 18:08:32 -0800
In-Reply-To: <1259707865-6561-1-git-send-email-sn_@gmx.net>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.6; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Dec 2009 02:08:33.0111 (UTC) FILETIME=[5968D670:01CA72F4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134294>

On Tue,  1 Dec 2009 23:51:03 +0100
David Soria Parra <sn_@gmx.net> wrote:

> The following series adds a --track option to git clone. If the --track option
> is specified only the given remote branch will be received and checked out.

IMHO, the term "track" is already overloaded in Git and this doesn't help make
things clearer.

> It tries to make the following usecase possible:
> Imagine you are working on a project that has 1.x and a 2.x branch. The project
> itself requires a complex setup (webserver, configuration files, etc). Setting up
> 1.x and 2.x branch requires a lot of work, but a developer needs to maintain both.
> He'll use the --track option to clone the 2.x branch into a directory and does the same
> with the 1.x branch, where he setup the project. He can use locally separate repositories
> while still being able to push to just one remote repository.

This is already straightforward in Git without the limitation of tracking only
a single remote branch.   What is the necessity of doing this via the clone command?

  $ git init myrepo
  $ cd myrepo
  $ git remote add -t branch1.x -f origin <URL>
  $ git checkout -t origin/branch1.x

Sean
