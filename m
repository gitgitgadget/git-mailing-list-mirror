From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Mon, 9 Jun 2008 22:34:25 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806092232480.1783@racer>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0806092133260.1783@racer> <484D984F.20700@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5p2y-00083a-TJ
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbYFIVfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759884AbYFIVfq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:35:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757503AbYFIVfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:35:45 -0400
Received: (qmail invoked by alias); 09 Jun 2008 21:35:42 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 09 Jun 2008 23:35:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193fcFgZZp3+Uk2VBn4RzTk6D7iBbdYZtgH0NUVBP
	vHf04TR4PGVlsY
X-X-Sender: gene099@racer
In-Reply-To: <484D984F.20700@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84434>

Hi,

On Mon, 9 Jun 2008, Paolo Bonzini wrote:

> > Junio, this could be a backend for the zucchini instruction, by just
> >  zucchini <n>  =>  git-squash "HEAD~$(expr $n + 1)"    ;-) 
> 
> ... zucchini becomes
> 
>   git reset --hard HEAD~$(expr $n)
>   git merge --no-ff --squash HEAD@{1}

Except that zucchini is meant for the sequencer, which can implement it 
much more efficiently (i.e. it does not have to check out HEAD~$n).  Also, 
it must not rely on reflogs being enabled.

sequencer is plumbing, while the reset mantra is porcelain.

Ciao,
Dscho
