From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 13:01:20 -0700
Message-ID: <7vwtbqm73j.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
	<Pine.LNX.4.64.0606091201210.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Post, Mark K" <mark.post@eds.com>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonAo-0006Cl-PW
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWFIUBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFIUBX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:01:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60387 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030468AbWFIUBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 16:01:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609200122.PWKO5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 16:01:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606091201210.5498@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 9 Jun 2006 12:05:36 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21545>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 9 Jun 2006, Post, Mark K wrote:
>>
>> As far as I can tell, the problem is happening because these files are
>> being written out with file permissions of 640, and since Apache is
>> running as user wwwrun, it can't read them:

> Or add
> 	[core]
> 		SharedRepository = true
>
> to the repository config file.

This is about being able to share among the group, not with
people outside, so if wwwrun is outside git group like Mark's
setting I do not think it would do anything helpful to the
situation.
