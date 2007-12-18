From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 23:29:55 +0100
Message-ID: <20071218222955.GI2875@steel.home>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com> <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org> <56b7f5510712181408g4aee55d2j2a7f0f13bf90323d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:30:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kxB-0005ny-ET
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbXLRW36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXLRW36
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:29:58 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:25929 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbXLRW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:29:57 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+a72E=
Received: from tigra.home (Fc89a.f.strato-dslnet.de [195.4.200.154])
	by post.webmailer.de (fruni mo14) (RZmta 14.6)
	with ESMTP id d03628jBIJr8NM ; Tue, 18 Dec 2007 23:29:55 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AFF33277AE;
	Tue, 18 Dec 2007 23:29:55 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 37B7256D22; Tue, 18 Dec 2007 23:29:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56b7f5510712181408g4aee55d2j2a7f0f13bf90323d@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68836>

Dana How, Tue, Dec 18, 2007 23:08:33 +0100:
> When it *does* refer to a commit,  then for commit:relpath you prefix
> relpath with the suffix of the cwd which is an extension beyond the root
> of the working tree.

...universally known as "prefix" (the last argument of builtin
commands) :)

> > where the magic is *not* done by any "SHA1 path lookup" at all, but is
> > simply done by the commit->tree lookup. At least at that point it would
> > make logical sense (although it would probably be quite painful to
> > implement).
> 
> I must be missing something.  The old patch I submitted did this.
> Its defect was that it did NOT make the cwd insertion conditional
> on whether the tree-ish involved a commit or not (a test which also
> _seems_ doable,  but I don't think I finished it & sent it in).

It is also a bit painful: lots of funtions (sha1_name.c) will have
their prototypes changed to get the prefix (aka suffix). And their
callers...
