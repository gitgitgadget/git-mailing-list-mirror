From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] Add generic 'strbuf_readlink()' helper function
Date: Wed, 17 Dec 2008 13:44:12 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812171343230.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>  <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain> <76718490812171326q4d8896c1yb535873c71eec23f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 22:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4Do-0003QF-H5
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYLQVpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYLQVpG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:45:06 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48596 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494AbYLQVpE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 16:45:04 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHLiDZw004981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Dec 2008 13:44:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHLiCCA012200;
	Wed, 17 Dec 2008 13:44:13 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <76718490812171326q4d8896c1yb535873c71eec23f@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.923 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103396>



On Wed, 17 Dec 2008, Jay Soffian wrote:
> > +               /* .. the buffer was too small - try again */
> > +               hint *= 2;
> > +               continue;
> > +       }
> 
> Why the continue statement at the end of the loop?

Oh, it's unnecessary left-over from me originally writing that part inside 
an if-statement, and then moving things around.

So it could/should be deleted. Good eyes.

		Linus
