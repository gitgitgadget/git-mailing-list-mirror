From: Lukas Fleischer <git@cryptocrack.de>
Subject: Re: Issue with compiling git 1.8.4 under uclibc with gcc 4.6.3
Date: Mon, 26 Aug 2013 22:31:54 +0200
Message-ID: <20130826203154.GA21357@blizzard>
References: <521BB643.304@gmail.com>
 <20130826201804.GB13130@blizzard>
 <521BBA98.7010102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lance <lancethepants@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 22:32:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE3SG-0000n9-Ku
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 22:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421Ab3HZUcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 16:32:00 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:36738 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab3HZUb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 16:31:59 -0400
Received: from localhost (p57B4037E.dip0.t-ipconnect.de [87.180.3.126]);
	by elnino.cryptocrack.de (OpenSMTPD) with ESMTP id 06485200;
	TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO;
	Mon, 26 Aug 2013 22:31:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <521BBA98.7010102@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233025>

On Mon, Aug 26, 2013 at 02:29:12PM -0600, Lance wrote:
> [...]
> >>     CC config.o
> >>config.c: In function 'get_next_char':
> >>config.c:220:14: error: expected identifier before '(' token
> >>config.c:220:14: error: expected statement before ')' token
> >>config.c:220:14: error: expected statement before ')' token
> >>config.c:224:11: error: expected identifier before '(' token
> >Does changing line 220 of config.c to
> >
> >     int c = (cf->fgetc)(cf);
> >
> >fix it?
> I also had to change line 224 to the following
> 
>                 c = (cf->fgetc)(cf);
> 
> Once both places were changes, it compiled successfully.

Sounds like a parser bug to me. Should we patch this in Git in order to
make it compile with (broken?) GCC versions?
> [...]
