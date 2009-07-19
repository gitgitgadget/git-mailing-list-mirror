From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: how to start with non-master branch?
Date: Sun, 19 Jul 2009 09:19:29 -0700
Message-ID: <BLU0-SMTP89B66EA462C93B0D1943F6AE1C0@phx.gbl>
References: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 18:19:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSZ7F-0005kd-LC
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 18:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZGSQTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 12:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZGSQTd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 12:19:33 -0400
Received: from blu0-omc3-s28.blu0.hotmail.com ([65.55.116.103]:40457 "EHLO
	blu0-omc3-s28.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754597AbZGSQTd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jul 2009 12:19:33 -0400
Received: from BLU0-SMTP89 ([65.55.116.73]) by blu0-omc3-s28.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Jul 2009 09:19:33 -0700
X-Originating-IP: [96.49.109.68]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([96.49.109.68]) by BLU0-SMTP89.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Jul 2009 09:19:31 -0700
In-Reply-To: <f46c52560907190553x4e21ffbdn6d55c43f2d6b08ad@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 19 Jul 2009 16:19:31.0891 (UTC) FILETIME=[B2A26030:01CA088C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123556>

On Sun, 19 Jul 2009 18:23:32 +0530
Rustom Mody <rustompmody@gmail.com> wrote:

Hi Rustom,

> I want my first commit to be on a non-master branch.
> So after the git init I do
> $ git checkout -b newbranch
> 
> I get
> fatal: You are on a branch yet to be born

No branches exist in a new repository that you've just init'ed.  If you run
"git branch" you'll see that no branches are listed.  You must make an
initial commit before a branch will be "born".   Since "git checkout"
needs you to supply a branch/commit to operate, you can't use it to create
the first branch in a repo.

When you make the initial commit in a repo the HEAD reference will
determine which branch is created.   So the following ugly looking
command will allow you to change the name to something other than 
master before making your first commit:

	$ git symbolic-ref HEAD refs/heads/newbranch

> Of course I can get by with making the first commit on master and then
> switching.

That is probably the simplest thing to do, rename master after the initial
commit:

	$ git commit -m "initial commit"
	$ git branch -m newbranch

HTH,
Sean
