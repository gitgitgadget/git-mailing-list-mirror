From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Thu, 28 Aug 2008 14:52:58 +0200
Message-ID: <20080828125258.GA16940@cuci.nl>
References: <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <32541b130808271122t45031cc7n497da8da6ca52bd3@mail.gmail.com> <20080828122142.GA6518@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Karl Chen <quarl@cs.berkeley.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Thu Aug 28 14:54:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYh0q-0007sA-4x
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 14:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYH1MxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 08:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752299AbYH1MxA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 08:53:00 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:54867 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbYH1Mw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 08:52:59 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id DC0205465; Thu, 28 Aug 2008 14:52:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080828122142.GA6518@mail.local.tull.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94044>

Nick Andrew wrote:
>On Wed, Aug 27, 2008 at 02:22:39PM -0400, Avery Pennarun wrote:
>> I'm just feeling protective of the future sanity of other developers
>> here, hoping they don't have to go through what I did on a multi-week

>You're not alone. I've been having trouble with a combination of
>fetchmail, procmail and ssmtp, in which situation the ssmtp program
>_somehow_ sometimes opens /dev/urandom as file descriptor 0 (while

>in controlled circumstances. It's possible that fetchmail or procmail
>is doing something stupid - but a little more defensive programming
>in ssmtp could avoid the total disaster area of sending an endless
>binary stream to an SMTP server.

Procmail I can vouch for, it basically assumes your OS is broken and
fights it's way back to sanity (it can be setuid root, so it has to
be rather careful).
Nonetheless, I still maintain that hiding problems doesn't help, it
only makes the bugs even rarer and more difficult to find.

The filedescriptor problem is a programmer-error, not a user-error,
which is why not hiding it should be preferred.  If it were a
user-error, thing would be different, assisting the user is a Good
Thing.
-- 
Sincerely,
           Stephen R. van den Berg.

"Listen carefully, I shall say this only wence."
