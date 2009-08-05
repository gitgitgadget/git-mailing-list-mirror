From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/2] Implement git-vcs-p4
Date: Wed, 5 Aug 2009 14:32:49 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051424370.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050056580.2147@iabervon.org> <7vocqu9mzx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlIc-00005j-Jg
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbZHEScu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbZHEScu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:32:50 -0400
Received: from iabervon.org ([66.92.72.58]:46924 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbZHESct (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:32:49 -0400
Received: (qmail 31782 invoked by uid 1000); 5 Aug 2009 18:32:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 18:32:49 -0000
In-Reply-To: <7vocqu9mzx.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124947>

On Wed, 5 Aug 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This is probably not particularly appropriate for mainline
> > application, and is somewhat buggy, not extensively tested, and
> > incomplete, but is here as an example implementation of the API and in
> > case it is useful to other people.
> 
> I do not mind carrying this in the tree, at least on 'pu', for wider
> exposure---giving easier access to others _might_ help you gain
> contributors.
> 
> But we need to disable this in the Makefile by default and force
> interested parties to explicitly ask for it if we were to do that.

There are two ways it can be built: either against the API library that 
Perforce distributes (without any obvious license documents) or to call 
the client executable. The Makefile only tries to build against the API if 
configured to have the location of it; it currently tries the client if 
the API wasn't configured, but I'll make it only try even that if 
configured to do so.

Alternatively, perhaps I should set up the Makefile to have a 
configuration option for contrib subdirectories that need to be built? I 
didn't put it in contrib/ because it (currently) needs to link against 
-lgit, depend on it, and have compilation rules, and everything currently 
in contrib/ is interpreted code.

	-Daniel
*This .sig left intentionally blank*
