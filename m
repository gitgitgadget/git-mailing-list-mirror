From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into
 normal names
Date: Fri, 6 Nov 2009 18:12:52 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911061755360.14365@iabervon.org>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com> <1257547966-14603-2-git-send-email-srabbelier@gmail.com> <1257547966-14603-3-git-send-email-srabbelier@gmail.com> <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com> <1257547966-14603-6-git-send-email-srabbelier@gmail.com> <1257547966-14603-7-git-send-email-srabbelier@gmail.com> <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 07 00:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6XzL-0007BB-7r
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 00:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168AbZKFXMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 18:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760133AbZKFXMt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 18:12:49 -0500
Received: from iabervon.org ([66.92.72.58]:46914 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760135AbZKFXMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 18:12:47 -0500
Received: (qmail 5151 invoked by uid 1000); 6 Nov 2009 23:12:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Nov 2009 23:12:52 -0000
In-Reply-To: <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132341>

On Fri, 6 Nov 2009, Sverre Rabbelier wrote:

> From: Daniel Barkalow <barkalow@iabervon.org>
> 
> This allows a helper to say that, when it handles "import
> refs/heads/topic", the script it outputs will actually write to
> refs/svn/origin/branches/topic; therefore, transport-helper should
> read it from the latter location after git-fast-import completes.
> ---
> 
> 	New in this series.
> 	Daniel, you did not include a S-o-b, I assume because you
> 	mean to add documentation?

I wasn't terribly convinced I'd actually implemented it correctly, since I 
couldn't test it essentially at all; I was just going for something that 
gave the right idea. 

At the very least, it needs documentation and memory leaks fixed (the 
refspec strings read from the helper, and the refspec structs and array on 
freeing the helper data).

Is this actually working with your helper? Occasionally I write code that 
just works without any testing, but I don't usually expect it. :)

	-Daniel
*This .sig left intentionally blank*
