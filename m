From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 16:28:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712041625530.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site> <20071204140326.14d9e7a0@pc09.procura.nl>
 <Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl>
 <47556EE2.6040105@op5.se> <20071204152240.6cb6018e@pc09.procura.nl>
 <Pine.LNX.4.64.0712041536180.27959@racer.site> <20071204155655.053f4fb4@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 17:29:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzaeH-0001rq-CG
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 17:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXLDQ3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 11:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbXLDQ3I
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 11:29:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:55015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbXLDQ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 11:29:05 -0500
Received: (qmail invoked by alias); 04 Dec 2007 16:29:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 04 Dec 2007 17:29:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H4jltBSfHhrMx64fliUi+2Xhw1r3VHM9ERJLDLA
	2jVWOY0v+afUL0
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204155655.053f4fb4@pc09.procura.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67064>

Hi,

On Tue, 4 Dec 2007, H.Merijn Brand wrote:

> I found it! unset returns false

Oh, wow!  The question is now: how to deal with it (there are quite a few 
unsets in the test scripts).

Is there a way to override "unset" with something like this:

	unset_real () {
		unset "$@"
	}

	unset () {
		unset_real "$@"
		true
	}

?

Ciao,
Dscho
