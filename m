From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Tue, 11 Mar 2008 23:49:07 -0700
Message-ID: <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 07:50:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZKml-0007ba-K6
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 07:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYCLGtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 02:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYCLGtR
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 02:49:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYCLGtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 02:49:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 031113F8C;
	Wed, 12 Mar 2008 02:49:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3237C3F8B; Wed, 12 Mar 2008 02:49:10 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803112234470.2947@xanadu.home> (Nicolas
 Pitre's message of "Tue, 11 Mar 2008 22:37:09 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76931>

Nicolas Pitre <nico@cam.org> writes:

>> Can we also have "why this is a good idea", "what problem this solves"?
>
> FWIW, my agreeing with the "why this is a good idea" can be translated 
> into:
>
> Acked-by: Nicolas Pitre <nico@cam.org>

Hmmm.  Is it _that_ obvious?

At least it would be easier to readers if we had something like this in
the documentation (and/or the commit message):

    "git gc" used to never prune unreachable objects without being
    explicitly told to, with its --prune option.  This left cruft to
    accumulate; the user eventually has to run "git prune" manually.

    It is safe to prune old objects that are unreachable from refs nor
    reflogs.  "git gc" is updated to run "git prune --expire 2.weeks.ago"
    so that users has to run "git prune" by hand much less often.

Is it too much to ask for regulars to set the example of justifying why
each of the change is a good idea?
