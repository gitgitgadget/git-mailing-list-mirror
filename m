From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] autoconf: Add tests for memmem, strtoumax and mkdtemp
	functions
Date: Tue, 20 Nov 2007 16:08:24 -0800
Message-ID: <20071121000824.GA25959@ftbfs.org>
References: <200711191947.05960.jnareb@gmail.com> <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 05:20:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuh4K-0006Pd-3h
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 05:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbXKUETu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 23:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbXKUETu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 23:19:50 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:35218 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbXKUETt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 23:19:49 -0500
X-Greylist: delayed 2311 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2007 23:19:49 EST
Received: from pool-71-104-149-201.lsanca.dsl-w.verizon.net ([71.104.149.201] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1Iugos-0002K1-3F; Tue, 20 Nov 2007 20:04:14 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.68)
	(envelope-from <kraai@ftbfs.org>)
	id 1Iud8i-0008JD-7N; Tue, 20 Nov 2007 16:08:24 -0800
Content-Disposition: inline
In-Reply-To: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Score: -4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65590>

On Tue, Nov 20, 2007 at 01:00:44AM -0800, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > * Define NO_R_TO_GCC_LINKER if your gcc does not like "-R/path/lib"
> >   that tells runtime paths to dynamic libraries;
> >   "-Wl,-rpath=/path/lib" is used instead.
> 
> Try with -R/path/lib and see if it complains, perhaps?
> 
> 206488774238c94ff337dd5c997be441dbde5112 (Correct the name of
> NO_R_TO_GCC_LINKER in the comment describing it.)

I don't know how to test this, unfortunately.  I'll be happy to test
any tests you'd like me to try, though.

> >   MakeMaker (e.g. using ActiveState under Cygwin).
> 
> f848718a6980ebda0eb5afb2ca49c3bc1e7b2b1d (Make perl/ build
> procedure ActiveState friendly.)
> 
> Alex CC'ed.
> 
> > * Define ASCIIDOC8 if you want to format documentation with AsciiDoc 8
> 
>         case "$(asciidoc --version)" in
>         asciidoc' '7*)	: not def ;;
>         asciidoc' '8)	: def ;;
>         esac
> 
> > * Define DOCBOOK_XSL_172 if you want to format man pages with DocBook XSL v1.72.
> >
> >   - it needs some portable way to check asciidoc and docbook-xsl version
> 
> Hmmm.
> 
> > * Define OLD_ICONV if your library has an old iconv(), where the second
> >   (input buffer pointer) parameter is declared with type (const char **).
> >
> >   - perhaps compile with new iconv and check for compile errors?
> 
> Yeah, with appropriate includes,
> 
>         char *ibp, *obp;
>         size_t insz, outsz;
>         iconv(conv, &ibp, &insz, &obp, &outsz);
> 
> would cause compilation trouble if iconv() wants "const char *"
> for ibp.

-- 
Matt
