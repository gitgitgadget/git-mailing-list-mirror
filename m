From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 01:12:43 +0100
Message-ID: <4956C47B.4020602@lsrfire.ath.cx>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain> <200812280024.59096.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Dec 28 01:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjIH-0006y1-3W
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYL1AMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 19:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYL1AMs
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:12:48 -0500
Received: from india601.server4you.de ([85.25.151.105]:39602 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbYL1AMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 19:12:47 -0500
Received: from [10.0.1.101] (p57B7C571.dip.t-dialin.net [87.183.197.113])
	by india601.server4you.de (Postfix) with ESMTPSA id DB9F92F8003;
	Sun, 28 Dec 2008 01:12:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <200812280024.59096.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104034>

Markus Heidelberg schrieb:
>> git log --pretty=3Dformat:%s (and tformat:) used to display the firs=
t
>> line of the subject, unlike the other --pretty options, which would
>> construct a subject line from all lines of the first paragraph of
>> the commit message.
>=20
> And that can be very annoying when working on repositories with a
> history not formatted after the recommendations of git (empty line af=
ter
> the summary). Then the output of commands like
> "git log --pretty=3Doneline", "git format-patch" and "git show-branch=
"
> is unreadable.
>=20
> Sorry, I haven't tested your patch set, what is the output of
> git-shortlog like now?

It's unchanged since it has it's own commit message parser.

>> For consistency and increased code reuse, change format: to do the
>> same as the other options.
>=20
> What's wrong with using the first line instead of the first paragraph
> for the other pretty options and for cases where only a small subject
> line is desired? A sentence would be broken into a small uncomplete p=
art
> for the subject for example. What else?

I'm inching towards the goal of being able to replicate all of the othe=
r
--pretty flavours with format: (or tformat:) strings.

--pretty=3Doneline used to print only the first line, but was changed t=
o
the way it's now in 4234a761 more than a year ago.  In my mind,
"subject" is defined by "what oneline is printing", so I think changing
the format: placeholder %s to show the whole first paragraph is a bug f=
ix.

If you actually like the old behaviour then perhaps a new placeholder
(%S ?) should be introduced instead?

Ren=C3=A9
