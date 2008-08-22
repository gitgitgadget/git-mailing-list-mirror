From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: some questions
Date: Fri, 22 Aug 2008 07:08:32 -0700
Message-ID: <20080822140832.GC3483@spearce.org>
References: <48AE6B41.1070005@jentro.com> <vpqtzddtoq2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Pasch <thomas.pasch@jentro.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:09:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWXKc-0001Su-JL
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 16:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbYHVOIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 10:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbYHVOIe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 10:08:34 -0400
Received: from george.spearce.org ([209.20.77.23]:48095 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYHVOId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 10:08:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E46BD38375; Fri, 22 Aug 2008 14:08:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpqtzddtoq2.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93301>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Thomas Pasch <thomas.pasch@jentro.com> writes:
> >
> > I try to migrate our old cvs repo to git.
> > However, I still have to following questions
> > that I found difficult to answer with
> > the documentation.
> >
> > - Is there a way to convert a indexVersion 1
> >   repo to indexVersion 2? (And vice versa?)
> 
> The index itself is just a little file in .git/index. There might be a
> better solution, but just
> 
>   rm .git/index
>   git reset
> 
> seems to do it (of course, don't do while you have staged changes in
> the index !).

True, that would reset the dircache (aka .git/index).  But we only
have effectively 1 version of the dircache.  Sure there was an older
version, way back before it got a version header and the ability to
get extension sections added.  I don't think there are many clients
using that format anymore.  That format predates the 1.4 series,
and we really encourage people to be on 1.5 or later.

The original poster asked about indexVersion 1 and indexVersion 2,
which means he is probably talking about pack.indexVersion and thus
a .idx file alongside a pack, not the dircache file that tracks
the working tree state.
 
-- 
Shawn.
