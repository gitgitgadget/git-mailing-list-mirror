From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Fri, 09 Nov 2007 01:49:19 +0100
Message-ID: <4733AE8F.4080403@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>	<Pine.LNX.4.64.0711041915290.4362@racer.site>	<7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>	<472F7B2F.4050608@lsrfire.ath.cx>	<7vejf4kwry.fsf@gitster.siamese.dyndns.org>	<4730EB4E.4080903@lsrfire.ath.cx> <4730F5FA.3030705@lsrfire.ath.cx> <7vhcjxaire.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFN-00047A-SR
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760720AbXKIA7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 19:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757856AbXKIA7s
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 19:59:48 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:52599
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756422AbXKIA7r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 19:59:47 -0500
Received: from [10.0.1.201] (p57B7C9DB.dip.t-dialin.net [87.183.201.219])
	by neapel230.server4you.de (Postfix) with ESMTP id E32D8873BA;
	Fri,  9 Nov 2007 01:49:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcjxaire.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64096>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I haven't seen any comments on strbuf_expand.  Is it too far out?
>> Here it is again, adjusted for current master and with the changes
>> to strbuf.[ch] coming first:
>=20
> Numbers talk ;-).

:-)  I just hope someone else has compared the times, too..

> In your previous round, you alluded that the strbuf_expand()
> interface could allow caching of the return value of fn(), but I
> do not think strbuf_expand() in this patch has anything to
> directly support that notion.
>=20
> Nor I would expect to --- fn() could keep the really expensive
> information cached, keyed with context value, if it wanted to,
> but in practice for the purpose of format_commit_item() I do not
> offhand see anything cacheable and reusable, unless the user did
> stupid things (e.g. use more than one %h in the format string).

Yes, that's what I arrived at, too, when I actually wrote and used
the function.

> I added a few paragraphs to describe the API in the commit log
> message, and rewrote "# master" to "(master)" etc.

Thanks!  I'll send a slightly enhanced version in a two-patch
series -- with an actual commit message, including your API
desciption -- in just a few seconds.

Ren=C3=A9
