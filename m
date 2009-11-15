From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: PEBKAC or bug: unable to create path-like branch names
Date: Sun, 15 Nov 2009 02:16:34 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911150150160.14365@iabervon.org>
References: <20091115020605.GE15966@cl.cam.ac.uk> <20091115050227.GD5934@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam@codegnome.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 08:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9ZMn-0007OC-DZ
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 08:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbZKOHQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 02:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZKOHQb
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 02:16:31 -0500
Received: from iabervon.org ([66.92.72.58]:46516 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbZKOHQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 02:16:29 -0500
Received: (qmail 31512 invoked by uid 1000); 15 Nov 2009 07:16:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Nov 2009 07:16:34 -0000
In-Reply-To: <20091115050227.GD5934@penguin.codegnome.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132912>

On Sat, 14 Nov 2009, Todd A. Jacobs wrote:

> I want to create a nested feature branch, but git keeps complaining if I
> nest more than one level deep:
> 
>     $ git checkout -b dev/feature/foo
>     error: unable to resolve reference refs/heads/dev/feature/foo:
>     Not a directory
>     fatal: Failed to lock ref for update: Not a directory
> 
> Based on my reading of the manual pages, it seems like I should be able
> to nest branch names as long as it conforms to certain rules. I read
> git-branch(1), which points me to git-check-ref-format(1), which seems
> to say that the rules are being followed.

Do you have a branch "dev/feature"? Branch names are path-like in that you 
can't have dev/feature as both a branch and a prefix for branches.

> On the other hand, running:
> 
>     $ git check-ref-format foo; echo $?
> 
> always results in a non-zero error code, even with a literal 'foo' as a
> branch name, so clearly it isn't saying what I think it's saying.
> *shrug*

You want either "git check-ref-format --branch foo" or "git 
check-ref-format refs/heads/foo".

	-Daniel
*This .sig left intentionally blank*
