From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-status: wording update to deal with deleted files.
Date: Thu, 11 Jan 2007 19:07:01 -0500
Message-ID: <20070112000701.GC16042@coredump.intra.peff.net>
References: <87bql5cok3.fsf@morpheus.local> <7vejq12nlu.fsf@assigned-by-dhcp.cox.net> <7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:07:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H59ws-0007aD-IW
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXALAHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbXALAHH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:07:07 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2510 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbXALAHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:07:05 -0500
Received: (qmail 32156 invoked from network); 11 Jan 2007 19:07:17 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Jan 2007 19:07:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2007 19:07:01 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsleh16ey.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36639>

On Thu, Jan 11, 2007 at 03:37:41PM -0800, Junio C Hamano wrote:

>  - The section header is the old "Changed but not updated",
>    instead of "Changed but not added";

Isn't that the original wording that we recently got rid of? I think
it's a bit confusing, given that "changed" and "updated" really mean the
same thing (we tend to use 'updated' only to refer to the index, but new
users don't know that). How about "Changed but not marked for commit"?
Or even "Files with changes that are not marked for commit" (which is
longer, but more precise).

Maybe it would be clearer to split the section (and only show those
sections which are applicable):

  Files with changes that have are not marked for commit:
    (use "git add <file>" to mark changes)

  Files that have been removed but not marked for commit:
    (use "git rm <file>" to mark for commit)

  Files that exist but have not been marked for commit:
    (use "git add <file>" to mark for commit)

The latter being the current untracked files. And potentially even:

  Files that have merge conflicts:
    (use "git add <file>" to mark as resolved)

And yet another option would be to individually mark each file:
  #  deleted: foo  (use "git rm" to mark for deletion)
but I think that is probably too verbose.

Anyway, please consider my first wording change, if not the more radical
splitting.

-Peff
