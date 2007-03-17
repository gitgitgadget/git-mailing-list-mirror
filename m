From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] bisecting miscounts revisions left to test
Date: Sat, 17 Mar 2007 01:50:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703170139110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316161421.GA24584@lala>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1913680298-1174092611=:22628"
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 01:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSN7r-0002Aa-CH
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 01:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992480AbXCQAuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 20:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992481AbXCQAuP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 20:50:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:55918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992480AbXCQAuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 20:50:13 -0400
Received: (qmail invoked by alias); 17 Mar 2007 00:50:11 -0000
X-Provags-ID: V01U2FsdGVkX1/hzI8NPkLhECU6t679YeySdC/seCxA4K8jwk27Au
	HJk6y4UbWGsQjR
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070316161421.GA24584@lala>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42413>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1913680298-1174092611=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 16 Mar 2007, Uwe Kleine-König wrote:

> zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
> Bisecting: 2 revisions left to test after this
> [e7b0d26a86943370c04d6833c6edba2a72a6e240] sysfs: reinstate exclusion between method calls and attribute unregistration
> 
> zeisberg@cassiopeia:~/gsrc/linux-2.6$ git bisect good
> Bisecting: 2 revisions left to test after this
> [b810cdfcf91d76f603fd48023aede48ced8e6bed] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6

The problem is that after the first git-bisect good, it looks like this:

g1 - b2 - b1 - M - B
             /
     g2 - b3

where both g1 and g2 are good, and B is bad. The bisection point is b1. 
(Which makes sense, absolutely.)

After the second git-bisect good, it looks like this:

     g3 - M - B
        /
g2 - b3

and the bisection point is M.

Your problem, of course, is that it is not possible to pick a commit 
_exactly_ in the middle. So, the number is just an _expected_ number of 
revisions to test. I am not sure if it is necessary to make this clearer, 
though, as I fully expect that you just said "What the heck" and continued 
bisecting just fine.

Ciao,
Dscho

P.S.: if Momo's turtle thinks that your name contains no non-ASCIIs, why 
should I?

---1148973799-1913680298-1174092611=:22628--
