From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Applying patches from gmane can be dangerous.
Date: Thu, 07 Feb 2008 01:08:41 -0800
Message-ID: <7vy79xnnfq.fsf@gitster.siamese.dyndns.org>
References: <20080205211044.GP26392@lavos.net>
	<7vodatqu6w.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0802062327350.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 07 10:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN2lB-0001gK-3C
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 10:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080AbYBGJI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 04:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756569AbYBGJI6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 04:08:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbYBGJIy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 04:08:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B456344C;
	Thu,  7 Feb 2008 04:08:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A8A1F3425;
	Thu,  7 Feb 2008 04:08:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72912>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 6 Feb 2008, Junio C Hamano wrote:
>
>> ...
>> It already is part of 'next', and we have the policy of not
>> rewinding 'next', so the record of this mistake will
>> unfortunately be with us forever.  Sorry, Brian, Dscho and
>> Steffen.
>
> Maybe you can make an exception for this time?  A single

That's very tempting.

There currently are 1176 commits in 'next' that are not in
'master'.  Among them, 1100 or so of them will never be.  They
are merges of topics that have long graduated to 'master', or
upmerge of 'master' into 'next'.

If we rebuild an equivalent of 'next', starting with 'master'
and merging the still-cooking topics today, the result is only
70 commits ahead of 'master'.  Among of them, 16 are merges.

In other words, 'next' will go down from v1.5.4-1200-gXXXXXX to
v1.5.4-70-gXXXXXX all of a sudden, if we decide to do so.

People who follow 'next' hopefully know what goes on the list,
so perhaps we could revise the "never rewind" rule to read "it
will not rewind during the regular cycle, but it will be rebuilt
once each feature release, immediately after release."

Hmmmmmmmm...
