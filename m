From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 08 Jun 2010 10:37:05 +0200
Message-ID: <4C0E0131.9030701@drmicha.warpmail.net>
References: <20100605110930.GA10526@localhost>	<vpqljas5e33.fsf@bauges.imag.fr>	<20100606164642.GA10104@localhost>	<buobpbnz6mh.fsf@dhlpc061.dev.necel.com>	<20100607185439.GB17343@localhost>	<vpqzkz6fy9m.fsf@bauges.imag.fr>	<20100607193226.GA19789@localhost>	<4C0DFA55.8070800@drmicha.warpmail.net> <AANLkTinCq1lzD8_RTQVKOcEkDh_Yw41WXpYQsJVgkJRn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:37:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLuJX-0002Oe-D0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab0FHIhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 04:37:33 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51556 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753796Ab0FHIhc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 04:37:32 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6307BF2610;
	Tue,  8 Jun 2010 04:37:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 08 Jun 2010 04:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0cNtxaMrXMKxnYizkLJDuUuEBKk=; b=h4VONyvJrNq4KhHcMlG1u/FN+I4BWoAZWKbQdSLXmEBrSWxCiUe6sixFtdOXuXB20jbnyh2d8KEAOWaI+gt++Kfq4t49Wv8NqKH00QTtAZbuGPF31irsMMrTDpMSXBiZx2rfTdzFBpQ/DLkEzTWDjZnNvOAuOioAUzTGzYWsiS4=
X-Sasl-enc: 3VhqXjbEKO4rJ/wK0LBLLnDHBESOx/h6P9mN+kAtpKKW 1275986250
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2686F4CB462;
	Tue,  8 Jun 2010 04:37:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTinCq1lzD8_RTQVKOcEkDh_Yw41WXpYQsJVgkJRn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148656>

demerphq venit, vidit, dixit 08.06.2010 10:18:
> On 8 June 2010 10:07, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Clemens Buchacher venit, vidit, dixit 07.06.2010 21:32:
>>> On Mon, Jun 07, 2010 at 09:17:25PM +0200, Matthieu Moy wrote:
>>>> Clemens Buchacher <drizzd@aon.at> writes:
>>>>
>>>>> But this is supposedly a feature which helps users who type "git
>>>>> checkout <branch>" by mistake, when they really wanted to do "git
>>>>> checkout -t <remote>/<branch>".
>>>>
>>>> Not sure what's the argument here, but aren't the two commands
>>>> equivalent? Do you prefer the second syntax "git checkout -t
>>>> <remote>/<branch>"? It's already a DWIM for "git checkout -b <branch>
>>>> -t <remote>/<branch>", and I find this one far more confusing:
>>>>
>>>> git checkout    <remote>/<branch> => detaches HEAD
>>>> git checkout -t <remote>/<branch> => creates a local branch automatically
>>>
>>> The intent with -t is clear. It is used only when you create a new
>>> branch. Also, you specify the remote branch you're going to create
>>> a new branch from.
>>>
>>> "git checkout <branch>", on the other hand, will create a branch
>>> based on a remote branch, even though you neither asked for a new
>>> branch, nor did you specify any remote at all.
>>
>> You're making a very important point here:
>>
>> The existing DWIMery executes *different commands* depending on the
>> circumstances (<branch> existing or not). "checkout" and "checkout
>> -t/-b" really are different commands.
> 
> "checkout a branch" is the command. The rest is just bookkeeping.

I'm sorry but that is just plain silly.

We have several "commands" which do very different things depending on
options, i.e. comprise different commands/command modes - which is why I
used the phrase command (mode) in the part you chose to leave out.

One mode is checking out an existing branch.

One mode is creating a new branch and checking it out, i.e. doing a "git
branch" followed by a "git checkout" proper.

Current DWIMery switches from the first to the second depending on your
existing branches. The only reason this could sneak in is the fact that
it is non-destructive, just (over-) eagerly constructive.

Michael
