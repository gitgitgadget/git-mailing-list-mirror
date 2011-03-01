From: Jeff King <peff@peff.net>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 15:57:02 -0500
Message-ID: <20110301205702.GA21429@sigill.intra.peff.net>
References: <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net>
 <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net>
 <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
 <AANLkTinkjhH6YR7VPC0hji9CK=qeQMAYr+ptJE3szUyR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chad Joan <chadjoan@gmail.com>, git@vger.kernel.org
To: Computer Druid <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:57:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWcx-0002gD-R9
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab1CAU4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 15:56:54 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40732 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757423Ab1CAU4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:56:53 -0500
Received: (qmail 10421 invoked by uid 111); 1 Mar 2011 20:56:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 20:56:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 15:57:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinkjhH6YR7VPC0hji9CK=qeQMAYr+ptJE3szUyR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168259>

On Tue, Mar 01, 2011 at 03:39:10PM -0500, Computer Druid wrote:

> > I'll do that, but it will probably take a long long time for me to =
see
> > the patch. =C2=A0I'm hoping there's some cheap hack I can use to wo=
rk
> > around it in the meantime.
>=20
> A simple answer to preventing git from calling rmdir would be to run
> rm and git rm separately:
> $ rm file
> $ git rm --cached -f file
>=20
> But that doesn't solve the misbehavior of git under the previous
> scenario. I'm not sure if this is something we should fix in git or i=
f
> it should be fixed in cifs.

That will fix some instances. But git will rmdir to clean up anytime it
removes content. That includes during a merge or patch application. So
you can't really get around those cases.

-Peff
