From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the command
 invocation
Date: Mon, 14 Jul 2008 13:20:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141319420.8950@racer>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at> <alpine.DEB.1.00.0807132141130.8950@racer> <1216018557.487af87d7bd28@webmail.eunet.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:21:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIN3j-0003WF-US
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbYGNMUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYGNMUl
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:20:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:35554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbYGNMUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:20:41 -0400
Received: (qmail invoked by alias); 14 Jul 2008 12:20:39 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp026) with SMTP; 14 Jul 2008 14:20:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F8sxyoopFaukilo6yd7tMJ+PPmeE8ukKQRk6JuY
	L5Ed6oyVEcv2ib
X-X-Sender: gene099@racer
In-Reply-To: <1216018557.487af87d7bd28@webmail.eunet.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88420>

Hi,

On Mon, 14 Jul 2008, Johannes Sixt wrote:

> Zitat von Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > On Sun, 13 Jul 2008, Johannes Sixt wrote:
> >
> > > @@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char
> > > *path)
> > >  	}
> > >  }
> > >
> > > -void setup_path(const char *cmd_path)
> > > +void setup_path(void)
> >
> > It seems to me that this patch would not do anything different, but 
> > with less code change, if setup_path() would set argv0_path, and not a 
> > new function was introduced.
> 
> This is just to play a safe game. I had it that way, but I decided to have
> the call to the new git_set_argv0_path() early in git.c because the call
> to setup_path() in git.c is very late, and it could happen that we call
> system_path() (which needs argv0_path) before that. Although I didn't audit
> the code whether this really happens.

Well, okay... I would have rather seen it not change (since there was no 
bug to fix), or as a separate patch, but it's Junio's call.

Ciao,
Dscho
