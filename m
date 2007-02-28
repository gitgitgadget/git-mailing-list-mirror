From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 19:06:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281903470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702281526270.15314@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.63.0702281643200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E5B7B4.9080605@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
X-From: git-owner@vger.kernel.org Wed Feb 28 19:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMTCC-000467-EL
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 19:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXB1SGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 13:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbXB1SGa
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 13:06:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:36494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751349AbXB1SG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 13:06:29 -0500
Received: (qmail invoked by alias); 28 Feb 2007 18:06:28 -0000
X-Provags-ID: V01U2FsdGVkX1/0smx505/00gmaU8ISl/E6TldqsjlITcFxM0bGR9
	1HrA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E5B7B4.9080605@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40979>

Hi,

On Wed, 28 Feb 2007, Paolo Bonzini wrote:

> 
> > I don't think that you should be forced to do it explicitely. If you 
> > want to merge in another branch, you can do that _explicitely_. So, 
> > defaulting to what most people want anyway is A Good Thing.
> 
> Here is a prototype patch to implement this functionality.  One problem 
> is that config.c does not remove cleaned sections, so after "git-branch 
> -d mybranch" one is left with a useless "[branch "mybranch"]" section in 
> .git/config.  Other than this, it seems to work well in my experiments.

I'd rather remove the complete section (However, that means that you have 
to introduce a function to do that in config.c) instead of unsetting 
several hardcoded values.

Also, the second part of your patch would be clearer (methinks) if you 
replaced the call to get_sha1() with dwim_ref(). You'd get the real 
refname for free...

Ciao,
Dscho
