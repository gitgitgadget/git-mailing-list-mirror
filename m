From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if
	cur/ is empty
Date: Tue, 6 Nov 2007 22:50:58 +0100
Message-ID: <20071106215058.GA3654@steel.home>
References: <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com> <20071106072831.GA3021@steel.home> <20071106075150.GA21694@sigill.intra.peff.net> <Pine.LNX.4.64.0711061100150.4362@racer.site> <20071106154740.GA24505@sigill.intra.peff.net> <Pine.LNX.4.64.0711061550580.4362@racer.site> <20071106163548.GA8207@diana.vm.bytemark.co.uk>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Michael Cohen <michaeljosephcohen@mac.com>,
	Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Karl =?iso-8859-15?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 22:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWKg-0001EP-0m
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 22:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbXKFVvF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbXKFVvE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 16:51:04 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:33454 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152AbXKFVvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 16:51:01 -0500
Received: from tigra.home (Fa80a.f.strato-dslnet.de [195.4.168.10])
	by post.webmailer.de (fruni mo59) (RZmta 14.0)
	with ESMTP id g0224cjA6KQkmU ; Tue, 6 Nov 2007 22:50:58 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D579C277AE;
	Tue,  6 Nov 2007 22:50:58 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4559356D22; Tue,  6 Nov 2007 22:50:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071106163548.GA8207@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSmBw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63735>

Karl Hasselstr=F6m, Tue, Nov 06, 2007 17:35:48 +0100:
> On 2007-11-06 15:51:09 +0000, Johannes Schindelin wrote:
> > On Tue, 6 Nov 2007, Jeff King wrote:
> > > On Tue, Nov 06, 2007 at 11:01:03AM +0000, Johannes Schindelin wro=
te:
> > > > I fail to see how the absence of one of cur/ or new/ can lead t=
o
> > > > the absence of patches. You could forget to save some patches,
> > > > yes, but the presence of cur/ and new/ is no indicator for that=
=2E
> > >
> > > Read my message again. Alex is proposing ignoring errors in
> > > opening the directories; I am proposing ignoring such errors
> > > _only_ when the error is that the directory does not exist.
> > >
> > > IOW, if there is some other error in opening the directory, it
> > > should be fatal, because you might be missing patches.
> >
> > Yeah, sorry, I missed that.
>=20
> I think it might actually not be totally unreasonable to error out
> unless both directories exist. From
> http://www.qmail.org/qmail-manual-html/man5/maildir.html:
>=20
>   A directory in maildir format has three subdirectories, all on the
>   same filesystem: tmp, new, and cur.
>=20
> In other words, if it doesn't have these three directories, it isn't =
a
> Maildir directory.

On the same line of reasoning, if opening a ".../cur" fails with ENOTDI=
R,
it must be not a Maildir...

> On the other hand, one could argue that requiring both dirs to exist
> is being too picky.

=2E..which MUST NOT mean it does not contain useful patches.
IOW, the tool can try and apply everything it finds.
If user told it to get patches from the...whatever, then the patches
should it get and damn qmail.
