From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add feature release instructions to MaintNotes
 addendum
Date: Thu, 26 Mar 2009 13:28:38 -0700
Message-ID: <7vprg4m3k9.fsf@gitster.siamese.dyndns.org>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm>
 <20090326121017.6117@nanako3.lavabit.com> <49CB8871.2020605@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Mar 26 21:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmwDX-0007xJ-TP
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 21:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289AbZCZU2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 16:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755562AbZCZU2t
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 16:28:49 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbZCZU2s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 16:28:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FDC896CE;
	Thu, 26 Mar 2009 16:28:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 72B5D96C7; Thu,
 26 Mar 2009 16:28:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3B106D8-1A44-11DE-99EE-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114814>

Raman Gupta <rocketraman@fastmail.fm> writes:

> Nanako Shiraishi wrote:
>> Quoting rocketraman@fastmail.fm:
>> 
>>> + - The 'maint' branch is updated to the new release.
>>> +
>>> +     $ git checkout maint
>>> +     $ git merge master
>>> +
>>> +   This is equivalent to deleting maint and recreating it from
>>> +   master, but it preserves the maint reflog.
>> 
>> After giving a recipe that is better than an alternative, what's
>> the point of describing an inferior alternative as "equivalent",
>> when it is obviously not "equivalent"?
>
> Is this better:
>
> The resulting maint tree is equivalent to deleting maint and
> recreating it from the tip of master, but merging from master
> preserves the maint reflog.

It is unclear what you are trying to explain with these two (in your
original) or three (your rewrite) lines.  As an explanation for the two
command sequence, I would expect to see:

    "This merges the tip of the master into maint".

But that is literally what the command sequence does, so it goes without
saying.

If there is anything that needs to be said further, I think it is not how
delete-then-recreate is inappropriate (I do not think it is even worth
teaching).  But you may want to explain the reason _why_ maint gets this
update from master.  I thought the explanation "... is updated to the new
release" already covers that motivation, but if you want to make the
description really novice-friendly, you _could_ say something like:

    Now a new release X.Y.Z is out, the 'maint' branch will be used to
    manage the fixes to it.  The branch used to be used for managing the
    fixes to X.Y.(Z-1), and does not have any feature development that
    happened between X.Y.(Z-1) and X.Y.Z.  Because these changes are
    contained in the 'master' branch, we can merge 'master' to 'maint' to
    have the latter have them, which prepares it to be used for managing
    the fixes to X.Y.Z.

I personally would not want to see somebody who needs the above to be
explained to take over git maintenance after I get hit by a wayward bus,
by the way ;-)
