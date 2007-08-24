From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 09:28:51 +0300
Message-ID: <1C01FFED-1C80-4C1F-A73D-2529B5B81F7E@pp.inet.fi>
References: <11878991123605-git-send-email-v@pp.inet.fi>
 <vpqabsikmbg.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 24 08:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOSg6-0006zy-KS
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 08:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbXHXG3r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 02:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbXHXG3r
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 02:29:47 -0400
Received: from hyatt.suomi.net ([82.128.152.22]:47263 "EHLO hyatt.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755683AbXHXG3q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 02:29:46 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JN900DIOM1CVB00@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 24 Aug 2007 09:29:36 +0300 (EEST)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JN900GP7M1L9C80@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 24 Aug 2007 09:29:45 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id A457517718A; Fri,
 24 Aug 2007 09:29:28 +0300 (EEST)
In-reply-to: <vpqabsikmbg.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,	score=-0.769,
 required 5, autolearn=not spam, AWL 0.23,	BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56551>

On Aug 23, 2007, at 23:50, Matthieu Moy wrote:

> V=E4in=F6 J=E4rvel=E4 <v@pp.inet.fi> writes:
>
>> Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status =20
>> commands.
>                                        ^^
>
> I suppose you meant --only-tracked.

Yes, a stupid typo. It should be --only-tracked.

>>  static const char runstatus_usage[] =3D
>> -"git-runstatus [--color|--nocolor] [--amend] [--verbose] [--=20
>> untracked]";
>> +"git-runstatus [--color|--nocolor] [--amend] [--verbose]
>> [--untracked]" "[--only-tracked]";
>                ^^^
>
> The compiler will concatenate the strings, but won't add a space. Tha=
t
> results in "... [--untracked][--only-tracked]".

Should have checked it more properly, sorry about that.

>
> Otherwise, the patch sounds fine to me. Not /terribly/ usefull, but
> why not.

This is something that has come up many times on our project, there =20
might be a lot of temporary files that are used inside the project =20
tree, to test the code, and the user just wants to see the =20
modifications to tracked files without using a pager. One could use =20
gitignore, but in our case, it would be hard to create a gitignore =20
which would ignore all of the test files, and none of the actual =20
project files, so it's quite convenient to use --only-tracked.

A better behavior might be to test outside of the project tree.

>
> --=20
> Matthieu

--
V=E4in=F6