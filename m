From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 21:41:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903022135360.20047@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se>
 <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com>
 <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
 <200903021530.01165.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:44:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeEzd-0003DA-AL
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 21:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZCBUmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 15:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbZCBUmg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 15:42:36 -0500
Received: from smtp.getmail.no ([84.208.20.33]:57150 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbZCBUmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 15:42:35 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFW00A1BC6WYX00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:42:32 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFW00L7MC5X0160@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:41:57 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFW0064NC5XPF70@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 02 Mar 2009 21:41:57 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 7C66B2FC03; Mon,
 02 Mar 2009 21:41:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 788EB2FC02; Mon, 02 Mar 2009 21:41:57 +0100 (CET)
In-reply-to: <200903021530.01165.trast@student.ethz.ch>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111962>

Thomas Rast:

> Have you thought about all the consequences this would have for the *=
nix=20
> people here? [*]

Yeah. It will fix problems trying to check out a Git repository created=
 by=20
me in a iso8859-1 locale on a machine using a utf-8 locale, where both =
ends=20
would like to have a file named "=DC".

Or, hopefully, a careful adoption of this on Windows won't affect Unixe=
s and=20
other systems with pre-Unicode APIs at all, since the Windows code woul=
d be=20
in the "compat" directory.

> you're still in a world of hurt when trying to check out such paths u=
nder=20
> a locale (or whatever setting might control this new encoding logic) =
that=20
> does not support the whole range of UTF-8.

Yeah. That would be a case similar to the casing problem on Windows.

> With backwards compatibility it's even worse as you're suddenly impos=
ing=20
> extra restrictions on what a valid filename in the repository must lo=
ok=20
> like.

Indeed. It is unfortunate that this wasn't properly specified to start =
with.=20
It's mostly a minor issue since *most* people will not use non-ASCII fi=
le=20
names. At least for most of the kind of projects that Git have attracte=
d so=20
far, so the problem is not that big. The problem is if Git is to attrac=
t=20
"the masses". Especially on Windows, where file names using non-ASCII a=
re=20
common, this needs to be addressed eventually.

> [*] I'm _extremely_ tempted to write "people using non-broken OSes", =
but=20
> let's pretend to be neutral for a second.

In most cases, I would most definitely agree with you on calling it tha=
t,=20
but when it comes to Unicode support, Windows is one of the least broke=
n=20
OSes (with Symbian being my favourite).

--=20
\\// Peter - http://www.softwolves.pp.se/
