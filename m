From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin clone: support bundles
Date: Sun, 2 Mar 2008 17:34:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803021731400.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org> <alpine.LSU.1.00.0803020556380.22527@racer.site> <alpine.LSU.1.00.0803020622190.22527@racer.site>
 <alpine.LSU.1.00.0803020743170.22527@racer.site> <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:35:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVs6E-0006AH-9c
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbYCBRe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbYCBRe7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:34:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:56828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754900AbYCBRe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:34:58 -0500
Received: (qmail invoked by alias); 02 Mar 2008 17:34:56 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp007) with SMTP; 02 Mar 2008 18:34:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18T8tkrHz4TWm62dOnx6iOl4OE+cFfUfxdk5L2Ihd
	4XCsXEbRNjT59a
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0803021128510.19665@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75816>

Hi,

On Sun, 2 Mar 2008, Daniel Barkalow wrote:

> On Sun, 2 Mar 2008, Johannes Schindelin wrote:
> 
> > +	for (i = 0; i < ARRAY_SIZE(bundle_suffix); i++) {
> > +		const char *path;
> > +		path = mkpath("%s%s", repo, bundle_suffix[i]);
> > +		if (!stat(path, &st) && S_ISREG(st.st_mode)) {
> > +			*is_bundle = 1;
> > +			return xstrdup(make_absolute_path(path));
> 
> The problem I'm seeing in general is that origin/next's make_absolute_path 
> doesn't work on a regular file in the current directory. How are you 
> getting those tests to pass?

http://repo.or.cz/w/git/dscho.git?a=commitdiff;h=d066bd60e5a93d69c47318cf6e71f77c84b737e6

> In any case, I've got my current version at
> 
> git://iabervon.org/~barkalow/git.git builtin-clone

Thanks.

> The top patch is possibly the correct change for make_absolute_path(), 

Mine has a test now, too...

> and I've incorporated your changes (except that I'd reorganized a bunch 
> of stuff already, making some of them unnecessary and doing some of them 
> slightly differently). For example, I just make bundles not count as 
> local, and let transport.c deal with them in the normal path.

Makes sense.

Ciao,
Dscho

