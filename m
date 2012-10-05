From: =?koi8-r?B?7dXLz9fOycvP1yDtycjBycw=?= <m.mukovnikov@gmail.com>
Subject: Re: Bug report
Date: Fri, 5 Oct 2012 14:52:14 +0400
Message-ID: <CD9B0AA9-703B-4B26-BEFA-A548DC1D548A@gmail.com>
References: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com> <20121005143231.788094d675c9974f4777318d@domain007.com>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 12:52:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5W9-0003G0-AW
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 12:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab2JEKwT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 06:52:19 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56591 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108Ab2JEKwT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 06:52:19 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1226843lbo.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=/+55klCu/1tNVAjZmyJuqtzgxEJP25zhJDfepOwm8eo=;
        b=Es63A5tzFRI3pQUtOOfZNDU5s1U7yRTIOY7OvVAHEeKr22d+iberyPl7cfGljNF2Dj
         +uKVqjohhxU6q/2l6JP7e/3PPElVLt6QRlvsdBHgUlJoqnEsKI33m4vLpHWqRHHK5hPb
         fo1u1ob7x2PA+tBLv4M0cXCqzdpkRV7jCCi7BDmCeY1A0WZ4wqDwgbdWxNAkPnqvnC64
         PHdVpmbs0SVqSTmfe0d8BsyiYiqXxHhkCRDMnjYSPpHNKGSMgtqpRcfTGvG4KD/CRK0U
         KuvaIG4Rk8itH5/oVT0XAmzbOS7UVrKxIOMuTWU8zecCXLbSJ2kNpq+gYP3c0PQp+EC7
         0qvQ==
Received: by 10.112.38.134 with SMTP id g6mr3855352lbk.39.1349434337387;
        Fri, 05 Oct 2012 03:52:17 -0700 (PDT)
Received: from 192.168.215.200 ([213.232.243.233])
        by mx.google.com with ESMTPS id i3sm3042670lbg.10.2012.10.05.03.52.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 03:52:16 -0700 (PDT)
In-Reply-To: <20121005143231.788094d675c9974f4777318d@domain007.com>
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207097>

Hey, Konstantin!
Thanks for your reply. My bad, I described the problem not very well. I=
 don't mind displaying escapes etc. (core.quotepath just makes "\320\27=
0\314\206" be "=CA" and that's it), the problem is that git cannot trac=
k files with cyrillic "=CA" in their name. I created a file, added it b=
ut git writes it's still untracked, and it seems there's no way to trac=
k it.

05.10.2012, =D7 14:32, Konstantin Khomoutov <flatworm@users.sourceforge=
=2Enet> =CE=C1=D0=C9=D3=C1=CC(=C1):

> On Fri, 5 Oct 2012 14:13:49 +0400
> =ED=D5=CB=CF=D7=CE=C9=CB=CF=D7 =ED=C9=C8=C1=C9=CC <m.mukovnikov@gmail=
=2Ecom> wrote:
>=20
>> There's a problem using git with files having cyrillic '=CA' in thei=
r
>> name, git just can't track them.
>>=20
>> uname: Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25
>> 00:48:52 PDT 2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64 git
>> version: 1.7.12.1 (from macports)
>>=20
>> Steps to reproduce:
>> - git init
>> - touch test_=CA
>> - git status (should be "untracked files present")
>> - git add test_=CA
>> - git status
>>=20
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	"test_\320\270\314\206"
>> nothing added to commit but untracked files present (use "git add" t=
o
>> track)
>>=20
>> Could this be helped somehow?--
>=20
> What "this"?  If you mean displaying escapes for UTF-8 bytes
> representing that letter "=CA", then try setting core.quotepath to fa=
lse
> for this repository and see if that helps.
>=20
> More info can be found in the git-config manual page.
