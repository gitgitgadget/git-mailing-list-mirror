From: Stephen Fisher <sfisher@SDF.ORG>
Subject: Re: Git's configure script --mandir doesn't work
Date: Wed, 10 Dec 2014 12:41:50 -0700
Message-ID: <20141210194150.GA28190@SDF.ORG>
References: <20141204232532.GB14036@SDF.ORG>
 <20141205093619.GE32112@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 20:42:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyn9O-0007Uu-DF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 20:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932866AbaLJTmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 14:42:12 -0500
Received: from mx.sdf.org ([192.94.73.24]:55577 "EHLO sdf.lonestar.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932319AbaLJTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 14:42:10 -0500
Received: from sdf.org (IDENT:sfisher@otaku.freeshell.org [192.94.73.9])
	by sdf.lonestar.org (8.14.8/8.14.5) with ESMTP id sBAJfoGP017147
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
	Wed, 10 Dec 2014 19:41:50 GMT
Received: (from sfisher@localhost)
	by sdf.org (8.14.8/8.12.8/Submit) id sBAJfo6A016878;
	Wed, 10 Dec 2014 12:41:50 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <20141205093619.GE32112@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261240>

On Fri, Dec 05, 2014 at 04:36:20AM -0500, Jeff King wrote:
> On Thu, Dec 04, 2014 at 04:25:32PM -0700, Stephen Fisher wrote:
> 
> > I'm installing Git 2.2.0 from source distribution on NetBSD 6.1.5 
> > (amd64) and when I specify --mandir=/usr/local/man, it still 
> > installs man pages in the default /usr/local/share/man directory.  
> > Is there a fix available for this?
> 
> It works fine for me here (Debian):

> Can you elaborate on the commands you're running? After running the 
> configure script, can you confirm that "mandir" is set appropriately 
> in config.mak.autogen?

Thanks for your reply and sorry for my delay in responding.

I'm executing ./configure --mandir=/usr/local/man --disable-pthreads 
then gmake and gmake install.  I'm using gmake (GNU make) because I get 
Makefile errors with the regular BSD make, but that's another issue.  
I'm disabling pthreads because there is a linking error for undefined 
references to a few functions (I probably need to pass -lpthread in 
LDFLAGS, but haven't tried that yet).

mandir is properly set in config.mak.autogen.

When I set prefix to /tmp/foo and mandir to /tmp/bar like your example, 
it installs things into /tmp/foo, but /tmp/bar isn't even created.

I noticed text files in Documentation/ that look like the content of man 
pages, and when I run gmake in that directory, I get an error about 
asciidoc missing to make an HTML file.  Is asciidoc required for the man 
pages as well?  I don't see any files that appear to be man page format 
other than in perl/blib/man3 and those are installed (but not under the 
mandir prefix, rather the default /usr/local/share/man prefix).
