From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git://oss.sgi.com broke
Date: Mon, 6 Oct 2008 10:14:06 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810061005540.3208@nehalem.linux-foundation.org>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: xfs-masters@oss.sgi.com, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 19:19:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmtgT-0002ct-GG
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbYJFROi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbYJFROi
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:14:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40382 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752641AbYJFROh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 13:14:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96HE6Ac029134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Oct 2008 10:14:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m96HE6CN028836;
	Mon, 6 Oct 2008 10:14:06 -0700
In-Reply-To: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-2.891 required=5 tests=AWL,BAYES_00,WEIRD_PORT
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97606>



On Fri, 3 Oct 2008, Andrew Morton wrote:
>
> y:/usr/src/git26> git --version
> git version 1.5.6.rc0
> 
> y:/usr/src/git26> cat .git/branches/git-xfs
> git://oss.sgi.com:8090/xfs/xfs-2.6.git#master

Hmm. That's the really old and deprecated branch format.

I'm getting a "Connection refused" from oss.sgi.com, and I think there's 
possibly something broken there, but quite independently of that, maybe we 
can try to teach you another way to set up remote branches?

In your .git/config file, use

	[remote "git-xfs"]
		url = git://oss.sgi.com:8090/xfs/xfs-2.6.git
		fetch = master

because the whole .git/branches/<branch-name> thing is fairly deprecated, 
and cannot handle some things that the .git/config file format can (like 
saying where to fetch into, or how to push back etc).

		Linus
