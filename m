From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Thu, 07 Sep 2006 01:16:17 -0700
Message-ID: <7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	<44FFD00E.5040305@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 10:16:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLF3W-0006Bd-2N
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 10:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWIGIQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 04:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWIGIQK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 04:16:10 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:2981 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751062AbWIGIQG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 04:16:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907081605.ZLUQ27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 04:16:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KLFx1V00D1kojtg0000000
	Thu, 07 Sep 2006 04:15:58 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <44FFD00E.5040305@innova-card.com> (Franck Bui-Huu's message of
	"Thu, 07 Sep 2006 09:53:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26614>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> My first intention was to enable/disable specific archive format
> through daemon service. But we could in an other way: send a 
> "git-upload-archive --format=tar" request then in upload-archive
> check that git-upload-tar service is enabled. This service would
> exist even if git-upload-tar is not a valid command.
>
> But Rene thinks that part should be in git-upload-archive. I dunno
> what is the best direction. I have used git-daemon service because
> the service infrastucture already allow us to achieve that.

Hmph.  daemon_service was a nice idea but the current
implementation falls short by not giving finer control such as
"this service is Ok with such and such option but not this
option".  Here we ideally would want to say something like
"git-archive is fine with upload-tar but not upload-zip" or "Ok
as long as upload-tar's numeric arg is less than 6".  Needs some
thought _if_ we plan to add tons of services to the daemon.

> I'm sorry to not make things faster. I'm new to git internals and
> unfortunately I'm busy to do some other (crap) things. I'll send
> a new patchset this morning and I'll sum up what's done and what
> we still need to do.

Taking things slowly is just fine.  Otherwise _I_ would burn out
;-).
