From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 13:20:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211318550.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:22:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIB5L-00066S-6A
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIUUUw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbVIUUUw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:20:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbVIUUUw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 16:20:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LKKaBo015919
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 13:20:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LKKY7f026876;
	Wed, 21 Sep 2005 13:20:36 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9075>



On Wed, 21 Sep 2005, Linus Torvalds wrote:
> 
> If the new merge policies do not allow that, then the new merge policies 
> are incredibly broken.

I just checked.

It _is_ incredibly broken. 

It will do 

	echo "Rewinding the tree to pristine..."
	git reset --hard $head

if any merge strategy every fails, so that check is needed for the new 
merger.

This makes merges totally unusable. It feels like the dark ages.

		Linus
