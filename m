From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 07:19:47 -0700
Message-ID: <20090603141947.GD3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com> <200906031429.28967.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 16:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBrJy-0007sw-Fu
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 16:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbZFCOTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 10:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbZFCOTp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 10:19:45 -0400
Received: from george.spearce.org ([209.20.77.23]:51009 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbZFCOTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 10:19:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C8DE381D1; Wed,  3 Jun 2009 14:19:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906031429.28967.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120610>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 2 Jun 2009, Jakub Narebski wrote:
> > Should we describe here, or in appendix, or in sidenote, or
> > in a footnote, all currently supported client capabilities
> > and server capabilities? 
> 
>    * include-tag
> 
> What does it mean? Is it about sending tags if we are sending objects 
> they point to,

Yes, this.

> or is it about sending all tags?

No, not this.

If we pack an object to the client, and a tag points exactly at
that object, we pack the tag too.  In general this allows a client
to get all new tags when it fetches a branch, in a single network
connection.
 
> P.S. Is hexdigit length case sensitive i.e. 0-9a-f, or is it not
>      case sensitive i.e. 0-9a-fA-F?

Git parses both a-f/A-F, but prefers to create a-f.

-- 
Shawn.
