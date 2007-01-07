From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: i18n, alternative solution
Date: Sun, 7 Jan 2007 17:55:33 +0100
Organization: Dewire
Message-ID: <200701071755.34496.robin.rosenberg.lists@dewire.com>
References: <200701011547.48697.robin.rosenberg.lists@dewire.com> <7vy7om7cs0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 17:51:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3bFU-0000P0-HZ
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 17:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbXAGQvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 7 Jan 2007 11:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbXAGQvx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 11:51:53 -0500
Received: from [83.140.172.130] ([83.140.172.130]:17300 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932612AbXAGQvw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 11:51:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9122B8030D3;
	Sun,  7 Jan 2007 17:47:32 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14941-07; Sun,  7 Jan 2007 17:47:32 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3DF308030CF;
	Sun,  7 Jan 2007 17:47:30 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vy7om7cs0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36177>

m=E5ndag 01 januari 2007 20:44 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> > What disturbes me is the complexity that the approach of storing mu=
ltiple
> > encodings in the same repository results in.
>
> We are not encouraging mixed encodings, mind you.
>
> Even though we check and warn comits that do not have a valid
> UTF-8 string, the users can make mistakes and people need be
> able to look at them later.  That is what we are solving.

My is to not convert at all if the uset  has locale=3DUTF-8. Mostly it'=
s an
optimization, but it also has the effect of getting the raw message.

> At the same time we do NOT force inconvenience on projects that
> want to use legacy encoding for whatever reason.  The world is
> not UTF-8 only, and encoding to UTF-8 is non-reversible a times=20
> (positive return value from iconv(3)).  Always re-coding to
> UTF-8 will NOT be accepted to git for now.  We can revisit this
> perhaps in 5 years.

According to the unicode FAQ, unicode is a superset of all local=20
encodings, so why would the conversion be non-reversible for local=20
vs utf-8?

In five years there will be so much legacy, that fixing it in a simple =
way=20
will be unfeasble (just like CVS,  FTP, etc).

-- robin
