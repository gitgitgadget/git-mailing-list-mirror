From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: -p diff output and the 'Index:' line
Date: Sun, 29 May 2005 14:36:24 +0200
Message-ID: <20050529123624.GJ4881@cip.informatik.uni-erlangen.de>
References: <20050529071520.GC1036@pasky.ji.cz> <7vd5raqy28.fsf@assigned-by-dhcp.cox.net> <2788.10.10.10.24.1117353158.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 14:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcMzq-0008Jm-04
	for gcvg-git@gmane.org; Sun, 29 May 2005 14:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVE2Mgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 08:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVE2Mgp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 08:36:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49889 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261225AbVE2Mgm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2005 08:36:42 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4TCaPS8022220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 12:36:25 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4TCaOOa022219;
	Sun, 29 May 2005 14:36:24 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <2788.10.10.10.24.1117353158.squirrel@linux1>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I actually use the following bash script to browse the diffs with
what-changed:

(faui03) [~/work/monitor] git-whatchanged -p | cdiff
...


# COLORDEFINITIONS
BLACK="[0;30m"
RED="[0;31m"
GREEN="[0;32m"
YELLO="[0;33m"
BLUE="[0;34m"
PURPLE="[0;35m"
CYAN="[0;36m"
WHITE="[0;37m"
END="[0m"
REVERSE="[7m"

cdiff()
{
	cat $1 | \
	sed -e " \
		s/^\(diff-tree\)\(.*\)/\1${RED}\2${END}/; \
	        s/^+.*/$RED&$END/;  \
		s/^-.*/$BLUE&$END/;  \
		s/^@.*/$GREEN&$END/;  \
		s/^Date.*/$RED&$END/;  \
		s/^Author.*/$RED&$END/; \
		" | less -R -i -p "^diff-tree"

		# This would highlight manpages but the last line clashes with cdiff
		# --tg 00:52 05-05-26
		#s/^[A-Z]\+[A-Z ]\+$/$RED&$END/; \
		#s/[A-Z]\+([0-9])/$RED&$END/g; \
		# s/\W--\?[0-9a-zA-Z=-]\+/$BLUE&$END/g; \
}

Gruesse,
	Thomas
