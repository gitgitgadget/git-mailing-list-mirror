From: Jeff King <peff@peff.net>
Subject: Re: Changes based on a branch not yet merged back to master
Date: Tue, 8 Apr 2014 15:53:09 -0400
Message-ID: <20140408195309.GA8461@sigill.intra.peff.net>
References: <1396956140.85747.YahooMailNeo@web121901.mail.ne1.yahoo.com>
 <1396981364.85181.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "K. Kwan" <kkwansj_888@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:54:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXc6C-0007GY-9j
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbaDHTxu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 15:53:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:56303 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932233AbaDHTxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:53:11 -0400
Received: (qmail 21404 invoked by uid 102); 8 Apr 2014 19:53:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Apr 2014 14:53:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Apr 2014 15:53:09 -0400
Content-Disposition: inline
In-Reply-To: <1396981364.85181.YahooMailNeo@web121903.mail.ne1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245955>

On Tue, Apr 08, 2014 at 11:22:44AM -0700, K. Kwan wrote:

> My tree would look like this:
>=20
> - x - x - x (master)=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ x - x (A) x - x (B)
>=20
>=20
> But after merge of branch (A), I would like it to look like this:
>=20
> - x - x - x ---- x (master)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0/ \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0x - x (A)=C2=A0=C2=A0=
x - x (B)
>=20
>=20
> Perhaps this?
>=20
> $ git checkout master
> $ git pull origin master
> $ git merge A
> $ git rebase --onto master A B

Yes, that should work. I think you could even just do:

  git rebase master B

since after the merge, all of A is contained in master (and so will be
omitted from the rebased commits).

-Peff
