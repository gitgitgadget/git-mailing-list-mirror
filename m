From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Fri, 26 Sep 2008 08:32:19 +0200
Message-ID: <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 08:34:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6uB-0002il-Lv
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 08:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYIZGdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 02:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbYIZGdK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 02:33:10 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:34250 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYIZGdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2008 02:33:09 -0400
Received: from cuzco.lan (142.pool85-53-5.dynamic.orange.es [85.53.5.142])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m8Q6WM8Q008801
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 26 Sep 2008 02:32:24 -0400
In-Reply-To: <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96831>

El 26/9/2008, a las 2:37, Linus Torvalds escribi=F3:

> On Thu, 25 Sep 2008, Linus Torvalds wrote:
>>
>> And the thing I wanted to work was to have the abbreviated SHA1's =20
>> that
>> have started to get more common in the kernel commit logs work as =20
>> links in
>> gitk too, just the way a full 40-character SHA1 link works.
>
> For a test-case, I just pushed out my current top-of-tree that finall=
y
> pushed me over the edge. I've seen this before, but I couldn't really
> force me to do anything about it until now.
>
> So to see this in action, do
>
> 	gitk v2.6.26..6ef190c
>
> on the current kernel repo, and notice that "Commit ee1e2c82 ("IPoIB:
> Refresh paths .." thing, where we want that 'ee1e2c82' to be a link =20
> even
> though it's not a full SHA1.
>
> Of course, the matching could be better, it will now accept any =20
> random 6+
> character sequence of hex characters, even if they are surrounded by
> characters that make it clear that it's not a SHA1 ("Haahahhaaaaaa!"
> would find the 'aaaaaa' and if you have a commit that starts with =20
> that,
> link to it ;)

I know nothing about tcl/tk, but will comment anyway:

It's a shame that tcl/tk regular expressions don't appear to support =20
anchoring matches against word boundaries (ie. "\b").

If so, a regexp like:

  [regexp {\b[0-9a-f]{4,39}\b} $id]

would mostly eliminate that kind of false positive. But from my =20
reading of the wiki[1], looks like there's no "\b" escape sequence. =20
Nor does it look like tcl/tk has support for lookahead/lookbehind =20
assertions which could be used to the same effect.

>

Cheers,
Wincent

[1] http://wiki.tcl.tk/396
