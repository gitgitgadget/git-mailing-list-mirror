From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] --decorate now decorates ancestors, too
Date: Sat, 21 Jul 2007 23:26:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707212322260.14781@racer.site>
References: <Pine.LNX.4.64.0707110220340.4047@racer.site>
 <Pine.LNX.4.64.0707110229320.4047@racer.site> <20070711022714.GI27033@thunk.org>
 <7vmyy1tq96.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 00:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICNPz-0005HE-Kq
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 00:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbXGUW04 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbXGUW0z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 18:26:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:55497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751855AbXGUW0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 18:26:54 -0400
Received: (qmail invoked by alias); 21 Jul 2007 22:26:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 22 Jul 2007 00:26:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qIZlr+75qcc/qTYVYJki0MIqJiIJG2issRTIe85
	wW9c8XLyFc2lvR
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyy1tq96.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53192>

Hi,

On Thu, 12 Jul 2007, Junio C Hamano wrote:

> But in general I do not see ("I haven't realized" might turn out to be a 
> better expression) much value in this series yet except for the initial 
> clean-up patches, while I think this option would be quite expensive in 
> terms of memory footprints on projects with nontrivial size of history.  
> I dunno.

It would not, since you do not have to say "--decorate" at all.  However, 
if you do want the functionality this patch provides, you have to jump 
through hoops right now.  ATM an alias is my work around, since I run 
'master' as you requested:

git config --global alias.decoratelog '!sh -c
	"(case \"\$0\" in
		sh) git log --color;;
		*) git log --color \"\$0\" \"\$@\";;
	 esac) |
	 git -p name-rev --tags --stdin"'

Ugly, ain't it?

And I still have to look up at which release certain features were 
introduced every day.

Ciao,
Dscho
