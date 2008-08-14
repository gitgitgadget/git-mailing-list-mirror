From: Sergio <sergio.callegari@gmail.com>
Subject: git push changes local tags
Date: Thu, 14 Aug 2008 13:29:54 +0000 (UTC)
Message-ID: <loom.20080814T132143-757@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 15:31:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTcv6-0006nI-6x
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 15:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYHNNaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 09:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbYHNNaK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 09:30:10 -0400
Received: from main.gmane.org ([80.91.229.2]:50350 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753732AbYHNNaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 09:30:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KTctu-0001nN-7L
	for git@vger.kernel.org; Thu, 14 Aug 2008 13:30:02 +0000
Received: from host82-52-dynamic.6-87-r.retail.telecomitalia.it ([87.6.52.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 13:30:02 +0000
Received: from sergio.callegari by host82-52-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 13:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.52.82 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008072820 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92356>

Hi,

I have a repo with the following in the config

remote "Skeleton"]
        url = /<something>/Skeleton/Main.skeleton.git
        push = +refs/heads/*:refs/remotes/ET-LE/*
        push = refs/tags/*:refs/tags/ET-LE/*

This may look a bit unusual, but it has a ratio:

I have a skeleton repo.  Whenever something is taken from there and modified, I
like to have it pushed back so that the changes can be evaluated and possibly
incorporated in the skeleton.

The problem is with tags.

If I do not add the push entry for the tags, the local tags pollute the Skeleton
repo in case they are pushed.

Say someone has a local repo with tag ONE and he pushes to skeleton. The tag ONE
is pushed into the Skeleton possibly overwriting some already existing tag named
ONE there.

If I do add the push entry for the tags, whenever I push an unwanted tag appears
locally.

Say, that I have locally the tag ONE, when I push I _locally_ get the tag
ET-LE/ONE that is clearly unwanted, because when I push again I get
ET-LE/ET-LE/ONE and so on.

Any idea?

Sergio   
