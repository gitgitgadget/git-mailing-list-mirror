From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 22:26:44 +0100
Message-ID: <1121290004.6876.11.camel@localhost.localdomain>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
	 <tnxll4bdn7b.fsf@arm.com>  <42D55AC9.4000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 23:29:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsomt-0005fE-IJ
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 23:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVGMV2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVGMV20
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 17:28:26 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:52187 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262476AbVGMV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 17:26:48 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050713212647.NGCK481.mta07-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Wed, 13 Jul 2005 22:26:47 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050713212647.UZLY4721.aamta12-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Wed, 13 Jul 2005 22:26:47 +0100
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42D55AC9.4000506@gmail.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-07-13 at 14:17 -0400, Bryan Larsen wrote:
> Catalin Marinas wrote:
> I would have hoped that emacs py-mode would "do the right thing". 
> Anybody know how to make it do what Catalin wants?

It looks like the python-mode in my emacs does the right thing. You
could add something like below in your .emacs file:

(add-hook 'python-mode-hook
          #'(lambda ()
              (setq indent-tabs-mode nil)))

Otherwise, select the whole buffer and do a "M-x untabify".

> > What's the reason for having 'fin' as well? It doesn't seem to be used
> > (this is found in other parts of the patch as well).
> 
> popen does not support bypassing the shell by using vectors of 
> arguments.  Only popen2 and friends have this capability.

But the manual says that it is not possible to get the exit code of the
child process with popen2 (at least not in python 2.3). You would need
to use the Popen3 and Popen4 classes in the popen2 module.

Does it make that big difference if the commands are invoked via the
shell? I haven't run any tests.

> > I'm not sure whether the GIT guys are happy for us to use this mailing
> > list for StGIT. If the StGIT traffic increases, I will try to create a
> > separate mailing list (maybe using a site like sf.net).
> > 
> 
> I'd very much like to stay on the same list.  By the same logic, cogito 
> should have it's own list as well...

I'd like this too and it's probably OK with a low traffic (we'll see if
we receive complaints :-) ).

Catalin
