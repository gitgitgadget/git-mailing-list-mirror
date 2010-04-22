From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT counterpart to "svn list"
Date: Thu, 22 Apr 2010 09:41:59 +0200
Message-ID: <4BCFFDC7.4050205@drmicha.warpmail.net>
References: <20100421222237.1758ca66@pennie-farthing>	<4BCFC180.5020009@dbservice.com> <20100421223716.6526f625@pennie-farthing>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Jack Desert <jackdesert556@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 09:45:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4r61-00012D-1d
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 09:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab0DVHpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 03:45:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34114 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752664Ab0DVHpG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Apr 2010 03:45:06 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2DBCFEB849;
	Thu, 22 Apr 2010 03:45:06 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 22 Apr 2010 03:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ONtX+iEx5MPC9yup5hKeG8tJE9k=; b=pFyp99L1o/tG39kKWENoMhGwucu/TgM+SjKw7PpyTIIWxNyVpLylySXx877BcdhjJdbpYTTGHxfFZisjy9DwCjNZ61R6Z/JKJ54ceiNziD/OZxwl+0+dZo2r/7cDHb1WFgq9KnvAhqnn4DBEwmZqMPYUQxSjqcSI9ND3E+UVbhA=
X-Sasl-enc: ejvOAtYk234z2cbjKgmVxjZkZHZxVXl1NIXtnXtTcI61 1271922305
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 37E1037D7F;
	Thu, 22 Apr 2010 03:45:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100421223716.6526f625@pennie-farthing>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145506>

Jack Desert venit, vidit, dixit 22.04.2010 05:37:
> El Thu, 22 Apr 2010 05:24:48 +0200
> Tomas Carnecky <tom@dbservice.com> escribi=F3:
>> On 4/22/10 5:22 AM, Jack Desert wrote:
>>>
>>> I'm new to GIT, and the one command I can't live without is:
>>>    svn list
>>> Is ther a GIT couterpart to svn list?
>>
>> We're all clueless about how svn works, or what svn list does. Can y=
ou=20
>> enlighten us please?
>>
>> tom
>>
> =20
> "svn list" displays which files and folders in the current directory =
are under version control. It's helpful in figuring out which files you=
 still need to add to the repository. Attached is sample output from on=
e of my directories under subversion souce control.

Now, that statement is about as true as Tomas' about "all" people's
svn-cluelessness here ;)

svn list [URL[@REV]] lists the files and directories of the repo URL at
revision rev, rev defaulting to the head revision, URL defaulting to th=
e
repo URL of ".".

So, even without URL, it does not look at the files and folders of the
current directory at all (besides .svn to find the repo URL). In
particular, it does not tell you anything about untracked files and is
(by itself) useless for figuring out what to add. svn status is used fo=
r
that. Instead, svn list tells you which files and folders are under
version control at "." in the repo, but not limited to the the contents
of your cwd.

git ls-files does what svn list (without URL) does, and more. But git
status [-s] may be what you are really looking for, if you're intereste=
d
in tracked versus untracked files.

Now, svn list URL is something that git does not really do, because it
tries to do as much as possible locally, not on the server side. But
that is not the svn list incantation you asked about ;)

Cheers,
Michael
