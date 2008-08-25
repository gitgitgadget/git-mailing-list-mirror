From: Junio C Hamano <gitster@pobox.com>
Subject: Dropping core.worktree and GIT_WORK_TREE support (was Re: limiting
 relationship of git dir and worktree)
Date: Sun, 24 Aug 2008 17:30:54 -0700
Message-ID: <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org>
References: <quack.20080821T2114.lthvdxtvg7b@roar.cs.berkeley.edu>
 <7vsksw92nh.fsf@gitster.siamese.dyndns.org>
 <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu>
 <7vprnyqo59.fsf@gitster.siamese.dyndns.org>
 <20080824220854.GA27299@coredump.intra.peff.net>
 <7vzln2j9y2.fsf@gitster.siamese.dyndns.org>
 <20080824231343.GC27619@coredump.intra.peff.net>
 <7vhc9aj82i.fsf@gitster.siamese.dyndns.org>
 <20080824235124.GA28248@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl Chen <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 02:32:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXQ0B-0006W3-I9
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 02:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYHYAbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbYHYAbF
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 20:31:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49080 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbYHYAbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 20:31:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E82B766DB0;
	Sun, 24 Aug 2008 20:31:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E31E066DAF; Sun, 24 Aug 2008 20:30:56 -0400 (EDT)
In-Reply-To: <20080824235124.GA28248@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 24 Aug 2008 19:51:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 17D36ADA-723D-11DD-8E38-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93579>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 24, 2008 at 04:40:21PM -0700, Junio C Hamano wrote:
>
>> Judging from the occasional "I tried core.worktree but it does not work in
>> this and that situations" I see here and on #git, my impression is that
>> new people try it, saying "git is cool -- unlike cvs that sprinkles those
>> ugly CVS directories all over the place, it only contaminates my work tree
>> with a single directory '.git' and nothing else.  Ah, wait --- what's this
>> core.worktree thing?  Can I get rid of that last one as well?  That sounds
>> even cooler".
>> 
>> IOW, I do not think it is really _needed_ per-se as a feature, but it was
>> done because it was thought to be doable, which unfortunately turned out
>> to involve hair-pulling complexity that the two attempts that led to the
>> current code still haven't resolved.
>> 
>> I really wish we do not have to worry about that anymore.
>
> Well, as a non-user of this feature, I certainly have no argument
> against taking it out. Maybe the subject line will pull some other
> people into the discussion.

Heh, if we are to do the attention-getter, let's do so more strongly ;-)
