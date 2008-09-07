From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 16:13:56 +0300
Message-ID: <20080907131356.GC3387@mithlond.arda.local>
References: <20080906193744.GA3122@mithlond.arda.local> <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 15:15:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcK6e-0007CF-Hb
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYIGNN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbYIGNN7
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:13:59 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:52034 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbYIGNN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 09:13:59 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 488F153401D54206; Sun, 7 Sep 2008 16:13:56 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KcK5U-0002fQ-4j; Sun, 07 Sep 2008 16:13:56 +0300
Content-Disposition: inline
In-Reply-To: <d2e97e800809070332t35e4ed46u7af4653ea768b39b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95135>

Michael Wookey wrote (2008-09-07 20:32 +1000):

> If you alter the RunShellCommand() function to the following -

>       if stridx(a:cmdline, "diff") > 0
>           set filetype=diff
>       endif

> Then Vim will apply diff syntax highlighting to the scratch buffer
> when a "diff" command is executed.

Good idea. I implemented the same thing this way:

    if match(a:cmdline,'\v^(git|hg|svn|bzr) diff') >= 0
        setlocal filetype=diff
    endif
