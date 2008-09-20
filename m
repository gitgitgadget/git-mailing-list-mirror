From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] Checking out signed tags fails
Date: Fri, 19 Sep 2008 17:26:48 -0700
Message-ID: <20080920002648.GG13139@spearce.org>
References: <gaoaif$2up$1@ger.gmane.org> <2c6b72b30809161148p2b4ce08fh32ff5717ca85e773@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonas Flodddn <jonas.floden@gmail.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 02:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgqKN-0000Nb-K6
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 02:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYITA0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 20:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752815AbYITA0u
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 20:26:50 -0400
Received: from george.spearce.org ([209.20.77.23]:40694 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYITA0t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 20:26:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CE98C3835F; Sat, 20 Sep 2008 00:26:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30809161148p2b4ce08fh32ff5717ca85e773@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96329>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> On Tue, Sep 16, 2008 at 14:58, Jonas Flod=C3=A9n <jonas.floden@gmail.=
com> wrote:
> > When trying to check-out a signed tag I get the following Error:
> > Unable to switch branches
> >
> > Reason:
> >  Mapping commit: refs/tags/v1.3.1.1
> >
> > And in details:
> > Object XXX is not a commit.
> >
> > The object ID shown is actually the id for the tag object and not t=
he
> > tagged commit.
> >
> > This was tested with the latest master. It seemed commit 1f460e2 (T=
ests
> > and fixes for dereferencing tags in Repository.resolve(), 2008-09-1=
2)
> > would fix it, but it didn't.
>=20
> The fixes are only for the code path where reference expressions need=
s
> to be resolved. From what I understand, the problem you have
> encountered is due to resolve() falling back to using resolveSimple()
> which doesn't dereference any tags. Perhaps EGit could postfix ^{} or
> ^{commit} to the tag name before calling mapCommit(), or whatever it
> uses?

Yea, a ^{} is missing somwhere...  this is now in the issue tracker.
I'm behind and probably won't look at it more this week, but its
probably a simple thing in the checkout UI.

--=20
Shawn.
