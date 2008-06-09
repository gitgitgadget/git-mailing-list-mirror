From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 9 Jun 2008 02:02:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090201090.1783@racer>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com> <alpine.DEB.1.00.0806090033030.1783@racer> <484C73DA.10804@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 03:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Vom-0007HH-Dz
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 03:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbYFIBDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 21:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754236AbYFIBDn
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 21:03:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:51972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752873AbYFIBDn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 21:03:43 -0400
Received: (qmail invoked by alias); 09 Jun 2008 01:03:41 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 09 Jun 2008 03:03:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gSgh18LVgpjABCzQgNE6wIzywdDlM+a0kSpFNEi
	EVdCDwAd+rlKLa
X-X-Sender: gene099@racer
In-Reply-To: <484C73DA.10804@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84355>

Hi,

On Mon, 9 Jun 2008, Lea Wiemann wrote:

> Johannes Schindelin wrote:
> > Lea Wiemann wrote:
> > > -	if (type <= 0)
> > > -		return 1;
> > > +	if (type <= 0) {
> > > +		printf("%s missing\n", obj_name);
> > > +		fflush(stdout);
> > > +		return 0;
> > > +	}
> > 
> > Is it really intended that it returns 0 now?
> 
> Yes, return 0 causes it to not exit (which is the desired effect, as in
> documented).

That is unexpected.  IMO this is a bug.  rev-parse I can understand, but 
cat-file not failing when it clearly did not find the object?

Ciao,
Dscho
