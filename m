From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 6 Jan 2011 19:28:48 +0200
Message-ID: <20110106172848.GA15729@LK-Perkele-VI.localdomain>
References: <4D25E3DE.7050801@xiplink.com>
 <20110106163035.GA7812@sigill.intra.peff.net>
 <AANLkTinGYjExrnHCqcTPu-APzk9WynxwWoKVOLaSkZ2y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:29:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PateF-0005CD-6L
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1AFR2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 12:28:50 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:57478 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab1AFR2t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 12:28:49 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id CEBF918D6D0;
	Thu,  6 Jan 2011 19:28:47 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07248B31A1; Thu, 06 Jan 2011 19:28:47 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id F3F93403C;
	Thu,  6 Jan 2011 19:28:42 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <AANLkTinGYjExrnHCqcTPu-APzk9WynxwWoKVOLaSkZ2y@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164646>

On Thu, Jan 06, 2011 at 08:48:11AM -0800, Shawn Pearce wrote:
> On Thu, Jan 6, 2011 at 08:30, Jeff King <peff@peff.net> wrote:
> >
> > =C2=A0 =C2=A0 Right now you are getting contention on the lock itse=
lf. But may
> > =C2=A0 =C2=A0 you not also run afoul of step (6) above? That is, on=
e push updates
> > =C2=A0 =C2=A0 the ref from A to B, then the other one in attempting=
 to go from A
> > =C2=A0 =C2=A0 to B sees that it has already changed to B under our =
feet and
> > =C2=A0 =C2=A0 complains?
>=20
> Not if its a force push.  :-)

IIRC, there are no wire protocol bits to denote a forced push, the
force option only overrides client-side checks. Thus, even forced pushe=
s
can fail due to race conditions...

-Ilari
