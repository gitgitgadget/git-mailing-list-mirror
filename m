From: Bill Lear <rael@zopyra.com>
Subject: Re: git-push through git protocol
Date: Sun, 21 Jan 2007 14:09:19 -0600
Message-ID: <17843.51311.784904.54317@lisa.zopyra.com>
References: <17843.29798.866272.414435@lisa.zopyra.com>
	<ep00nl$mop$1@sea.gmane.org>
	<Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 21:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8j0O-0006Eg-Gl
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 21:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbXAUUJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 15:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXAUUJa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 15:09:30 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61254 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492AbXAUUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 15:09:29 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0LK9Lt14981;
	Sun, 21 Jan 2007 14:09:21 -0600
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701211034490.14248@woody.osdl.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37340>

Interesting.  This is exactly (if memory serves) the patch that I
tried myself, but in retrospect, I think I only tried it on the client
side, for some idiotic reason (I'll plead cold weather here in
Austin).  I'll see if I can get this installed and tested.

Thanks Linus.


Bill

On Sunday, January 21, 2007 at 11:04:13 (-0800) Linus Torvalds writes:
>
>
>On Sun, 21 Jan 2007, Jakub Narebski wrote:
>> > 
>> > It seems there should be a way to configure a repo or the git daemon
>> > to say "Allow push operations".
>> > 
>> > I looked through the release notes Junio posted for 1.5.0-rc2, but
>> > found no reference to the git daemon.
>> 
>> git:// protocol is not authenticated. git by design allow push only through
>> authenticated protocols, i.e. local, ssh:// (git+ssh://), http(s):// with
>> WebDAV, probably in the future ftps://. 
>
>Well, it _should_ actually be truly fairly trivial to allow pushing over 
>the git:// protocol, and while it's not authenticated, I could well 
>imagine that it would make sense from within a firewalled setup (where 
>nobody but trusted internal people can reach the git port anyway).
>
>So in that sense, I do think Bill's request makes some amount of sense.
>
>At the same time, I suspect it's not a great idea, unless you also add 
>*some* kind of logging facility to git-daemon.
>
>But here is a trivial patch that *MAY* do what Bill wants.
>
>NOTE! "git-receive-pack" is disabled by default, so you need to enable it 
>explicitly by starting git-daemon with the "--enable=receive-pack" command  
>line argument, or by having your config enable it automatically.
>
>And a second note: I obviously didn't test it. I'm Linus. I don't do no 
>steenking testing..
