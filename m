From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 9/9] Add a sample user for the svndump library
Date: Thu, 24 Jun 2010 22:17:09 +0200
Message-ID: <AANLkTinnB_TRYa0nzJHHqbHuJk9a7tfk8mAhr95Sc98E@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110752.GI12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:17:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsrg-0005rD-4k
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab0FXURc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 16:17:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48785 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab0FXURa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 16:17:30 -0400
Received: by gye5 with SMTP id 5so4647085gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=X7ghtjOjvR9VC6PMiyaWwDtTNWOzeYk8uGAcMJWDO/k=;
        b=RJ1ulZddKrjpLmlUxhd+ROHUKhsbmf9bLvUHDfuuo/dVlQp/PssfR6GoerpdQMkGnr
         QVEhKJlx50qoFwvvdrWxXX00+YEc6fvrNi3BlUMHwXYxen9F+uv9zY/D8F/3e2DqYoq9
         YVXGHpW0QYPtP2Y+NAO2ch4ZgnfOgWq3soXiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fGu9ACKbDkEUA3IsGJqun0Ov53Syg/Y5E/FP8FVTzZfav15paZIWztPNlgR/NeTO8P
         TVUvItTCCb8Y+xABoxw4RrRaKzb7WtlqzQA1aF9awLl8gPLlDyCJuQla6A2mDvNSlbDO
         CDgXk2T+rIXPdF6fRYDo2Oov0iSQGoWfxRW1Y=
Received: by 10.229.193.16 with SMTP id ds16mr5709019qcb.148.1277410649193; 
	Thu, 24 Jun 2010 13:17:29 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 13:17:09 -0700 (PDT)
In-Reply-To: <20100624110752.GI12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149634>

Hi Jonathan,

Jonathan Nieder wrote:
> NEEDSWORK: litters cwd with useless .bin files.
> But I hope it is enough to show the idea.

How do you propose we solve this? Maybe using a generic
$TEMP_DIRECTORY like /tmp in Unix and then getting rid of the files
after the export is complete?

> +QUIET_SUBDIR0 =3D +$(MAKE) -C # space to separate -C and subdir
> +QUIET_SUBDIR1 =3D

> +ifneq ($(findstring $(MAKEFLAGS),s),s)
> +ifndef V
> + =C2=A0 =C2=A0 =C2=A0 QUIET_CC =C2=A0 =C2=A0 =C2=A0=3D @echo ' =C2=A0=
 ' CC $@;
> + =C2=A0 =C2=A0 =C2=A0 QUIET_LINK =C2=A0 =C2=A0=3D @echo ' =C2=A0 ' L=
INK $@;
> + =C2=A0 =C2=A0 =C2=A0 QUIET_SUBDIR0 =3D +@subdir=3D
> + =C2=A0 =C2=A0 =C2=A0 QUIET_SUBDIR1 =3D ;$(NO_SUBDIR) echo ' =C2=A0 =
' SUBDIR $$subdir; \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 $(MAKE) $(PRINT_DIR) -C $$subdir
> +endif
> +endif

I saw this in the Git Makefile too, but I didn't understand the logic
behind it. Could you explain it to me?
Note: I couldn't understand most of the Makefile, so I just skipped it
when I found similar declarations in the Git Makefile.

> diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
> new file mode 100644
> index 0000000..d84dd4f
> --- /dev/null
> +++ b/contrib/svn-fe/svn-fe.c
> @@ -0,0 +1,43 @@
> +/*
> + * Parse and rearrange a svnadmin dump.
> + * Create the dump with:
> + * svnadmin dump --incremental -r<startrev>:<endrev> <repository> >o=
utfile
> + *
> + * Copyright (C) 2010 David Barr <david.barr@cordelta.com>.
> + * All rights reserved.

That's a huge license header applies just to the trivial five-line
program, right? Is it necessary at all?

> +#include <stdlib.h>
> +#include "../../vcs-svn/svndump.h"

Inelegant. Why not include ../../vcs-svn in the path you're searching
for headers?

> +svnadmin dump --incremental REPO | svn-fe [url] | git fast-import

If the user doesn't have a clue about SVN, they won't know what REPO
is here: Without knowing anything about svnadmin, I'd naively try it
with a remote repository. Maybe include a note about having to mirror
a complete repository locally using svnsync (or otherwise) first?

> +Converts a textual representation of a Subversion repository into
> +input suitable for git-fast-import(1) and similar importers.

To be more specific, "Subversion dumpfile (version: 2)" from FILE(1).

-- Ram
