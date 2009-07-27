From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC 00/11] Foreign VCS helper program for CVS repositories
Date: Mon, 27 Jul 2009 13:27:47 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907271251280.2147@iabervon.org>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:27:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVTzP-0004WI-Vn
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 19:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZG0R1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbZG0R1s
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 13:27:48 -0400
Received: from iabervon.org ([66.92.72.58]:48436 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbZG0R1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 13:27:48 -0400
Received: (qmail 4813 invoked by uid 1000); 27 Jul 2009 17:27:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jul 2009 17:27:47 -0000
In-Reply-To: <1248656659-21415-1-git-send-email-johan@herland.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124173>

On Mon, 27 Jul 2009, Johan Herland wrote:

> This series is a first draft towards implementing a foreign VCS helper
> program for CVS.
> 
> It is based on the 'db/foreign-scm' and 'jh/notes' topics in 'pu'. As such,
> this patch series should apply cleanly to current 'pu'.
> 
> The first 4 patches supply the necessary parts of Daniel Barkalow's
> foreign-scm topic that has not yet been merged to 'pu' (i.e. everything
> remaining in Daniel's original patch series, except the p4-specific stuff).

I've got some changes to this series in the works; I just made a few 
changes to share the transport-side code for interacting with the helper 
with the transport-side code for interacting with native-object helpers. 
Mainly, this means starting each line in the "list" response with "?" to 
indicate that you don't know the hash, since the protocol is trying to be 
compatible with cases where you do know.

> The next 2 patches add some functionality to git fast-import, for
> facilitating the import of 'notes' objects (this is a _much_ faster way to
> generate/import notes than invoking "git notes edit -m MSG" for each note).
> 
> Next, there are 3 patches tweaking and expanding the git-vcs API (with
> corresponding implementations in the foreign transport code) to adjust for
> the CVS helper's needs.

These make sense to me. I assume you're planning to support exporting in 
some ways, but haven't got it working yet? I largely ignored the 
capabilities stuff because I didn't have two systems with differing 
requirements to actually use it.

	-Daniel
*This .sig left intentionally blank*
