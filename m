From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 03:33:29 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902160322530.19665@iabervon.org>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 09:35:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYywN-0000zp-DM
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 09:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbZBPIdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 03:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbZBPIdb
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 03:33:31 -0500
Received: from iabervon.org ([66.92.72.58]:47094 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbZBPIda (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 03:33:30 -0500
Received: (qmail 20160 invoked by uid 1000); 16 Feb 2009 08:33:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Feb 2009 08:33:29 -0000
In-Reply-To: <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110146>

On Sun, 15 Feb 2009, david@lang.hm wrote:

> If there is some reason for the normal push to try and update the HEAD, index,
> and workdir. instead of refusing the push, how about having it put the commits
> in the repository and then fail to change the HEAD, index, and workdir if any
> of them contain changes? (along with a warning that it's doing so).

A push cannot help but update HEAD, because HEAD is generally literally 
"ref: refs/heads/<current-branch>"; it doesn't store its own value, and 
the storage that it references is the storage that push is updating.

In fact, if you expect to be pushing to a non-bare repository, you 
probably want to have HEAD contain the actual commit currently checked out 
(instead of a reference to externally mutable storage), which you can do 
with "git checkout refs/heads/master".

	-Daniel
*This .sig left intentionally blank*
