From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames
 only)
Date: Mon, 22 Oct 2007 09:33:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Oct 22 18:34:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik0E3-0002M9-Eb
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 18:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXJVQds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXJVQds
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 12:33:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49435 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751362AbXJVQdr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 12:33:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MGXAn6016036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 09:33:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MGX6jZ002927;
	Mon, 22 Oct 2007 09:33:09 -0700
In-Reply-To: <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62024>



On Mon, 22 Oct 2007, Sven Verdoolaege wrote:
> 
> Aren't you truncating the ptr list after the first entry here?
> (While you still need the whole list in free_file_table.)

Yes. I didn't have that bug in the first version (I didn't do a separate 
"free_file_table()" at all - I just free'd the src/dst pointer lists at 
the end of that function). But I wanted to "clean up" the thing. Duh.

		Linus
