From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : 2 questions on git-send-email usage
Date: Tue, 11 Jul 2006 08:46:35 +0000 (GMT)
Message-ID: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 10:46:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Dt9-0001j9-53
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 10:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWGKIqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 04:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWGKIqh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 04:46:37 -0400
Received: from web25809.mail.ukl.yahoo.com ([217.12.10.194]:36240 "HELO
	web25809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750770AbWGKIqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 04:46:36 -0400
Received: (qmail 81395 invoked by uid 60001); 11 Jul 2006 08:46:35 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=JYuNow69yyfFxwOOmbs1x39VSRvJ58JMrU49DBmXf7STuT3e95nykz4m9d5mNPPVJxkZmDAhh0wZEJBWN6Fj5yI+HBDrsS32lPHP+0aceaM2aKp0vIcrmNPISEjw4sPcws4oWivL1SEPqDUz0SPb67+GojM/G9S9tZeaxYEHpHs=  ;
Received: from [194.3.162.233] by web25809.mail.ukl.yahoo.com via HTTP; Tue, 11 Jul 2006 08:46:35 GMT
To: moreau francis <francis_moreau2000@yahoo.fr>, jnareb@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23697>

moreau francis wrote:
> (please let me CCed when replying)
>  
>  2006/7/10, Jakub Narebski <jnareb@gmail.com>:
>  > moreau francis wrote:
>  > 
>  > > I'm wondering what am I supposed to answer when git-send-email
>  > > is asking me :
>  > >
>  > > Message-ID to be used as In-Reply-To for the first email?
>  > >
>  > > I'm running this command:
>  > >
>  > > $ git-send-email --no-signed-off-by-cc --no-chain-reply-to --to \
>  > >   foo@bar.com --compose /tmp/patch/
>  > >
>  > > to write an introductory message, and all patches are sent as replies to
>  > > this introductory email sent.
>  > 
>  > Empty string (i.e. RET) should do if you don't want to attach your series of
>  > patches somewhere in existing thread.
>  
>  ok I'll try
>  
>  --in-reply-to ""

ok it works. But wouldn't it make more sense to have by default --in-reply-to ""
when --compose is set ? That would mean "by default all patches are sent
as replies to the email I'm composing" which is usely what happens, no ?

>  
>  > 
>  > > I also noticed that git-send-email removes the commit message of each
>  > > patches I sent, I don't think this is the normal behaviour though. What
>  > > am I missing ?
>  > 
>  > Are patches formatted using git-format-patch?
>  > 
>  
>  yes
>  

I think I have found out a clue. The commit message and Signed-off-by are
missing because the header patches are formatted like this:

>From 90df31ca209f85108976d18916f33f352a6ef340 Mon Sep 17 00:00:00 2001
From: Francis <francis.moreau2000@yahoo.fr>
Date: Thu, 8 Jun 2006 09:51:12 +0200
Subject: [PATCH 3/4] step #3: interrupt implementation
(cherry picked from 427778e2e622cdefa2c834edcc19bf102a35bc2d commit)
(cherry picked from fe4692336801fcbb42bb734bb6b6f9c041d63087 commit)
Signed-off-by: Francis <francis_moreau2000@yahoo.fr>
---

2 RETs is missing. One after the Subject line and the other before the 
Signed-off-by line. If I add the first missing RET, all works fine.  I guess
it's missing because of git-cherry-pick command. But I don't understand
why the last RET is missing

Can anybody tell me why ?

Thanks

Francis
