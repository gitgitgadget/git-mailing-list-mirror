From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] Add strbuf_initf()
Date: Thu, 6 Mar 2008 20:10:08 +0100
Organization: glandium.org
Message-ID: <20080306191008.GA11635@glandium.org>
References: <200803052221.12495.johannes.sixt@telecom.at> <alpine.LSU.1.00.0803052317350.15786@racer.site> <7vir00lski.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803052327570.15786@racer.site> <alpine.LSU.1.00.0803060212170.15786@racer.site> <20080306063331.GA7325@glandium.org> <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com> <alpine.LSU.1.00.0803061153400.15786@racer.site> <1204827539.10084.9.camel@gaara.boston.redhat.com> <alpine.LSU.1.00.0803061925370.3941@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>,
	Reece Dunn <msclrhd@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXLQw-0002g1-Ja
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 20:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756553AbYCFTGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbYCFTGe
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 14:06:34 -0500
Received: from vuizook.err.no ([194.24.252.247]:40219 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271AbYCFTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 14:06:33 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JXLPZ-0001ef-21; Thu, 06 Mar 2008 20:05:55 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JXLTk-00034K-SB; Thu, 06 Mar 2008 20:10:08 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803061925370.3941@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76410>

On Thu, Mar 06, 2008 at 07:26:50PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 6 Mar 2008, Kristian H=F8gsberg wrote:
>=20
> > On Thu, 2008-03-06 at 11:55 +0100, Johannes Schindelin wrote:
> >
> > > So your suggestion is out, unless you suggest to implement the wh=
ole=20
> > > printf mechanism... which I hope you're not.
> >=20
> > It's not a terrible idea, honestly.
>=20
> Heh.  Yeah, I actually posted a start...
>=20
> > There are several mature vsnprintf implementations out there under=20
> > friendly licenses.  We could just stick it in compat/.  It's the on=
ly=20
> > way to do reliable, cross platform vsnprintf, in my experience.  An=
d the=20
> > issue with %I64u vs %llu could be handle by implementing both, as W=
ayne=20
> > Davison suggests.
>=20
> Sure, we could always copy from somewhere else.  My rationale was tha=
t I=20
> had fun writing it, and that we do not really need a full printf()=20
> implementation.

And vsnprintf is a mess accross systems, returning -1 when not expected=
=2E
I even had the surprise to get an interesting bug in liferea/libxml2 du=
e
to glibc's vsnprintf returning -1 in some obscure cases.

Mike
