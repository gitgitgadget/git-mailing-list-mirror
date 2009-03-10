From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 23:04:00 +0100
Message-ID: <20090310220400.GA9612@pvv.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org> <20090310175233.GA26351@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhA5A-0002rX-6o
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 23:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984AbZCJWEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbZCJWEF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 18:04:05 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:32943 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbZCJWEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 18:04:04 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LhA3M-00038Z-Vt; Tue, 10 Mar 2009 23:04:00 +0100
Content-Disposition: inline
In-Reply-To: <20090310175233.GA26351@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112853>

On Tue, Mar 10, 2009 at 01:52:33PM -0400, Jeff King wrote:
> 
> I have not been following this topic too closely, so can you please
> explain (or point me to an explanation about) something? How do these
> options interact with refspecs given on the command line? That is, why
> would I choose to use:
> 
>   git push --current
> 
> over
> 
>   git push - HEAD

--current pushs the current branch to whatever it is tracking, no
matter what name it has (i.e. it can push to a branch of different
name). If it is not tracking anything, it will not push.

git push - HEAD pushes the current branch to a branch of the same name
on the "current remote", which defaults to origin if nothing is set up
for the branch.

> (assuming your earlier patch is applied, or "git push HEAD" if Junio's
> suggested DWIMmery is implemented). And what does it mean to say
> 
>   git push --matching - HEAD
> 
> ? Those are conflicting instructions. Is one followed and one discarded?
> Are they merged?

It would be an error, no refspecs can be specified with --matching.

- Finn Arne
