From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 21:59:47 +0200
Message-ID: <20050912195947.GA28502@vrfy.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 22:01:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEuT4-0008Ik-Ci
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 21:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVILT7w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 15:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVILT7v
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 15:59:51 -0400
Received: from soundwarez.org ([217.160.171.123]:56291 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750769AbVILT7v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 15:59:51 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id F0EA758478; Mon, 12 Sep 2005 21:59:47 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8420>

On Mon, Sep 12, 2005 at 11:26:24AM -0700, Linus Torvalds wrote:
> On Mon, 12 Sep 2005, Kay Sievers wrote:
> >
> > Can't we teach the git tools that a "root commit" (one without a any
> > parent) is not visible as a "root", if let's say:
> >   .git/parents/<root-commit-id> -> <fake-parent-id>
> > 
> > does connect a "fake" parent to the "root"? This way we could add any
> > older Linux history to the current tree. Combined with "alternates" it
> > could live in a complete different repository too.
> 
> Ehh.. That's exactly what "grafting" is about.
> 
> So just do
> 
> 	echo "<root-id> <grafted-parent-id>" >> .git/info/grafts
> 
> and it should all work.
> 
> Of course, anything that parses the commits by hand won't see it, but all 
> the regular tools hopefully do.

Yup, tried it and works nicely with the history.git tree on kernel.org
connected to your tree, replacing the initial commit.

And good to know about that, need to fix the "parent" link in gitweb to
respect grafts.

Thanks,
Kay
