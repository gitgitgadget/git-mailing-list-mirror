From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support "core.excludesfile = ~/.gitignore"
Date: Sun, 24 Aug 2008 16:40:21 -0700
Message-ID: <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 01:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXPDC-0005gC-6V
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 01:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbYHXXk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYHXXk2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 19:40:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbYHXXk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 19:40:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D5DC46E536;
	Sun, 24 Aug 2008 19:40:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D8716E535; Sun, 24 Aug 2008 19:40:23 -0400 (EDT)
In-Reply-To: <20080824231343.GC27619@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 24 Aug 2008 19:13:43 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0761DDB4-7236-11DD-B2BB-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93575>

Jeff King <peff@peff.net> writes:

>> Perhaps we should rid of the worktree that is separate and floats
>> unrelated to where $GIT_DIR is.
>
> I assumed people were actually using it, which is why it was
> implemented.

Judging from the occasional "I tried core.worktree but it does not work in
this and that situations" I see here and on #git, my impression is that
new people try it, saying "git is cool -- unlike cvs that sprinkles those
ugly CVS directories all over the place, it only contaminates my work tree
with a single directory '.git' and nothing else.  Ah, wait --- what's this
core.worktree thing?  Can I get rid of that last one as well?  That sounds
even cooler".

IOW, I do not think it is really _needed_ per-se as a feature, but it was
done because it was thought to be doable, which unfortunately turned out
to involve hair-pulling complexity that the two attempts that led to the
current code still haven't resolved.

I really wish we do not have to worry about that anymore.
