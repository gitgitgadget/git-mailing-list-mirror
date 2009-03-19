From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: git am from scratch
Date: Thu, 19 Mar 2009 21:42:49 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903192142.49754.agruen@suse.de>
References: <200903191609.24812.agruen@suse.de> <20090319201817.GE17028@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:46:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkP8F-0007sH-Ul
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 21:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759857AbZCSUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 16:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758461AbZCSUok
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:44:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34427 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756582AbZCSUok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:44:40 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D588564A86;
	Thu, 19 Mar 2009 21:44:37 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20090319201817.GE17028@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113826>

On Thursday, 19 March 2009 21:18:17 Jeff King wrote:
> I don't think this has ever worked in any version of git.

I did find a way to help myself in the end. Still it was still a major, 
unnecessary annoyance.

I ran into this problem when trying to reconstruct a project's history (after 
going RCS -> CVS -> git many things were still wrong like unrelated RCS files 
which ended up in the history, RCS files being moved to the Attic in the 
original tree to indicate deletes [which means they will happily live on from 
a CVS point of view], etc.).

The easiest way I could find how to get rid of all the mess without going 
totally insane was to git-format-patch the repository, fix up the major 
things in the mbox, and then recreate the history.

In the end I ended up preparing the initial commit by hand followed 
by "commit -c HASH" to preserve the metadata. (The cvsimport branch had a 
different commit at its tip, so I couldn't use commit --amend on that.) After 
that, I git-am'ed the rest of the mbox onto that reconstructed commit. This 
could have been significantly easier.

> There are many other ways to do this.

That's really not the point. Thanks though.

Andreas
