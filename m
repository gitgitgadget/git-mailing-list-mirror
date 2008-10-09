From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Thu, 9 Oct 2008 08:13:00 -0700
Message-ID: <20081009151300.GS8203@spearce.org>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil> <20081009001727.GP536@genesis.frugalware.org> <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil> <7vmyheowcr.fsf@gitster.siamese.dyndns.org> <rKU9r5196P_JTKZZkb10yo7uwH_n_7KAuyX6RMOa9jc@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnxDT-0002Rb-5l
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760021AbYJIPND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760018AbYJIPND
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:13:03 -0400
Received: from george.spearce.org ([209.20.77.23]:51942 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbYJIPNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:13:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2FA373835F; Thu,  9 Oct 2008 15:13:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <rKU9r5196P_JTKZZkb10yo7uwH_n_7KAuyX6RMOa9jc@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97857>

Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Junio C Hamano wrote:
> > Brandon Casey <casey@nrlssc.navy.mil> writes:
> >> I didn't mean to imply that the memory under-allocation
> >> was caused by a change in variable type in this case. Re-reading my commit
> >> message, maybe it sounds like that.
> > 
> > Yeah, it does.  I was scratching my head and had to read the patch three
> > times until I got it (yes, I am especially slower than usual today, as the
> > reason I am reading mails right now is because I am jetlagged and cannot
> > sleep).
> 
> If it's not too late, maybe this would make a better commit message:

Nope, I didn't get around to the patch until now.  Better message
is being used...  ;-)

Thanks everyone.
 
> --->8---
> builtin-merge.c: allocate correct amount of memory
> 
> Fix two memory allocation errors which allocate space for a pointer rather
> than enough space for the structure itself.
> 
> This:
> 
>     struct commit_list *parent = xmalloc(sizeof(struct commit_list *));
> 
> should have been this:
> 
>     struct commit_list *parent = xmalloc(sizeof(struct commit_list));
>     
> But while we're at it, change the allocation to reference the variable it is
> allocating memory for to try to prevent a similar mistake, for example if the
> type is changed, in the future.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

-- 
Shawn.
