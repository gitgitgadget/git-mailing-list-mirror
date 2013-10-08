From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: gitk next/prev buttons
Date: Tue, 08 Oct 2013 16:45:24 -0400
Message-ID: <52546EE4.3070307@xiplink.com>
References: <524A33E5.7090001@threeamdesign.com.au> <525445FB.6000806@xiplink.com> <20131008193618.GE9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>,
	git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 22:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTe9p-0001oD-9T
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab3JHUpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:45:25 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:51242 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753965Ab3JHUpY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 16:45:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id B83FB14815F;
	Tue,  8 Oct 2013 16:45:23 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp1.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7D6A61480FA;
	Tue,  8 Oct 2013 16:45:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131008193618.GE9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235792>

On 13-10-08 03:36 PM, Jonathan Nieder wrote:
> 
> In a branchy history, it is possible for the next matching commit to
> actually be newer.

Chronologically, yes.

Gitk will often display a history like this (here the numbers represent
commit dates, so 1 is the oldest commit, and I've rotated this 90 degrees
clockwise from how gitk would display it):

--3--4-------5---
            /
--------1--2

If commits 2 and 4 match, and the user is looking at commit 2, then the
"next" matching commit from 2 is 4, which is chronologically newer.

However, I still find it more intuitive to think of commit 4 as "older" than
commit 2, at least when using gitk.  This is because in gitk the commits are
generally older as you go down the list.  (When it comes to branches,
chronology hardly matters anyway.  In fact, gitk could ensure that all
commits are displayed in strictly chronological order regardless of branches,
and such a display would be just as correct as what it currently shows
although it'd be less compact.)

A gitk user comes to expect older commits to be lower down in the display.
It's certainly not a hard-and-fast rule, but it's a general paradigm that works.

> I think the intent of the buttons is "find the
> next result, looking down or up in the list of commits in the upper
> pane".  Is there some other wording that would convey this better?

The problem is, at least for me, that when I'm using gitk to browse the
history of changes to a file, I'll often want to see things that happened
before or after a certain point.  Once I start thinking like that, gitk's
concepts of "next" and "prev" mix me up, because I want to see the next thing
that happened to the file but the "next" button doesn't take me there.  The
chronological (dis)ordering that branches introduce doesn't trip me up as
much as the "next" and "prev" buttons.

		M.
