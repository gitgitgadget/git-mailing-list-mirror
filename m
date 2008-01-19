From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push and http-fetch: handle URLs without leading
 /
Date: Sat, 19 Jan 2008 23:16:00 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192315260.5731@racer.site>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org> <1200756171-11696-2-git-send-email-gb@gbarbier.org> <1200756171-11696-3-git-send-email-gb@gbarbier.org> <1200756171-11696-4-git-send-email-gb@gbarbier.org>
 <20080119152947.GA26553@glandium.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1646808368-1200784561=:5731"
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMva-0006Hv-TO
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYASXQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYASXQN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:16:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:41649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbYASXQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:16:12 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:16:10 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp003) with SMTP; 20 Jan 2008 00:16:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mAfJ6YZfmqeFsxjgNLtDqIqJEHRIxlcOM9v/2Oy
	9H/SvL2QBIxrjw
X-X-Sender: gene099@racer.site
In-Reply-To: <20080119152947.GA26553@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71141>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1646808368-1200784561=:5731
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Jan 2008, Mike Hommey wrote:

> On Sat, Jan 19, 2008 at 04:22:50PM +0100, Grégoire Barbier wrote:
> > Since HTTP/302 is not handled in the git code calling curl, URLs 
> > without leading / used to lead to frozen git-fetch or git-push with no 
> > error message.
> > 
> > Furthermore, http-push freeze forces the user to interrupt it (^C) and 
> > therefore to leave a dandling webdav lock that makes the remote 
> > repository un-pushable for 10 minutes.
> > 
> > The patch does not make curl calls handle HTTP/302 but instead adds a 
> > / at the end of URLs that does not have it yet.
> 
> Actually, it would be much better to do just that, i.e. handle HTTP 302 
> return codes. I suspect there may be other cases leading to similar dead 
> locks with other HTTP codes. But that might just be easier to deal with 
> once my refactoring will be done ;)

Independently, it seems a good idea to not try a URL we _know_ will fail 
(read: redirect).

Ciao,
Dscho

---1463811741-1646808368-1200784561=:5731--
