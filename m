From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support
Date: Sun, 24 Aug 2008 20:05:03 -0700
Message-ID: <7v1w0dkd5s.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <20080824235124.GA28248@coredump.intra.peff.net>
 <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
 <20080825020054.GP23800@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Karl Chen <quarl@cs.berkeley.edu>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 05:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXSPL-0000av-1R
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 05:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbYHYDFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 23:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbYHYDFN
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 23:05:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbYHYDFM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 23:05:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 903436E32C;
	Sun, 24 Aug 2008 23:05:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 865036E32A; Sun, 24 Aug 2008 23:05:05 -0400 (EDT)
In-Reply-To: <20080825020054.GP23800@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 25 Aug 2008 04:00:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A10BA690-7252-11DD-912F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93589>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sun, Aug 24, 2008 at 05:30:54PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Heh, if we are to do the attention-getter, let's do so more strongly ;-)
>
> Does this include removing of --work-tree as well?
>
> The git backend of Pootle (http://translate.sourceforge.net/wiki/) uses
> it.

Interesting.  Does it use it because it can (meaning, --work-tree is
supposed to work), or because --work-tree is the cleanest way to do what
it wants to do (if the feature worked properly, that is, which is not the
case)?

> Also, here is a question:
>
> $ git --git-dir git/.git --work-tree git diff --stat|tail -n 1
>  1443 files changed, 0 insertions(+), 299668 deletions(-)
>
> So, it's like it thinks every file is removed.
>
> But then:
>
> $ cd git
> $ git diff --stat|wc -l
> 0
>
> is this a bug, or a user error?

I  think it is among the many other things that falls into "the two
attempts still haven't resolved" category.
