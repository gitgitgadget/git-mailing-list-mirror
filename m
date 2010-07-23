From: Eric James Michael Ritz <Eric@cybersprocket.com>
Subject: Re: Replacing a Remote Branch
Date: Fri, 23 Jul 2010 16:52:42 -0400
Organization: Cyber Sprocket Labs
Message-ID: <4C4A011A.40604@cybersprocket.com>
References: <4C49F83B.4060903@cybersprocket.com> <201007232248.49520.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jul 24 00:05:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcQNQ-000112-4T
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 00:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374Ab0GWWFu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 18:05:50 -0400
Received: from host.cybersprocket.com ([72.52.158.193]:38185 "EHLO
	host.cybersprocket.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab0GWWFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 18:05:49 -0400
X-Greylist: delayed 4384 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2010 18:05:49 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=cybersprocket.com;
	h=Received:Message-ID:Date:From:Organization:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding;
	b=b9bDMsK8qjDjSrWkmClAScQlIKEiU8NGcGXZAlHjwM0rLQq9nLa3Pi7kQM8Vwa69AWFyDWFrCSS/Y/IYFwjUBzi52hSUgzI6PDwtQib0WWFodaflRecXJx/hNE4MVoUx;
Received: from 173.221.45.130.nw.nuvox.net ([173.221.45.130] helo=[10.1.10.120])
	by host.cybersprocket.com with esmtp (Exim 4.69)
	(envelope-from <Eric@cybersprocket.com>)
	id 1OcPEM-0003pQ-QJ; Fri, 23 Jul 2010 16:52:30 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
In-Reply-To: <201007232248.49520.trast@student.ethz.ch>
X-Enigmail-Version: 1.0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.cybersprocket.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cybersprocket.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151576>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 07/23/2010 04:48 PM, Thomas Rast wrote:
> Eric James Michael Ritz wrote:
>>   2. I realized I need to perform some =E2=80=98destructive=E2=80=99=
 action like
>>   =E2=80=98rebase -i=E2=80=99 or amend the last commit to fix a typo=
 in the message.
>>
>>   3. Then I want to push the changed branch as a replacement.
> [...]
>>     $ git push origin :foo && git push origin foo
>>
>> to replace `foo`.  But is there a shorter way to do this?  I thought
>> that writing something like
>>
>>     $ git push origin +foo:foo
>>
>> may have the intended effect, but I still get a rejection due to a
>> non-fast-forward, so I am likely misunderstanding the purpose of `+`=
=2E
>
> Since + overrides the non-ff check, this means that the remote side
> has receive.denyNonFastForwards (see man git-config) enabled (or a
> hook to the same effect).  Deleting and pushing the new branch merely
> defeats this refusal because it is no longer a branch *update*.
>
> You should probably check why and by who receive.denyNonFastForwards
> was set.  Git itself sets it if you use 'git init --shared', so that
> may be one reason.

That=E2=80=99s the reason then, `--shared` was used.

> Note that non-ff updates are generally a bad thing for everyone who
> has work based on the affected branch.

We make it a policy to never base work off individual developer=E2=80=99=
s
branches precisely for this reason, because we=E2=80=99re often making
cleanups via rebase and such.

Thank you for the answer.

- --
Eric James Michael Ritz
Cyber Sprocket Labs
(843) 225-3830
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJMSgEVAAoJEEHUZXw5hMWsu1wIANwTnswKzd0pKub3zms1y2wv
ouv2TRvxvpQhKvVO2r+CjDohdH2BQQIa2FWa8g/bG7fQVvGby1xQkWNJYxypebrh
GHHX3Q4uF6mNIqD+yC4AQNQdEywCDXL4lBqh0Q7Bo+6ZGhUtQIEp1vyWHQeHTLuZ
8NhWd4PwE4z5ssGGKTzzvg2FgkWxtKrNaCVXfPTHpeh51J/Slt0Jfhw/i/zXNlGU
BN0Jlnavhvr5IDbODCNB96KJQue1xLZv+mNNrINlY+TlHwNVyKlq2ui8zvG0vC0K
OwwbOh6HlGV1sPReFfbObu6F9oxz6DMcmdHqNtedQPiAmm38EIuFFTa4H1CiYlM=3D
=3DP2Zr
-----END PGP SIGNATURE-----
