From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 16:42:02 -0400
Message-ID: <20070823204202.GA10644@filer.fsl.cs.sunysb.edu>
References: <20070823092254.GA5976@kroah.com> <20070823180633.GA24530@filer.fsl.cs.sunysb.edu> <20070823184758.GB17601@kroah.com> <20070823185608.GC1608@filer.fsl.cs.sunysb.edu> <b0943d9e0708231336h3a92de22oc025c69b9209da9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJVZ-0006VB-TW
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760246AbXHWUmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760171AbXHWUmI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:42:08 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52937 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760067AbXHWUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:42:07 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7NKg2aV013674;
	Thu, 23 Aug 2007 16:42:02 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l7NKg2R3013672;
	Thu, 23 Aug 2007 16:42:02 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <b0943d9e0708231336h3a92de22oc025c69b9209da9a@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56529>

On Thu, Aug 23, 2007 at 09:36:05PM +0100, Catalin Marinas wrote:
> On 23/08/07, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> > Yep. Two different projects taking different approaches to storing the
> > patches. I go with the plaintext diff approach ala quilt, while stgit uses
> > git objects to store the data.
> 
> But guilt also generates a commit object when pushing a patch. Or am I wrong?

That's correct. But the git commit/tree/blob objects are a mere cache. For
example, a refresh consists of:

git-update-index ...
git-diff HEAD^ > patchfile
git-reset --hard HEAD^
<internal push patch function - uses git-apply, git-{write,commit}-tree>

Josef 'Jeff' Sipek.

-- 
Research, n.:
  Consider Columbus:
    He didn't know where he was going.
    When he got there he didn't know where he was.
    When he got back he didn't know where he had been.
    And he did it all on someone else's money.
