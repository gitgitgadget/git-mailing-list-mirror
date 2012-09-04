From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: checkout extra files
Date: Tue, 04 Sep 2012 03:57:23 +0200
Message-ID: <87txvev9bw.fsf@centaur.cmartin.tk>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<87sjazw6qq.fsf@centaur.cmartin.tk>
	<CAB9Jk9AkFW-fAqOZuhCMgMBdEZwDpe5ZG9Dkse=Wz_x9LvJEPw@mail.gmail.com>
	<87harfw4bp.fsf@centaur.cmartin.tk>
	<CAB9Jk9BjO+HdxhaGxEyaDoXgGisi0QpuVvsx3dZUnJV1VoKN1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 03:58:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8iP4-0003N7-7A
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 03:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab2IDB5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 21:57:23 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:35510 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754318Ab2IDB5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 21:57:22 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 3DA9481C5D;
	Tue,  4 Sep 2012 03:57:18 +0200 (CEST)
Received: (nullmailer pid 15848 invoked by uid 1000);
	Tue, 04 Sep 2012 01:57:23 -0000
In-Reply-To: <CAB9Jk9BjO+HdxhaGxEyaDoXgGisi0QpuVvsx3dZUnJV1VoKN1g@mail.gmail.com>
	(Angelo Borsotti's message of "Mon, 3 Sep 2012 17:10:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204716>


Keep it in the list.

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hi Carlos,
>>
>> That grouping is not what it's saying. It doesn't update the files that
>> exist in the working tree matching some glob. It updates the files in
>> the working tree from either the index or a treeish. The pathspec
>> refers, as always, to the data source, and '*' matches all files.
>>
>> It puts the named paths on to the working tree. Is that clearer?
>>
> This was mi first understanding, until one day I had in the working directory
> a file that matched the <path> (the path was '*') and that was NOT in the
> index or a treeish. The git checkout command tried to copy it and
> complained that there was no such file to restore.

So you're saying that you ran

    git checkout <tree-ish> -- *

and git complained that there was no such file? This is because the
shell expanded the glob and gave git a list of files.

> Then I thought that it visited the working directory and tried to restore
> each file it matched and at the end restored also the ones that were not
> there.

I can't quite parse this. Git will restore whichever files you tell it
to. If you use an asterisk, then your shell will usually expand it. In
the case you posted to the list there were no files, so there was
nothing to expand it to. Some shells complain in this case by default,
some don't and just pass the asterisk to the program and let it figure
out what to do with it. This was the case in your example. You told git
to expand all the files it found in that tree-ish.

   cmn
