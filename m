From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 18:12:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071811060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <20070207170122.GB18704@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-939614238-1170868332=:22628"
Cc: Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqLd-0007MW-6C
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbXBGRMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965689AbXBGRMP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:12:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:50785 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965688AbXBGRMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:12:14 -0500
Received: (qmail invoked by alias); 07 Feb 2007 17:12:12 -0000
X-Provags-ID: V01U2FsdGVkX1/HieRRO2zHeW979UWqSZpQYtvNfv6dyiP3yMpoE1
	H5OA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070207170122.GB18704@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38944>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-939614238-1170868332=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Feb 2007, Uwe Kleine-König wrote:

> Don Zickus wrote:
> > I was curious to know what is the easiest way to filter info inside a
> > commit message.
> > 
> > For example say I wanted to find out what patches Joe User has
> > submitted to the git project.
> > I know I can do something like ' git log |grep -B2 "^Author: Joe User"
> What about
> 
> 	git log --author="Joe User"
> 
> > ' and it will output the matches and the commit id.  However, if I
> > wanted to filter on something like "Signed-off-by: Joe User", then it
> > is a little harder to dig for the commit id.
> > 
> > Is there a better way of doing this?  Or should I accept the fact that
> > git wasn't designed to filter info like this very quickly?
> > 
> > I guess what I was looking to do was embed some metadata inside the
> > commit message and parse through it at a later time (ie like a
> > bugzilla number or something).
> > 
> > Any thoughts/tips/tricks would be helpful.
> 
> Maybe:
> 
> 	git log | awk -v sob="Joe User" '$1 == "commit" {commit = $2} /Signed-off-by:/ {if (match($0, sob)) print commit}'

*grin* Why do you know --author, but not --grep?

git log --grep=Signed-off-by:\ Joe\ User

Ciao,
Dscho

---1148973799-939614238-1170868332=:22628--
