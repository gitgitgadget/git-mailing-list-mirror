From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 09:43:03 +0100
Message-ID: <4D676B97.3000204@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph> <4D6672F7.4020101@drmicha.warpmail.net> <buozkpk91nf.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 25 09:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PstK4-0005DM-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 09:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab1BYIqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 03:46:24 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41483 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754179Ab1BYIqX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 03:46:23 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3609D20B58;
	Fri, 25 Feb 2011 03:46:22 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 25 Feb 2011 03:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UYL58EABJoTde8c1AzKX+099l84=; b=sfQAp9+JHTZgpaSi6VLKBNU7w7sISV6ll14wBM89vEQCyCt53scoscsXR72nQ/xAXB5W2VoshOvowZRzJqHjyje9TH5KA7COnWFd01xUZiID2nTBM02R088pKp5oHSroAyX+vuiKMcDGPaVnIV4pGhPD3NjOBaf1oKIe2sLG3xY=
X-Sasl-enc: 4OIj8z+Hzl6obp2HDCN3iuIdYFDjTrswcYDiKbgQzjYU 1298623581
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9508D4074E2;
	Fri, 25 Feb 2011 03:46:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <buozkpk91nf.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167884>

Miles Bader venit, vidit, dixit 25.02.2011 05:30:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> git add -A && git commit -m "Message"
>>
>> "commit -a" is much like "add -u", at least when used without file
>> arguments ("pathspec").
>>
>> "commit -A" does not exist, so that "git add -A && git commit" is your
>> only way.
>>
>> Why does it not exist? Because you should at least
>> "git add -A && git status && behappy && git commit".
> 
> The exact same argument applies to "git commit -a" of course, but it's

No, because you are usually more aware of tracked files than of
untracked ones, especially in subdirs.

> still supported.  Why?  Because it's a nice convenience for many common
> situations.  It isn't the least bit unsafe if one does git status _first_.

That is why I recommended to use git status first. But "-A" is still
different, because (depending on your config) git status does not show
you files in untracked subdirs.

>> Also, "-A" supports a very "un-gitty" way of using git. This makes it
>> unlikely that someone cares to implement it... (By "un-gitty" I don't
>> mean a matter of personal taste, but a matter of fruitful habits.)
> 
> Nonsense.
> 
> The index is a great idea, and cool and useful in many situations; I use
> it heavily, and wish other systems had something like it.  But there's
> nothing "un-gitty" or "unfruitful" about directly commiting sometimes.

And you can do that with "git add -A" followed by "git commit".

> For the record, I usually use the index, but sometimes when the changes

So if you use the index usually, it must be a fruitful habit. That
renders your "Nonsense" remark rather nonsensical.

> are simple, I'll use shortcuts like "commit -a", because they're handy.
> Typically I'll do "git status" _first_, check that everything's kosher,
> and then do "git commit -a ...".  If "git commit -A" existed, I'd use
> that in the same way.

It almost exists (add -A plus commit), and you carefully chose to ignore
my earlier posts about the implementation strategy leading to "commit
-A" (after I had looked at the details of the code - have you?), of
course, because otherwise the content of your post would be baseless;
the tone is anyway. No surprise here either.

Just for those wondering:

The "habit problem" with "commit -A" is that, potentially, it keeps
newcomers from learning vcs/git at all. It's a (too) wonderful way of
not having to worry even about the concept of "files under version
control" - this has nothing to do with using the index or not (that
would be the "-a" thingy). Even "svn commit" does not do what "git
commit -A" would.

No more posts from me on this subthread, it's just not worth it.
Michael
