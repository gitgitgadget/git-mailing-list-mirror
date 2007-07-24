From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: http git clone memory problem.
Date: Tue, 24 Jul 2007 18:45:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241842270.14781@racer.site>
References: <1621f9fa0707232044j7cec2bes7bc7cd268775ce48@mail.gmail.com> 
 <Pine.LNX.4.64.0707241025450.14781@racer.site> 
 <1621f9fa0707240958y7c5f1b66lbfa940d60c082067@mail.gmail.com>
 <1621f9fa0707241033l7ac53b97i8c8ea068be0cba2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDOSW-0005Gc-5f
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 19:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbXGXRqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 13:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbXGXRqD
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 13:46:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:52705 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753747AbXGXRqB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 13:46:01 -0400
Received: (qmail invoked by alias); 24 Jul 2007 17:46:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 24 Jul 2007 19:46:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX186gVhcl2I6aZyeB5j5e8egyITXONew4eA7oacdP4
	OBys5mw3B2+M8Y
X-X-Sender: gene099@racer.site
In-Reply-To: <1621f9fa0707241033l7ac53b97i8c8ea068be0cba2f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53619>

Hi,

On Tue, 24 Jul 2007, Benjamin Sergeant wrote:

> I still have the segfault with 1.5.2.4. If I try to gdb it, it abort 
> before I can do anything. Is there an environment variable that I can 
> set to disable signal handling or something in git ?

Did you gdb http-fetch?

If not, please use "sh -x git-clone..." to find out what command line to 
use.

And when you have the command line, please use valgrind to find out where 
the leak/corruption is.

There are some flags that are automatically set/unset when compiling the 
http transport, and it is not easy to know which flags are enabled in your 
setup.

But for starters, you might want to recompile http-fetch without -O2.  My 
gdb always has problems attributing the correct line, which does not 
exactly make it easier for me to debug things.  I could imagine your gdb 
is as annoying.

Ciao,
Dscho
