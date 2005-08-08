From: Junio C Hamano <junkio@cox.net>
Subject: Request for help from binary packaging people.
Date: Mon, 08 Aug 2005 10:38:44 -0700
Message-ID: <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 08 19:40:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2BaM-00040I-Nr
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVHHRir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 13:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVHHRir
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 13:38:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:11915 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932141AbVHHRiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 13:38:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808173845.JEWF1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 13:38:45 -0400
To: git@vger.kernel.org
In-Reply-To: <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 08 Aug 2005 02:09:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I need a bit more help from binary packaging people.

I have not heard from Darwin or BSD people for some time.  Is
your portfile up to date?  Do you have updates you want me to
include?  Have we introduced non-Linux non-GNU incompatibilities
lately that you want to see fixed and/or worked around?

For RPM, from my lack of RPM expertise (and RPM capable
environment until recently), I have not updated the "Prereq:"
field in git-core.spec.in at all.  I would appreciate somebody
to sanity check the list of dependencies.  The dependency list
Debian side has is more up-to-date and I am reasonably sure it
is accurate.  It lists patch, diff, and rcs (for the "merge"
command) as the essential dependency (aside from the shared
libraries like libc), and libmail-sendmail-perl, rsync, curl,
ssh, and libemail-valid-perl as the recommended dependency.  I
do not even know if RPM has the notion of such multi-tier
dependencies, but the latter list is meant to mean "you could
live without these, but to exercise this package fully you may
want them" (in our case of git-core, you could live without the
networking if you do not do multi-user, multi-repository).  If
RPM spec file has a way to say something like that, I would like
to see these packages (probably their names are different
between Debian and RPM) listed on the recommended dependency
list; otherwise I would want to see them added to the main
"Prereq:" list.

For Debian, we recommend lib*-*-perl packages.  Do we need to
recommend perl itself as well, or is it the case that things
that are covered with the automatic dependency chain need not be
listed?  Earlier I said that the Debian side is reasonably
accurate to the best of my knowledge, but I would appreciate it
if somebody ran lintian on it.

Pretty please?
