From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 14:00:55 -0800
Message-ID: <20060201220055.GS2812@ca-server1.us.oracle.com>
References: <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net> <20060130185822.GA24487@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain> <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:03:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Q2S-0005Jn-HH
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 23:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422966AbWBAWBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 17:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422967AbWBAWBS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 17:01:18 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:25062 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422966AbWBAWBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 17:01:17 -0500
Received: from rgmsgw01.us.oracle.com (rgmsgw01.us.oracle.com [138.1.186.51])
	by agminet01.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k11M109i026180;
	Wed, 1 Feb 2006 16:01:00 -0600
Received: from rgmsgw01.us.oracle.com (localhost.localdomain [127.0.0.1])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k11M10WL015072;
	Wed, 1 Feb 2006 15:01:00 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw01.us.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id k11M0xW6015053
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 15:00:59 -0700
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.60)
	(envelope-from <joel.becker@oracle.com>)
	id 1F4Q24-0003OP-C6; Wed, 01 Feb 2006 14:00:57 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15455>

On Wed, Feb 01, 2006 at 12:27:17PM -0800, Junio C Hamano wrote:
>  - "git commit fileA..." means: create a temporary index from the
>    current HEAD commit (or empty index if there is none), update
>    it at listed paths (add/remove if necessary) and commit the

	Please don't do the add/remove automatically.  I know, it's
pretty convenient if I explicitly say "git commit filetoadd", but what
happens if I say "git commit libfoo/*"?  I know that I want all my
changes in libfoo/ to be commited, ignoring my changes in libbar/.  But
I forgot that I created libfoo/testfoo.c to debug my changes, and now
it's in the repository -- and I might not even notice it for weeks.
	CVS and Subversion require an explicit "add" for this very
reason.  Even then, almost everyone gets an "import" or two wrong,
pulling in a couple built files (eg, "configure") they didn't mean to
get.
	I guess you could query the user.  "I noticed that you specified
filetoadd, and you never said 'git add'.  Do you want to add it now
[Y/n]?"

Joel


-- 

"When I am working on a problem I never think about beauty. I
 only think about how to solve the problem. But when I have finished, if
 the solution is not beautiful, I know it is wrong."
         - Buckminster Fuller

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
