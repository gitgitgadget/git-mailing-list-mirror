From: John Chapman <thestar@fussycoder.id.au>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for
	problematic files? [Was: Re: after first git clone of linux kernel
	repository there are changed files in working dir]
Date: Wed, 21 Jan 2009 08:28:49 +1100
Message-ID: <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	 <83ocy3fmez.fsf@kalahari.s2.org>
	 <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
	 <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Hannu Koivisto <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPP5l-0000TY-9T
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbZATW1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbZATW1f
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:27:35 -0500
Received: from nskntqsrv02p.mx.bigpond.com ([61.9.168.234]:52953 "EHLO
	nskntqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754497AbZATW1e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 17:27:34 -0500
Received: from nskntotgx02p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas01p.mx.bigpond.com with ESMTP
          id <20090120211627.DVWR6186.nskntmtas01p.mx.bigpond.com@nskntotgx02p.mx.bigpond.com>;
          Tue, 20 Jan 2009 21:16:27 +0000
Received: from therock.local ([58.173.132.215])
          by nskntotgx02p.mx.bigpond.com with ESMTP
          id <20090120211622.GKOF12531.nskntotgx02p.mx.bigpond.com@therock.local>;
          Tue, 20 Jan 2009 21:16:22 +0000
In-Reply-To: <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150202.49763F27.0028,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106535>

On Tue, 2009-01-20 at 15:11 -0500, Daniel Barkalow wrote:
<snip>
> 
> The hard part is actually identifying what the user's filesystem has done. 
> There's pretty good internal support for git knowing that, for a 
> particular entry, the filesystem should not be consulted for information. 
> I don't think anyone's come up with a suitably cross-platform and 
> automatic way to figure out what's happened when git tries to write to a 
> particular filename and the system decides it is the same as some other 
> filename or it decides to use a different filename instead.

This would only need to interact with the git status command, wouldn't
it?

> 
> Of course, it is reasonably likely that a project whose files can't all be 
> checked out can't be dealt with anyway on that platform (IIRC, the Linux 
> kernel build system assumes that it can create both .S and .s files, so it 
> won't build on FAT). So nobody's been sufficiently motivated to try to 
> implement a fix.

I doubt the kernel builds on windows, but this would allow a windows
user to modify such files, perhaps in preparation for a patch that does
allow the kernel to be built on windows?
(Of course, we're using the kernel here as an example, right?  Nobody
would be insane as to want to use windows for that!)

See, a very annoying thing about windows is that it is quite simple for
a team to commit two files that differ by case alone to a git
repository.

Was just an idea, really.
