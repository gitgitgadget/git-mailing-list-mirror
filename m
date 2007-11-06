From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if cur/ is empty
Date: Tue, 6 Nov 2007 17:35:48 +0100
Message-ID: <20071106163548.GA8207@diana.vm.bytemark.co.uk>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com> <20071106072831.GA3021@steel.home> <20071106075150.GA21694@sigill.intra.peff.net> <Pine.LNX.4.64.0711061100150.4362@racer.site> <20071106154740.GA24505@sigill.intra.peff.net> <Pine.LNX.4.64.0711061550580.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Alex Riesen <raa.lkml@gmail.com>,
	Michael Cohen <michaeljosephcohen@mac.com>,
	Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 18:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpRuW-0002vc-Hp
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 18:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbXKFRIF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 12:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXKFRIE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 12:08:04 -0500
Received: from 80-68-90-142.no-reverse-dns-set.bytemark.co.uk ([80.68.90.142]:3525
	"EHLO diana.vm.bytemark.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753016AbXKFRID (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 12:08:03 -0500
X-Greylist: delayed 1809 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2007 12:08:03 EST
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IpRP2-0002E4-00; Tue, 06 Nov 2007 16:35:48 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711061550580.4362@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63688>

On 2007-11-06 15:51:09 +0000, Johannes Schindelin wrote:

> On Tue, 6 Nov 2007, Jeff King wrote:
>
> > On Tue, Nov 06, 2007 at 11:01:03AM +0000, Johannes Schindelin wrote=
:
> >
> > > I fail to see how the absence of one of cur/ or new/ can lead to
> > > the absence of patches. You could forget to save some patches,
> > > yes, but the presence of cur/ and new/ is no indicator for that.
> >
> > Read my message again. Alex is proposing ignoring errors in
> > opening the directories; I am proposing ignoring such errors
> > _only_ when the error is that the directory does not exist.
> >
> > IOW, if there is some other error in opening the directory, it
> > should be fatal, because you might be missing patches.
>
> Yeah, sorry, I missed that.

I think it might actually not be totally unreasonable to error out
unless both directories exist. From
http://www.qmail.org/qmail-manual-html/man5/maildir.html:

  A directory in maildir format has three subdirectories, all on the
  same filesystem: tmp, new, and cur.

In other words, if it doesn't have these three directories, it isn't a
Maildir directory.

On the other hand, one could argue that requiring both dirs to exist
is being too picky.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
