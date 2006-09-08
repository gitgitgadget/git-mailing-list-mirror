From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 01:58:39 -0700
Message-ID: <7v64fyivk0.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	<44FFD00E.5040305@innova-card.com>
	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
	<450019C3.4030001@innova-card.com>
	<7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
	<45012752.4070300@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLcC1-0004AK-5S
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWIHI6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWIHI6T
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:58:19 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51092 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750729AbWIHI6T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 04:58:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908085818.IDHT12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 04:58:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KkyA1V00B1kojtg0000000
	Fri, 08 Sep 2006 04:58:10 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <45012752.4070300@innova-card.com> (Franck Bui-Huu's message of
	"Fri, 08 Sep 2006 10:18:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26690>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> Junio C Hamano wrote:
>> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
>>>
>>>   2/ Can I remove 'git-upload-tar' command ?
>>>   3/ Should I kill 'git-zip-tree' command ?
>> 
>> We do not deprecate commands that easily.  Notice we have kept
>> git-resolve for a long time (we should remove it and by now it
>> should be safe)?
>
> heh ? I've just noticed that you removed 'git-upload-tar' from
> master branch (commit d9edcbd6061a392c1315ab6f3aedb9992a3c01b1).
>
> Futhermore I was thinking about 'git-zip-tree' removal because
> it's a very recent command. It shouldn't hurt to remove it now
> and make our life easier, not sure though...

I do not think I removed upload-tar.  I removed it from daemon
service list and the documentation for daemon, because that part
is a new code.

	git tar-tree --remote=../linux-2.6/.git HEAD
	git tar-tree --remote=kernel.org:git next

should still work; the former is "from a directory next door"
and connect.c invokes local /bin/sh as the transport, and the
latter is "ssh login to kernel.org and use ./git directory".

I recall from earlier review of your code, "git archive" should
work well over these two transports in addition to git://
protocol that talks with git-daemon.
