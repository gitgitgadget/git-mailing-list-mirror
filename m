From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 21:59:10 -0500
Message-ID: <20120112025910.GA26038@sigill.intra.peff.net>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
 <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
 <20120112025445.GB25365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAsr-0006RD-AV
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab2ALC7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 21:59:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35598
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab2ALC7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 21:59:14 -0500
Received: (qmail 27065 invoked by uid 107); 12 Jan 2012 03:06:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 22:06:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 21:59:10 -0500
Content-Disposition: inline
In-Reply-To: <20120112025445.GB25365@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188420>

On Wed, Jan 11, 2012 at 09:54:45PM -0500, Jeff King wrote:

> On Wed, Jan 11, 2012 at 06:46:56PM -0800, Junio C Hamano wrote:
>=20
> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> >=20
> > > The tightening done in (ee27ca4a: archive: don't let remote clien=
ts
> > > get unreachable commits, 2011-11-17) went too far and disallowed
> > > HEAD:Documentation as it would try to find "HEAD:Documentation" a=
s a
> > > ref.
> >=20
> > I do not think it went too far. Actually we discussed this exact is=
sue
> > when the topic was cooking, and saw no objections. The commit in qu=
estion
> > itself advertises this restriction.
>=20
> I think you and I discussed it off list (I originally took this off-l=
ist
> because the original issue did have some security implications). So I
> don't think people necessarily had a chance to object.

Here is the only on-list discussion:

  http://article.gmane.org/gmane.comp.version-control.git/186366

Quoted below:

  >> * jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
  >>  - archive: don't let remote clients get unreachable commits
  >>  (this branch is used by jk/maint-upload-archive.)
  >>
  >> * jk/maint-upload-archive (2011-11-21) 1 commit
  >>  - Merge branch 'jk/maint-1.6.2-upload-archive' into
  >>  jk/maint-upload-archive
  >>  (this branch uses jk/maint-1.6.2-upload-archive.)
  >>
  >> Will merge to 'next' after taking another look.
  >
  > Thanks. I also have some followup patches to re-loosen to at least
  > trees reachable from refs. Do you want to leave the tightening to
  > the maint track, and then consider the re-loosening for master?

  I was planning to first have the really tight version graduate to
  'master' and ship it in 1.7.9, while possibly merging that to 1.7.8.X
  series.  If we hear complaints from real users in the meantime before
  or after such releases, we could apply loosening patch on top of thes=
e
  topics and call them "regression fix", but I have been assuming that
  nobody would have been using this backdoor for anything that really
  matters.

So now we have heard a complaint. :)

-Peff
