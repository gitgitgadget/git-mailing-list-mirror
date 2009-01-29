From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Security and permissions in git
Date: Thu, 29 Jan 2009 17:13:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901291645300.19665@iabervon.org>
References: <loom.20090129T203050-865@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jay Renbaum <jrenbaum@hcrest.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:15:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfAE-00060v-FE
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbZA2WNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZA2WNn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:13:43 -0500
Received: from iabervon.org ([66.92.72.58]:57580 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbZA2WNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:13:42 -0500
Received: (qmail 7335 invoked by uid 1000); 29 Jan 2009 22:13:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Jan 2009 22:13:41 -0000
In-Reply-To: <loom.20090129T203050-865@post.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107734>

On Thu, 29 Jan 2009, Jay Renbaum wrote:

> When setting up a public repository is there a way to control who has access 
> to various directories within the repository or is everything equal once you 
> are in?

Every commit contains a version of the complete contents, so people have 
to be able to read the contents of all directories and write some 
directory contents. However, you can prohibit users from pushing content 
to the repository unless particular directories (or files) match what's 
there already. This is generally what people want when they have this 
requirement.

It's also possible to use submodules to have a project contain parts that 
some users don't have any access to, while still being able to produce 
commits to the main project (in combination with the above check so that 
try can't replace the submodule entirely with content they do have access 
to, or submodule commits they've seen referenced previously)

	-Daniel
*This .sig left intentionally blank*
