From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Wed, 27 Apr 2005 18:31:47 -0400
Message-ID: <200504271831.47830.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <200504271423.37433.mason@suse.com> <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 00:35:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQv7W-000677-Ux
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 00:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVD0Wij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVD0WfM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 18:35:12 -0400
Received: from ns1.suse.de ([195.135.220.2]:44168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262050AbVD0Wby (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 18:31:54 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 97C17160DFD6;
	Thu, 28 Apr 2005 00:31:50 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 27 April 2005 18:19, Linus Torvalds wrote:
> On Wed, 27 Apr 2005, Chris Mason wrote:
> > So, new prog attached.  New usage:
> >
> > file-changes [-c commit_id] [-s commit_id] file ...
> >
> > -c is the commit where you want to start searching
> > -s is the commit where you want to stop searching
>
> Your script will do some funky stuff, because you incorrectly think that
> the rev-list is sorted linearly. It's not. It's sorted in a rough
> chronological order, but you really can't do the "last" vs "cur" thing
> that you do, because two commits after each other in the rev-list listing
> may well be from two totally different branches, so when you compare one
> tree against the other, you're really doing something pretty nonsensical.

Aha, didn't realize that one.  Thanks, I'll rework things here.

-chris
