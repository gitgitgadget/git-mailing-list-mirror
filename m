From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 12:39:07 -0700
Message-ID: <7v63pw3ick.fsf@gitster.siamese.dyndns.org>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com>
 <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com>
 <20080819185804.GA17943@coredump.intra.peff.net>
 <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVX41-0007lh-73
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYHSTjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYHSTjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:39:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbYHSTjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:39:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF3C752B14;
	Tue, 19 Aug 2008 15:39:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BEE2952B0C; Tue, 19 Aug 2008 15:39:09 -0400 (EDT)
In-Reply-To: <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
 (Scott Chacon's message of "Tue, 19 Aug 2008 12:00:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80A4558A-6E26-11DD-BFFF-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92913>

"Scott Chacon" <schacon@gmail.com> writes:

> If the patch is acceptable, I will update the githooks doc with more
> information, but we would like this so that you could add a hook that
> runs your automated tests before a push would go through.

I've said this number of times on this list but I guess it has been while
since the last time I said it.

"If the patch is acceptable, I'll document it" is the last thing we as
reviewers would want to hear from the submitter, *unless* there is an
ongoing discussion that already have established what is wanted and a
patch came as "ok, here is a possible solution, what do you guys think?".

If the original submitter does not care enough to defend why it is needed,
why should reviewers spend their precious brain cycles to decipher what it
does, guess what situation the change would help, and determine if the
change actually would help the situation it might be trying to help (and
risk wasting all this work because they guessed the motivation wrong)?
And what assurance would we have that the change will be maintained and
supported?

Having said that, I would agree "validate and potentially stop before
pushing" is a very good thing to have.

It is still unclear at this point what kind of input that validation would
want to base its decision on.  At least we would want what branch is being
pushed (so that a validation failure on a branch that is not being pushed
would not interfere), and possibly where you are pushing to (so that you
can still push a change you would want to verify and potentially polish on
a different test/dev box without getting interfered).
