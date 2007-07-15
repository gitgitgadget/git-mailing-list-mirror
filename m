From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Exporting a tree from a repository
Date: Sun, 15 Jul 2007 11:15:10 +0200
Message-ID: <20070715091510.GC2568@steel.home>
References: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com> <Pine.LNX.4.64.0707142237190.13310@beast.quantumfyre.co.uk> <8e04b5820707150012r13c5db69g96b97d910dc1b137@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 11:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA0CD-0003Zm-W4
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 11:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbXGOJPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 05:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbXGOJPO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 05:15:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:8882 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbXGOJPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 05:15:12 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo14) (RZmta 8.3)
	with ESMTP id d01b59j6F3E5ob ; Sun, 15 Jul 2007 11:15:10 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 43F4C277BD;
	Sun, 15 Jul 2007 11:15:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1EC7AC164; Sun, 15 Jul 2007 11:15:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8e04b5820707150012r13c5db69g96b97d910dc1b137@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52536>

Ciprian Dorin Craciun, Sun, Jul 15, 2007 09:12:08 +0200:
>    Now for the export thing... I know that I can just clone the
> remote repository and then remove the .git folder, but for my purpose
> I just want to have the HEAD tree downloaded, without any history...
> And by using git clone I end up downloading much more than I actually
> need.

Well, if you have a ssh access to remote repository, you can run
git-archive there:

    $ ssh -n 'cd /dir/repo/.git && git --bare archive --prefix=<local-path> <tree>' |tar xf -

or even simplier:

    $ git archive --remote=<remote-host:remote-path> --prefix=<local-path>/ <tree> |tar xf -

(for whatever reason it does not work with just git-daemon).
