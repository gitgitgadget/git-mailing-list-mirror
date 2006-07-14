From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] urls.txt: Use substitution to escape square brackets
Date: Sat, 15 Jul 2006 00:57:04 +0100
Message-ID: <44B82F50.7050106@atoker.com>
References: <11528726881431-git-send-email-alp@atoker.com>	<20060714215039.GA21994@diku.dk>	<7vfyh3on6w.fsf@assigned-by-dhcp.cox.net> <44B82243.20604@atoker.com> <7v8xmvok49.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jul 15 01:57:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1XWx-0001hs-St
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 01:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWGNX5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Jul 2006 19:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945925AbWGNX5H
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 19:57:07 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:28422 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1945924AbWGNX5G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 19:57:06 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id F0AE4176BFA;
	Sat, 15 Jul 2006 00:57:04 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v8xmvok49.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23918>

Junio C Hamano wrote:
> Alp Toker <alp@atoker.com> writes:
>=20
>> Junio C Hamano wrote:
>>> Looks nicer.  Alp?  Does this work with your version of
>>> asciidoc?
>> I'm using asciidoc 7.0.2, which came with Ubuntu Dapper.
>>
>> The man page output now looks like this:
>>
>>        =B7  ssh://[ # [user@] # ]host.xz/path/to/repo.git/
>>        =B7  ssh://[ # [user@] # ]host.xz/~user/path/to/repo.git/
>>        =B7  ssh://[ # [user@] # ]host.xz/~/path/to/repo.git
>=20
> I got a bit inventive and removed the comments after #, which
> were in Jonas's version, when I tried it out.  Maybe doing the
> same might help you, since I suspect the above '#' are coming
> from the comment part.

No. Removing the comments doesn't help -- the output remains broken.

>> Out of the three patches,
>>
>>   (at) "ssh://[user@]host.xz/path/to/repo.git/"
>>   (jc) "ssh://+++[user@+++]host.xz/path/to/repo.git/"
>>   (jf) "ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/"
>>
>> I'd say (at) is still most readable, not requiring +++ markup (jc) o=
r
>> hacks to asciidoc.conf (jf).
>=20
> I do not think defining [attribute] is a hack; it is a
> documented feature.

"You write an AsciiDoc document the same way you would write a normal=20
text document, there are no markup tags or weird format notations."

asciidoc solves this problem by design and without markup, with the=20
prescribed syntax being to indent and quote the text verbatim, just as=20
it was meant to be read.

Why try to fit a square peg in a round hole by defining attributes? It'=
s=20
a good indicator that there's a hack going down when three competent=20
programmers can't escape a square bracket after three attempts spanning=
=20
  two days ;-)
