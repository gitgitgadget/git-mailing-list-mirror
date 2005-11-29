From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 09:31:39 -0800
Message-ID: <7v1x0zicn8.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
	<7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
	<20051128212804.GV22159@pasky.or.cz>
	<Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511281845280.25300@iabervon.org>
	<Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282027360.25300@iabervon.org>
	<Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282208050.25300@iabervon.org>
	<Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282337170.25300@iabervon.org>
	<7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511290141220.25300@iabervon.org>
	<7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.11.29.13.39.01.958465@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 18:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh9KR-0002cY-VD
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 18:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVK2Rbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVK2Rbl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 12:31:41 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54266 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVK2Rbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 12:31:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129173054.BBKL20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 12:30:54 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.11.29.13.39.01.958465@smurf.noris.de> (Matthias
	Urlichs's message of "Tue, 29 Nov 2005 14:39:02 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12950>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Hi, Junio C Hamano wrote:
>
>> When everything goes well, the daemon goes to treeP and pulls
>> from treeR's master into "deploy", which is checked out.
>
> Why do you need a separate tree for that? -EOVERKILL.

Yes that is overkill, but treeR is used for merge and the scheme
allows that merge to be real merge not just fast forwards ---
you need a checked out tree for that.  We can use multiple
checked out tree sharing the same .git/ directory with separate
index files instead.
