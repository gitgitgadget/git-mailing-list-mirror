From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 9/9] Add a sample user for the svndump library
Date: Thu, 24 Jun 2010 22:42:26 +0200
Message-ID: <AANLkTinSbQbT1tmKIiWnZnX52mJEZOlf9xCV1ENUGFT_@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110752.GI12376@burratino> 
	<AANLkTinnB_TRYa0nzJHHqbHuJk9a7tfk8mAhr95Sc98E@mail.gmail.com> 
	<20100624203041.GA2262@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtGC-0000f7-W5
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab0FXUms convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:42:48 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40810 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0FXUmr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 16:42:47 -0400
Received: by qyk38 with SMTP id 38so312580qyk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KNzMH+xmvw+SasWKbZRqbil2VFd7O+08a3LHVKwMncI=;
        b=yEWSiVvYJYHliQaAuttqTsHdzdD22iw+OfzJv+3OHFW7gzZRz4mnhxTgjS9k7OL/h1
         jklTxNnLAuvmG+Y8lctft3/jWDqnW0OxF2EizicgE6+7o+Noh3n6ZBYqbRWtSh0q4060
         2ZXGf2GEh7/23Bss5i5u2okPleuVEQ+sPcBew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D3sLrCjdGCBJ0H2OCUUSWwFSegIJkTS04fSzdbF61bc3pZ/xRY4AfrpqV2FXRUZ9mD
         tcd2s1+PY6DeqkvzgLHG3C9sXjNZHALwv6KZTVZ0X7HrPR2YvEJlJBxTTHTLp/wuJ6ou
         40f8ldd1C+voShWdr9d398ADtCM9NymQz9CtY=
Received: by 10.224.34.141 with SMTP id l13mr6494994qad.220.1277412166446; 
	Thu, 24 Jun 2010 13:42:46 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 13:42:26 -0700 (PDT)
In-Reply-To: <20100624203041.GA2262@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149641>

Hi again,

Jonathan Nieder wrote:
> Turn off persistence until it is ready. =C2=A0At that point, we will =
need
> to access the target git repo anyway, so we can keep extra metadata i=
n
> the .git directory.

Unfortunately, turning off persistence isn't so easy now because the
branch has been merged into master now, and it's difficult to sort out
just the commits that correspond to persistence and rebase.
Yes, the remote helper can use the .git directory, but I thought we
wanted to keep this in contrib/ even after the remote helper is
merged?

> See commit 74f2b2a.
>
> Summary: this produces the
>
> =C2=A0 =C2=A0CC foo.o
>
> lines. =C2=A0The idea is that long command lines distract from what i=
s more
> important, which is the compiler output. =C2=A0The behavior can be tu=
rned
> off with =E2=80=9Cmake V=3D1=E2=80=9D or =E2=80=9Cmake -s=E2=80=9D.

Ah. Black magic :)

> Maybe the file should get a simpler license? =C2=A0e.g.:
>
> =C2=A0This file is in the public domain.
> =C2=A0You may freely use, modify, distribute, and relicense it.

Yes, I like this.

> Sounds reasonable. =C2=A0Care to suggest wording?

Something along "REPO is a path to a Subversion repository mirrored on
the local disk. Remote Subversion repositories can be mirrored on
local disk using the `svnsync` command."

> Do version 3 dumpfiles fail?

Yes, they do. We aren't parsing the extra headers anywhere, and
deltified dumps aren't supported.

-- Ram
