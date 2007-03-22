From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-apply: Do not free the wrong buffer when we convert
 the data for writeout
Date: Thu, 22 Mar 2007 13:55:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703221355110.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
 <7virctt3yi.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUUJu-00066l-LN
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 21:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXCVUzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbXCVUzf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 16:55:35 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51263 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbXCVUzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 16:55:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MKtUG9019984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 13:55:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MKtTQn030138;
	Thu, 22 Mar 2007 13:55:30 -0700
In-Reply-To: <7virctt3yi.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.469 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42880>



On Thu, 22 Mar 2007, Junio C Hamano wrote:
> 
> This patch also moves the call to open() up in the function, as
> the caller expects us to fail cheaply if leading directories
> need to be created (and then the caller creates them and calls
> us again).  For that calling pattern, attempting conversion
> before opening the file adds unnecessary overhead.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Ack, looks good.

		Linus
