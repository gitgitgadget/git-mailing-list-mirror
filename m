From: Joe Perches <joe@perches.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Thu, 29 May 2008 11:20:33 -0700
Message-ID: <1212085233.27103.54.camel@localhost>
References: <20080529210018.GA5508@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Sverre Rabbelier <alturin@gmail.com>, git@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 00:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1qMG-0002Ur-F9
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 00:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223AbYE2WLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 18:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbYE2WLf
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 18:11:35 -0400
Received: from 136-022.dsl.labridge.com ([206.117.136.22]:2580 "EHLO
	mail.perches.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbYE2WLf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 18:11:35 -0400
Received: from [192.168.1.128] (192-168-1-128.labridge.com [192.168.1.128] (may be forged))
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id OAA28039;
	Thu, 29 May 2008 14:56:02 -0700
In-Reply-To: <20080529210018.GA5508@damson.getinternet.no>
X-Mailer: Evolution 2.12.3-1.2mdv2008.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83247>

> I've written this perl script that takes a patch as input and prints the
> authors/committers of the affected lines, using git-blame as the back end.

Nice enough script.
It's unfortunate that it can't output the appropriate mailing lists.

I think the shell script that Linus gave awhile ago:
http://lkml.org/lkml/2007/8/14/276

        #!/bin/sh
               git log --since=6.months.ago -- "$@" |
                       grep -i '^    [-a-z]*by:.*@' |
                       sort | uniq -c |
                       sort -r -n | head
        
         (Maybe you want to add a
               grep -v '\(Linus Torvalds\)\|\(Andrew Morton\)'
        
might work just as well.

I still prefer the file pattern match in MAINTAINERS, or
another external file, and/or data stored directly into GIT
via gitattributes approaches.

This script can give maintainer, mailing lists, and git
contact information for patches or files.
http://lkml.org/lkml/2007/8/20/352
The script works with git-send-email to cc the appropriate parties.

This script and git repository is very old and probably doesn't apply...
git pull git://repo.or.cz/linux-2.6/trivial-mods.git get_maintainer
