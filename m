From: David Kastrup <dak@gnu.org>
Subject: 100% (was: [PATCH] diffcore-rename: favour identical basenames)
Date: Fri, 22 Jun 2007 12:52:29 +0200
Message-ID: <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
References: <20070621030622.GD8477@spearce.org> <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org> <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net> <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com> <Pine.LNX.4.64.0706221122200.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 13:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1hja-00020s-IG
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 13:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbXFVLzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 07:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXFVLzT
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 07:55:19 -0400
Received: from main.gmane.org ([80.91.229.2]:49492 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbXFVLzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 07:55:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I1hNg-00054T-9e
	for git@vger.kernel.org; Fri, 22 Jun 2007 13:32:48 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 13:32:48 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 13:32:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:qWb0dyQ+Naj5CDFaAgNV6I77pUA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50691>


> Footnote:
>
> *1* Actually, it is not _that_ bad. The score is not a value between 0 and 
>     100, IOW it is _not_ what you see in the output of "diff -M". It is an 
>     unsigned short between 0 and MAX_SCORE, which is defined in 
>     diffcore.h as 60000.0.
>
>     The Levenshtein distance between two filenames cannot be larger than 
>     the sum of their lengths, so it should be relatively safe. That is, if 
>     you don't have such insanely long paths as e.g. egit. But even there, 
>     the paths share most of their directories, and therefore the distances 
>     should be much, much smaller in real life.

As a note aside: would it be possible to always round downwards when
computing similarities or converting between them?

I very much would like to see the 100% figure reserved for identity.
This is particularly relevant when interpreting the output of git-diff
--name-status with regard to R100, C100 and similar flags.

-- 
David Kastrup
