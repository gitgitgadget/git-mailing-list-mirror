From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save
 author information
Date: Mon, 22 Jun 2009 11:19:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906221117270.4168@intel-tinevez-2-302>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <alpine.DEB.1.00.0906212354030.26154@pacific.mpi-cbg.de> <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 11:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIfh4-00078a-0d
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 11:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZFVJTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 05:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbZFVJTv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 05:19:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:40918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751660AbZFVJTu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 05:19:50 -0400
Received: (qmail invoked by alias); 22 Jun 2009 09:19:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 22 Jun 2009 11:19:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192G9ctQsl2l9lImn48aF2O/Vzyv683hR+Sls0Ze2
	pis1y2m4iNMtlW
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122021>

Hi,

On Sun, 21 Jun 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 20 Jun 2009, Christian Couder wrote:
> >
> >> This is better than saving in a shell script, because it will make
> >> it much easier to port "rebase -i" to C. This also removes some sed
> >> regexps and some "eval"s.
> >
> > It will not make it easier to port "rebase -i" to C, as this is an 
> > internal file.  The user is not supposed to touch it at all.  Only "rebase 
> > -i".  So it would be very easy to just use a different on-disk format when 
> > turning "rebase -i" into a builtin.
> 
> "This is an internal file" is just a declaration you are making, and the
> file is observable by anybody after "rebase -i" relinquishes the control
> to let the user sort out the mess.

It is an observation I am making.  Sure, the file is observable by the 
user.  But it is hidden deep inside .git/ and users who change things 
inside .git/ (with the exception of config) are asking for trouble.

I really do not see the point of changing the file format _before_ turning 
rebase -i into C.

Oh, and I do not see the point of turning rebase -i into C before finally 
polishing sequencer so it can go into git.git's master.

Ciao,
Dscho
