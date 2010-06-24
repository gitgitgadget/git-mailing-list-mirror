From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] Add a sample user for the svndump library
Date: Thu, 24 Jun 2010 15:30:41 -0500
Message-ID: <20100624203041.GA2262@burratino>
References: <20100624105004.GA12336@burratino>
 <20100624110752.GI12376@burratino>
 <AANLkTinnB_TRYa0nzJHHqbHuJk9a7tfk8mAhr95Sc98E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORt4e-0003V9-1u
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab0FXUaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:30:55 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42396 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0FXUay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:30:54 -0400
Received: by pxi8 with SMTP id 8so376885pxi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6XKMDlWCWvskDfXs20ejgUtw6yNtXaROhO0UyHcA/Ks=;
        b=uBmpRaNd+GH208Isf7QFCrAGlJSw2becVHPE0Tyzh8Xbl2OIqN5tVv2DtZsdZr/wfI
         URbi/SfCwHHdcVml7WXcbJlR9RUN008cEhis6ZfACECsSdFSLHxwhjmbz86cMTtJvvH7
         WoH4TAOBxjW6Akg397UC5G6QBqO1VFZcKLGEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Q/SsM/8kMs17ux68fj9MCEukKnl/rIoLVWVBo+21u7WjWYRBmQWUkMW19uLxZ3VveH
         JO/C6Kc1/FrBVsRn9MPym7C866VJP9KffthqmcCbSgdHoHFuPoRj/9sEBwIpRCbC1i3F
         gR5BjZZmKbEqxw2YxYdKXhIXrTmjG8K8uc84M=
Received: by 10.142.3.35 with SMTP id 35mr9807590wfc.74.1277411454502;
        Thu, 24 Jun 2010 13:30:54 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id u6sm42910684ibu.12.2010.06.24.13.30.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:30:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinnB_TRYa0nzJHHqbHuJk9a7tfk8mAhr95Sc98E@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149638>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> NEEDSWORK: litters cwd with useless .bin files.
>> But I hope it is enough to show the idea.
>
> How do you propose we solve this?

Turn off persistence until it is ready.  At that point, we will need
to access the target git repo anyway, so we can keep extra metadata in
the .git directory.

> > +QUIET_SUBDIR0 =3D +$(MAKE) -C # space to separate -C and subdir
> > +QUIET_SUBDIR1 =3D
>=20
> > +ifneq ($(findstring $(MAKEFLAGS),s),s)
> > +ifndef V
> > + =C2=A0 =C2=A0 =C2=A0 QUIET_CC =C2=A0 =C2=A0 =C2=A0=3D @echo ' =C2=
=A0 ' CC $@;
> > + =C2=A0 =C2=A0 =C2=A0 QUIET_LINK =C2=A0 =C2=A0=3D @echo ' =C2=A0 '=
 LINK $@;
> > + =C2=A0 =C2=A0 =C2=A0 QUIET_SUBDIR0 =3D +@subdir=3D
> > + =C2=A0 =C2=A0 =C2=A0 QUIET_SUBDIR1 =3D ;$(NO_SUBDIR) echo ' =C2=A0=
 ' SUBDIR $$subdir; \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 $(MAKE) $(PRINT_DIR) -C $$subdir
> > +endif
> > +endif
>=20
> I saw this in the Git Makefile too, but I didn't understand the logic
> behind it. Could you explain it to me?

See commit 74f2b2a.

Summary: this produces the

    CC foo.o

lines.  The idea is that long command lines distract from what is more
important, which is the compiler output.  The behavior can be turned
off with =E2=80=9Cmake V=3D1=E2=80=9D or =E2=80=9Cmake -s=E2=80=9D.

>> diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
>> new file mode 100644
>> index 0000000..d84dd4f
>> --- /dev/null
>> +++ b/contrib/svn-fe/svn-fe.c
>> @@ -0,0 +1,43 @@
>> +/*
>> + * Parse and rearrange a svnadmin dump.
>> + * Create the dump with:
>> + * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >=
outfile
>> + *
>> + * Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
>> + * All rights reserved.
>
> That's a huge license header applies just to the trivial five-line
> program, right? Is it necessary at all?

I dunno.  I included the license header instead of refering to LICENSE
because this file tends to be installed in /usr/share/doc/git/contrib
and LICENSE does not.

Maybe the file should get a simpler license?  e.g.:

 This file is in the public domain.
 You may freely use, modify, distribute, and relicense it.

>> +#include <stdlib.h>
>> +#include "../../vcs-svn/svndump.h"
>
> Inelegant. Why not include ../../vcs-svn in the path you're searching
> for headers?

Right, this should be changed to

 #include <stdlib.h>
 #include "vcs-svn/svndump.h"

>> +svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
>
> If the user doesn't have a clue about SVN, they won't know what REPO
> is here: Without knowing anything about svnadmin, I'd naively try it
> with a remote repository. Maybe include a note about having to mirror
> a complete repository locally using svnsync (or otherwise) first?

Sounds reasonable.  Care to suggest wording?

>> +Converts a textual representation of a Subversion repository into
>> +input suitable for git-fast-import(1) and similar importers.
>
> To be more specific, "Subversion dumpfile (version: 2)" from FILE(1).

Do version 3 dumpfiles fail?

Jonathan
