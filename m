From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/7] gitweb: Trying to improve history view speed
Date: Wed, 6 Sep 2006 12:04:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061202230.27779@g5.osdl.org>
References: <200609061504.40725.jnareb@gmail.com> <Pine.LNX.4.64.0609060847521.27779@g5.osdl.org>
 <edmv57$lt7$1@sea.gmane.org> <Pine.LNX.4.64.0609061125000.27779@g5.osdl.org>
 <edn54s$c4s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 21:04:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL2he-0007pj-1p
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 21:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWIFTEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 15:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWIFTEr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 15:04:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43702 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751223AbWIFTEq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 15:04:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86J4cnW017501
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 12:04:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86J4WP5020743;
	Wed, 6 Sep 2006 12:04:36 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edn54s$c4s$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.994 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26551>



On Wed, 6 Sep 2006, Jakub Narebski wrote:
> 
> Well, I just didn't realize that --parents gives parents in _simplified_
> history, unless --full-history is used. Hence my confusion.

Right. That's really the main reason for "--parents" existing in the first 
place. I added it exactly so that "gitk" would work with pathname 
limiting.

If you don't want the simplified history parents, you might as well just 
parse the parents information directly from the commit data yourself 
(although with grafting, there's arguably _some_ reason to have 
git-rev-list do it for you regardless of simplification).

			Linus
