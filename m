From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to coax hooks into working
Date: Tue, 27 Apr 2010 12:47:20 +0200
Message-ID: <4BD6C0B8.9040709@drmicha.warpmail.net>
References: <B65E8227-B3C0-4AB8-A225-4A5661523CAD@pelagicore.com> <v2u8c9a061004261111l429b0c8cs73cf7e1afea3d39f@mail.gmail.com> <FAF218B9-D2DB-4081-88CB-BEBA08DF1229@pelagicore.com> <4BD6A5BC.3010708@drmicha.warpmail.net> <EA3DE148-CDC8-4FA3-8C97-74379E91B495@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 12:47:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6iK9-0000uj-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 12:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab0D0KrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 06:47:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35828 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751396Ab0D0KrW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Apr 2010 06:47:22 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0BBC5EEE7C;
	Tue, 27 Apr 2010 06:47:22 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 27 Apr 2010 06:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=h/d9ee5UEj3R13zdpYS8FFP+5F8=; b=f2CFOmDgwyILorfVXP1ui3iF2pJT32GfQm1LB3PMyF5bk+GrP04J4Apbd7jvxOa+15gtWxVrOW9O6rYbNLD249Bv3QvZgjo7+DCQ9fqS1g5dH6CuVYm96ZdbX2o8IDWsiEIk5kU69oXHYStA2IofXpwo0uzbKIz3r7eRgntU+LM=
X-Sasl-enc: jiNBJ71QANOEjJQWmN+lr4lHrPXjOSiXNNCrrHPmmdBp 1272365241
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 74F0612722;
	Tue, 27 Apr 2010 06:47:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <EA3DE148-CDC8-4FA3-8C97-74379E91B495@pelagicore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145896>

Jeremiah Foster venit, vidit, dixit 27.04.2010 11:08:
> 
> On Apr 27, 2010, at 10:52 AM, Michael J Gruber wrote:
>> Jeremiah Foster venit, vidit, dixit 27.04.2010 10:33:
>>> 
>>> On Apr 26, 2010, at 8:11 PM, Jacob Helwig wrote:
>>>> 
>>>> You want one of the receive, or update hooks, if you're
>>>> putting this in a central place, where it needs to be triggered
>>>> by someone doing a push in to the repo.
>>> 
>>> Thanks Jacob. I'd just like to confirm that I am, in fact, using
>>> the update hook. I logged into the server holding the git repo,
>>> cd'd to
>> 
>> That used to be different ;) update hook on the server is good.
>> 
>>> the .git/hooks/ directory. Moved the update.sample to update.
>>> Changed the code to something trivial that would echo back to the
>>> client for testing. I checked permissions, checked ownership, ran
>>> the code as the git repo owner. I logged out, did a trivial
>>> change in the client repo, ran git commit -a -m "foo" and
>>> expected that the trivial update script to run on the server
>>> would produce output to the client. This
>> 
>> But this is the same problem backwards. Again: Please try to
>> understand what commit does, and what push does, in terms of where
>> (local repo vs. server) a change happens:
> 
> I think I do. The commit pushes the change onto the index. The index
> is local. It gets pushed to the remote server when I do a git push. I
> should have been more explicit - I am in fact pushing the code to the
> remote server in such a manner that git-receive-pack is run. My

Before you said you committed locally and expected the server to run a
hook in response to that!

I'm sorry but I'm giving up at this point, your description of what
you've done is to volatile for my nerves.

If you still want help please provide a line by line transcript of what
commands you're running and what respone you get.

> understanding from the documentation is that this is the trigger
> which update gets called. Yet no information from that update script
> is produced in the logs or in the client.
>> 
>> As long as you only commit in your local repo nothing changes on
>> the server (remote repo), so no hook is triggered there.
>> 
>>> never occurred. I further tested the client hooks which also did
>>> not run.
>> 
>> Which ones?
>> 
>> committing locally triggers post-commit on your local repo.
> 
> These did not work.
> 
>> pushing to remote triggers post-update (and others) on the remote 
>> server's repo.
> 
> These also did not work. In short, the triggers that the
> documentation defines for both client and remote hooks fail to
> produce information in the client. Any idea on why?
> 
> Jeremiah-- To unsubscribe from this list: send the line "unsubscribe
> git" in the body of a message to majordomo@vger.kernel.org More
> majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
