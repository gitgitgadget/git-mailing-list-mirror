From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 13:58:55 +0200
Message-ID: <20100624115855.GA22684@pvv.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <4C2344C0.2010402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 13:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORl5P-00065r-2Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab0FXL7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:59:09 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:32818 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171Ab0FXL7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:59:08 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1ORl55-0001AO-Dt; Thu, 24 Jun 2010 13:58:55 +0200
Content-Disposition: inline
In-Reply-To: <4C2344C0.2010402@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149584>

On Thu, Jun 24, 2010 at 01:42:56PM +0200, Johannes Sixt wrote:
> Am 6/24/2010 13:17, schrieb Finn Arne Gangstad:
> > Assume you start out with a repo that has a lot of text files with
> > CRLF checked in (A).
> > 
> >   C----
> >  /     \
> > A---B---D
> > 
> > B: Add "* text=auto" to .gitattributes and normalize all files to LF
> > only in repo
> > 
> > D: try to merge C
> > 
> > Without this patch you will get a ridiculous number of lf/crlf
> > conflicts when trying to merge C into D, since the repository contents
> > for C are "wrong" wrt the new .gitattributes file.
> 
> What should happen when you have C checked out (i.e., you do not yet have
> the updated .gitattributes in your worktree nor index) and merge B?
> Currently, you get the identical conflicts, but I suspect that the patch
> does not help in this situation. IOW, it breaks the merge symmetry.

git merges .gitattributes early, so it will work any way you do the
merge I think? Each file in a merge is processed separately with
whatever .gitattributes file is active.

If you get a conflict in .gitattributes you may be in a slightly
interesting spot, but you will still get all the new attributes in the
conflicted file, so in practice it should still work. git ignores the
conflict markers in .gitattributes and moves on..

- Finn Arne
