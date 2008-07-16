From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 13:51:31 -0700
Message-ID: <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:52:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDzN-0006e4-S0
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbYGPUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757104AbYGPUvk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:51:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055AbYGPUvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:51:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CF252E886;
	Wed, 16 Jul 2008 16:51:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 677212E884; Wed, 16 Jul 2008 16:51:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807161804400.8950@racer> (Johannes
 Schindelin's message of "Wed, 16 Jul 2008 18:21:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FC92A624-5378-11DD-9FA2-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88758>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Am I the only one who deems teaching plumbing to users ("I like it raw!  
> So I teach it the same way!") harmful?

I think that justification is harmful.

More productive way to think about it is to identify cases where we _need_
to go down to combination of the plumbing commands in our daily workflow,
with today's command set.  That would give us a good indication that some
Porcelain may need to be enhanced.

An example. I find myself running "git read-tree -m -u $another_state"
while redoing a series inside a "rebase -i" session to move commit
boundaries.  There may need an insn that says "use that tree" instead of
"edit" and running "read-tree -m -u" by hand.  This does not bother me too
much, but there probably are other examples.

Another example.  I often run "git ls-files -u" while looking at which
paths are conflicting.  ls-files is classified as plumbing, but it does
not bother me as much as having to see the staged long object names in
this output.  Other people, however, might find it yucky, and we might
want "git merge --unmerged" or something that lists the paths (and only
paths, no stage information) that still have conflicts.
