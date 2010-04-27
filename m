From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 12/16] host-OSF1.patch
Date: Tue, 27 Apr 2010 14:39:12 +0000
Message-ID: <20100427143912.GB36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135904.486582000@mlists.thewrittenword.com>
 <l2jd2d39d861004270710w8e5416d5iad3fa7497e620733@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Tue Apr 27 16:39:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lwW-0002rC-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0D0OjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 10:39:14 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:55292 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab0D0OjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 10:39:13 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 7077F5C48;
	Tue, 27 Apr 2010 15:00:20 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 7077F5C48
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 9A91AA1E;
	Tue, 27 Apr 2010 14:39:12 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 94F20BAB3; Tue, 27 Apr 2010 14:39:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <l2jd2d39d861004270710w8e5416d5iad3fa7497e620733@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145922>

On Tue, Apr 27, 2010 at 04:10:56PM +0200, Tor Arntsen wrote:
> On Tue, Apr 27, 2010 at 15:57, Gary V. Vaughan
> <git@mlists.thewrittenword.com> wrote:
> > Add defaults for Tru64 Unix. ?Without this patch I cannot compile
> > git on Tru64 5.1.
> > ---
> > ?Makefile | ? ?6 ++++++
> > ?1 file changed, 6 insertions(+)
> >
> > Index: b/Makefile
> > ===================================================================
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -734,6 +734,12 @@ EXTLIBS =
> > ?# because maintaining the nesting to match is a pain. ?If
> > ?# we had "elif" things would have been much nicer...
> >
> > +ifeq ($(uname_S),OSF1)
> > + ? ? ? # Need this for u_short definitions et al
> > + ? ? ? BASIC_CFLAGS += -D_OSF_SOURCE
> > + ? ? ? NO_STRTOULL = YesPlease
> > + ? ? ? NO_NSEC = YesPlease
> > +endif
> 
> I'll try your patch for OSF1,

Much appreciated :)

> but (ref. a patch I sent earlier, in its
> first revision) I needed several other changes in order to compile on
> 5.1 (I also needed those you have above), e.g.
> -D_POSIX_C_SOURCE=1 NO_STRCASESTR = YesPlease NO_STRTOUMAX = YesPlease
> NO_STRLCPY = YesPlease NO_MEMMEM = YesPlease NO_UINTMAX_T = YesPlease
> NO_C99_FORMAT = YesPlease
> and
> NO_TCLTK = YesPlease

Indeed, I don't mean to imply that this patch is all that is needed
for OSF1, merely that the changes it contains benefit only OSF1.

Please bear in mind that I build using configure, and may have missed
something necessary for a make-only driven build.

> because V5.1 comes with tcl/tk 8.2 and gitk refuses to start with
> anything older than 8.4.
> I had some other too, but those could be worked around by building and
> installing own versions of iconv, openssl, zlib, python, expat.

Ack.  And since that is our business, we do indeed build git against
our own packages of relatively cutting edge releases of prerequisite
OS software on all our hosts (including all of the above).

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
