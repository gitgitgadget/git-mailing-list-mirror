From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Heads up: major rebase -i -p rework coming up
Date: Sun, 25 Jan 2009 21:59:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901252157090.14855@racer>
References: <alpine.DEB.1.00.0901242056070.14855@racer> <200901242347.23187.trast@student.ethz.ch> <alpine.DEB.1.00.0901250303150.14855@racer> <alpine.DEB.1.00.0901250324320.14855@racer> <glhqdi$tec$1@ger.gmane.org> <alpine.DEB.1.00.0901251509550.14855@racer>
 <bd6139dc0901250707m5e1898cdu530a0d7566ca2da5@mail.gmail.com> <alpine.DEB.1.00.0901251622310.14855@racer> <7vwscjceec.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRC5V-0007zS-OB
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 22:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZAYU6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZAYU6t
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:58:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:46271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbZAYU6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:58:49 -0500
Received: (qmail invoked by alias); 25 Jan 2009 20:58:46 -0000
Received: from pD9EB3E0E.dip0.t-ipconnect.de (EHLO noname) [217.235.62.14]
  by mail.gmx.net (mp004) with SMTP; 25 Jan 2009 21:58:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19N/u0+nWhNElCqOj4fphKcgxsPQpjQXVM2zxHS3m
	sJOKP9IDoC6nj8
X-X-Sender: gene099@racer
In-Reply-To: <7vwscjceec.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107102>

Hi,

On Sun, 25 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So maybe I answered my question myself:
> >
> > 	merge parents $sha1 [$sha1...] original $sha1 $msg
> 
> When you are reparenting, how would original commit get in the picture?
> You wouldn't want the resulting merge to claim it merged X (which would be
> what's in original's commit log) when in fact it now merged Y because the
> user reparented it, would you?

Oh yes, I would!  Example:


	A - B - C
	  /
	X - Y

If I merged X into B by accident, but actually meant to merge Y, then C' 
should still come after B', no?

Ciao,
Dscho
