From: Junio C Hamano <junkio@cox.net>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 11:42:33 -0800
Message-ID: <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
	<Pine.LNX.4.64.0511241037400.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Ed Tomlinson <tomlins@cam.org>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 20:44:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfN02-0000gA-3b
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 20:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVKXTmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 14:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVKXTmg
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 14:42:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27123 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932648AbVKXTmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 14:42:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124194152.LDGX20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 14:41:52 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 24 Nov 2005 10:44:14 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12712>

Linus Torvalds <torvalds@osdl.org> writes:

> (This is in no way really fundamental, and the server could cache the 
> packs it generates for initial clones, but that isn't implemented yet, and 
> probably won't be for some times).

Performance perceived by cloners is helped by

    $ mkdir -p .git/pack-cache
    $ git-rev-list --objects --all | git-pack-objects .git/pack-cache/pack

on the server side.  This exact example of preparing by the
repository maintainer is optimizing for a wrong case, and I do
not think it is worth doing in practice, but this will give you
the lower bound when server side cache is implemented to do it
on demand.
