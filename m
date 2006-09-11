From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Start handling references internally as a sorted in-memory list
Date: Mon, 11 Sep 2006 16:50:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609111647000.27779@g5.osdl.org>
References: <Pine.LNX.4.64.0609111158390.3960@g5.osdl.org>
 <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 12 01:50:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMvXl-00077E-PP
	for gcvg-git@gmane.org; Tue, 12 Sep 2006 01:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWIKXuV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 19:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWIKXuV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 19:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965167AbWIKXuT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 19:50:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8BNoFnW004215
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Sep 2006 16:50:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8BNoEtk000753;
	Mon, 11 Sep 2006 16:50:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0609111632050.27779@g5.osdl.org>
X-Spam-Status: No, hits=-0.522 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26869>



On Mon, 11 Sep 2006, Linus Torvalds wrote:
> 
> And yeah, I know that the "sorting" code is O(n**2) thanks to doing an 
> insertion sort into a simple linked list. Tough. I didn't care enough to 
> do it well. With "n" usually being a few hundred at most, we really don't 
> care, and if we ever do, we _can_ fix it later on to use a heap or 
> something.

Btw, to expand on that - one of the nice things from this whole re-org of 
how we handle refs is that when you do

	git-rev-parse --all

it now sorts them in a reliable order - by name. Before, they came out in 
some random order that totally depended on the filesystem that the 
references were on.

Use the "--symbolic --all" to see this in a more obvious way, before and 
after.

		Linus
