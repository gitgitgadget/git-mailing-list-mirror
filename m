From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 19:45:02 -0400
Message-ID: <20060629234502.GB10041@fieldses.org>
References: <20060629194723.GD14287@fieldses.org> <20060629215725.GI14287@fieldses.org> <7vlkrfoaky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 01:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw6C9-0004BQ-P1
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 01:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933105AbWF2XpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 19:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933109AbWF2XpF
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 19:45:05 -0400
Received: from mail.fieldses.org ([66.93.2.214]:14512 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S933105AbWF2XpD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 19:45:03 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1Fw6By-0003Fz-Jj; Thu, 29 Jun 2006 19:45:02 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkrfoaky.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22928>

On Thu, Jun 29, 2006 at 03:34:21PM -0700, Junio C Hamano wrote:
> For example, I maintain two public branches "master" and
> "next", the former is supposed to be quite stable and the latter
> to contain sane proposed updates that need to be proven before
> graduating to "master".
> 
> Sometimes I get patches that I have to apply on top of "next"
> because of textual dependency, but the changes are worthwhile to
> have it in "master" earlier than the changes the other series
> depends on.
> 
>  o---o---o---o---o master
>       \
>        o---o---o---o---o next
>                         \
>                          o---o---o good
> 
> 	$ git checkout good
>         $ git rebase --onto master next
> 
>  o---o---o---o---o master
>      |            \
>      |             o---o---o good
>       \
>        o---o---o---o---o next
> 

OK, so you're saying "take everything in good but not in next, and try to apply
it to master."

I don't know why I find that syntax so counterintuitive.  Something like

	git checkout -b newgood master
	git cherry-pick next..good

would seem more obvious.  But I think this has been discussed before.  OK,
thanks for the explanation.

--b.
