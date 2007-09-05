From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 00:30:35 -0700
Message-ID: <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 09:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpLc-0001xF-2e
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 09:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbXIEHan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 03:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755411AbXIEHan
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 03:30:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbXIEHam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 03:30:42 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A282612E9CB;
	Wed,  5 Sep 2007 03:31:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 5 Sep 2007 00:09:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57675>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I personally repack everything way more often than is necessary, and I had 
> kind of assumed that people did it that way, but I was apparently wrong. 
> Comments?

I am as old timer as you are so I am not qualified to add much
variety to the discussion, but I agree that excessive cruft is
something we should warn the user about.

I personally was _extremely_ annoyed by git-cvsimport
occassionary deciding to repack whenever it finds more than
certain number of loose objects, not because it is a big import,
but because I happened to start the command to start a very
small import after doing my own development for a while to
accumulate loose objects, and I really hate automatic repacking
for any operation (or tool that thinks it knows better than I do
in general).

Perhaps _exiting_ "git-commit" and "git-fetch" before doing
anything, when the repository has more than 5000 loose objects
with a LOUD bang that instructs an immediate repack would be
good?

I really do not like the idea of automatically running a repack
after first interrupting the original command and then resuming.
For one thing it would make a horribly difficult situation to
debug if anything goes wrong.  You cannot reproduce such a
situation easily.
