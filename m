From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Syncing with CVS
Date: Mon, 19 Jan 2009 23:05:36 +0100
Message-ID: <200901192305.36577.robin.rosenberg.lists@dewire.com>
References: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Christian von Kietzell" <cuboci@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 23:07:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP2Gv-00054e-OJ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 23:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbZASWFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 17:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZASWFk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 17:05:40 -0500
Received: from mail.dewire.com ([83.140.172.130]:10437 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbZASWFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 17:05:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AD53A147E5EF;
	Mon, 19 Jan 2009 23:05:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5o61NOqD5HOv; Mon, 19 Jan 2009 23:05:37 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 1A7D28028B8;
	Mon, 19 Jan 2009 23:05:37 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106394>

m=C3=A5ndag 19 januari 2009 10:39:53 skrev Christian von Kietzell:
> Hi,
>=20
> I have a project I started in git. After a while I exported that to
> CVS via git cvsexportcommit which worked quite nicely. Now, a
> colleague made changes to the project - in CVS. What's the best way t=
o
> get those back into my git repository so that I'll be able to sync
> back and forth between git and CVS? I had a quick look at the wiki bu=
t
> couldn't find anything appropriate.
>=20
> I know of git cvsimport, of course, but that doesn't work on my
> original repository. Or does it? I didn't find anything on how to
> limit what to import. After all, some of the commits are already in m=
y
> repository (the ones I exported).
Just continue with cvsimport, then git rebase origin. That'll drop the
commits that you made when the same commit have been discovered
in CVS.

I personally do the cvs import into a separate repo using a cron job. T=
hat
extra repo is my origin so I get up-to-date using git fetch and rebase =
just
as if the CVS commits would come from a real repo.

-- robin
