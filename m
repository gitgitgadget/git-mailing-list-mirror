From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 00/16] Portability Patches for git-1.7.1 (v4)
Date: Wed, 28 Apr 2010 09:19:22 +0000
Message-ID: <20100428091922.GF36271@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <4BD7032D.9050508@drmicha.warpmail.net>
 <20100427175442.GB13626@coredump.intra.peff.net>
 <m2iq7cejsh.fsf@igel.home>
 <20100428020816.GC16107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 28 11:19:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O73QX-00053n-W4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 11:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924Ab0D1JTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 05:19:24 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:58949 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0D1JTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 05:19:23 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 9DCA55CD5;
	Wed, 28 Apr 2010 09:40:32 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 9DCA55CD5
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id D45C6AFC;
	Wed, 28 Apr 2010 09:19:22 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id CDEC2BAB4; Wed, 28 Apr 2010 09:19:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100428020816.GC16107@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145980>

Hi Jeff,

On Tue, Apr 27, 2010 at 10:08:16PM -0400, Jeff King wrote:
> On Tue, Apr 27, 2010 at 10:13:02PM +0200, Andreas Schwab wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > Furthermore, if we do take such changes, how are we going to manage
> > > portability going forward? Some constructs (like non-constant
> > > initializers) make the code much easier to read. People _will_ submit
> > > patches that use them. Is somebody going to be auto-building on all of
> > > these platforms with vendor compilers to confirm that nothing is broken?

And that's fine.  People who are trying to build will notice the
breakage on their platforms and likely submit patches in due course.
A portability guide in the source tree might help reduce the code
churn, I'd even be willing to draft it for you if you agree that it
would help. I think it would be just a few hundred words setting out
the 5 or 6 problems that I have to patch over-and-over when I port OS
packages to our older architectures...

> > You can use "gcc -pedantic" to find these portability problems.
> 
> Sort of. It reports much more than we necessarily need to fix to remain
> portable to even remotely sane platforms. So it's a nice tool for
> finding problems, but somebody needs to do the work of figuring out
> which are important and which are not, and then periodically run with
> -pedantic and sort out the results.

IMHO, unless it is a significant impediment to development of git,
then it makes sense to support any platform for which you have someone
prepared to maintain the port.

While our release cycle revs only 2 or 3 times per year, for as long
as I have customers who want me to port to their platforms, I will
continue to patch support for those platforms into our packages.  I
think that it would be a shame if those ports were kept hidden away on
our servers and only benefited our customers rather than integrated
into upstream for the benefit of the whole community.

So the real question is whether uglification of unportable code is so
unacceptable that git wants to wilfully reject external maintenance of
ports to end-of-life but none-the-less deployed and active
architectures?

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
