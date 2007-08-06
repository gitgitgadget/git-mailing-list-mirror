From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name
 HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 11:42:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061134380.14781@racer.site>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 12:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II03x-0000ui-8v
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 12:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbXHFKnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 06:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbXHFKnV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 06:43:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:33434 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752798AbXHFKnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 06:43:20 -0400
Received: (qmail invoked by alias); 06 Aug 2007 10:43:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 06 Aug 2007 12:43:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+b624NqHubNwvI+bt1zTdcKWCyTWrNKzKUEOJfYf
	zZaOTUCQ3EU+hY
X-X-Sender: gene099@racer.site
In-Reply-To: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55139>

Hi,

On Mon, 6 Aug 2007, Dmitry Kakurin wrote:

> environment.c caches results of many getenv calls. Under MinGW setenv(X) 
> invalidates all previous values returned by getenv(X) so cached values 
> become dangling pointers.
> 
> Added cache-aware function set_git_dir to complement get_git_dir

The real problem here: mingw.git did not merge with upstream git.git in a 
long time (mainly because its maintainer is on holiday).  In the meantime, 
set_git_dir() is already there!

I had more problems than I thought with setting up a fork of mingw.git.  
It seems that the relative alternates path to mingw.git is followed, but 
not that one from mingw.git to git.git.  So I could upload, but not fetch.

So I propose to use http://repo.or.cz/w/git/mingw4msysgit.git/ in the 
meantime.  (Just give me your account name, and you'll be able to push to 
it.)

BTW your patch was white-space mangled.

Ciao,
Dscho
