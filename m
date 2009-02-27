From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 13:02:27 -0800
Message-ID: <7vr61jiof0.fsf@gitster.siamese.dyndns.org>
References: <20090227192708.6266.qmail@science.horizon.com>
 <7v3adzk5wb.fsf@gitster.siamese.dyndns.org>
 <20090227203108.10186.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9sN-00034C-Q4
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbZB0VCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 16:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbZB0VCh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:02:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbZB0VCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 16:02:36 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E0D19B842;
	Fri, 27 Feb 2009 16:02:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A1D089B841; Fri,
 27 Feb 2009 16:02:29 -0500 (EST)
In-Reply-To: <20090227203108.10186.qmail@science.horizon.com> (George
 Spelvin's message of "Fri, 27 Feb 2009 15:31:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F461F356-0511-11DE-8865-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111717>

"George Spelvin" <linux@horizon.com> writes:

> The suggestion was in <83vdsefz9j.fsf@kalahari.s2.org>, available as
> http://marc.info/?l=git&m=123216049508531
> but I agree that there was no consensus.  I just thought this thread was
> a good place to elicit discussion, since it would be an incompatible change.
>
>> The only way you could justify such a default change is to say:
>>
>>     Almost all the time, everybody wants to use this new behaviour; the
>>     old behaviour is almost never useful in any situation other than a
>>     narrow corner case; and if somebody wants to do such a useless thing
>>     in a corner case, he can always add " ." at the end, so nothing is
>>     lost.
>>
>> I do not think that is true for the change you are proposing here.  'He
>> can always add " ." at the end' alone is not a good enough justification.
>
> Please forgive me, ...

There is nothing that needs forgiveness.  Discussion is a good thing, as
long as it is not about useless bikeshedding (and I should just learn to
ignore discussions that are useless, instead of getting upset.  Lucikly we
haven't had many).

> ... I thought the above *might* be true, and wanted to provoke
> discussion to see how people felt.

If you suspected that the above may be true, that the new behaviour should
be the default, and that many people may support that view, and wanted to
confirm it, then your justification should have really spelled it out.

> The "consistent with
> git-log and all that stuff" argument is quite persuasive to me, but it's
> a convenience feature, so it depends on how people feel.

Consistency among tools with a similar objective is a good thing to aim
for.

"log" especially "log -p" is about inspecting _changes_ and to understand
the change you would more often than not want to view the change in the
entire context (that is the point of having an atomic while-tree commit).

On the other hand, "grep" is about narrowing down the _state_ you would
want to inspect, and unlike the case when you _inspect changes_ where you
would more often want to have the entire context, you would more often
want to omit unrelated parts of the tree while you are _narrowing down
state_ to inspect.  This is especially true when you run it from a
subdirectory, and by definition when you are already in a subdirectory,
your attention is already narrowed down to the part of the whole tree you
are currently in.

So in that sense, I do not see a "similar objective" between what log and
grep are used for.  They may superficially look similar, but the useful
mode of operation between them can be different because they are used for
different purposes.
