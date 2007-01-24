From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 00:29:00 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701240019250.20138@iabervon.org>
References: <17846.53626.895660.762096@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 06:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9ah1-0005v2-8c
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 06:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965655AbXAXF3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 00:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965649AbXAXF3D
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 00:29:03 -0500
Received: from iabervon.org ([66.92.72.58]:4738 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965655AbXAXF3C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 00:29:02 -0500
Received: (qmail 26100 invoked by uid 1000); 24 Jan 2007 00:29:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jan 2007 00:29:00 -0500
In-Reply-To: <17846.53626.895660.762096@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37604>

On Tue, 23 Jan 2007, Bill Lear wrote:

> I have a long-running topic branch.  I have fixed a few nits on
> the master branch that I would like on the topic branch.  How do I
> pull in only a few files from the head of the master branch?

You don't pull in a few files, you apply the changes made in a few 
commits:

  git diff HEX_OF_NIT_FIX^ HEX_OF_NIT_FIX | git apply

If there's other stuff in the nit-fixing commit, shame on you, but you can 
edit the patch before applying it to remove everything that's not what you 
want.

(Incidentally, I think "git diff ^ {commit}" should be made to do "git 
diff {commit}^ {commit}"; i.e., if there is a single other revision 
provided, interpret a modifier not applied to anything as applying to that 
revision, in the "what else could that possibly mean?" department.)

	-Daniel
*This .sig left intentionally blank*
