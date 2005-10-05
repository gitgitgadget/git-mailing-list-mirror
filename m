From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 5 Oct 2005 15:45:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510051541300.31407@g5.osdl.org>
References: <20051005191300.GC17475@hexapodia.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 00:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENI14-0001t2-Gz
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 00:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVJEWpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 18:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVJEWpU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 18:45:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030406AbVJEWpT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 18:45:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j95MjG4s005125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 5 Oct 2005 15:45:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j95MjFRd003963;
	Wed, 5 Oct 2005 15:45:16 -0700
To: Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20051005191300.GC17475@hexapodia.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9742>



On Wed, 5 Oct 2005, Andy Isaacson wrote:
>
> Trying to do a local clone of the linux-mips.org git repo:
> 
> % git clone /home/adi/linux/git/lmo/linux foo
> defaulting to local storage area
> fatal: I'm only doing a max of 256 requests

The pack upload has a totally arbitrary limit of 256 heads.

> I got git/lmo/linux from http://www.linux-mips.org/pub/scm/linux.git.

Heh. And:

	git ls-remote http://www.linux-mips.org/pub/scm/linux.git | wc -l

returns "295". Seems to have all the old bk history in it.

> Am I doing something wrong, or what?

No, just change the "MAX_NEEDS" define from 256 to some larger value.

There's no real reason for the limit, except that maybe we should have 
some dynamic allocation for this.

		Linus
