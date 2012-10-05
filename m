From: =?utf-8?B?0JzRg9C60L7QstC90LjQutC+0LIg0JzQuNGF0LDQuNC7?= 
	<m.mukovnikov@gmail.com>
Subject: Re: Bug report
Date: Fri, 5 Oct 2012 15:03:14 +0400
Message-ID: <FE9266F4-28C0-4DCF-B91F-92351FE8D226@gmail.com>
References: <61FEBCE8-8206-498C-B3D4-ECD6AF192EE0@gmail.com> <20121005143231.788094d675c9974f4777318d@domain007.com> <87boghdwkx.fsf@centaur.cmartin.tk>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: cmn@elego.de (=?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?=)
X-From: git-owner@vger.kernel.org Fri Oct 05 13:03:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK5gn-0002gr-Mi
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 13:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab2JELDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 07:03:20 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34438 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab2JELDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2012 07:03:19 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1234102lbo.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=QG/H5bTz9YVFNey69vaXh8BLDUjS9QRudSL0BQu/8g4=;
        b=aRr2GMjZQcBfjxWAGL9Udkv/hNmEdfUPb55krrYDCrLDjqMlZBkx/SKwhVSzpgV8d/
         BzrlWYBy3FsB8fyTetTuSuzUcGCNLcPQcS6jG3y4WqRvCXiqf9lptBtwtzUtuW2dCBQD
         i3oWqeWrhbi4QHcjRQtFbHwAt0By86Eu9aV4i9Gn8Cmc/igLKySphEBxQdq/GFmhfIg9
         sbeXFK3lUemsuH+U/PjZSAPGiVz0sVrfNnEws3ypjfNn5wLDcPboyW85fyTuYPl+fi1c
         rDFaIgsNOYI2oZL996n1Jz1Qil+Ucv1KQcCBORxcu2lxzZVkwc6MvVuwHTjxKfWoO6Da
         PuhQ==
Received: by 10.152.104.240 with SMTP id gh16mr6605382lab.56.1349434997758;
        Fri, 05 Oct 2012 04:03:17 -0700 (PDT)
Received: from 192.168.215.200 ([213.232.243.233])
        by mx.google.com with ESMTPS id p7sm3048205lbg.17.2012.10.05.04.03.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 04:03:17 -0700 (PDT)
In-Reply-To: <87boghdwkx.fsf@centaur.cmartin.tk>
X-Mailer: Apple Mail (2.1498)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207098>

Carlos, thank you very much, core.precomposeunicode works just like you=
 said.
And you're right, it seems the problem is in HFS+, 'git add .' worked a=
s well, so did even 'git add test_*'.
The problem seems solved.

05.10.2012, =D0=B2 14:47, cmn@elego.de (Carlos Mart=C3=ADn Nieto) =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):

> Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:
>=20
>> On Fri, 5 Oct 2012 14:13:49 +0400
>> =D0=9C=D1=83=D0=BA=D0=BE=D0=B2=D0=BD=D0=B8=D0=BA=D0=BE=D0=B2 =D0=9C=D0=
=B8=D1=85=D0=B0=D0=B8=D0=BB <m.mukovnikov@gmail.com> wrote:
>>=20
>>> There's a problem using git with files having cyrillic '=D0=B9' in =
their
>>> name, git just can't track them.
>>>=20
>>> uname: Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25
>>> 00:48:52 PDT 2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64 git
>>> version: 1.7.12.1 (from macports)
>>>=20
>>> Steps to reproduce:
>>> - git init
>>> - touch test_=D0=B9
>>> - git status (should be "untracked files present")
>>> - git add test_=D0=B9
>>> - git status
>>>=20
>>> # Untracked files:
>>> #   (use "git add <file>..." to include in what will be committed)
>>> #
>>> #	"test_\320\270\314\206"
>>> nothing added to commit but untracked files present (use "git add" =
to
>>> track)
>>>=20
>>> Could this be helped somehow?--
>>=20
>> What "this"?  If you mean displaying escapes for UTF-8 bytes
>> representing that letter "=D0=B9", then try setting core.quotepath t=
o false
>> for this repository and see if that helps.
>=20
> Notice the 'git add test_=D0=B9'. The problem is that git reports it =
as untracked.
>=20
> =D0=9C=D0=B8=D1=85=D0=B0=D0=B8=D0=BB, is this the whole output or do =
you also see a
> differently-escaped version of the filename under tracked files? Does
> this problem not show up if you use 'git add -A' or 'git add .' inste=
ad
> of typing the name? If so, this happens because HFS+ stores and repor=
ts
> names differently than the way we told it to store it, so git sees a
> different set of bytes than what it's expecting and considers it a
> different file.
>=20
> With a recent version of git, you can set the core.precomposeunicode
> config setting to true, which deals with this situation. This tells g=
it
> to transform the data it gets from the filesystem to the format that
> everyone else uses, which helps not only this, but also the 'git add =
=2E'
> case, so git stores the filename in the format the same way that othe=
r
> OSs expect to find.
>=20
>   cmn
