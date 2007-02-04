From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Sun, 04 Feb 2007 22:34:13 +0100
Organization: At home
Message-ID: <eq5jdt$173$1@sea.gmane.org>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net> <7vps8qtgbm.fsf@assigned-by-dhcp.cox.net> <20070204185144.GB24368@coredump.intra.peff.net> <Pine.LNX.4.64.0702041111010.8424@woody.linux-foundation.org> <20070204205858.GE12943@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 22:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDozJ-0001cN-RV
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 22:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbXBDVdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 16:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXBDVdH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 16:33:07 -0500
Received: from main.gmane.org ([80.91.229.2]:60621 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbXBDVdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 16:33:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HDoyq-0005vl-QO
	for git@vger.kernel.org; Sun, 04 Feb 2007 22:33:00 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 22:33:00 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 22:33:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38710>

Theodore Tso wrote:
> On Sun, Feb 04, 2007 at 11:12:34AM -0800, Linus Torvalds wrote:
>> On Sun, 4 Feb 2007, Jeff King wrote:
>>> 
>>> Just a thought, but it might be useful to blame the contents of an
>>> arbitrary file (but starting the history at a given pathname). Something
>>> like "git blame --contents /tmp/foo.c file.c", with contents defaulting
>>> to "file.c". There's much discussion of editor interfaces, and this
>>> leaves the possibility of git-blaming the contents of the editor buffer
>>> (after writing it out to a temp file) without having to save changes to
>>> the working tree file.
>> 
>> I agree, that probably would make most sense. If we do this at all. On the 
>> other hand, I suspect that most editors would probably want to pipe the 
>> contents to the program, not write it to a temp-file.
> 
> ... and use it with --incremental, as well.  In emacs you can have the
> annotation take place as it is being written out relatively easily, by
> arranging to have a callback function get called each time more
> information is handed back to emacs via a pipe.

So perhaps instead of "git blame --contents /tmp/foo.c file.c" we should
have "cat /tmp/foo.c | git blame --stdin file.c", hmmm? Editor would then
pipe current contents of the buffer to "git blame --stdin --incremental
file.c" (where file.c is the name in tree/in HEAD).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
