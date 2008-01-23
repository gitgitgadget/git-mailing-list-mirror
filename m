From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why does git track directory listed in
 .gitignore/".git/info/exclude"?
Date: Wed, 23 Jan 2008 13:17:28 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: pradeep singh rautela <rautelap@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHmyx-0006dX-9q
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 22:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYAWVRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbYAWVRc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 16:17:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36172 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752249AbYAWVRb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 16:17:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NLHT5c002114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jan 2008 13:17:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0NLHS7J026844;
	Wed, 23 Jan 2008 13:17:28 -0800
In-Reply-To: <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-1.797 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71571>



On Wed, 23 Jan 2008, pradeep singh rautela wrote:
>
> Apologies to all.Kindly pardon my novice experiments with git.
> Some more trial and error method led to find that you have to put a *
> at the end of the directory too.
>
> i.e xen-3.1.0-src/*
> 
> But i still would like to ask git gurus here.
> Isn't it fine to include a directory name as
> 
>    $directory_name/
>     instead of
>    $directory_name/*

Heh.

I think your problem is that "/" itself. By adding it, the exclude 
information does *not* match the directory entry itself (because the 
directory entry itself is called just "xen-3.1.0-src" - note no slash!), 
and since you added it, it also doesn't match any names _under_ that 
directory exactly.

So what you *should* have done is to just tell git to ignore the directory 
named "xen-3.1.0-src", and you'd have been ok.

Using "xen-3.1.0-src/*" works too, but it is heavy-handed and unnecessary.

		Linus
