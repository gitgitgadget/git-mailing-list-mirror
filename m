From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [BUG] gitk fails with argument that is both existing directory and branch name
Date: Tue, 3 Jul 2007 22:23:01 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070703202301.GA24071@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 22:23:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5otz-00062Z-VY
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbXGCUXI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 3 Jul 2007 16:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757872AbXGCUXH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 16:23:07 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33628 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757889AbXGCUXG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 16:23:06 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1I5otr-0003kO-P4
	for git@vger.kernel.org; Tue, 03 Jul 2007 22:23:03 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l63KN1TJ024328
	for <git@vger.kernel.org>; Tue, 3 Jul 2007 22:23:01 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l63KN14V024327
	for git@vger.kernel.org; Tue, 3 Jul 2007 22:23:01 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51532>

Hello,

I have a branch named fixes in my linux repo and until I did:

	git format-patch -o fixes linus/master=20

the following command worked fine:
=09
	gitk ^linus/master fixes

but now that there is a directory named fixes, nothing happens when
running gitk.  With rev-list I get=20

	zeisberg@cassiopeia:~/gsrc/linux-2.6$ git rev-list ^linus/master fixes
	fatal: ambiguous argument 'fixes': both revision and filename
	Use '--' to separate filenames from revisions

but=20
=09
	gitk ^linus/master fixes --

doesn't work either.  I'd suspect that the call to rev-list doesn't see
the "--" and the error is lost somewhere inbetween ...?

I currently have no time to look into it, so for now you only get a
report.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Di+squared
