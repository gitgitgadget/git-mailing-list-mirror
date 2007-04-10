From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 08:52:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704100849170.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org> 
 <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com> 
 <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
 <81b0412b0704100835vbbfe8e7o2df2f121ce088589@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbIe8-0001di-8Y
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030899AbXDJPwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030922AbXDJPwM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:52:12 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33144 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030899AbXDJPwK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 11:52:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AFq4VZ001614
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 08:52:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AFq20F011124;
	Tue, 10 Apr 2007 08:52:03 -0700
In-Reply-To: <81b0412b0704100835vbbfe8e7o2df2f121ce088589@mail.gmail.com>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44149>



On Tue, 10 Apr 2007, Alex Riesen wrote:
> 
> After a bit of thinking I could imagine a repo which is
> used for integration exclusively (no compilation or looking
> at the files at all).

Well, you also cannot *commit* to a bare repository, so it's a bit 
pointless for integration reasons. You'd still have to commit all changes 
somewhere else.

That said, it's definitely designed so that if you want to automate 
tracking other peoples bare repositories, you can do so: you'd just have 
to *really* script it with something like

	git update-index --cacheinfo 0160000 <sha1> <dirname>

(which is how you could create those commits to a bare repo too, so it's 
not like this is really even any different)

		Linus
