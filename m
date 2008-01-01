From: =?UTF-8?B?R3LDqWdvaXJlIEJhcmJpZXI=?= <gb@gbarbier.org>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Tue, 01 Jan 2008 12:41:49 +0100
Message-ID: <477A26FD.7020408@gbarbier.org>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com> <20080101113301.GC9214@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 12:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9fVt-0000W3-8K
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 12:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYAALl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 06:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYAALl4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 06:41:56 -0500
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:55689 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbYAALlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 06:41:55 -0500
Received: from localhost (mfilter3-v.gandi.net [217.70.178.37])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 1A2C2362AF;
	Tue,  1 Jan 2008 12:41:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter3-v.mgt.gandi.net
Received: from relay1-v.mail.gandi.net ([217.70.178.75])
	by localhost (mfilter3-v.mgt.gandi.net [217.70.178.37]) (amavisd-new, port 10024)
	with ESMTP id W-jzwkZay02q; Tue,  1 Jan 2008 12:07:48 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 3752D362AA;
	Tue,  1 Jan 2008 12:41:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080101113301.GC9214@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69436>

Jan Hudec a =C3=A9crit :
> On Mon, Dec 31, 2007 at 10:57:52 -0600, Graham Barr wrote:
>  =20
>> Daniel Barkalow wrote:
>>    =20
>>> On Sun, 30 Dec 2007, Gr=C3=A9goire Barbier wrote:
>>>      =20
>>>> As for me, the main rationale to use http(s) rather than
>>>> git or ssh is to get through corporate firewalls, otherwise I woul=
d probably
>>>> not bother with webdav.
>>>>        =20
>>> In general, we've been able to either get through firewalls with ss=
h or=20
>>> it's all in the same VPN. So it's kind of unloved at this point. Pe=
ople=20
>>> poke at it occasionally, but mostly in the context of other fixes, =
I=20
>>> think.
>>>      =20
>> If you have a http proxy that you can use, the you can use ssh via t=
hat with
>> something like corkscrew. http://wiki.kartbuilding.net/index.php/Cor=
kscrew_-_ssh_over_https
>>    =20
>
> This, obviously, requires, that ssh is running on port 443, because m=
ost HTTP
> proxies won't let you CONNECT anywhere else. I have also heared of a =
HTTP
> proxy, that will check whether the session inside CONNECT starts with=
 SSL
> handshake and will break your connection if it does not.
>  =20

Hello Jan.

I think we have similar experiences. I have personnaly be faced to=20
proxies that not only scan for the SSL handshake but do=20
man-in-the-middle "attack" to break the SSL into two parts, checking fo=
r=20
HTTP inside it (and probably scanning for viruses and things like hat, =
I=20
think).

I first replied privatly to Graham because I didn't think it was=20
interesting for the whole list.
It was a mistake, here is my answer:

In fact, I already use this hack where it is possible.

However some well advised companies does not allow CONNECT through thei=
r HTTP proxy without some limitations that make this tip unusable (for =
instance: allowing only port 443, allowing only sites of a white-list, =
forcing a man-in-the-middle that not only breaks the confidentiality bu=
t too forbids the use of other protocols such as SSH, even on port 443)=
=2E

BTW such circumvention of the security facilities is often (at less whe=
re I live and with my clients) forbidden in some corporate rules, even =
when it is technically possible.
Therefore I'm not allowed to do so and, furthermore, I cannot tell my c=
lients to do so and write documents that tell it's the good way.

I think that real HTTP support is better than all workarounds we will b=
e able to find to get through firewalls (when CONNECT is not available,=
 some awful VPNs that send Etherne over HTTP may work ;-)).
That's why I'm ok to work several hours on git code to enhance real HTT=
P(S) support.


--=20
Gr=C3=A9goire Barbier - gb =C3=A0 gbarbier.org - +33 6 21 35 73 49
