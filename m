From: Gonzalo Garramuno <gga@filmaura.com>
Subject: git update index question
Date: Wed, 17 Oct 2007 07:23:39 -0300
Message-ID: <4715E2AB.4030900@filmaura.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 13:04:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii6h0-0004h2-Jl
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 13:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759248AbXJQLDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759322AbXJQLDv
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 07:03:51 -0400
Received: from an.site5.com ([74.53.3.196]:40533 "EHLO an.site5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759067AbXJQLDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 07:03:50 -0400
X-Greylist: delayed 2419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2007 07:03:50 EDT
Received: from [201.255.33.200] (helo=[192.168.1.3])
	by an.site5.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <gga@filmaura.com>)
	id 1Ii63h-0005ro-Qn
	for git@vger.kernel.org; Wed, 17 Oct 2007 05:23:26 -0500
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - an.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - filmaura.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61366>

Hi.  I'm new to git but have been using it successfully for about three=
=20
months now and love it.

I've run into my first problem (or, more specifically) lack of=20
understanding.

I'm currently working on linux.

After some modifications of my source code with a script and doing a=20
commit with qgit, it seems some spaces at the end of those changed line=
s=20
got added.

Now, whenever I try to do a commit, the result is that git aborts with
* trailing whitespace (line XXX).
That is, it fails due to git's pre-commit perl hook.

Now, I've modified and changed the offending lines, but redoing the=20
commit the problem persists.

After loooking into it, I realized the issue is git's index file.  If=20
git-diff-index is called without --cached, the diff matches what's on=20
disk and works as I expect.  However, the pre-commit hook calls it with=
=20
--cached which leads to the problem.

Thus, since I don't want to modify the pre-commit hook, the question is=
=20
what's the proper way to rebuild git's index file for all the files tha=
t=20
were to be committed but weren't due to the abort.

I've tried git-update-index with most of the flags with no success.  I=20
only got it to update the index properly when I specifically specified =
a=20
filename with the problem, but I have a lot of files with the issue and=
=20
git already knows about them so I was hoping for a better method.






--=20
Gonzalo Garramu=F1o

=46ilm Aura
A New Dawn in Media Companies

gga@filmaura.com
http://www.filmaura.com
