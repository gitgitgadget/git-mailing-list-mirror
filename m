From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15
Date: Mon, 2 Nov 2009 12:05:31 +0200
Message-ID: <94a0d4530911020205x355d4655n4de6e34d1d5b08e5@mail.gmail.com>
References: <b0943d9e0910241541n7b1091ecp6b21fa896405afa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 11:05:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4tnE-0005Rr-Au
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 11:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbZKBKF3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 05:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbZKBKF3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 05:05:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:56960 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbZKBKF3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 05:05:29 -0500
Received: by fg-out-1718.google.com with SMTP id d23so631942fga.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 02:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=u6fs4wmXMUpbhyKw+XeVkjlxRvdiK+y8Un8a24QSgt8=;
        b=TuWeU1ElxxFsG2GUny7Nup/TEfS8TT5Pto9N6tTJxWrga7H4avAfy1/hx0Q2pEEV/h
         jmyIfI5n3NqcKvlV8gucbtFTMBSzbvfxyAYboOF7QdQSR9Zga+MSc4ouTMV5t1iH5zDj
         kcLK6F5svQn6KqIn0V+eXbWIKOZiddHqOOAqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hfrhEFSk+Va22qraRr0wl+oo65QHg3P6MSfZyreCZq/chcDCcCxMnDSqRLg+QuAtfO
         8UUyIpD+duQzgd3ZDc7c8YNZEMF1J5zvj1dEMBv0z8ITDbyfJDHOMRe1JlXHPNeE0c2k
         mB+iu6Vfz2wADcmdfOZp8pncsq67f8Pv+hkEk=
Received: by 10.86.181.6 with SMTP id d6mr2063053fgf.29.1257156331874; Mon, 02 
	Nov 2009 02:05:31 -0800 (PST)
In-Reply-To: <b0943d9e0910241541n7b1091ecp6b21fa896405afa0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131900>

On Sun, Oct 25, 2009 at 12:41 AM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:
> StGit is a Python application providing functionality similar to Quil=
t
> (i.e. pushing/popping patches to/from a stack) on top of Git. These
> operations are performed using Git commands, and the patches are
> stored as Git commit objects, allowing easy merging of the StGit
> patches into other repositories using standard Git functionality.
>
> =C2=A0Download: =C2=A0 =C2=A0 =C2=A0 =C2=A0 http://download.gna.org/s=
tgit/stgit-0.15.tar.gz
> =C2=A0Main repository: =C2=A0git://repo.or.cz/stgit.git
> =C2=A0Project homepage: http://www.procode.org/stgit/
> =C2=A0Mailing list: =C2=A0 =C2=A0 git@vger.kernel.org (please use "St=
Git" in the subject)
> =C2=A0Bug tracker: =C2=A0 =C2=A0 =C2=A0https://gna.org/bugs/?group=3D=
stgit
>
> The main changes since release 0.14.3 are
>
> =C2=A0- New core infrastructure for repository operations, including
>
> =C2=A0 =C2=A0 =C2=A0+ Infinite undo/redo operations and corresponding=
 commands.
>
> =C2=A0 =C2=A0 =C2=A0+ Automatic rollback of changes following a faile=
d operation
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(using transactions)---this ensures that S=
tGit commands either
> =C2=A0 =C2=A0 =C2=A0 =C2=A0succeed or do nothing. Previously, every c=
ommands had its own
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ad hoc implementation of this.
>
> =C2=A0- Some commands were added, including
>
> =C2=A0 =C2=A0 =C2=A0+ "stg squash", for combining two or more patches=
 into one.
>
> =C2=A0 =C2=A0 =C2=A0+ "stg publish", for maintaining merge-friendly b=
ranches (which
> =C2=A0 =C2=A0 =C2=A0 =C2=A0are not rebased).
>
> =C2=A0 =C2=A0 =C2=A0+ "stg prev/next" for printing the name of the pr=
evious or next
> =C2=A0 =C2=A0 =C2=A0 =C2=A0patch in the series.
>
> =C2=A0- The commands "stg add", "stg rm", "stg cp", and "stg resolved=
"
> =C2=A0 =C2=A0were removed, since there are corresponding Git equivale=
nts.
>
> =C2=A0- The "stg import" and "stg fold" commands support the "-p N" o=
ption
> =C2=A0 =C2=A0for stripping leading slashes from diff paths.
>
> =C2=A0- The "stg import" and "stg fold" commands support the "--rejec=
t"
> =C2=A0 =C2=A0option for leaving rejected hunks in corresponding *.rej=
 files.
>
> =C2=A0- New patch identification syntax: <branch>:<patch> (see
> =C2=A0 =C2=A0documentation for the "stg id" command).
>
> =C2=A0- Autosigning of imported patches when "sign.autosign" configur=
ation
> =C2=A0 =C2=A0option is set.
>
> =C2=A0- A powerful Emacs mode for StGit was added to the "contrib"
> =C2=A0 =C2=A0directory. It displays the patch stack in an Emacs buffe=
r, and can
> =C2=A0 =C2=A0handle all common StGit tasks.
>
> =C2=A0- Improved bash tab-completion, automatically generated from th=
e stg
> =C2=A0 =C2=A0command definitions.
>
> =C2=A0- Man pages and an improved tutorial.
>
> Special thanks go to Karl Wiberg for the hard work done on the new
> StGit features, to Catalin Marinas for many new features and bugfixes=
,
> and to David K=C3=A5gedal and Gustav H=C3=A5llberg for the Emacs mode=
=2E

I don't know why, but the announcement RSS feed breaks exactly here
due to some UTF-8 miss-match or something:
wget http://gitrss.q42.co.uk/announce.rss

--=20
=46elipe Contreras
