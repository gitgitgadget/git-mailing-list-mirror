From: Kate Ebneter <kate@ning.com>
Subject: Re: Strange behavior (possible bug) using bash command
 subsitution with "git branch"
Date: Sun, 08 Nov 2009 15:10:13 -0800
Message-ID: <C71C8FD5.2243E%kate@ning.com>
References: <20091108230300.GB17129@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Bj=?ISO-8859-1?B?9g==?=rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 09 00:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7H3a-0003ny-NH
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 00:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbZKHXUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 18:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbZKHXUO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 18:20:14 -0500
Received: from server107x.exghost.com ([69.20.26.49]:2895 "EHLO
	server107.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750763AbZKHXUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2009 18:20:13 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2009 18:20:13 EST
X-Policy: GLOBAL - ning.com
X-Policy: GLOBAL - ning.com
X-Policy: GLOBAL - ning.com
X-Primary: kate@ning.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: kate@ning.com ALLOWED
X-Virus-Scan: V-
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->UNITED STATES->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 207.97.230.106
X-Note-Reverse-DNS: fe08.exg3.exghost.com
X-Note-WHTLIST: kate@ning.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 120 121 122 123 127 128 139 225 
X-Note: Mail Class: ALLOWEDSENDER
X-Note: Headers Injected
Received: from [207.97.230.106] (HELO FE08.exg3.exghost.com)
  by server107.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 120981757; Sun, 08 Nov 2009 18:10:25 -0500
Received: from be32.exg3.exghost.com ([207.97.230.171]) by FE08.exg3.exghost.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 8 Nov 2009 18:10:17 -0500
Received: from 207.97.202.210 ([207.97.202.210]) by be32.exg3.exghost.com ([207.97.230.171]) via Exchange Front-End Server exg3.exghost.com ([207.97.230.162]) with Microsoft Exchange Server HTTP-DAV ;
 Sun,  8 Nov 2009 23:10:14 +0000
User-Agent: Microsoft-Entourage/11.4.0.080122
Thread-Topic: Strange behavior (possible bug) using bash command
 subsitution with "git branch"
Thread-Index: AcpgyKAl3qtbysy7Ed6LBwAX8g2h+g==
In-Reply-To: <20091108230300.GB17129@coredump.intra.peff.net>
X-OriginalArrivalTime: 08 Nov 2009 23:10:17.0828 (UTC) FILETIME=[A305EA40:01CA60C8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132431>

On 11/8/09 3:03 PM, "Jeff King" <peff@peff.net> wrote:

> On Sun, Nov 08, 2009 at 11:49:55PM +0100, Bj=F6rn Steinbrink wrote:
>=20
>>> I ran into a weird situation while working on a script, which is be=
st
>>> described with a little snippet from my gitosis-admin repository:
>>>=20
>>>     $ git branch
>>>     * master
>>      ^^^
>>=20
>>>     $ branch=3D$(git branch)
>>>     $ echo $branch
>>>     gitosis.conf keydir master
>>=20
>> Your shell expands the *, thus echo sees all the things in the curre=
nt
>> directory. Use 'echo "$branch"' and you'll see what you expected.
>=20
> And more to the point, this is just one reason why one should use
> for-each-ref when scripting (the other is that git-branch's output is
> considered porcelain, and is not guaranteed to remain stable). E.g.:
>=20
>   git for-each-ref --format=3D'%(refname:short)' refs/heads/
>=20
> would produce the output the original poster wanted.

Ah, sweet, I did not know about that. I ended up doing something entire=
ly
different (short form: my original idea about what I wanted to do was w=
rong)
but that's very helpful for the future.

Thanks,
Kate Ebneter (who is gradually learning more and more about git)
