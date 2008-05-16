From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bug: rebase fatal failure
Date: Fri, 16 May 2008 11:41:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161139530.30431@racer>
References: <482BE5F7.2050108@thorn.ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Fri May 16 12:43:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwxOR-0008Av-AH
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYEPKll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbYEPKll
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:41:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:43935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752114AbYEPKlk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:41:40 -0400
Received: (qmail invoked by alias); 16 May 2008 10:41:39 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp021) with SMTP; 16 May 2008 12:41:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18KRDsqXjAKyDfD4FTheVrWXfdzd5nup3v8nltcvG
	BSLgKubwXkKI7E
X-X-Sender: gene099@racer
In-Reply-To: <482BE5F7.2050108@thorn.ws>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82270>

Hi,

On Thu, 15 May 2008, Tommy Thorn wrote:

> I have large-ish repository (143 MB) where git rebase failed 
> unexpectedly (see below). If anyone is interested in looking at this, I 
> have left a copy of the repository at 
> http://thorn.ws/git-fatal-rebase-error.tar.gz

I can reproduce.  It seems that our diff machinery generates a file that 
adds a file with 10668 lines, but says 10669 lines in the hunk header.

It is a .info file, so I suspect strange things going on with 
non-printable ASCII characters.

I'm on it,
Dscho
