From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitignore bug: including files in an excluded directoy does not
        work.
Date: Wed, 27 May 2009 22:55:03 +0200
Message-ID: <4A1DA8A7.9030606@drmicha.warpmail.net>
References: <809f58722b8bdb916fa7816cd80d3833-EhVcXl1BQAtYRw8cBxcBWQEwfgFLV15YQUBGAEFbXkI3XV8WXlhwH1RQWEFeRENtXlhdQ1hSWAtfWg==-webmailer2@server05.webmailer.hosteurope.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: florian@fkoeberle.de
X-From: git-owner@vger.kernel.org Wed May 27 22:56:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9QBD-0008QG-Uz
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760487AbZE0UzO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 16:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760756AbZE0UzO
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:55:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52103 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760737AbZE0UzM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 16:55:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 426B6346835;
	Wed, 27 May 2009 16:55:14 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 27 May 2009 16:55:14 -0400
X-Sasl-enc: jomobjr6CwjJT4FlXiY7RTnyPakCVZhXQzI1ujViqKlg 1243457713
Received: from localhost.localdomain (p548598F2.dip0.t-ipconnect.de [84.133.152.242])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5FF5F16A78;
	Wed, 27 May 2009 16:55:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090525 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <809f58722b8bdb916fa7816cd80d3833-EhVcXl1BQAtYRw8cBxcBWQEwfgFLV15YQUBGAEFbXkI3XV8WXlhwH1RQWEFeRENtXlhdQ1hSWAtfWg==-webmailer2@server05.webmailer.hosteurope.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120105>

=46lorian K=F6berle venit, vidit, dixit 23.05.2009 11:18:
> steps to reproduce:
>=20
> git init
> echo /src/config > .gitignore
> echo \!/src/config/readme.txt >> .gitignore
> mkdir -p src/config
> touch src/config/readme.txt
> git add src
>=20
> expected results:
> git should add the readme.txt file
>=20
> actual result:
> git doesn't add the readme.txt file
>=20
>=20
> additional comments:
>=20
> pre to the commit d6b8fc303b it was possible to archive the wished ef=
fect
> with this .gitignore file:
> ------------------
> /src/config/
> !/src/config/readme.txt
> ------------------
> The pre d6b8fc303b git fails to detect that it can exclude src/config=
=2E
> Thus it checks the directory content and finds out that the readme.tx=
t
> matches both - the exclude and the include pattern.

The change in behaviour was intentional. You get the desired effect usi=
ng:

/src/config/*
!/src/config/readme.txt

Cheers,
Michael
