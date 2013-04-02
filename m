From: Jeff King <peff@peff.net>
Subject: Re: transient build error after 'Writing MYMETA.yml and MYMETA.json'
Date: Tue, 2 Apr 2013 01:22:11 -0400
Message-ID: <20130402052210.GA22089@sigill.intra.peff.net>
References: <CABURp0os62JCPCRsvQ+NneGaSobTUmgs7oZ9SqUiTH8AG0hPmQ@mail.gmail.com>
 <7vhajqjh3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtgB-0002xs-9u
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759559Ab3DBFWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:22:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51690 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757172Ab3DBFWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:22:14 -0400
Received: (qmail 6859 invoked by uid 107); 2 Apr 2013 05:24:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 01:24:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 01:22:11 -0400
Content-Disposition: inline
In-Reply-To: <7vhajqjh3v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219739>

On Mon, Apr 01, 2013 at 10:28:04AM -0700, Junio C Hamano wrote:

> Phil Hord <phil.hord@gmail.com> writes:
> 
> > I have not seen this before, which makes me think it is something new
> > in the makefiles.  But maybe it was a one-time fluke. When I ran
> > 'make' again, it proceeded as normal.
> > ...
> > $ make prefix=/home/hordp all doc man
> > ...
> >     GEN git-add--interactive
> > Writing perl.mak for Git
> > Writing MYMETA.yml and MYMETA.json
> > make[2]: *** [perl.mak] Error 1
> > make[1]: *** [instlibdir] Error 2
> > make: *** [git-add--interactive] Error 2
> > $ make prefix=/home/hordp all doc man
> >     GEN perl/PM.stamp
> >     SUBDIR perl
> > /usr/bin/perl Makefile.PL PREFIX='/home/hordp' INSTALL_BASE=''
> > --localedir='/home/hordp/share/locale'
> > Writing perl.mak for Git
> > Writing MYMETA.yml and MYMETA.json
> >     GEN git-add--interactive
> >     GEN git-difftool
> >     GEN git-archimport
> 
> I've also seen build failure with -j<something> in perl/
> subdirectory from time to time, but the failure has been fairly
> elusive for me that I haven't had a chance to look into what
> triggers it.

The one I have seen usually involves errors around "perl.mak"; this
might be a new form of it, or it might be different.

Previous analysis and a patch (which I have no idea if it helps or not,
as I can't reproduce the problem at will):

  http://article.gmane.org/gmane.comp.version-control.git/158251

-Peff
