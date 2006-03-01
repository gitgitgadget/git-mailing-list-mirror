From: Greg KH <greg@kroah.com>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 15:35:06 -0800
Message-ID: <20060301233506.GA25209@kroah.com>
References: <20060301220802.GA18250@kroah.com> <20060301220840.GB18250@kroah.com> <7v8xrtepje.fsf@assigned-by-dhcp.cox.net> <20060301232719.GA22068@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 00:35:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaqY-0003Ub-D8
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCAXfB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbWCAXfB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:35:01 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:58079
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751937AbWCAXfA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 18:35:00 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEaqL-0005Ay-Vc; Wed, 01 Mar 2006 15:34:54 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060301232719.GA22068@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17030>

On Wed, Mar 01, 2006 at 03:27:19PM -0800, Greg KH wrote:
> On Wed, Mar 01, 2006 at 03:03:17PM -0800, Junio C Hamano wrote:
> > I suspect "git push --thin origin" might help, if you are on my
> > "master" branch:
> > 
> >         diff-tree a79a276... (from 2245be3...)
> >         Author: Junio C Hamano <junkio@cox.net>
> >         Date:   Mon Feb 20 00:09:41 2006 -0800
> > 
> >             Add git-push --thin.
> > 
> >             Maybe we would want to make this default before it graduates to
> >             the master branch, but in the meantime to help testing things,
> >             this allows you to say "git push --thin destination".
> > 
> >             Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> Will try that.  I eventually gave up on the last push when it ran for 45
> minutes at full cpu usage, and X got killed by the OOM killer in the
> kernel for some reason...

Nice, this worked!

Now what's the odds that when I pull from the server to another box
these same objects, the server will have the same problem as git-push
did?

will go try that now...

thanks,

greg k-h
