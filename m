From: James Pickens <jepicken@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 17:59:38 +0000 (UTC)
Message-ID: <loom.20080724T171151-310@post.gmane.org>
References: <20080723145518.GA29035@laptop>  <loom.20080724T065737-580@post.gmane.org> <fcaeb9bf0807240200x10a6a267h4c37e4566da967ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 20:00:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM57Q-0000rA-2U
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbYGXR7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYGXR7s
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:59:48 -0400
Received: from main.gmane.org ([80.91.229.2]:51128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYGXR7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:59:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KM56P-0004TT-Qb
	for git@vger.kernel.org; Thu, 24 Jul 2008 17:59:46 +0000
Received: from chfwpr02.ch.intel.com ([143.182.124.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 17:59:45 +0000
Received: from jepicken by chfwpr02.ch.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 17:59:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 143.182.124.2 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89926>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> This one is difficult (and may probably produce more intrusive patch).
> Let's see what I can do.

This is not a high priority for me, so if the added
difficulty/intrusiveness means it would take longer for the sparse
checkout capability to make it into mainline git, then I would drop this
request, or at least delay it until some later time.

> >  Second, I would want a capability to checkout and release directories
> >  incrementally, similar to how we do it in cvs.  For example, I might do
> >  the following in cvs:
> 
> You can do that with "git checkout --path" (non-recursive checkout aside):
> 
> $ git checkout --path=A                     # checkout full A
> $ git checkout --path=A/B1/C1               # no, limit to A/B1/C1 only
> $ git checkout --path=A/B1/C1:A/B2          # extend to A/B2 too

My point was not that incremental checkout is impossible, just that it
would be easier if I didn't have to re-type the full path list again.
Suppose I had 9 directories (A/B1 through A/B9) in my sparse checkout,
and I wanted to add a 10th directory (A/B10).  It would be much easier
to type something like

$ cd A
$ git checkout B10

instead of

$ git checkout --path=A/B1:A/B2:A/B3:A/B4:A/B5:A/B6:A/B7:A/B8:A/B9:A/B10


Another thing I thought of, which I'm not sure if it's sensible or not,
is to make sparse checkout a persistent branch attribute by creating a
.gitpaths (or whatever) file containing a list of directories that
should be checked out.  This would be analogous to the .gitmodules file.
The .gitpaths file could then be checked in, and applied automatically
any time the user checks out a branch containing such file.  This is
just an idea for discussion, not a feature request.

James
