From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] git-bundle: various fixups
Date: Tue, 6 Mar 2007 03:13:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060310120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk5xvw6mg.fsf@assigned-by-dhcp.cox.net> <7vtzwzurss.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 03:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOPBS-0002bN-SI
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 03:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933850AbXCFCNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 21:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933852AbXCFCNo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 21:13:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:51428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933850AbXCFCNn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 21:13:43 -0500
Received: (qmail invoked by alias); 06 Mar 2007 02:13:42 -0000
X-Provags-ID: V01U2FsdGVkX1/3ImITrTL3vjwSSXWDoX5Kq6jwM5/ybtqefwuI8j
	n/2lundJnNOyEo
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vtzwzurss.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41528>

Hi,

On Mon, 5 Mar 2007, Junio C Hamano wrote:

> verify_bundle() returned with an error early only when all
> prerequisite commits were missing.  It should error out much
> earlier when some are missing.

The idea was to list _all_ missing prerequisites so that git-bundle will 
not complain _again_, about different missing prerequisites, when the 
first set of missing prerequisites was obtained.

The check only prevented looking for _reachable_ commits, when none of the 
prerequisites were found in the object database to begin with.

> When the rev-list is limited in ways other than revision range (e.g. 
> --max-count or --max-age), create_bundle() listed all positive refs 
> given from the command line as if they are available, but resulting pack 
> may not have some of them.  Add a logic to make sure all of them are 
> included, and error out otherwise.

Good catch!

Ciao,
Dscho
