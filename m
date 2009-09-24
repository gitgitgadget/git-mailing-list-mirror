From: Eric Raible <raible@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Thu, 24 Sep 2009 16:45:26 +0000 (UTC)
Message-ID: <loom.20090924T184504-686@post.gmane.org>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>  <m3bpl0c2cf.fsf@localhost.localdomain> <5b5e291e0909240225q49a202abk7cf1a0c8f715ad5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 18:46:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqrSK-0005sq-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752408AbZIXQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 12:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbZIXQpz
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 12:45:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:38559 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbZIXQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 12:45:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MqrS6-0005nw-1q
	for git@vger.kernel.org; Thu, 24 Sep 2009 18:45:56 +0200
Received: from adsl-63-197-71-184.dsl.snfc21.pacbell.net ([63.197.71.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 18:45:54 +0200
Received: from raible by adsl-63-197-71-184.dsl.snfc21.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 Sep 2009 18:45:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 63.197.71.184 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.21 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129048>

Deon George <deon.george <at> gmail.com> writes:

> > Third, if the above isn't what you want, then you can manually
> > intermingle working directories of different git repositories
> > (probably requiring decouplig of bare git repository (git-dir)
> > from working area (work-tree)).
> 
> Ahh, now this sounds like it might be what I want to do - I think I'll
> explore this. I can see that it would provide file level autonomy
> only, but as a starting point I think it will help heaps...

Proof of concept:

export GIT_WORK_TREE=.

git --git-dir=.git1 init
git --git-dir=.git1 add view1-file
git --git-dir=.git1 commit -m"view1 initial"

git --git-dir=.git2 init
git --git-dir=.git2 add view1-file
git --git-dir=.git2 commit -m"view2 initial"

git --git-dir=.git1 log
git --git-dir=.git2 log
