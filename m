From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 13:13:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705181312060.3890@woody.linux-foundation.org>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz>
 <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
 <20070518190159.GS24644@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Fri May 18 22:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp8rX-0004Lx-9R
	for gcvg-git@gmane.org; Fri, 18 May 2007 22:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbXERUPh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbXERUPh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 16:15:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46791 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752100AbXERUPg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 16:15:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4IKDbwj007993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 13:14:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4IKDaRG022721;
	Fri, 18 May 2007 13:13:37 -0700
In-Reply-To: <20070518190159.GS24644@ca-server1.us.oracle.com>
X-Spam-Status: No, hits=-2.84 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47657>



On Fri, 18 May 2007, Joel Becker wrote:
> 
> 	It's not about packet scanning, it's about GET vs CONNECT.  If
> the proxy allows GET but not CONNECT, it's going to forward the HTTP
> protocol to the server, and git-daemon is going to see "GET /project
> HTTP/1.1" as its first input.  Now, perhaps we can cook that up behind
> some apache so that apache handles vhosting the URL, then calls
> git-daemon which can take the stdin.  So we'd be doing POST, not GET.

If it's _just_ the initial GET/CONNECT strings, yeah, we could probably 
easily make the git-daemon just ignore them. That shouldn't be a problem.

But if there's anything *else* required, it gets uglier much more quickly.

		Linus
