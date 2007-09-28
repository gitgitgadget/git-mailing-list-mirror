From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 27 Sep 2007 23:24:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709272153450.5926@iabervon.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 05:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib6TH-0000Ho-G3
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 05:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbXI1DYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 23:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXI1DYt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 23:24:49 -0400
Received: from iabervon.org ([66.92.72.58]:55005 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbXI1DYs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 23:24:48 -0400
Received: (qmail 23415 invoked by uid 1000); 28 Sep 2007 03:24:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Sep 2007 03:24:47 -0000
In-Reply-To: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59354>

On Wed, 26 Sep 2007, Junio C Hamano wrote:

> * db/fetch-pack (Tue Sep 25 00:13:25 2007 -0400) 45 commits
>  + Prevent send-pack from segfaulting when a branch doesn't match
>  + Cleanup unnecessary break in remote.c
>  + Cleanup style nit of 'x == NULL' in remote.c
>  + Fix memory leaks when disconnecting transport instances
>  + Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
>  + ...
> 
> Two issues known to me are:
> 
>  - "rsync" transport is not supported yet;
> 
>  - regresses "git pull <name>" using .git/remotes/<name>; does
>    not merge the first refspec when branch.<name>.merge is not
>    set.

Actually, I think it's only that it doesn't merge anything if the first 
refspec doesn't match the first fetched ref from the server. I'm running 
tests on a patch that should fix it, but I'm not sure how to write a test 
for this particular case; I think the fetch tests try to test this, but 
pass by chance.

	-Daniel
*This .sig left intentionally blank*
