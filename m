From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Obliterating a commit
Date: Sun, 30 Sep 2007 16:13:17 +0200
Message-ID: <57945943-2355-447D-9474-89834BADB312@wincent.com>
References: <D2BD14BD-44F2-4D01-AAEE-6CBC2A2DE85B@wincent.com> <1f6632e50709300515h57f4b4ffh9a18fef29b134f13@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Matthias Kestenholz" <lists@spinlock.ch>
X-From: git-owner@vger.kernel.org Sun Sep 30 16:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbzYJ-0000hZ-6N
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 16:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbXI3ONj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 10:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbXI3ONj
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 10:13:39 -0400
Received: from wincent.com ([72.3.236.74]:37489 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755030AbXI3ONj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2007 10:13:39 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8UEDUp5030523;
	Sun, 30 Sep 2007 09:13:35 -0500
In-Reply-To: <1f6632e50709300515h57f4b4ffh9a18fef29b134f13@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59542>

El 30/9/2007, a las 14:15, Matthias Kestenholz escribi=F3:

> If you use ssh to push your changes (that is, you are not copying
> or rsyncing packfiles), only commits, trees and blobs, which are =20
> reachable
> through the DAG will be published. Commits and Blobs which are only
> reachable through your reflog are not published, since the reflog =20
> only applies
> to your local repository.

Ah, this is good to know. Yes, I do principally publish by pushing to =20
a central repo, but I wanted to really destroy the objects just in =20
case in the future I or somebody else ever clones my local repo.

> The simplest thing you could do is remove the reflog for HEAD and
> refs/heads/master respectively your current branch and run 'git prune=
'
> afterwards (if you have not repacked
> already, otherwise you'd need to run 'git repack -a -d' or 'git gc' =20
> to get
> rid of blobs inside your packfile.

Thanks very much, Matthias. Blowing away those reflogs and running =20
git-prune worked and it's doesn't require too much fiddling.

Cheers,
Wincent
