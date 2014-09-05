From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [BUG (maybe)] git rev-parse --verify --quiet isn't quiet
Date: Fri, 5 Sep 2014 07:15:32 +0000 (UTC)
Message-ID: <loom.20140905T085616-576@post.gmane.org>
References: <loom.20140904T131954-274@post.gmane.org> <xmqq1trruv3b.fsf@gitster.dls.corp.google.com> <xmqqppfbtfu0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 09:16:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPnkf-0003Yx-Oz
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 09:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbaIEHPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2014 03:15:47 -0400
Received: from plane.gmane.org ([80.91.229.3]:49630 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbaIEHPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 03:15:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XPnkD-0003Dm-UF
	for git@vger.kernel.org; Fri, 05 Sep 2014 09:15:41 +0200
Received: from 46.19.18.182 ([46.19.18.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 09:15:41 +0200
Received: from oystwa by 46.19.18.182 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 09:15:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 46.19.18.182 (Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Firefox/31.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256500>

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> Junio C Hamano <gitster <at> pobox.com> writes:
>=20
> > I would suspect that this may be fine.
> >
> > "rev-parse --verify" makes sure the named object exists, but in thi=
s
> > case  <at> {u} does not even name any object, does it?
>=20
> Hmph, but "rev-parse --verify no-such-branch" does *not* name any
> object, we would want to see it barf, and we probably would want to
> be able to squelch the message.  So it is unclear if  <at> {u} barfin=
g is
> a good idea.
>=20

That was my counter-argument :) The "vibe" I get from rev-parse --verif=
y
--quiet is that it should handle anything.

>=20
> What is the reason why it is inpractical to pass 'quiet' down the
> callchain?
>=20

Maybe I'm missing something obvious, but wouldn't that mean changing th=
e
signature of 9 different functions, and consequently all of their calls
throughout Git?=20

That's perhaps not a good argument. Who cares whether a diff is small o=
r
large if it fixes a bug properly?  But most (or all) of those functions
do not concern themselves with printing stuff so maybe an additional
"quiet?" argument would look foreign in most places and make the code
harder to read.

=C3=98sse
