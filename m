From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: Trouble with case-insensitive filesystems
Date: Fri, 26 Oct 2007 11:29:36 -0400
Message-ID: <A4BC28F4-0774-4D3E-AB1B-DA365841894F@yahoo.ca>
References: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rocco Rutte <pdmef@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlR8Z-0001qV-1o
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 17:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbXJZP3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2007 11:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbXJZP3k
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 11:29:40 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:39498 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752999AbXJZP3j convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 11:29:39 -0400
Received: (qmail 9150 invoked from network); 26 Oct 2007 15:29:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=4XXJ2cyDSSUXxDyw40kO4U+dXKHdUy/subaxlf/UG59vTG9FjUDaXFAvx0fyBr++mUackU2vYGlAQ68B+IY7t/kqr1WflFDYXAAV/Y7XikilP3MJdrZ/JTJQKNl7+m6HxA4zJpk0KlA7XiRX7QK/IuPQA9tgtQoR/Bb/gGMLJ3Y=  ;
Received: from unknown (HELO ?192.168.3.32?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp109.mail.mud.yahoo.com with SMTP; 26 Oct 2007 15:29:37 -0000
X-YMail-OSG: e2vUMScVM1mviu6tXNsKa1i6T5tzAjaHRD5GYNsuFfRu2SJIcI05m0ULSLHxluXDqGcilKqh36HFxhiY7Z.sWtHzmg--
In-Reply-To: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62419>

You can workaround this by creating a disk-image with a case-=20
sensitive filesystem, then do your work inside that virtual drive.

- jfv

Le 07-10-26 =E0 10:52, Rocco Rutte a =E9crit :

> Hi,
>
> after importing the opensolaris hg repo into git, I noticed that =20
> git gets confused if the repo contains files that clash on case-=20
> insensitive filesystems (here on OS X, I can't test Cygwin and =20
> Win32). git-checkout tells me that these files are modified, git-=20
> status gives me:
>
> $ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HB
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/=20
> HB.name
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HI
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/=20
> HI.name
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HX
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/=20
> HX.name
> #       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/=20
> charlib/LH
> #       modified:   usr/src/lib/libldap4/common/Version.c
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> ...without touching anything. Yes, there's a version.c file next to =20
> Version.c, HI.name next to Hi.name and so on.
>
> I'm not really sure what I'm expecting git to do, but I guess I =20
> want it to abort a checkout and only continue with -f. But at the =20
> very least, it should issue a big fat warning (one may decide to =20
> work in some area without clashes).
>
> I really have no idea how to efficiently detect that at runtime and =20
> which areas of git to look at for patching...
>
> Rocco
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
