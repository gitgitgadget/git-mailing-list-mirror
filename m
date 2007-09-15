From: David Watson <dwatson@mimvista.com>
Subject: Re: git commit workflow question
Date: Sat, 15 Sep 2007 08:07:51 -0400
Message-ID: <20070915120750.GA21968@mimvista.com>
References: <20070914103348.GA22621@bulgaria> <20070914181417.GU3099@spearce.org> <BCFC81AB-0EDD-4C3C-B7D4-DEC60E2565C3@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Brian Swetland <swetland@google.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 14:07:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWWQb-0002sc-3V
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 14:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbXIOMGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 08:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXIOMGv
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 08:06:51 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:56268
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751837AbXIOMGt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 08:06:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id BD1B0357AC2;
	Sat, 15 Sep 2007 08:03:48 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: 1.393
X-Spam-Level: *
X-Spam-Status: No, score=1.393 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946,
	RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 47uroNGui2AE; Sat, 15 Sep 2007 08:03:46 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 0CCEC357ABC;
	Sat, 15 Sep 2007 08:03:45 -0400 (EDT)
Mail-Followup-To: Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brian Swetland <swetland@google.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <BCFC81AB-0EDD-4C3C-B7D4-DEC60E2565C3@wincent.com>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58239>

<shameless plug>The Eclipse plugin (egit) actually already supports this
feature, and I use it all the time. It's incredibly handy, since I can
stag things as much as I want, and then commit then piecemeal.</shameless
plug>

However, I'm not convinced this should necessarily be included in git, at
least not by editing the commit message. Perhaps it should be a task for a
porcelain? I know you can do something similar using git-gui as
well, just by clicking on files in its top view to stage/unstage. Or like
rebase -i, where you first get a buffer with a list of stuff to be done,
and then in a separate buffer you get the commit message.

On Sat, Sep 15, 2007 at 01:31:37PM +0200, Wincent Colaiuta wrote:
>  El 14/9/2007, a las 20:14, Shawn O. Pearce escribi?:
> 
> > I'm not sure how the Git community would react to being able to edit
> > the list of files being committed from within the commit message
> > buffer.  I think most Git users run at least `git diff --cached`
> > before they commit to make sure they are happy with the difference.
> > I know a lot of users who do that.
> 
>  Yes, I generally check what's in the index before going ahead with a commit; in 
>  fact I have the following alias in my .bash_profile so that I can just type 
>  "staged" to see what'll be in the commit, along with an "unstaged" alias for 
>  the opposite:
> 
>  alias staged='git diff --cached'
> 
>  Having said that, it would be very useful to be able to edit the list within 
>  the commit message buffer for those occasions where you realise that stuff you 
>  have staged in the index really should be two separate commits. It would enable 
>  this very simple workflow:
> 
>    1. review changes, realize that some of the changes belong in a separate 
>  commit
>    2. commit, omitting the unwanted changes
>    3. commit again, this time with the remainder of the changes
> 
>  Without the ability to edit the list within the commit message buffer your 
>  workflow becomes a bit more cumbersome:
> 
>    1. review changes, realize that some of the changes belong in a separate 
>  commit
>    2a. explicitly pass files to commit on the commandline (cumbersome if number 
>  of files is large); or:
>    2b. use git-commit --interactive (again can be relatively cumbersome); or:
>    2c. explicitly unstage unwanted files, commit, then restage them and commit
> 
>  So, yes, the proposed functionality isn't necessary by any means, but it would 
>  make some nice usability sugar. I know that in the past my experience with 
>  other SCMs that can do this has made me mistakenly believe that Git does too.
> 
>  Cheers,
>  Wincent
> 
>  -
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dave Watson
Software Engineer
MIMvista Corp
