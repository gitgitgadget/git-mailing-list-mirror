From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 08 Jun 2006 03:33:34 -0600
Message-ID: <m164jc9ekx.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<m1y7wpde1w.fsf@ebiederm.dsl.xmission.com>
	<7virntsto6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 11:33:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoGtm-0004IP-2Q
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 11:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWFHJdt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 05:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWFHJdt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 05:33:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55442 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751320AbWFHJds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 05:33:48 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k589XeKq029011;
	Thu, 8 Jun 2006 03:33:40 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k589XcGw029010;
	Thu, 8 Jun 2006 03:33:38 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virntsto6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 25 May 2006 14:04:09 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21476>


A quick status update.

I think I have clean working version of the sha1 transfer code,
I left on vacation before I could send it out so I need to dig
it out and make certain everything still applies.

I finally figured out what my problem pulling Andrew's changes
were.  git-quiltimport remembers what the previous commit was and when
I added merging I forgot to update that the variable that stores
the previous commit.  So since I had the history wrong git-merge
was finding the wrong common ancestor, which is an easy way
to mess up an automatic merge :)

> The last time I talked with Andrew, he is not doing a merge nor
> resolving merge conflicts.  He treats git primarily as a
> patchbomb distribution mechanism, and works on (a rough
> equivalent of) the output of format-patch from merge base
> between his base tree and individual subsystem tree.  After that
> things are normal quilt workflow outside git, whatever it is.

Andrews git import does appear to be a git-pull from an appropriate
tree and then a diff of the automatic merge result, so while
there doesn't appear to be manual merging there is a little
bit of automatic merging going on.

Anyway when I wake up in the morning I should see if I have
successfully imported Andres 2.6.17-rc5-mm3 tree.   All of that
pulling of git trees on demand noticeably slows down the import 
on my dinky test machine.  I'm not certain how much of that
a machine that had plenty of memory would see though.

Eric
