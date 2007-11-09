From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase --skip
Date: Fri, 9 Nov 2007 02:09:08 +0100
Message-ID: <20071109010908.GA10781@atjola.homenet>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net> <7vir4cz45z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqINF-0006BX-7U
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbXKIBJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 20:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbXKIBJM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:09:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:45878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753363AbXKIBJL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:09:11 -0500
Received: (qmail invoked by alias); 09 Nov 2007 01:09:09 -0000
Received: from i577B8015.versanet.de (EHLO localhost) [87.123.128.21]
  by mail.gmx.net (mp046) with SMTP; 09 Nov 2007 02:09:09 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18No70ZWMgN91MJ8V1TJcI6cNyDH04aAWKcLaleBl
	tElYpc8Cfy3Xsp
Content-Disposition: inline
In-Reply-To: <7vir4cz45z.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64098>

On 2007.11.08 15:52:08 -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Personally, I don't see the point of a --force option; it turns you=
r work
> > flow from:
> >
> >   1. git-rebase --skip
> >   2. Oops, I guess I have to reset.
> >   3. git-reset --hard; git-rebase --skip
> >
> > to:
> >
> >   1. same as above
> >   2. same as above
> >   3. git-rebase --force --skip
>=20
> I do not see it as improvement, either, for the same reason you
> state.
>=20
> > AIUI, Andreas's proposal is not so much DWIM as "do the obvious thi=
ng,
> > but include a safety valve to prevent throwing away work." Is there
> > actually a case where it would not have the desired effect?
>=20
> The user is explicitly saying --skip, so I do not think it is
> dangerous even if we unconditionally did "reset --hard" at that
> point.

The user _must_ say --skip in the case I outlined. And I'm pretty sure
that the first thing I'll (accidently) do once --skip implies "reset
--hard" is to forget to commit. Murphy has never let me down.

How about adding that --amend option that someone mentioned? Or even
just letting --continue act like --skip when there's nothing to commit.
That way, you're no longer forced to use --skip.

Bj=F6rn
