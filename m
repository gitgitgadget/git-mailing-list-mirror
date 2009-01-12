From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: rebase-merge/done: No such file or directory
Date: Tue, 13 Jan 2009 00:02:28 +0100
Message-ID: <20090112230228.GA28545@chistera.yi.org>
References: <87ocycjq29.fsf@jidanni.org> <alpine.DEB.1.00.0901122342420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 13 00:04:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVpB-0002Ux-1L
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 00:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758852AbZALXCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760621AbZALXCd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 18:02:33 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2632
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZALXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 18:02:31 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id C2509801C078;
	Tue, 13 Jan 2009 00:02:29 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMVng-0007av-Vr; Tue, 13 Jan 2009 00:02:29 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901122342420.3586@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105411>

* Johannes Schindelin [Mon, 12 Jan 2009 23:47:47 +0100]:

> > $DONE might not exist. Do test -f $DONE before you grep it.

> I cannot reproduce here.  Since all the files in .git/rebase-merge/ a=
re=20
> internal files to rebase--interactive, I think we do not have to guar=
d=20
> against any possible user action rendering assumptions about internal=
s=20
> invalid.

> Wasting a minute, I seem to understand why I cannot reproduce.  Just=20
> looking all of _two_ lines above the line you mentioned:

> 	sed -e 1q < "$TODO" >> "$DONE"

> Hrmpf.  You're right.  The user could have removed "$DONE"e between t=
he=20
> two lines ;-)

No, not really. Start a rebase -i. Change the *first* "pick" to a
"squash". Save and exit the editor. You'll see the output jidanni
mentioned:

  grep: .git/rebase-merge/done: No such file or directory
  Cannot 'squash' without a previous commit

The second line tells the user what happened (what their error was), bu=
t
I guess we could do without the first one.

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
Debugging is twice as hard as writing the code in the first place. Ther=
efore,
if you write the code as cleverly as possible, you are, by definition, =
not
smart enough to debug it.
                -- Brian W. Kernighan
