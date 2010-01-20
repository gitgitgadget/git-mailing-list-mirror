From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 23:58:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
References: <20100120050343.GA12860@gnu.kitenet.net> <201001201148.11701.johan@herland.net> <20100120182438.GB31507@gnu.kitenet.net> <7vhbqg376b.fsf@alter.siamese.dyndns.org> <20100120195626.GA6641@gnu.kitenet.net> <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net> <7veilk1o3s.fsf@alter.siamese.dyndns.org> <7v3a201lpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 23:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXjPX-0000Xo-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 23:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0ATWwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791Ab0ATWwV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 17:52:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:45039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754786Ab0ATWwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 17:52:21 -0500
Received: (qmail invoked by alias); 20 Jan 2010 22:52:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 20 Jan 2010 23:52:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0ogVCntG0qufQhjnrYgb73/Se4wGaQhl/16sIyw
	u6ADNN/MsBAZaB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3a201lpz.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137597>

Hi,

On Wed, 20 Jan 2010, Junio C Hamano wrote:

> Subject: Fix "log" family not to be too agressive about showing notes
> 
> Giving "Notes" information in the default output format of "log" and
> "show" is a sensible progress (the user has asked for it by having the
> notes), but for some commands (e.g. "format-patch") spewing notes into the
> formatted commit log message without being asked is too aggressive.
> 
> Enable notes output only for "log", "show", "whatchanged" by default;
> other users can ask for it by setting show_notes field to true.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Makes sense, and the patch actually removes what could be seen as an ugly 
side effect (why it only ONELINE not getting notes?).

I would agree with Peff about the mention of --pretty disabling notes 
(unless asked for by a user format) in the commit notes as well as in the 
pretty options, but I fully disagree on the need for tests.  We should not 
have a thorough test suite that runs for days on end, but we should 
concentrate on things that are more likely to get broken.  And the added 
code is just too obvious for that.

(Anybody remember the initial suggestion for testing git-commit before 
making it builtin?  It had something like 70 tests.)

Ciao,
Dscho
