From: Jeff King <peff@peff.net>
Subject: Re: v1.5.4 plans
Date: Mon, 10 Dec 2007 18:49:41 -0500
Message-ID: <20071210234941.GE22254@coredump.intra.peff.net>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org> <7vabpg9x5k.fsf@gitster.siamese.dyndns.org> <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org> <7v63zjgoel.fsf@gitster.siamese.dyndns.org> <7vsl2i6ea4.fsf@gitster.siamese.dyndns.org> <7vhcixtnm4.fsf@gitster.siamese.dyndns.org> <7vfxye4yv7.fsf@gitster.siamese.dyndns.org> <7vve78qhtf.fsf@gitster.siamese.dyndns.org> <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 00:50:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1sNx-00037Y-GC
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 00:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbXLJXto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXLJXto
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 18:49:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4534 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbXLJXtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 18:49:43 -0500
Received: (qmail 4178 invoked by uid 111); 10 Dec 2007 23:49:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Dec 2007 18:49:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Dec 2007 18:49:41 -0500
Content-Disposition: inline
In-Reply-To: <7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67771>

On Mon, Dec 10, 2007 at 02:37:09PM -0800, Junio C Hamano wrote:

>  * Please, everybody, no more new features until v1.5.4 final ships, and
>    please spend a bit more time on finding and fixing regressions than
>    you would spend time cooking your favorite new features.  I do not
>    have infinite amount of time to comment on new feature patches while
>    concentrating on fixes at the same time.
> 
> There are outstanding issues that need to be resolved:

A few regressions that you did not mention, but I think should be
addressed before 1.5.4:

 - extra newline in builtin-commit output. You found a case that
   needs it, but fixing it is non-trivial, and I wanted to get your
   input before preparing a patch. See

     http://mid.gmane.org/20071203075357.GB3614@sigill.intra.peff.net

 - git-clean's handling of directory wildcards. I didn't get a response
   to

     http://mid.gmane.org/20071206043247.GC5499@coredump.intra.peff.net

   I suspect there are still some bugs lurking in there, but it's hard
   to say because I don't know what the behavior _should_ be (there are
   some test cases in that email).

And perhaps not a regression, but I think we should bring git-svn's
handling of color.* in line with the changes to the rest of the code
before 1.5.4. I posted a "last resort" patch, but I think with your
changes to "git config --colorbool" it might be possible to use that.
I'll try to work up a new patch.

-Peff
