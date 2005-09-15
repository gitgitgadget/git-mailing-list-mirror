From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Thu, 15 Sep 2005 12:31:24 -0700
Message-ID: <7vu0gmyvoz.fsf@assigned-by-dhcp.cox.net>
References: <20050914124206.GC24405@master.mivlgu.local>
	<7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
	<Pine.LNX.4.63.0509141641290.23242@iabervon.org>
	<Pine.LNX.4.58.0509141411510.26803@g5.osdl.org>
	<Pine.LNX.4.63.0509141722500.23242@iabervon.org>
	<7vk6hjfh9u.fsf@assigned-by-dhcp.cox.net>
	<pan.2005.09.15.10.34.59.363606@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 21:33:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzSG-0005ZT-Nw
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVIOTba (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbVIOTba
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:31:30 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52441 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965270AbVIOTb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:31:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915193125.SAMN18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 15:31:25 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8629>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Personally I'd rather combine the two. The point being, broken
> repositories do happen -- for instance, when the file system is
> inconsistent after a crash, or when the referent of an info/alternates
> directory vanishes. :-/
>
> I'd rather have a simple repair flag than do a "download everything again
> and then throw most of it away" job when something like that happens.

If you are talking about disaster recovery, wouldn't you rather
clone the remote into a clean repository, and fetch what are
salvageable from the potentially corrupt old repository into
this clean repository you know is OK?  I think that would
suggest that you do not need another "download everything again"
added to git-http-fetch.  You can already run git-clone from the
remote to "download everything again", and then git-fetch from
the repository being salvaged.
