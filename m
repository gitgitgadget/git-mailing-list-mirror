From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 04 Apr 2013 13:11:38 -0500
Message-ID: <871uaqrwrp.fsf@59A2.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan> <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de> <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNodv-0008WL-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764340Ab3DDSLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:11:42 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:35794 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764319Ab3DDSLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:11:41 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so3051224oag.7
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=fKLcSesNkpy5gS/zLFIwqcNcDApaCn1PJ0MpcLIqWbo=;
        b=sSgO/WkRoVDha7bcmUNnzJCzJssQDSzR3IXOUetxbpJ2zmgyYECN3FK99AKNp+7KDT
         7cthtw82ts2lgN4Bbf1q5igE5Bml5xOvY4RMXcn5oQe5Tj9aPDvupFeqV7qDzzKJzWQt
         fxguN28mTX08OgHZ7O4UASFSNj3hCTkhX3e4t0TJrYWDzNrAL8P1s+13LpNwVih8wmQJ
         XMot9CuTSoPM8Fh22v3NJCP0jxUtN7LJazx+4V7YQUxVozlCiiVH/6yYQWGwaZwALJnT
         lx8A5f6sWlqqgNkuXzMZrzRc7yp6qbyEluy1uE5xN91OsR9YosmVxCP6AxiRU/ELE9c2
         F3zg==
X-Received: by 10.182.98.109 with SMTP id eh13mr5315355obb.50.1365099101441;
        Thu, 04 Apr 2013 11:11:41 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id w10sm7990289oed.2.2013.04.04.11.11.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:11:40 -0700 (PDT)
In-Reply-To: <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220044>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I still don't see any good reason why a user might prefer gitifyhg,
> even more importantly, why gitifyhg developers don't contribute to
> remote-hg.

Felipe, I read your blog announcement [1] and got the impression that
remote-hg was ready for daily use.  When I tried to use it, it promptly
crashed in my first attempt to clone.  I opened up the script, fixed
whatever caused the first stack trace and made it slighly further before
it crashed again.  I couldn't tell what was expected to work, what was a
known problem, and what was an unknown problem.  Many things clearly did
not work and it had the look of a project that was not getting active
use.  I felt that it was wildly oversold and that putting it into
git.git was premature.

I tried gitifyhg later and it basically worked out of the box.  All
known problems were marked by 'xfail' test cases.  At that time,
remote-hg failed almost all the gitifyhg tests.  I contributed a few
things to gitifyhg, including the notes support (essential when talking
via email with other people using Mercurial).  Since then, the last
major project I'm involved with has switched to Git so I rarely need
gitifyhg or remote-hg any more.



FWIW, I also thought Dusty's original announcement oversold gitifyhg, but
it was closer to the truth and upon cloning the repo, it was more clear
what didn't work.  The early history of gitifyhg is quite chaotic and I
didn't realize at first how much code turned out to be borrowed from
remote-hg.  I don't know whether you wrote all of remote-hg or borrowed
significant parts from elsewhere.  To be honest, I don't really care,
but it would be good to coalesce around one project that is well-tested
and has documented behavior so that the poor folks stuck with Mercurial
upstreams can have dependable behavior.

[1] http://felipec.wordpress.com/2012/11/13/git-remote-hg-bzr-2/
