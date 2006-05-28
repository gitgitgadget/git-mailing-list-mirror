From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Sun, 28 May 2006 13:42:33 -0700
Message-ID: <7vlksldgp2.fsf@assigned-by-dhcp.cox.net>
References: <m21wuem2xj.fsf@ziti.fhcrc.org> <m2verqkobr.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Seth Falcon <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 28 22:42:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkS5u-0003GT-Lv
	for gcvg-git@gmane.org; Sun, 28 May 2006 22:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWE1Umg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWE1Umf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 16:42:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22734 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750908AbWE1Umf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 16:42:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060528204235.OGDP15767.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 May 2006 16:42:35 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <m2verqkobr.fsf@ziti.fhcrc.org> (Seth Falcon's message of "Sun,
	28 May 2006 11:15:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20892>

Seth Falcon <sethfalcon@gmail.com> writes:

> svn has trouble parsing files with embedded '@' characters.  For
> example,
>
>   svn propget svn:keywords foo@bar.c
>   svn: Syntax error parsing revision 'bar.c'
>
> I asked about this on #svn and the workaround suggested was to append
> an explicit revision specifier:
>
>   svn propget svn:keywords foo@bar.c@BASE
>
> This patch appends '@BASE' to the filename in all calls to 'svn
> propget'.

Eric, this sounds sane to me.  Ack?
