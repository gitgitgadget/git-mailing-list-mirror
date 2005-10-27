From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 15:02:10 -0700
Message-ID: <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
References: <20051027203945.GC1622@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 00:03:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVFpT-00033u-5Z
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 00:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVJ0WCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVJ0WCR
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 18:02:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58329 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932663AbVJ0WCL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 18:02:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027220132.RVCR11356.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 18:01:32 -0400
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20051027203945.GC1622@pe.Belkin> (Chris Shoemaker's message of
	"Thu, 27 Oct 2005 16:39:45 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10729>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> If anyone thinks this is a good feature, then please tell me an
> efficient way to get some heuristic of the patch size.
>
> Right now, I'm using: 
>
> GIT_DIFF_OPTS='-U 0' $gitbin/git-diff-tree -p $hash | wc -l
>
> which is pretty slow.  Any suggestions?

* do we really want to know the number of lines?  sometimes the
  number of pahts that are affected is more useful than number
  of lines when assessing the damage, which can be done with
  'git-diff-tree --name-only'.

* cache the result -- they never change.

An interesting question is what to do with merges, but probably
we can just ignore it for now.
