From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 07:59:33 -0800 (PST)
Message-ID: <m3iqqvefmo.fsf@localhost.localdomain>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 17:02:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzZC9-0000Q7-Ga
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 17:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbYKJP7h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 10:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753390AbYKJP7h
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 10:59:37 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:9637 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbYKJP7g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 10:59:36 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1117528nfc.21
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 07:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=pEOk68MRhQbYmibFFxr9wJLwUO2rVgefh7mCkIDkRYY=;
        b=E5HJv/XHZ/o4lpFscXIzHA2vxpXmRzfS2TNYuQ+QhuoyBkn5i3oUUDpxxKpI/7+HXt
         MqLDOQxsq6QRgcH3rWW3vYFHjnlr1ATrED+j/+rdxALp2ewc5skt56THVOUIkeaX5ed6
         7GSuXPDyKdNJDiaXJjVVFvDgYsUj1Ze4C+PCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=FexYlVMGxsPNF9rSXRchbKoSQJPU0buXfFX2bJkvipYRM0o0o1/p3toFzxerql1baZ
         pWTQgdocqjX5JezpDwylWrMdV6Z2JZ/A8QxbhWsLeMEyeftqhxFu7e3kDWG6NnbONSL9
         8kLsm9+S/Lh0D+byqIjd3jGzA54Mhw2C6wAKA=
Received: by 10.210.111.4 with SMTP id j4mr7771545ebc.170.1226332774678;
        Mon, 10 Nov 2008 07:59:34 -0800 (PST)
Received: from localhost.localdomain (abwz230.neoplus.adsl.tpnet.pl [83.8.249.230])
        by mx.google.com with ESMTPS id 10sm60523eyd.6.2008.11.10.07.59.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 07:59:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAAFxVIp014092;
	Mon, 10 Nov 2008 16:59:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAAFxS9u014089;
	Mon, 10 Nov 2008 16:59:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87ljvsjuq7.fsf@erwin.mina86.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100529>

Michal Nazarewicz <mina86@tlen.pl> writes:

> Hello,
>=20
> as probably many of you know CVS supported some magic tags which were
> replaced in committed files to a predefined value.  For instance, if
> there was a "$Revision$" string in a file it would get replaced with
> "$Revision: x.y $" (or "$Revision: x.y.z.w $" and so on) where "x.y" =
is
> file's revision number.
>=20
> Now, what I need is such feature in GIT.  Upon committing I would lik=
e
> some magic string (say "$Date$") to be replaced with some value
> identifying uniquely given version of a file (a date of the commit wo=
uld
> be sufficient).
>=20
> I tried using some hooks for it but couldn't came up with anything th=
at
> would actually work.

Well, there is `ident` attribute which you can set in .gitattributes
file which would make git do $Id$ keyword expansion. However the $Id$
git uses is not something you are familiar with: it is 40-character
hexadecimal blob object name. With it you can find (try to find)
relevant commit.

The reason why git doesn't support keywords like $Revision$ or $Date$
is performance: the $Revision$ and $Date$ are keywords related to
_commit_ data, not blob data. You can have the same contents of the
file in two different branches, thus two different commits, thus two
different $Revision$ or $Date$. If contents of file didn't change
between branches, git doesn't touch the file, which results in much
faster branch switching, for example (and also faster committing).

What you can do is one of the following things:

1. You can try to use either hooks (post-commit, post-update I think)
   or smudge / clean filters (via gitattributes) to do keyword
   expansion. This hits performance, and you probably would have the
   problems CVS ad with keyword expansion.

2. You can use `export-subst` gitattribute and make git-archive do
   keyword expansion, which can include things like '$Format:%aD$'
   for commit date (equivalent of $Date:$?).

3. You can run some local equivalent of GIT-VERSION-GEN script git
   and Linux kernel uses, and make your build system (Makefile)
   replace '@@VERSION@@' or '++VERSION++' keywords / placeholders
   as part of compiling process.

HTH
--=20
Jakub Nar=C4=99bski
Poland
ShadeHawk on #git
