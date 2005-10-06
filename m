From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Thu, 6 Oct 2005 07:35:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510042155090.31407@g5.osdl.org> <7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510050725510.31407@g5.osdl.org> <7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
 <m1mzln9zi1.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
 <m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 16:43:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENWqz-0000Sh-49
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 16:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVJFOgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 10:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVJFOgJ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 10:36:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751024AbVJFOgJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 10:36:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j96EZx4s017705
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 6 Oct 2005 07:36:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j96EZw3n003353;
	Thu, 6 Oct 2005 07:35:59 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.49__
X-MIMEDefang-Filter: osdl$Revision: 1.119 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9771>



On Wed, 5 Oct 2005, Eric W. Biederman wrote:
>
> Ah.  I had missed that git-whatchanged can be given a filename that is
> nice.  One of the better kept secrets of git.  That makes my whole
> question worthwhile :)

That's definitely not a secret - it was part of the whole point of 
git-whatchanged. It's the native git version of "annotate", and I 
personally find it much more useful.

It's not even just a filename. You can do

	git-whatchanged -p drivers/scsi/ include/scsi

to limit the set to those two subdirectories. IOW, you can give 
git-whatchanged an arbitrary list of individual pathnames or directory 
names.

> But if you happen to have at least the file level sha1 you can
> actually know if the patch was against what you think it is against.

Yes, a file-level SHA1 may be useful. On the other hand, I suspect that by 
that time (since you have to search for the version anyway) you might as 
well have the "just try to apply the patch" approach. It's basically the 
same search space.

		Linus
