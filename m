From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: recursive prefix directory creation
Date: Sun, 20 May 2007 12:51:11 +0200
Message-ID: <4650281F.2030301@lsrfire.ath.cx>
References: <464EE169.30306@lsrfire.ath.cx>	<7vbqggy8ym.fsf@assigned-by-dhcp.cox.net>	<464F568B.9030308@lsrfire.ath.cx> <7vtzu8va12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 12:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpj0U-0000vs-I7
	for gcvg-git@gmane.org; Sun, 20 May 2007 12:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbXETKvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 06:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759829AbXETKvS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 06:51:18 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:33688
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757744AbXETKvR (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 06:51:17 -0400
Received: from [10.0.1.201] (p508E617B.dip.t-dialin.net [80.142.97.123])
	by neapel230.server4you.de (Postfix) with ESMTP id 76ECC16006;
	Sun, 20 May 2007 12:51:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vtzu8va12.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47823>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Junio C Hamano schrieb:
>>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>>>=20
>>>> Currently git-archive only adds a single directory entry for
>>>> prefixes, e.g. for --prefix=3Da/b/c/ only the directory a/b/c/
>>>> would be added to the archive, not a/ nor a/b/.  While tar and
>>>> unzip don't seem to have a problem handling these missing
>>>> entries, their omission was not intended.
>>> Until we start tracking directories (we briefly discussed, and I=20
>>> think I agree with Linus that it should not be too painful), I'd=20
>>> rather keep the current behaviour which I feel is more consistent
>>> with what we really are doing.
>> Hmm, fair enough.  I started out with a simple cleanup and then I
>> guess went a bit overboard with that overblown path walker. :-]
>=20
> Well, I take that back -- I did not realize you were primarily=20
> talking about the LEADING part of the path.

In any case, please don't apply this patch.  I checked again, and it
turns out both tar and zip don't always add leading directories to
archives.  So my "cleanup" only adds bloat.  I'll try to find another
way to beautify the code.

Ren=C3=A9
