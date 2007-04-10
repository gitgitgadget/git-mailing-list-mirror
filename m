From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Tue, 10 Apr 2007 15:00:50 +0200
Message-ID: <20070410130050.GA10104@diana.vm.bytemark.co.uk>
References: <20070406234826.GG3854@regex.yaph.org> <Pine.LNX.4.64.0704061830350.6730@woody.linux-foundation.org> <20070408200939.GL3854@regex.yaph.org> <20070410094801.GA6148@diana.vm.bytemark.co.uk> <20070410114507.GA28728@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbFy5-0000uJ-Ro
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXDJNBB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Apr 2007 09:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbXDJNBB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:01:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1957 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbXDJNBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 09:01:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HbFxq-0002fO-00; Tue, 10 Apr 2007 14:00:50 +0100
Mail-Followup-To: Arjen Laarhoven <arjen@yaph.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070410114507.GA28728@regex.yaph.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44134>

On 2007-04-10 13:45:07 +0200, Arjen Laarhoven wrote:

> On Tue, Apr 10, 2007 at 11:48:01AM +0200, Karl Hasselstr=F6m wrote:
>
> > On 2007-04-08 22:09:39 +0200, Arjen Laarhoven wrote:
> >
> > >  ppc/{sha1ppc.S =3D> sha1ppc.in.S} |  110 +++++++++++++++++++----=
---------------
> >
> > Wouldn't it be prettier if this filename was .S.in instead of
> > .in.S? Additional file suffixes are usually added at the end (e.g.
> > .tar.gz), and it makes more sense too.
>
> Using the .S suffix makes gcc automatically do the right thing.
> .S.in requires an extra '-x assembler-with-cpp' option to gcc. Of
> course, it's trivial fix.

I just read the Makefile changes again, a bit slower this time, and
noticed that you _first_ feed the .in.S file to gcc, and _then_ to the
perl script, instead of the other way around like I was expecting.
With that arrangement, your naming makes sense, since it reflects
which file format is contained in which. Sorry for the noise.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
