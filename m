From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow updating the index from a pipe
Date: Fri, 09 Dec 2005 23:06:37 -0800
Message-ID: <7vbqzpxwg2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512100145500.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 08:07:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekyos-0005Yb-Tj
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 08:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVLJHGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 02:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVLJHGo
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 02:06:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28551 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S964956AbVLJHGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 02:06:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051210070551.IGNQ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 02:05:51 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512100145500.25300@iabervon.org> (Daniel
	Barkalow's message of "Sat, 10 Dec 2005 01:57:05 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13441>

Daniel Barkalow <barkalow@iabervon.org> writes:

> In order to allow the index to be modified in simple ways without
> having a working tree, this adds an option to git-update-index which
> updates a single path with a mode of 100644 and reads the content from
> stdin.

I wonder ...

Could you do this with existing hash-object with update-index
--cache-info (or --index-info) please?  If you do not want a
temporary file and prefer piping contents into a command,
extending hash-object would be preferable.
