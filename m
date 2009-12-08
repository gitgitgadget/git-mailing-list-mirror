From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 20:13:24 +0100
Message-ID: <20091208191324.GA4200@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <20091208160822.GA1299@atjola.homenet>
 <20091208161142.GA32045@redhat.com>
 <20091208164113.GB2005@atjola.homenet>
 <20091208164904.GB32204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 20:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI5VE-0007lk-Ki
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 20:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965813AbZLHTN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 14:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965811AbZLHTN2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 14:13:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:51769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965810AbZLHTN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 14:13:27 -0500
Received: (qmail invoked by alias); 08 Dec 2009 19:13:28 -0000
Received: from i59F55883.versanet.de (EHLO atjola.homenet) [89.245.88.131]
  by mail.gmx.net (mp059) with SMTP; 08 Dec 2009 20:13:28 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18TUdJHF68TAZpfRu8rw0ndtUWWL3i3PCf6JojSX0
	GqEDDDs9igY64/
Content-Disposition: inline
In-Reply-To: <20091208164904.GB32204@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134904>

On 2009.12.08 18:49:04 +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2009 at 05:41:13PM +0100, Bj=F6rn Steinbrink wrote:
> > > > Also, AFAICT this needs to be called like this:
> > > > git rebase --revisions foo..bar HEAD
> > > >=20
> > > > Changing the meaning of the <upstream> argument and relying on =
the fact
> > > > that <newbase> defaults to <upstream>. If such a thing gets add=
ed, it
> > > > should rather work like --root, not using <upstream> at all, bu=
t --onto
> > > > <newbase> only. Maybe defaulting to HEAD for <newbase> and maki=
ng --onto
> > > > optional, as it's reversed WRT what it does compared to the usu=
al
> > > > rebase.
> > >=20
> > > Sorry, I had trouble parsing the above.  Could you suggest e.g. h=
ow the
> > > help line should look?
> >=20
> > Current:
> > git rebase [-i | --interactive] [options] [--onto <newbase>]
> > 	<upstream> [<branch>]
> > git rebase [-i | --interactive] [options] --onto <newbase>
> > 	--root [<branch>]
> >=20
> > Add:
> > git rebase [-i | --interactive] [options] --revisions <range> [<bra=
nch>]
> >=20
> > (Thinking about it, I guess an explicit --onto makes no sense with =
the
> > --revisions flag)
>=20
> I agree.
> So this is different from what I implemented basically only in that
> we should disallow combining --onto with --revisions. Right?

It also drops <upstream>, because that makes no sense with --revisions.
So the only mandatory argument is the revision range.

Bj=F6rn
