From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Document git-svn fetch --log-window-size parameter
Date: Fri, 26 Oct 2012 09:46:02 +0000
Message-ID: <20121026094602.GA7887@dcvr.yhbt.net>
References: <1350988406-97624-1-git-send-email-gunnlaugur@gmail.com>
 <20121025095202.GK8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Gunnlaugur =?utf-8?B?w57Ds3I=?= Briem <gunnlaugur@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 11:46:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRgUd-0004hj-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 11:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666Ab2JZJqG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2012 05:46:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48587 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab2JZJqE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 05:46:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09BB1F43F;
	Fri, 26 Oct 2012 09:46:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121025095202.GK8390@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208432>

Jeff King <peff@peff.net> wrote:
> On Tue, Oct 23, 2012 at 10:33:26AM +0000, Gunnlaugur =C3=9E=C3=B3r Br=
iem wrote:
>=20
> > The --log-window-size parameter to git-svn fetch is undocumented.
> >=20
> > Minimally describe what it does and why the user might change it.
>=20
> Thanks. Your description makes sense to me, but I do not have enough
> git-svn knowledge to know if it covers all intended uses of the flag.
> Eric?
>=20
> > +--log-window-size=3D<n>;;
> > +    Fetch <n> log entries per request when scanning Subversion his=
tory.
> > +    The default is 100. For very large Subversion repositories, la=
rger
> > +    values may be needed for 'clone'/'fetch' to complete in reason=
able
> > +    time. But overly large values may lead to request timeouts.

Overly large values also lead to excessive memory usage.  I may have
only had 256M in my dev machine at the time I added this parameter:

  commit 6af1db447b10c03db4c04a55000efaa9aad38caa
  Author: Eric Wong <normalperson@yhbt.net>
  Date:   Wed Feb 14 16:04:10 2007 -0800

      git-svn: allow --log-window-size to be specified, default to 100
     =20
      The newer default value should should lower memory usage for
      large fetches and also help with fetching from less reliable
      servers.  Previously the value was 1000 and memory usage
      got a bit high on some repositories and fetching became
      less reliable in some cases.
     =20
      Signed-off-by: Eric Wong <normalperson@yhbt.net>
