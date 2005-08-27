From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: cvsimport error: need a valid pathname
Date: Sat, 27 Aug 2005 20:44:33 +0300
Message-ID: <87zmr39svy.fsf@litku.valo.iki.fi>
References: <874q9bcu6d.fsf@litku.valo.iki.fi>
	<46a038f905082708371719121c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 19:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E94gU-0005D2-8m
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 19:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbVH0Rlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 13:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVH0Rlf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 13:41:35 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:8955 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751631AbVH0Rlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 13:41:35 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep01-app.kolumbus.fi
          with ESMTP
          id <20050827174131.HDDN23558.fep01-app.kolumbus.fi@litku.valo.iki.fi>;
          Sat, 27 Aug 2005 20:41:31 +0300
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905082708371719121c@mail.gmail.com> (Martin Langhoff's
	message of "Sun, 28 Aug 2005 03:37:48 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7851>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 8/28/05, Kalle Valo <Kalle.Valo@iki.fi> wrote:
>> The documentation says that it should be possible to update
>> incrementally from the CVS repository. Am I doing something wrong or
>> is this a bug?
>
> It _should_ work the way you are running it, so consider it a bug. Do
> you think you can do some tinkering/debugging to tell us some more?

I investigated it and realized that this was my mistake. I had copied
the imported git repository from my laptop to my desktop using 'scp
-r' and it changed .git/HEAD to a file, not a link as it should have
been. I copied it again, this time with tar to preserve symbolic
links, and cvsimport started to work again. So this was just a PEBCAK.
Thanks for your help.

> Otherwise. how large is the cvs repo?

'git log | grep commit | wc -l' says 2704 commits. I have to say that
git has made my life a lot easier. It was really easy to import the
CVS history to git and now I can read the history properly with gitk.
With CVS I would have been banging my head to the wall all the time.

Now all I want is svnimport and darcsimport :)

-- 
Kalle Valo
