From: Greg KH <greg@kroah.com>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 1 Mar 2006 15:27:19 -0800
Message-ID: <20060301232719.GA22068@kroah.com>
References: <20060301220802.GA18250@kroah.com> <20060301220840.GB18250@kroah.com> <7v8xrtepje.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 00:27:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaj0-0001li-Aq
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCAX1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWCAX1P
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:27:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:53412
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751125AbWCAX1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 18:27:15 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FEaio-00059X-B4; Wed, 01 Mar 2006 15:27:06 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xrtepje.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17029>

On Wed, Mar 01, 2006 at 03:03:17PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Wed, Mar 01, 2006 at 02:08:02PM -0800, Greg KH wrote:
> >> I have a mail archive stored with git, in mbox form, and I made some
> >> changes to a few of the files and checked them back in.
> >...
> 
> Ouch.  Running out of memory while deltifying sounds really bad.
> 
> > Oh, and I'm using:
> > 	$ git --version
> > 	git version 1.2.3.g8c2f
> >
> > if that helps or not.
> 
> It doen't, since I do not have 8c2fXXXX commit ;-).

Heh, that's a merge on my tree, sorry.  My tree only has one change to
the git-format-patch.sh script.

858cbfbabe4ede5f5eba32041eb7448319e53e2a is the most recent commit from
your tree.

> I suspect "git push --thin origin" might help, if you are on my
> "master" branch:
> 
>         diff-tree a79a276... (from 2245be3...)
>         Author: Junio C Hamano <junkio@cox.net>
>         Date:   Mon Feb 20 00:09:41 2006 -0800
> 
>             Add git-push --thin.
> 
>             Maybe we would want to make this default before it graduates to
>             the master branch, but in the meantime to help testing things,
>             this allows you to say "git push --thin destination".
> 
>             Signed-off-by: Junio C Hamano <junkio@cox.net>

Will try that.  I eventually gave up on the last push when it ran for 45
minutes at full cpu usage, and X got killed by the OOM killer in the
kernel for some reason...

thanks,

greg k-h
