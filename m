From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 5 Aug 2007 10:04:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708051000130.5037@woody.linux-foundation.org>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
 <alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
 <87hcnejuxp.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHjXw-0003kp-3F
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbXHERFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753552AbXHERFh
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:05:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56680 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753417AbXHERFg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 13:05:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75H4cWZ032107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 5 Aug 2007 10:04:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l75H4WKY017574;
	Sun, 5 Aug 2007 10:04:32 -0700
In-Reply-To: <87hcnejuxp.fsf@catnip.gol.com>
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55043>



On Sun, 5 Aug 2007, Miles Bader wrote:
> 
> I notice that "git ls-files -o" doesn't do normal ignore-processing, so
> for instance all my .o and editor backup files show up in the output...

Yeah, I'm a moron.

> Is that expected or is it a bug

It's expected (I just didn't try the command line I gave you).

"git ls-files" is low-level plumbing, and those things generally do only 
what you ask from them and never anything user-friendly. In particular, 
they tend to avoid policy decisions. An example of this is "git diff" that 
colorizes the output by default as you have specified, but "git diff-tree" 
that does not.

			Linus
