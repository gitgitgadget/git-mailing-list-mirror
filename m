From: Jeff King <peff@peff.net>
Subject: Re: cloning a tree which has detached branch checked out
Date: Tue, 7 Feb 2012 10:32:25 -0500
Message-ID: <20120207153225.GA14773@sigill.intra.peff.net>
References: <20120207070628.GA24698@redhat.com>
 <m362fjklb7.fsf@localhost.localdomain>
 <20120207104100.GA24828@redhat.com>
 <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 16:32:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Run27-00088D-0q
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 16:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab2BGPcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 10:32:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59275
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab2BGPca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 10:32:30 -0500
Received: (qmail 7158 invoked by uid 107); 7 Feb 2012 15:39:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Feb 2012 10:39:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Feb 2012 10:32:25 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8DtmQLX+Lfng-QRzVg9sfo8gQMXB-xTtPYpt+R2gModTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190178>

On Tue, Feb 07, 2012 at 07:57:08PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Feb 7, 2012 at 5:41 PM, Michael S. Tsirkin <mst@redhat.com> w=
rote:
> >> > #git clone -n lab:/home/mst/scm/linux
> >> > ....
> >> > error: Trying to write ref HEAD with nonexistant object
> >> > cec64082f689f949a397cb9b39423dc41545fa0e
> >> > fatal: Cannot update the ref 'HEAD'.
> >> >
> >> > Looks like a bug, doesn't it?
> >>
> >> Which git version? =C2=A0IIRC there was some bugfix recently in th=
at
> >> area...
> >
> > Sorry, forgot to mention that. It's pretty recent:
> > $ git --version
> > git version 1.7.9.111.gf3fb0
>=20
> The series that Jakub mentioned is probably nd/clone-detached 5ce2b97=
,
> which is already included in your tree. Does 1.7.9 work?
>=20
> I tried but it was ok for me. I think ref processing at local probabl=
y
> goes wrong and does not request commit from HEAD.  If the repo is not
> confidential, you can zip it and send me.

This particular bug should have been fixed before that, even, with my
c1921c1 (clone: always fetch remote HEAD, 2011-06-07). And it is tested
explicitly in t5707, so your series does not regress at least a simple
case. So I think your guess about a subtle error in the local ref
processing is a reasonable one.

-Peff
