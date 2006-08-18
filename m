From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Fri, 18 Aug 2006 20:35:46 +0200
Message-ID: <200608182035.47208.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com> <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0608180956100.29405@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 20:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE9CF-0007dx-Fd
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 20:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbWHRSfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 14:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWHRSfv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 14:35:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:53466 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030502AbWHRSfu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 14:35:50 -0400
Received: (qmail invoked by alias); 18 Aug 2006 18:35:49 -0000
Received: from p54969E29.dip0.t-ipconnect.de (EHLO noname) [84.150.158.41]
  by mail.gmx.net (mp035) with SMTP; 18 Aug 2006 20:35:49 +0200
X-Authenticated: #352111
To: David Rientjes <rientjes@google.com>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0608180956100.29405@chino.corp.google.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25688>

On Friday 18 August 2006 19:07, David Rientjes wrote:
> It shouldn't have ever been a perl script, it should have been /bin/sh.  
> Any shell implementation of this would be significantly faster than the 
> current implementation.

Can you explain your reasoning in more detail?
C compiles to native code. Bash itself first has to
parse the script. How on earth can this be faster than native code?

I simply do not understand this discussion about implementation language,
especially in this case where most of the work is probably done changing
git's index (the add's and rm's of tree entries). Of course it could have
been done in /bin/sh, but it wasn't (it started as git-rename.perl).

The portability argument speaks for C, thus I agree with Dscho.

> > 	if (!bad &&
> > 		(length = strlen(source[i])) >= 0 &&
> > 		!strncmp(destination[i], source[i], length) &&
> > 		(destination[i][length] == 0 || destination[i][length] == '/'))
> > 
> > construct. So, we assign the "length" variable only if we have to. And the 
> > ">= 0" trick is a common one. I could have done
> > 		
> 
> This is not a plausible justification _at all_.

Hmm... I suppose Dscho's argument was that this "... >=0" is a standard way
to code an assignment inside of an expression.

Josef
