From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Sun, 20 Nov 2005 19:29:43 +0100
Message-ID: <20051120182943.GG8383MdfPADPa@greensroom.kotnet.org>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 19:30:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edtwo-0002HI-L2
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 19:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVKTS3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVKTS3w
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 13:29:52 -0500
Received: from smtp19.wxs.nl ([195.121.247.10]:64391 "EHLO smtp19.wxs.nl")
	by vger.kernel.org with ESMTP id S1750888AbVKTS3v (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 13:29:51 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IQ9009PUNDJB8@smtp19.wxs.nl> for git@vger.kernel.org; Sun,
 20 Nov 2005 19:29:43 +0100 (CET)
Received: (qmail 22112 invoked by uid 500); Sun, 20 Nov 2005 18:29:43 +0000
In-reply-to: <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Mail-followup-to: Linus Torvalds <torvalds@osdl.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12393>

On Sun, Nov 20, 2005 at 10:09:50AM -0800, Linus Torvalds wrote:
> and that would result in a parse of
> 
> 	core.values.fixed = true
> 	core.values.nested = fine
> 	core.values.example.test = Hell yes
> 	core.other.example = strange
> 	core.name = hi
> 	secontion.example = yet another
> 

[..]

> I dunno. That seems a nice extension, and it would make these things 
> very unambiguous. But how do other .ini-file-like things do this?

Not sure if this falls in the ".ini-file-like" category, but
YAML (www.yaml.org) does nesting based on indentation.
Your example would look like

core:
  values:
    fixed: true
    nested: fine
    example:
      test: Hell yes
  other:
    example: strange
  name: hi
secontion:
  example: yet another

or

core:
  values: { fixed: true, nested: fine, example: { test: Hell yes } }
  other: { example: strange }
  name: hi
secontion: { example: 'yet another' }

skimo
