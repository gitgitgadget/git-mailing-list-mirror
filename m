From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-merge --squash
Date: Fri, 23 Jun 2006 16:11:26 -0700
Message-ID: <7vwtb78o2p.fsf@assigned-by-dhcp.cox.net>
References: <7virmscl2u.fsf@assigned-by-dhcp.cox.net>
	<7vd5d09pe2.fsf@assigned-by-dhcp.cox.net>
	<20060623122501.GD15631@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.63.0606231433370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 01:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtuoF-000367-Tj
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 01:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbWFWXL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbWFWXL2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 19:11:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47612 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752167AbWFWXL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 19:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623231127.QOIA1341.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 19:11:27 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606231433370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Jun 2006 14:36:11 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22451>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Isn't this the same as 'git-cherry-pick -n'? I often do a poor man's StGIT 
> by cherry picking my way through a messy branch, often combining patches 
> by '-n'.

Operationally, it probably is equivalent to the repeated use of
'cherry-pick -n' for all commits on a topic, but that would risk
you having to resolve conflicts unnecessarily when you are
shooting for as the result is a single commit, because you would
have to do N merges with that workflow.  Squashing is about
merging the tip of the topic into mainline, so the conflict
resolution needs to be done only once.
