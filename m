From: Mike Hommey <mh@glandium.org>
Subject: Re: Rewriting history with git-filter-branch and leaking objects
	(?)
Date: Fri, 17 Aug 2007 19:46:21 +0200
Organization: glandium.org
Message-ID: <20070817174621.GA14503@glandium.org>
References: <20070817171851.GB13891@glandium.org> <86k5ruxdxz.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:47:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5v1-0008UF-Ho
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbXHQRr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755874AbXHQRr1
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:47:27 -0400
Received: from vawad.err.no ([85.19.200.177]:33413 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755901AbXHQRr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:47:27 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM5ui-0000sD-8G; Fri, 17 Aug 2007 19:47:22 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM5tt-0003na-TV; Fri, 17 Aug 2007 19:46:22 +0200
Content-Disposition: inline
In-Reply-To: <86k5ruxdxz.fsf@lola.quinscape.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56076>

On Fri, Aug 17, 2007 at 07:34:32PM +0200, David Kastrup <dak@gnu.org> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > I've been playing with git-filter-branch, and was wondering how objects
> > from the original branch are supposed to be removed.
> >
> > It looks like removing the refs/original/* refs is not enough.
> >
> > And it also looks like when all references seem to be removed, git-prune
> > doesn't fully do its job...
> 
> It is quite quite hard to get rid of objects.  You need to get the
> reflogs for the commits and the files expired.
> 
> The last time I tried this, I ended up unpacking the packed objects,
> calling git-fsck with appropriate options to tell me about
> unreferenced objects when ignoring reflogs, and removing the files
> manually with xargs and rm.
> 
> Probably I was not able to do something reasonably intelligent, but
> making git actually _lose_ data/commits/whatever is really, really
> hard.  I have messed up my repo structure considerably several times,
> and everything is still there, with the reflog telling you how to get
> it.
> 
> Given how easy it is to shoot oneself in the foot with git, it is not
> the worst thing.  But you really have to work if you _mean_ it.

Well, with the introduction of git-filter-branch, once you have
rewritten your history and validated that everything is okay,
you might mean to remove the original branch...

Mike
