From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: core.autocrlf considered half-assed
Date: Mon, 8 Mar 2010 12:29:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003081225280.14277@intel-tinevez-2-302>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de> <20100307092701.GC31105@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 12:29:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nob9B-0007pQ-Vj
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 12:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab0CHL3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 06:29:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:43430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754140Ab0CHL3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 06:29:11 -0500
Received: (qmail invoked by alias); 08 Mar 2010 11:29:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp025) with SMTP; 08 Mar 2010 12:29:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cL7oF6NxcD8y6uf56RO7NikwSLIlBVYySGMLeWO
	42sNAnzu2+pRj/
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20100307092701.GC31105@dpotapov.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.60999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141760>

Hi,

On Sun, 7 Mar 2010, Dmitry Potapov wrote:

> On Sat, Mar 06, 2010 at 12:23:33AM +0100, Johannes Schindelin wrote:
> 
> > Just try to "git reset --hard" or "git stash" when there are files 
> > with DOS line endings and when core.autocrlf is not false.
> 
> I did, and I have not noticed any problem with that.
> 
> git init
> git config core.autocrlf true
> echo foo^ | tr ^ '\r' > foo
> git add foo
> git commit -m 'add foo'

Unfortunately, this is not the common case. The common case is that 
somebody committed _without_ autocrlf (implicitly =false), and you clone 
from there.

Easiest example:

$ git clone -n git://repo.or.cz/git.git html-docs
$ cd html-docs/
$ git config core.autocrlf true
$ git checkout -t origin/html
$ git status

... and despair.

Hth,
Dscho
