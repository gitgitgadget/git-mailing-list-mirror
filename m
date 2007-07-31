From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: git-svn and distributed git
Date: Tue, 31 Jul 2007 15:31:53 +0300
Message-ID: <52536EC3-C82C-4919-979A-9DE63BEF8C8C@pp.inet.fi>
References: <65B05BC3-2BC2-4451-87C2-940113C55287@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 14:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFr9k-0006PD-DZ
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 14:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489AbXGaMsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 08:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757260AbXGaMsx
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 08:48:53 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:46387 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489AbXGaMsw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 08:48:52 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JM100I87NIERZ20@hyatt.suomi.net> for
 git@vger.kernel.org; Tue, 31 Jul 2007 15:47:02 +0300 (EEST)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JM100MD1NLBJM20@mailstore.suomi.net> for git@vger.kernel.org;
 Tue, 31 Jul 2007 15:48:48 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam1.suomi.net (Postfix) with ESMTP id B374923BB0D	for
 <git@vger.kernel.org>; Tue, 31 Jul 2007 15:32:28 +0300 (EEST)
In-reply-to: <65B05BC3-2BC2-4451-87C2-940113C55287@pp.inet.fi>
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 5, autolearn=not spam, BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54348>

On Jul 31, 2007, at 12:42, V=E4in=F6 J=E4rvel=E4 wrote:

> I have thought about using two branches on the server, master, =20
> which will only include commits already processed through git-svn, =20
> and dev, which is used to pull the "local" changes to be committed =20
> to Subversion. But my inexperience with git got me here, and I =20
> can't seem to be able to get any updates from the other branch. And =20
> I'm not even sure if this is the right approach to this problem.

I got the branched situation to work. I was just pushing and pulling =20
wrong when it didn't work. I guess I didn't understand the =20
documentation well enough to fiddle around with remotes.

I got the branching to work with simple commands:
server$ git push origin dev
laptop$ git pull server dev
laptop$ git-svn dcommit && git push server && git branch -r -d dev
server$ git checkout master && git pull origin && git branch -D dev

But that's a lot of commands, am I still missing something with the =20
branching?


Regards,
V=E4in=F6