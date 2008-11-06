From: Mark Burton <markb@ordern.com>
Subject: Re: Issue updating files during a checkout from a remote push
Date: Thu, 6 Nov 2008 17:53:05 +0000 (UTC)
Message-ID: <loom.20081106T174246-381@post.gmane.org>
References: <334B3AB1-125A-4163-BEBC-9A73C4F569B5@idibu.com> <09C2A669-2B99-4490-9C95-FCCD76C03D61@idibu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 18:54:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky93y-0007Dj-0K
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 18:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbYKFRxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 12:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYKFRxQ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 12:53:16 -0500
Received: from main.gmane.org ([80.91.229.2]:40152 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYKFRxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 12:53:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ky92e-0007V4-HX
	for git@vger.kernel.org; Thu, 06 Nov 2008 17:53:12 +0000
Received: from host86-128-20-200.range86-128.btcentralplus.com ([86.128.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 17:53:12 +0000
Received: from markb by host86-128-20-200.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 17:53:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.20.200 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100258>


Hi Steve,

I think you are making the same mistake as I did when I first started using git.

You can't push to "master" from a remote repository because if you do, the index
and working files associated with the receiving repository look as if they have
been changed because they are out of date WRT the repository.

If you want to push to a repository that has working files associated with it,
push to a remote branch in that repository and then merge the contents of the
remote branch into the working files. I.e. don't push to "master", push to
"remotes/somename/master" and then merge somename/master into the master branch.

That's what I do now to migrate changes from my satellite development machines
to my master machine.

Cheers,

Mark
