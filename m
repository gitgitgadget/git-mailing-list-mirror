From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Optimized PowerPC SHA1 generation for Darwin (OS X)
Date: Fri, 06 Apr 2007 17:47:17 -0700
Message-ID: <7vodm1ggdm.fsf@assigned-by-dhcp.cox.net>
References: <20070406234826.GG3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Sat Apr 07 03:32:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZz5O-000526-OP
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 02:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXDGArS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbXDGArS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 20:47:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48385 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780AbXDGArS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 20:47:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407004718.SOHY1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 6 Apr 2007 20:47:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id k0nG1W00N1kojtg0000000; Fri, 06 Apr 2007 20:47:17 -0400
In-Reply-To: <20070406234826.GG3854@regex.yaph.org> (Arjen Laarhoven's message
	of "Sat, 7 Apr 2007 01:48:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43952>

arjen@yaph.org (Arjen Laarhoven) writes:

> The compiler toolchain supplied by Apple's Xcode environment has an old
> version (1.38) of the GNU assembler.  It cannot assemble the optimized
> ppc/sha1ppc.S file.  ppc/sha1ppc.S was rewritten into a Perl script
> which outputs the same code, but valid for the Xcode assembler.
>
> Signed-off-by: Arjen Laarhoven <arjen@yaph.org>

Gaah.

When there are improvements/fixes to the sha1ppc.S side, how are
you going to keep that in sync with darwin_ppc_gen.pl?  If that
script *_gen.pl were a postprocessor that munges CPP output from
sha1ppc.S to make it assemblable with an old assembler, it would
be one thing.  But this looks horrible.
