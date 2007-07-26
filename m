From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Thu, 26 Jul 2007 13:51:12 +0200
Message-ID: <46d6db660707260451l7dd6b54o3b4d434e0468cf55@mail.gmail.com>
References: <46A5B5F5.6000202@trolltech.com> <46A6F21D.2010306@trolltech.com>
	 <Pine.LNX.4.64.0707251024390.14781@racer.site>
	 <200707251205.48235.andyparkins@gmail.com>
	 <alpine.LFD.0.999.0707251327390.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Julian Phillips" <julian@quantumfyre.co.uk>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 13:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE1sY-0003VI-3Q
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 13:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbXGZLvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 07:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbXGZLvP
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 07:51:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:4677 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbXGZLvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 07:51:13 -0400
Received: by wa-out-1112.google.com with SMTP id v27so553300wah
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 04:51:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LRcJ5h9m78iJZHp/QY5NecsAWvrKW/rB85f0J+Ia41XhS/UlSbihJReu2tvn6WRmn0WbWGs3umZgmTTR9qsEBI6iiv5cuEz6VfenqgHajcfEsE4Ycz/4R/DB2xiFFre0F1zcd6uTXyIXwbYdLk8JznRssSI3ZKLJ+4px2pOsU0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fqKBPyPNfgucdp0keDUz4mgIv9rIYCBhP5r3+iwuoHvhBgRNeP9X2VSEUWOgkyHkgO9fv4IEGOuB/jheRj1e4ZdnsEh/jaePX1Jjl08wDmThY+In6LwuMkx/6xjQ+k2SIw7Z2tY2SuhuDcKeMkugu1LWtTQIYxIuLBJORHoMHtc=
Received: by 10.114.190.6 with SMTP id n6mr1647746waf.1185450672161;
        Thu, 26 Jul 2007 04:51:12 -0700 (PDT)
Received: by 10.115.78.15 with HTTP; Thu, 26 Jul 2007 04:51:12 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707251327390.3607@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53820>

On 7/25/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Now, admittedly, I think one issue with Windows is that the "hump" is
> simply much bigger. The initial cost (not necessarily in money, but in
> effort) of getting involved in a development process is just a *lot*
> higher for Windows users than it is for just about any UNIX.
>
> If you're on some unix platform, the cost of getting involved is basically
> that the project should already work to some degree, and then there may be
> some relatively *trivial* issues with making sure that you've got a
> compiler installed and the basic libraries. But that's really quite easy
> on just about any UNIX, to the point that most people don't even have to
> think about it.

http://www.openlina.org could closing this gap, as a temp fix.

It's supposed to help running linux native binaries on windows through
some virtualization layer. Speed is supposed to be good, the host filesystem
is supposed to be accessible. Many suppositions, I haven't evaluated
this beast yet.

If this is truly usable, it would mean an easy migration for unix users,
using the command line.

For true windows users, git-gui, gitk and ultimately a windows explorer
plugin/addon will be needed still, as mentionned earlier in this thread.

It is to be noted though that C conversion and shell replacement
will not be all that is needed.

Today, I've a colinux environment containing git-1.5.2.3 and all needed
tools for development (shell, compiler, editor). When I perform some git
operations in any linux controlled filesystem (ramfs, ext2 over cobd), no
problem, git works as advertised.

When I used shared windows folder in the ntfs filesystem, there are
issues. Fsync fails when writing files (could be colinux related), but
git-init produces different .git/config file and git-commit does not work
(fatal: index file smaller than expected). The last 2 problems should be
windows related I believe and should hit as soon as the shell over C
portage will be done.

Unless the current patches in mingw.git can fix these of course.

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu
