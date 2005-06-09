From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 8 Jun 2005 18:08:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081757170.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 03:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgBTR-0005eJ-Kr
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 03:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVFIBIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 21:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFIBI3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 21:08:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:19095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262223AbVFIBHA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 21:07:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5916ejA011123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 18:06:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5916dXQ029797;
	Wed, 8 Jun 2005 18:06:39 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voeag1j9y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 8 Jun 2005, Junio C Hamano wrote:
> 
> Consider the following two command sequences:
> 
>      (1) git-read-tree -m $H $M	&& git-write-tree
> 
>      (2) I=`git-write-tree` &&
>          git-read-tree -m $H $I $M &&
>          git-merge-cache -o git-merge-one-file-script -a &&
>          git-write-tree
> 
> I think they should be equivalent in that:
> 
>    - when (1) refuses to run, (2) should either cause
>      git-read-tree to refuse, or at least should result in an
>      unmerged cache and git-write-tree phase should fail;
> 
>    - when (1) succeeds, (2) should also succeed, and the
>      resulting tree from both should be the same.

I think that sounds reasonable. Is it not the case now?

		Linus
