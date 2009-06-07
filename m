From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP/RFC] Allow push and fetch urls to be different
Date: Sun, 07 Jun 2009 11:00:15 +0200
Message-ID: <4A2B819F.8010907@drmicha.warpmail.net>
References: <7v1vpztsci.fsf@alter.siamese.dyndns.org>	<1244299395-6605-1-git-send-email-git@drmicha.warpmail.net> <7vtz2sbrqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nikos Chantziaras <realnc@arcor.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 11:00:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDEEx-0005Iz-JX
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 11:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbZFGJAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 05:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753270AbZFGJAV
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 05:00:21 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37959 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753198AbZFGJAU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 05:00:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id A781934D5BC;
	Sun,  7 Jun 2009 05:00:21 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 07 Jun 2009 05:00:21 -0400
X-Sasl-enc: +SNhj3uIxDw6nb7RFLVU127+Cf6ZqmXFAid46L5ehnxA 1244365221
Received: from localhost.localdomain (p54859F19.dip0.t-ipconnect.de [84.133.159.25])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AB5283C081;
	Sun,  7 Jun 2009 05:00:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090606 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vtz2sbrqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120958>

Junio C Hamano venit, vidit, dixit 07.06.2009 06:19:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> This introduces a config setting remote.$remotename.pushurl which is
>> used for pushes only. If absent remote.$remotename.url is used for
>> pushes and fetches as before.
>> This is useful, for example, in order to to do passwordless fetches
>> (remote update) over git: but pushes over ssh.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> This is a working prototype, but I'd like to rfc about the approach before
>> coding further.
> 
> As I am guilty for suggesting this, obviously I do not have a problem with
> what the patch wants to achieve.
> 
> And the change looks simple, straightforward and correct.
> 
>> Things that would go in a full series:
>> * documentation (man pages, maybe manual)
>> * tests
> 
> Surely.
> 
>> * teach builtin-remote about pushurl
> 
> Hmm,...  my impression was that "git remote" does not have much support
> for the push side.  What kind of things are you going to teach?

First I was thinking about rm and mv, but that's being taken care of
automatically by removing/renaming a config section. This leaves "remote
show $remote" which should list the pushurls along with the urls.
"remote -v" should probably list urls but not pushurls. I don't plan on
adding pushurl support to "remote add", I think using git config is OK
for this setting.

Michael
