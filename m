From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 14:43:41 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712021441110.8458@woody.linux-foundation.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net> <7vmyssvn55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712021322580.8458@woody.linux-foundation.org>
 <7v1wa4vkev.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:45:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxYb-0008DB-Jh
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbXLBWom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXLBWom
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:44:42 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54775 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbXLBWol (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 17:44:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2MhgHV017654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Dec 2007 14:43:43 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2Mhf8V003196;
	Sun, 2 Dec 2007 14:43:42 -0800
In-Reply-To: <7v1wa4vkev.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66831>



On Sun, 2 Dec 2007, Junio C Hamano wrote:
> 
> I recall that the very initial git did not use the current format for
> timestamp but ctime() return value

Yes, but..

> and this will also notice them (and convert-objects will be there for 
> us).

.. I don't think we have actually accepted the ctime-string format since 
switchng over, so no existing git repositories will have them. The commit 
date parsing just does a "strtoul()" in parse_commit_date().

So I wouldn't expect convert-objects to be needed - or rather, it was 
needed 2.5 _years_ ago, and we've not supported those early broken formats 
since, afaik.

			Linus
