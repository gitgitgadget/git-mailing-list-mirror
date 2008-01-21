From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Files not deleted when merging after a rename
Date: Mon, 21 Jan 2008 22:20:15 +0100
Message-ID: <20080121212015.GB5263@steel.home>
References: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Desnoyer <mdesnoyer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:21:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH44i-0008HL-30
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbYAUVUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbYAUVUT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:20:19 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:63468 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYAUVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:20:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKatAU=
Received: from tigra.home (Fab8e.f.strato-dslnet.de [195.4.171.142])
	by post.webmailer.de (klopstock mo3) (RZmta 15.4)
	with ESMTP id g05b65k0LIMH52 ; Mon, 21 Jan 2008 22:20:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B5C8D277AE;
	Mon, 21 Jan 2008 22:20:15 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 27A4B56D25; Mon, 21 Jan 2008 22:20:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71344>

Mark Desnoyer, Mon, Jan 21, 2008 20:45:07 +0100:
> Hi,
> 
> I've run across a small problem and I was wondering if I could get
> some help. I have two users A and B. They are both git-cloned from a
> common repository on a different server.
> 
> User A moves a directory:
> foo/bar/ ==> bar
> using:
> git mv foo/bar bar
> git commit
> git push
> 
> Meanwhile, user B is doing some other changes that are completely
> unrelated and has a few local commits. Now, when user B pulls from the
> repository (git pull), and returns no errors merging, the directory
> "bar" is created, but "foo/bar" is not deleted, although, it becomes
> untracked.

Directories are never tracked. It should have been deleted though.
Did it have (or still has) some untracked files in it?
