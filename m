From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: regression in  92392b4
Date: Wed, 23 Jul 2008 01:58:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807230152580.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org> <alpine.DEB.1.00.0807230033000.8986@racer> <20080723004108.GB14668@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:59:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLShe-00084S-DZ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbYGWA6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbYGWA6i
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:58:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:52520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751802AbYGWA6i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:58:38 -0400
Received: (qmail invoked by alias); 23 Jul 2008 00:58:36 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 23 Jul 2008 02:58:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18OXb01S0wOTXIfAgqEWrYMvTo151xtBbEBgmbLBV
	inKgOlB6DlYWIi
X-X-Sender: gene099@racer
In-Reply-To: <20080723004108.GB14668@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89583>

Hi,

On Tue, 22 Jul 2008, Shawn O. Pearce wrote:

> Reading above shows we got a "fatal: Out of memory, malloc failed" right 
> before the segfault.  What's odd is we segfaulted after we ran out of 
> memory and should have die'd.
> 
> There's at least two bugs in the above output:
> 
> a) index-pack ran out of memory on a small pull (95 KiB).
> b) fetch segfaulted when index-pack failed.
> 
> And this patch will unfortunately address neither of them.  :-|

Yeah, I thought I had something, but no matter what I tried, I could not 
find a breakage.  Not even valgrind complains.

But as I said: it was just a guess.

Maybe it will be easier to reproduce by patching the code to malloc() 
everything that is available first, and then continuing.

Ciao,
Dscho
