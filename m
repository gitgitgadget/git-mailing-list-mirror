From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git hooks are not called over HTTP
Date: Fri, 17 Oct 2008 07:11:07 -0700
Message-ID: <20081017141107.GE9877@spearce.org>
References: <7beb12420810162323o6dce0a71r897fbed9b9d3e417@mail.gmail.com> <m38wsnk24l.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: KwangYul Seo <kwangyul.seo@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 16:12:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqq3x-0005Cw-OL
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 16:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYJQOLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbYJQOLJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 10:11:09 -0400
Received: from george.spearce.org ([209.20.77.23]:46585 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262AbYJQOLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 10:11:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C08E33835F; Fri, 17 Oct 2008 14:11:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m38wsnk24l.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98476>

Jakub Narebski <jnareb@gmail.com> wrote:
> "KwangYul Seo" <kwangyul.seo@gmail.com> writes:
> 
> > I have setup a git repository with post-receive and post-update
> > enabled. I configured hooks.envelopesender and hooks.mailinglist. I
> > confirmed that it works fine with push from local repositories.
> > However, hooks are never called when push is done over HTTP.
> 
> Perhaps that would get improved when "smart" HTTP protocol gets
> implemented (currently in the phase of design, I think just after
> designing protocol).

Yes.  The Git-in-HTTP protocol for push basically calls for an
embedding of send-pack/receive-pack's protocol into HTTP, and
implementation wise will probably be invoking git-receive-pack on
the web server side of the connection.  So if/when that finally
gets implemented we'd run hooks over HTTP, but *ONLY* if both sides
support the new Git-in-HTTP protocol.

If both sides are still using WebDAV, no hooks, for the reason you
cited earlier.

-- 
Shawn.
