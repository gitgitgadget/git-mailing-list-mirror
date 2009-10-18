From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Unapplied patches reminder
Date: Mon, 19 Oct 2009 05:20:30 +0900
Message-ID: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, bgustavsson@gmail.com,
	tgc@statsbiblioteket.dk, geofft@mit.edu, hvoigt@hvoigt.net,
	peff@peff.net, RKvinge@novell.com, crmafra@aei.mpg.de,
	Per.Strandh@q-matic.se, vietor@vxwo.org, bgustavsson@gmail.com,
	rene.scharfe@lsrfire.ath.cx
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 18 22:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzcFK-0008C4-Nu
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 22:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248AbZJRUUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 16:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755224AbZJRUUm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 16:20:42 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44395 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215AbZJRUUl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 16:20:41 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 5C6BA11B8C1;
	Sun, 18 Oct 2009 15:20:46 -0500 (CDT)
Received: from 4448.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id 3D5TIB9U924C; Sun, 18 Oct 2009 15:20:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=orU/Ae/hO4mGHoLOFQqkjDeMI13Q/zoJt1ETyVt/h1tNBcxBefn0b0Cl0RiyGUBULnU5JpQZfK6B1B8FcBw5gSUTHXQVQto5or97HyMYIqlzIH13MBf5K3S6Um/qC7TDtRJq9m0QaKo4fkZfK+VgB5LsDK7160jgsHTDQDzIg74=;
  h=From:To:Cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130611>

Junio, I saw these patches and thought what they try to do were=20
sensible, but I don't them in your tree. I didn't see much discussion=20
on most of them, either.

Because I don't read C very well, I may have listed some patches=20
here that you may have discarded because the code was no good, and=20
if so I apologize for wasting your time, but I thought at least=20
some of them should be salvaged.

Here is the list.

=46rom: Geoffrey Thomas <geofft@mit.edu>
Subject: [PATCH] diffcore-order: Default the order file to .git/info/or=
der.
Date: Sat, 12 Sep 2009 19:49:48 -0400
Message-ID: <1252799388-16295-1-git-send-email-geofft@mit.edu>

    Since order files tend to be useful for all operations in the
    project/repository, add a default location for the order file, so t=
hat
    you don't have to specify -O<orderfile> on every diff or similar
    operation.

=46rom:	Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] fix testsuite to not use any hooks possibly provided b=
y source
Date:	Wed, 23 Sep 2009 20:30:28 +0200
Message-ID: <20090923183023.GA85456@book.hvoigt.net>

    This is useful if you are using the testsuite with local changes th=
at
    include activated default hooks suitable for your teams installatio=
n.

=46rom:	Jeff King <peff@peff.net>
Subject: Re: [BUG?] git-cvsimport: path to cvspsfile
Date:	Wed, 23 Sep 2009 15:14:29 -0400
Message-ID: <20090923191428.GA30104@coredump.intra.peff.net>

    Bug. The script does a chdir() and then looks at the cvspsfile late=
r. I
    think "-A" would have the same problem. Here is a totally untested =
patch
    to address the issue. Johannes, will this is_absolute_path actually=
 work
    on Windows? I think The Right Way would be to use
    File::Spec::file_name_is_absolute, but I haven't checked whether th=
at is
    part of core perl and if so, which version it appeared in.

=46rom: "Rolf Bjarne Kvinge" <RKvinge@novell.com>
Subject: git rev-list --pretty=3Draw strips empty lines
Date: Tue, 06 Oct 2009 14:33:37 +0200
Message-ID: <op.u1do6bq5k71drc@linux.lacasa>

    It seems like the --pretty=3Draw format strips off empty newlines f=
rom the beginning of log messages, while I'd expect the raw format to n=
ot do any transformations (just as the documentation says: "The 'raw' f=
ormat shows the entire commit exactly as stored in the commit object").

    The below changes works for me, not sure if I'm right about this th=
ough (my first time here ;-)

=46rom:	"Carlos R. Mafra" <crmafra@aei.mpg.de>
Subject: [PATCH] Makefile: clean block-sha1/ directory instead of mozil=
la-sha1/
Date:	Sun, 11 Oct 2009 15:32:19 +0200

    'make clean' should remove the object files from block-sha1/
    instead of the non-existent mozilla-sha1/ directory.

=46rom: Per Strandh <Per.Strandh@q-matic.se>
Subject: [PATCH] git-p4: Fixed bug that didn't allow spaces in the depo=
t
Date: Tue, 13 Oct 2009 22:09:12 +0200
Message-ID: <65D9329CA2AF94438F542D48F2A42E830F95F51514@GOT-SRV-005.QMA=
TIC.local>

    git-p4 clone (and sync) did not work if the specified depot path co=
ntained spaces.
    Fixed by quoting the argument to the "p4 changes" and "p4 files" co=
mmands.

=46rom: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: [PATCH] NO_PERL_MAKEMAKER should behave more like ExtUtils::Ma=
keMaker
Date: Tue, 13 Oct 2009 13:14:31 +0200
Message-ID: <1255432471-14168-1-git-send-email-tgc@statsbiblioteket.dk>

    This change makes NO_PERL_MAKEMAKER behave more as ExtUtils::MakeMa=
ker
    by installing the modules into the perl libdir and not $(prefix)/li=
b.
    It will default to sitelib but will allow the user to choose by set=
ting
    the INSTALLDIRS variable which is also honored by ExtUtils::MakeMak=
er.

=46rom:	Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
Subject: [PATCH] push: fix usage: --tags is incompatible with --all and=
 --mirror
Date:	Thu, 15 Oct 2009 18:39:05 +0200
Message-ID: <4AD75029.1010109@gmail.com>

    Correct the usage text to make it clear that --tags cannot
    be combined with --all or --mirror.

=46rom: Vietor Liu <vietor@vxwo.org>
Subject: [PATCH v4] git-gui: adjust the minimum height of diff pane for
Date: Fri, 16 Oct 2009 17:41:26 +0800
Message-Id: <1255686086-3949-1-git-send-email-vietor@vxwo.org>

    When the main window is maximized, if the screen height is shorter =
(e.g.
    Netbook screen 1024x600), both the partial commit pane and the stat=
us bar
    are hidden.

=46rom: Junio C Hamano <gitster@pobox.com>
Subject: Re: Q: supplying large sets of path to git commands
Date: Fri, 16 Oct 2009 15:08:07 -0700
Message-ID: <7vtyxzrnzs.fsf@alter.siamese.dyndns.org>

    Here is how one might implement it for diff/log family of commands =
that
    use "setup_revisions()".

    I didn't test it (of course) beyond running=20

	./git diff --name-only HEAD | ./git diff --stdin-paths --stat -p

=46rom:	Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
Subject: [PATCH] bash: complete more options for 'git rebase'
Date:	Sat, 17 Oct 2009 11:33:38 +0200
Message-ID: <4AD98F72.1060901@gmail.com>

    Complete all long options for 'git rebase' except --no-verify
    (probably used very seldom) and the long options corresponding
    to -v, -q, and -f.

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] describe: load refnames before calling describe()
Date: Sat, 17 Oct 2009 18:30:48 +0200
Message-ID: <4AD9F138.3080405@lsrfire.ath.cx>

    Get rid of the static variable that was used to prevent loading all
    the refnames multiple times by moving that code out of describe(),
    simply making sure it is only run once that way.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
