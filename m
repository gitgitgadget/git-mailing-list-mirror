From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 9 Oct 2009 08:39:36 -0700
Message-ID: <20091009153936.GV9261@spearce.org>
References: <20091005152504.GE9261@spearce.org> <20091005165802.GA24402@tugrik.mns.mnsspb.ru> <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com> <1254737039-10404-1-git-send-email-kirr@mns.spb.ru> <20091005152504.GE9261@spearce.org> <20091008132718.GA12161@tugrik.mns.mnsspb.ru> <20091008150206.GD9261@spearce.org> <20091009090958.GA4758@tugrik.mns.mnsspb.ru> <20091009144606.GT9261@spearce.org> <20091009152149.GA26171@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Oct 09 17:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwHcx-0008HM-Sy
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933278AbZJIPkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933224AbZJIPkO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:40:14 -0400
Received: from george.spearce.org ([209.20.77.23]:57569 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038AbZJIPkN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:40:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0590D381FE; Fri,  9 Oct 2009 15:39:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091009152149.GA26171@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129818>

Kirill Smelkov <kirr@mns.spb.ru> wrote:
> On Fri, Oct 09, 2009 at 07:46:06AM -0700, Shawn O. Pearce wrote:
> > 
> > Squash this into the first patch and add the egrep change made by
> > Stephen Boyd "[PATCH 1/2] completion: fix completion of git <TAB><TAB>".
> 
> While it is technically easy to do so, isn't this a bad idea to squash
> semantic changes and fixes into something which should be as close as
> code movement?

The ejection forces the code to build with /bin/bash, unless you
apply the trivial fixes related to IFS to make it work with dash.
As they are trivial the tiny semantic change during the code move
is just cleaner.

> Especially Stephen's fix?

I expect Junio to apply his patch first, and then yours.  Since he
is changing a region you are moving, you need to account for it in
your patch, otherwise we have a conflict and/or a regression.
 
-- 
Shawn.
