From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 1/1] Guilt: Fixed guilt-patchbomb temporary mbox deletion bug
Date: Tue, 6 Mar 2007 02:38:21 -0500
Message-ID: <20070306073821.GA26626@filer.fsl.cs.sunysb.edu>
References: <1173164506.4877.19.camel@gandalf.dcc.usm.my> <7vvehesvf1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nur Hussein <hussein@cs.usm.my>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:38:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUG3-0002TF-86
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933978AbXCFHio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933979AbXCFHin
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:38:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:43924 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933978AbXCFHim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:38:42 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l267cMG6026903;
	Tue, 6 Mar 2007 02:38:22 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l267cMK9026901;
	Tue, 6 Mar 2007 02:38:22 -0500
Content-Disposition: inline
In-Reply-To: <7vvehesvf1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41552>

On Mon, Mar 05, 2007 at 11:06:26PM -0800, Junio C Hamano wrote:
> Nur Hussein <hussein@cs.usm.my> writes:
> 
> >  echo -n "Delete temporary directory? [Y/n] "
> >  read n
> >  
> > -[ "$n" != "n" -a "$n" != "N" ] && exit 0
> > +[ "$n" != "n" -o "$n" != "N" ] && exit 0
> >  rm -rf $dir
> 
> Is it just me who finds this much more readable?
> 
> 	case "$n" in [nN]*) exit 0 ;; esac
 
I don't know. I never saw case being "abused" as the condition in a while
loop either. I guess it is really a matter of taste. For anything more
complex then [nN] I'd go with the case statement as well.

I hear that the whole while-case is just an optimization for sh of many
moons ago - something about case being builtin but test not.

Josef "Jeff" Sipek.

-- 
Only two things are infinite, the universe and human stupidity, and I'm not
sure about the former.
		- Albert Einstein
