From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: warn non utf-8 commit log messages.
Date: Sun, 24 Dec 2006 00:46:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612240043510.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061222221913.GA3071@cepheus> <Pine.LNX.4.63.0612222331581.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0612230048350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfyb6qth6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 00:47:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyGa2-0007HQ-NZ
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 00:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbWLWXrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 18:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbWLWXrA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 18:47:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:51992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753935AbWLWXrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 18:47:00 -0500
Received: (qmail invoked by alias); 23 Dec 2006 23:46:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 24 Dec 2006 00:46:57 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyb6qth6.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35333>

Hi,

On Sat, 23 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> But I had enough of UTF-8 for a day.
> >
> > Okay, so I lied (this are both patches revised and combined):
> 
> I am thinking of putting this in 'next', with the following
> changes on top of your combined patch.
> 
> git-commit-tree warns if the commit message does not minimally
> conform to the UTF-8 encoding when i18n.commitencoding is either
> unset, or set to "utf-8".  It does not die as in your version.

Yeah, this is nicer.

> -			if (w < width || space < 0) {
> +			if (w < width || !space) {

This is a real bug fix. Thank you. I changed quite a bit between offset 
and char*, and eventually forgot this part.

Ciao,
Dscho
