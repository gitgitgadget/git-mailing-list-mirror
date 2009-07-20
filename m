From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 01:36:21 -0700
Message-ID: <20090720083621.GA3237@dcvr.yhbt.net>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com> <20090720075929.GA5591@dcvr.yhbt.net> <9b18b3110907200115p4c0c3b45nc6c7f31b34ceff0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 10:36:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSoMH-0006Po-Lb
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 10:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbZGTIgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 04:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbZGTIgW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 04:36:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59450 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbZGTIgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 04:36:21 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE181F5FC;
	Mon, 20 Jul 2009 08:36:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9b18b3110907200115p4c0c3b45nc6c7f31b34ceff0c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123580>

demerphq <demerphq@gmail.com> wrote:
> 2009/7/20 Eric Wong <normalperson@yhbt.net>:
> > Robert Zeh <robert.a.zeh@gmail.com> wrote:
> >> --- a/git-svn.perl
> >> +++ b/git-svn.perl
> >> @@ -35,11 +35,14 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
> >> =A0push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
> >> =A0push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
> >> =A0use Carp qw/croak/;
> >> +use Compress::Zlib;
> >
> > I'd "require" Compress::Zlib lazilly so it's not loaded at startup.
> > It's not a stock component of Perl and not needed for the majority =
of
> > commands.
>=20
> Actually, it has been a core component since 5.9.3

Ah thanks for pointing that out, I didn't notice my 5.10.x install had
it.  Nevertheless, git svn needs to continue supporting 5.8.x for a
while longer.

--=20
Eric Wong
