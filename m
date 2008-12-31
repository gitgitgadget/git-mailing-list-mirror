From: Daniel Barkalow <barkalow@iabervon.org>
Subject: RE: for newbs = little exercise / tutorial / warmup for windows and
 other non-sophisticated new Git users :-) [Scanned]
Date: Tue, 30 Dec 2008 19:15:14 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812301859100.19665@iabervon.org>
References: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Conor Rafferty <conor.rafferty@altmore.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 31 01:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHolQ-0004p4-AB
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbYLaAPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbYLaAPR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:15:17 -0500
Received: from iabervon.org ([66.92.72.58]:56679 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753272AbYLaAPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:15:15 -0500
Received: (qmail 19365 invoked by uid 1000); 31 Dec 2008 00:15:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Dec 2008 00:15:14 -0000
In-Reply-To: <BB5F02FD3789B54E8964D38D6775E718242D31@ALTMORE-SVR.altmore.local>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104232>

On Tue, 30 Dec 2008, Conor Rafferty wrote:

> I don't understand, sorry. I thought I'd already removed all files from
> the local tree, in the $ rm *.* move just above the checkout  

That removes them from the filesystem, but they're still in the index. And 
"git checkout <something> ." first gets everything that *is* in "." in
<something> into the index, and then gets everything from "." in the index 
into the filesystem.

I suppose it is questionable as to whether it ought to copy paths that 
aren't in versionA from the index into the filesystem.

To see this in a bit more detail, do:

$ rm *.*
$ git status
(notice that the deletes are in the "won't be committed" section)

Now, "git checkout <path>" will discard any changes in the "won't be 
committed" section for that path. Maybe "git checkout versionA <path>" 
should only discard changes that are in the "won't be committed" section 
for filenames that match that path and are in versionA (or are 
*different* in versionA and not removed?), but I think it's an area where, 
if you're expecting any particular behavior out of that command, you're 
likely to be surprised in some way in some situation.

	-Daniel
*This .sig left intentionally blank*
