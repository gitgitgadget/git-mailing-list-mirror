From: Eric Raymond <esr@thyrsus.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 19:06:10 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100410230610.GB4623@thyrsus.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
 <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
 <m3k4sfgmjc.fsf@localhost.localdomain>
 <20100410194154.GB28768@thyrsus.com>
 <s2i46a038f91004101331g1cdca78cya3e125275446a0a9@mail.gmail.com>
 <4BC0FB94.6050409@gnu.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 01:06:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jkn-0000gJ-Jb
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 01:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0DJXGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 19:06:12 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:43661
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab0DJXGK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 19:06:10 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 16C3220CBBC; Sat, 10 Apr 2010 19:06:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4BC0FB94.6050409@gnu.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144613>

Paolo Bonzini <bonzini@gnu.org>:
> >One issue is that there's no stream-parser JSON implementations that
> >I'm aware of.
> 
> Here is one.  It's ugly as hell, you're warned.  The only missing
> piece is making the stack state resizable.

I wrote one in C for the GPSD project that has two interesting
properties:

(1) No use of malloc(),

(2) Unpacks to *fixed-extent* data structures.

It has one language restriction: Array subelements all have to be the same type.

It's not a stream parser, so there will be compile-time limits on the
volume of data it can handle.  This isn't a big deal in the GPSD 
context, where the objects are relatively short (< 1K) datagrams.

It's very well tested and, I think, pretty bulletproof.  I've been thinking
of spinning it out as a reusable project.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
