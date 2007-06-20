From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Finally implement "git log --follow"
Date: Wed, 20 Jun 2007 09:47:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
 <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 18:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I13Lr-0004cQ-SB
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 18:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXFTQsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbXFTQsL
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 12:48:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52673 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580AbXFTQsK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2007 12:48:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5KGlY0m024791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 20 Jun 2007 09:47:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5KGlSPA009799;
	Wed, 20 Jun 2007 09:47:28 -0700
In-Reply-To: <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com>
X-Spam-Status: No, hits=-2.514 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50560>



On Wed, 20 Jun 2007, Marco Costalba wrote:
> 
>  now I have one more reason to switch from using git-rev-list to
> git-log in qgit, file history annotation, that is currently based on
> git-rev-list, will automatically gain a powerful feature.

Well, note my other email about how "--follow" does *not* play together 
with "--parents", because the two do totally different kinds of filtering 
of the commits. So yes, you can use it for file history annotation, but 
not for the "graphical history" part that depends on parenthood etc.

That said, you really would be better off using

	git blame -M --incremental

for the history annotation. It does the rename following *and* so much 
more.

		Linus
