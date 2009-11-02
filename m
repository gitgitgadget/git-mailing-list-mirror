From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Sun, 1 Nov 2009 22:16:46 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911012038120.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>  <1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org>  <fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com> 
 <alpine.LNX.2.00.0910301118070.14365@iabervon.org> <fabb9a1e0911011733o7d8d95eem57e02d455e0bd86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 04:16:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4nPZ-0003JB-4H
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 04:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZKBDQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 22:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZKBDQm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 22:16:42 -0500
Received: from iabervon.org ([66.92.72.58]:35145 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbZKBDQm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 22:16:42 -0500
Received: (qmail 13041 invoked by uid 1000); 2 Nov 2009 03:16:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Nov 2009 03:16:46 -0000
In-Reply-To: <fabb9a1e0911011733o7d8d95eem57e02d455e0bd86@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131894>

On Mon, 2 Nov 2009, Sverre Rabbelier wrote:

> Yes, that sounds very reasonable, and I think that's the right way to
> go. This leaves us with only one thing, we need a remote HEAD for 'git
> clone hg::/path/to/repo' to work and have it check out a branch, I
> think a seperate 'head' command might be appropriate? If supported it
> returns the which local symref (e.g. 'refs/heads/trunkr' in the svn
> case) should be pointed at by HEAD. If not supported we can just not
> set it and clone will give the default 'no remote HEAD, nothing
> checked out' message, which would probably be best for p4?

Why not have the regular list report:

@refs/heads/trunkr HEAD

or whatever it is, again like native git? That is, SVN would have an 
interaction like:

> list
< ? refs/heads/trunkr
< ? refs/heads/my-branch
< ? refs/tags/v1.0
< @refs/heads/trunkr HEAD
<

This is similar to the response from the curl helper, except that it uses 
"?" for the sha1s because it doesn't know them until they're imported.

	-Daniel
*This .sig left intentionally blank*
