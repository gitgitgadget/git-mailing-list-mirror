From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 21:54:45 -0500
Message-ID: <20120112025445.GB25365@sigill.intra.peff.net>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
 <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 03:54:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAoW-00055a-KC
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 03:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab2ALCys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 21:54:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35588
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab2ALCys (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 21:54:48 -0500
Received: (qmail 27001 invoked by uid 107); 12 Jan 2012 03:01:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 22:01:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 21:54:45 -0500
Content-Disposition: inline
In-Reply-To: <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188419>

On Wed, Jan 11, 2012 at 06:46:56PM -0800, Junio C Hamano wrote:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > The tightening done in (ee27ca4a: archive: don't let remote clients
> > get unreachable commits, 2011-11-17) went too far and disallowed
> > HEAD:Documentation as it would try to find "HEAD:Documentation" as =
a
> > ref.
>=20
> I do not think it went too far. Actually we discussed this exact issu=
e
> when the topic was cooking, and saw no objections. The commit in ques=
tion
> itself advertises this restriction.

I think you and I discussed it off list (I originally took this off-lis=
t
because the original issue did have some security implications). So I
don't think people necessarily had a chance to object.

> Why are we loosening it now? I do not see a compelling reason to do s=
o.

I see it the opposite way. People are clearly using the "$ref:$path"
syntax. So why would we restrict them from doing so? There are no
security implications (i.e., they could always just grab $ref and
extract $path themselves). In my view, ee27ca4a was over-eager in its
restrictions because I wanted it to be simple and close the hole. Now w=
e
can take our time adding more code to loosen it.

-Peff
