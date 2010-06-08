From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Tue, 08 Jun 2010 10:07:49 +0200
Message-ID: <4C0DFA55.8070800@drmicha.warpmail.net>
References: <20100605110930.GA10526@localhost> <vpqljas5e33.fsf@bauges.imag.fr> <20100606164642.GA10104@localhost> <buobpbnz6mh.fsf@dhlpc061.dev.necel.com> <20100607185439.GB17343@localhost> <vpqzkz6fy9m.fsf@bauges.imag.fr> <20100607193226.GA19789@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jun 08 10:08:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtrG-0000bF-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 10:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab0FHIIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 04:08:20 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51999 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227Ab0FHIIS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 04:08:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B5E8EF86A1;
	Tue,  8 Jun 2010 04:08:16 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 08 Jun 2010 04:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=CBsWcNLQwAMusR2jNJGyXZliplg=; b=onCPj24epZ7pnfJCzAEwiX2cLNet/lqgPK56CdYWUwcbqs77WFOrTeuWlLEsFhVU6Yqy7TFewPy/q4rBWV81iCfkI8jouqBpISaRyHRB06n4EeehRKBNR7IA9kPsuInh/hvCoD+UQPhfEOjG9QWWwfs5BsOrvLQOIgBYtw1G9F0=
X-Sasl-enc: fX43ItplTk5Ajn410vkRUjxj0EO1cMCF1EMCzqPRl/NZ 1275984494
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 529BA4C1D5;
	Tue,  8 Jun 2010 04:08:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100604 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100607193226.GA19789@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148651>

Clemens Buchacher venit, vidit, dixit 07.06.2010 21:32:
> On Mon, Jun 07, 2010 at 09:17:25PM +0200, Matthieu Moy wrote:
>> Clemens Buchacher <drizzd@aon.at> writes:
>>
>>> But this is supposedly a feature which helps users who type "git
>>> checkout <branch>" by mistake, when they really wanted to do "git
>>> checkout -t <remote>/<branch>".
>>
>> Not sure what's the argument here, but aren't the two commands
>> equivalent? Do you prefer the second syntax "git checkout -t
>> <remote>/<branch>"? It's already a DWIM for "git checkout -b <branch>
>> -t <remote>/<branch>", and I find this one far more confusing:
>>
>> git checkout    <remote>/<branch> => detaches HEAD
>> git checkout -t <remote>/<branch> => creates a local branch automatically
> 
> The intent with -t is clear. It is used only when you create a new
> branch. Also, you specify the remote branch you're going to create
> a new branch from.
> 
> "git checkout <branch>", on the other hand, will create a branch
> based on a remote branch, even though you neither asked for a new
> branch, nor did you specify any remote at all.

You're making a very important point here:

The existing DWIMery executes *different commands* depending on the
circumstances (<branch> existing or not). "checkout" and "checkout
-t/-b" really are different commands.

For me, DWIMery is OK in these cases:

- completing refs (<name> may be refs/heads/<name> or refs/tags/<name> etc.)

- Adding options without which the other options don't make sense
(independent of the circumstances), such adding "-b" for "-t", or, even
doing the DWIMery above since "--track" is requested explicitly.

Changing the command (mode) is something fundamentally different.

[In this specific case, it also keeps the user from learning what's
going on, but that's a different issue.]

But I'm afraid it's too late.

Michael
