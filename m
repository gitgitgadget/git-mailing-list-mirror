From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Sun, 11 Sep 2005 11:41:45 -0700
Message-ID: <7vvf17saza.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
	<7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509111153380.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
	<7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509111054590.3242@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 20:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWly-0001im-NJ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVIKSls (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVIKSls
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:41:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62421 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751113AbVIKSlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 14:41:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911184147.DOLL17436.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 14:41:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111054590.3242@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Sep 2005 10:58:00 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8318>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 11 Sep 2005, Junio C Hamano wrote:
>> 
>> Yes, but the issue becomes how we can reliably tell if a
>> repository is naked or has an associated working tree.
>
> You can't "git pull" into a naked thing anyway. And
>
> 	git-read-tree -m -u <old-head> <new-head>
>
> should always do the right thing (ie if there is dirty state that would be
> updated, it will fail gracefully).
>
> Or did I miss something?

No, I just stated my view poorly.

You cannot do pull into a naked one, but you can still fetch
into it.  My comment Johannes was responding to was what to do
when you do 'git fetch' into the repository associated with your
working tree and your branch is fast forwarded.  We obviously
want to prevent it from happening.  However, it is OK to do so
if the fetch is happening into a naked one and I was wondering
if there is a reliable way to tell that situation and allowing
that.
