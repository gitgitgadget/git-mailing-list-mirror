From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: Submodules implementation
Date: Wed, 24 Feb 2010 01:15:53 +0100
Message-ID: <201002240115.53771.bartoschek@gmx.de>
References: <k76e57-g67.ln1@burns.bruehl.pontohonk.de> <32541b131002231559r49fc31e0i4ce46869d27190c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 01:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4v0-0006pH-Ci
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 01:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab0BXAPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 19:15:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:55951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754402Ab0BXAPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 19:15:52 -0500
Received: (qmail invoked by alias); 24 Feb 2010 00:15:51 -0000
Received: from p54BACD4F.dip.t-dialin.net (EHLO homer.localnet) [84.186.205.79]
  by mail.gmx.net (mp064) with SMTP; 24 Feb 2010 01:15:51 +0100
X-Authenticated: #1174187
X-Provags-ID: V01U2FsdGVkX18MvnB/QogMWjYOKRzw1dWnH6Lkc5Tg13p0z0Zix3
	TfYDt9lnJ9OKMC
User-Agent: KMail/1.12.4 (Linux/2.6.31.12-0.1-desktop; KDE/4.3.5; x86_64; ; )
In-Reply-To: <32541b131002231559r49fc31e0i4ce46869d27190c8@mail.gmail.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140880>

Am Mittwoch 24 Februar 2010 schrieb Avery Pennarun:

> The data format itself implements submodules as simply pointers to
> commits (not trees) located at a particular point in the supermodule.
> This is very elegant and simple.

I see that in the submodule there is a .git directory with its own objects.  
This does not look like as if the submodule objects are part of the 
superproject.

> By comparison, my git-subtree tool
> (http://github.com/apenwarr/git-subtree) is the opposite: its data
> storage format isn't very elegant (it just has a tree stored inside
> another tree, as if there were no submodule at all) but its
> implementation makes it easier for end users (since they don't have to
> deal with separate repositories).

This is exaclty how I would expect it. The tree of the submodule has its root 
somewhere in the tree of the superproject. Then there are commits for the 
superproject that point to the root of the whole tree and commits for the 
submodules that point to nodes in the tree.
A combined tree looks much more elegant for me.

I'll take a look at your tool.

Christop
