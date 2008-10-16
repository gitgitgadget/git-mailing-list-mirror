From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 13:23:21 +0200 (CEST)
Message-ID: <3520b7a9009f072cfc3aeb82ae205e6b.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Pedro Melo" <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 13:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQv7-0001sV-PR
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbYJPLUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbYJPLUV
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:20:21 -0400
Received: from mail.codewut.de ([78.47.135.140]:47948 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbYJPLUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:20:20 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 264EF7BEF1; Thu, 16 Oct 2008 13:23:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 8795F7BE4C;
	Thu, 16 Oct 2008 13:23:21 +0200 (CEST)
Received: from 194.127.8.17
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Thu, 16 Oct 2008 13:23:21 +0200 (CEST)
In-Reply-To: <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98366>

Update:

Ok, I compiled several git versions from the git repo with the following
results:

v1.5.6.5 works
v1.6.0.2 fails
v1.6.0 fails
v1.6.0-rc0 fails

Given a git repo with a submodule 1.5.6.5 works (no untracked files) but
the same repo fails with 1.6.0-rc0 (lists submodule folders under
untracked files).

So something between 1.5.6.5 and 1.6.0-rc0 broke it for me.
A quick diff between the two version revealed a lot of changes. Thus
tracking down the issue might not be easy for someone who is not involved
in the code.

Maybe someone can give me a hint where to look? For example where does
"git status" decide whether a given filesystem folder should be ignored
with regard to .gitmodules?

Yours,
Lars

>
> On Oct 15, 2008, at 3:51 PM, Lars Hoss wrote:
>
>>> Works for me on Leopard
>>>
>>> Vienna:a pieter$ git submodule add ~/projects/GitX/ gitx
>>> Initialized empty Git repository in /Users/pieter/a/gitx/.git/
>>> Vienna:a pieter$ git st
>>> # On branch master
>>> # Changes to be committed:
>>> #   (use "git reset HEAD <file>..." to unstage)
>>> #
>>> #	new file:   .gitmodules
>>> #	new file:   gitx
>>> #
>>> Vienna:a pieter$ git --version
>>> git version 1.6.0.2.415.gf9137
>>
>> My git version "1.6.0.2" says:
>>
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #	new file:   .gitmodules
>> #	new file:   lib
>> #
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	lib/
>> git --version
>> git version 1.6.0.2
>>
>> Git was build from macports.
>
> hmms.. Really, I know about fink and Macports and all others, but I'm
> using Mac OS X since version 10.1 (when compiling OSS software was
> near impossible due to Apple decisions) and I've always had better
> results with compiling my own than using any of those OSS repositories.
>
> I understand the appeal, it seems easier, but I would recommend that
> you compile yourself the software packages you depend on.
>
> Regarding git, I saw a git-build.sh script floating around. If you
> cannot find it, you might want to try my own recipe
> (http://tinyurl.com/4ayze6
> ). I compile git master every day (cron) and thats the one I use on my
> main machine.
>
> Best regards,
> --
> Pedro Melo
> Blog: http://www.simplicidade.org/notes/
> XMPP ID: melo@simplicidade.org
> Use XMPP!
>
>
>
