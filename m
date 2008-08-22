From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Thu, 21 Aug 2008 23:09:55 -0700
Message-ID: <7vljypd1ho.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 08:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWPrb-0000xm-9H
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 08:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbYHVGKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 02:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752961AbYHVGKF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 02:10:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbYHVGKD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 02:10:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 932DB62A23;
	Fri, 22 Aug 2008 02:10:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7527262A20; Fri, 22 Aug 2008 02:09:58 -0400 (EDT)
In-Reply-To: <20080821200255.GB27705@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 21 Aug 2008 16:02:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F529B7F6-7010-11DD-9D93-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93257>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 21, 2008 at 11:19:41AM +0200, Michael J Gruber wrote:
>
>> This allows the use of author abbreviations when specifying commit
>> authors via the --author option to git commit. "--author=$key" is
>> resolved by looking up "user.$key.name" and "user.$key.email" in the
>> config.
>
> This seems like a reasonable feature to me, though two high-level
> questions:

In short, I'm in agreement with almost everything you said in your
response, in that I think (1) this is a reasonable thing to want to do,
(2) this should use an external mail-alias file, not set of in-config
values, possibly sharing the database with send-email, (3) committer
should be treated the same way (shouldn't the effort be the same?
otherwise there is something wrong in the existing code structure).

>> In an ideal word, all my collaborators would exchange changes as git 
>> ...
>> --author argument without "<>".
>
> This justification should probably go into the commit message, not the
> cover letter. When you are writing it, think about the reader who will
> bisect or blame to your commit a year from now. Will they want to see
> just _what_ you did, or _why_ you did it?

Absolutely.  What the change does is already visible in "log -p".  The
reason behind the change, "Why", is much more important, and Michael's
justification was very well written.  It should have been in the proposed
commit log message.
