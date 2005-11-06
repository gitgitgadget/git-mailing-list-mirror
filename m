From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: What's in git.git tonight
Date: Sun, 6 Nov 2005 13:11:49 +0100
Message-ID: <20051106121149.GB30718@fiberbit.xs4all.nl>
References: <7v3bmayu2r.fsf@assigned-by-dhcp.cox.net> <86acgiujuk.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:12:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYjNP-0000Zh-OR
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 13:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKFML5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 07:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVKFML5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 07:11:57 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:49300 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750809AbVKFML4
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 6 Nov 2005 07:11:56 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EYjNF-00080z-IK; Sun, 06 Nov 2005 13:11:49 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86acgiujuk.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11208>

On Sunday November 6th 2005 at 02:54 uur Randal L. Schwartz wrote:

> 
> http-push.c no longer compiles on OSX:
> 
> gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' http-push.c
> http-push.c:10:19: error: expat.h: No such file or directory

You need to have the expat (XML parsing library) header files installed
from something like the "expat development kit".

If you do already have 'expat.h' installed under say /usr/include does
changing "#include "expat.h" to "#include <expat.h>" perhaps help?
Searching for include files specified with #include "..." is somewhat
platform dependant.

Alternatively, if you don't need 'git-http-push' you can define
'NO_EXPAT' and the Makefile will take care that it doesn't get built.

Incidentally 'git whatchanged -p http-push.c' shows that this dependency
on expat and its include header has been there since the first version
on November 2nd. So 'no longer compiles' seems a bit odd!
-- 
Marco Roeland
