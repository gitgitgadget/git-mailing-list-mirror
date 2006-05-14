From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branch relationships
Date: Sun, 14 May 2006 16:55:00 -0700
Message-ID: <7vslncyxez.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<200605150001.48548.Josef.Weidendorfer@gmx.de>
	<7v8xp4ntbf.fsf@assigned-by-dhcp.cox.net>
	<200605150104.46762.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 01:55:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfQQc-0001MI-Vf
	for gcvg-git@gmane.org; Mon, 15 May 2006 01:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWENXzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 19:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWENXzE
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 19:55:04 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45987 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751412AbWENXzC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 19:55:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514235501.XXMT24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 19:55:01 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200605150104.46762.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 15 May 2006 01:04:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19996>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Monday 15 May 2006 00:19, you wrote:
>> > I suppose "branch.<branch name>.origin" is still the way to go for
>> > specifying the upstream?
>> 
>> Probably "origin" is a better name for it; I was assuming
>> "branch.<branch name>.remote = foo" refers to a [remote "foo"]
>> section and means "when on this branch, pull from foo and merge
>> from it".
>
> Maybe.
>
> But there is a misunderstanding. I wanted the branch attribute "origin"
> to specify the upstream _branch_, not a remote.
>
> After a "git clone", we would have
>
>  [remote "origin"]
>    url = ...
>    fetch = master:origin
>
>  [branch "master"]
>    origin = "origin" ; upstream of master is local branch "origin"

Doesn't that arrangement force people to use tracking branches?
IOW, "git pull somewhere that-head" fetches that-head, without
storing it anywhere in the local repository as a tracking
branch, and immediately merges it to the current branch.
