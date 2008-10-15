From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Wed, 15 Oct 2008 12:38:56 -0700
Message-ID: <7vljwpr6lr.fsf@gitster.siamese.dyndns.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
 <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Mike Ralphson" <mike@abacus.co.uk>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:40:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCEJ-0004wz-Ir
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbYJOTjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYJOTjI
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:39:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYJOTjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:39:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 124438B8EF;
	Wed, 15 Oct 2008 15:39:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5A5898B8EC; Wed, 15 Oct 2008 15:38:58 -0400 (EDT)
In-Reply-To: <bsftmRx17krWBpVlulipoJEO1fWsD0hZfF3HOZcajX6GV66RKW8W6A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 15 Oct 2008 10:35:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EDA22972-9AF0-11DD-A7CB-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98309>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Two questions:
>
>   1) Should a5a5a048 be in maint?
>      "xdiff-interface.c: strip newline (and cr) from line before pattern matching"

I would have forked a maint-fix topic to prepare a merge of this fix to
both 'maint' and 'master' but apparently this was applied directly on
'master'.  I may be missing a valid reason why Shawn did it this way.

If we can add a test case to demonstrate the existing breakage, I think we
can (and should) cherry-pick it to 'maint'.

>   2) Do we want to stick with compat/regex on
>
>       Darwin: Arjen
>      FreeBSD: Jeff
>          AIX: Mike
>
>      now that the builtin funcname patterns have been converted to Extended
>      Regular Expressions?

Mike already said AIX does not need to, and I expect others would say
their native regexp library can grok ERE just fine.  Let's wait for others
to confirm and then remove the compat/regex thing.
