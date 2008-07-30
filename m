From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Glean libexec path from argv[0] for git-upload-pack and
    git-receive-pack.
Date: Wed, 30 Jul 2008 20:21:47 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807302020300.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1217417238-26731-1-git-send-email-shaslam@lastminute.com> <alpine.LSU.1.00.0807301650060.3486@wbgn129.biozentrum.uni-wuerzburg.de> <48909396.3080500@lastminute.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOGK5-0003vI-Me
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 20:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbYG3SVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753737AbYG3SVv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 14:21:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:55519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753610AbYG3SVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 14:21:50 -0400
Received: (qmail invoked by alias); 30 Jul 2008 18:21:48 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 30 Jul 2008 20:21:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FKTdAS4fFwTDhsCH1U0lF8zA8cZMnq3drxaqE14
	TikWGbLgdrl1wk
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <48909396.3080500@lastminute.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90825>

Hi,

On Wed, 30 Jul 2008, Steve Haslam wrote:

> I think that once git-upload-pack.c et al get the argv[0] path over to 
> setup_path() then there's nothing more to do; setup_path() already uses 
> argv0_path in its list of paths to try. I'm confused to the reference to 
> PATH, though: we're avoiding the PATH environment variable completely.

There is an issue in setting up the argv0_path when Git is called as "git" 
and resolved via the PATH: argv[0] then is literally "git".

And we need argv0_path for other things than just calling programs: 
relative etc/gitconfig and libexecdir.

Ciao,
Dscho
