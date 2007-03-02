From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Thu, 01 Mar 2007 20:39:39 -0800
Message-ID: <7v8xegntro.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<87y7mhrnrc.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Josefsson <simon@josefsson.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMzYX-00012c-Lw
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 05:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422872AbXCBEjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Mar 2007 23:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422876AbXCBEjm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 23:39:42 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47886 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422872AbXCBEjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 23:39:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302043940.JZBZ26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 23:39:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vgff1W00F1kojtg0000000; Thu, 01 Mar 2007 23:39:40 -0500
In-Reply-To: <Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 1 Mar 2007 19:15:50 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41156>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 3) Possible charset problem?  Compare this (correct):
>>=20
>>         * configure.in: Fix -Wno-pointer-sign test to respect user-d=
efined
>>         CFLAGS.  Reported by "Diego 'Flameeyes' Petten=C3=B2"
>>         <flameeyes@gentoo.org>.
>>=20
>> with (wrong):
>>=20
>>         * configure.in: Fix -Wno-pointer-sign test to respect user-d=
efined
>>           CFLAGS.  Reported
>>=20
>> The git log do seem to contain the correct data, though, from git-lo=
g:
>>=20
>>     Fix -Wno-pointer-sign test to respect user-defined CFLAGS.  Repo=
rted
>>     by "Diego 'Flameeyes' Petten=C3=B2" <flameeyes@gentoo.org>.
>
> No charset problem. In Git commit messages, the first line is special=
=2E It=20
> is the so called "oneline" description. If you wrap the oneline, it's=
 your=20
> fault, not Git's.

I suspect that oneline mode in pretty_print_commit() _could_
treat the first line specially, by grabbing the first paragraph
and squashing LF into SP.  Commit messages that follow the
kernel convention (which matches well with what applymbox and am
creates) would always have a single line in the first paragraph,
so there is no change in behaviour, while commits that lack the
empty line on the second line, most often seen in cvsimport,
would get something a bit more readable than the status quo.

Not that I care too deeply about it.
