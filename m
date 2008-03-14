From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Segmentation fault      git read-tree
Date: Thu, 13 Mar 2008 21:30:35 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803132127281.3557@woody.linux-foundation.org>
References: <200803132359.06745.lenb@kernel.org> <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Len Brown <lenb@kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja1Zp-0005ip-B5
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 05:31:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbYCNEav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 00:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbYCNEau
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 00:30:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39776 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491AbYCNEau (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 00:30:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4VTfi009711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Mar 2008 21:31:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2E4UZ57016830;
	Thu, 13 Mar 2008 21:30:35 -0700
In-Reply-To: <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.349 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77167>



On Thu, 13 Mar 2008, Linus Torvalds wrote:
>
> Ok, I can reproduce this, I'm on it like a maggot on a two-week-dead baby 
> donkey.

Ooh, interesting. Compiling with debugging makes the SIGSEGV go away, and 
replaces it with an endless loop.

The SIGSEGV when non-debugging seems to be due to a corrupt "info->prev" 
pointer chain, but this was less obvious than I hoped it would be.

Still looking.

		Linus
