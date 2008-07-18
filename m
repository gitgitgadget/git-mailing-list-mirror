From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 02:08:19 -0700
Message-ID: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org>
References: <7vlk01hqzz.fsf@gitster.siamese.dyndns.org>
 <20080718175040.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlxx-0005vw-De
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbYGRJI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbYGRJI0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:08:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYGRJI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:08:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C8869312BC;
	Fri, 18 Jul 2008 05:08:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EE3F8312BB; Fri, 18 Jul 2008 05:08:21 -0400 (EDT)
In-Reply-To: <20080718175040.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 18 Jul 2008 17:50:40 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 145211CE-54A9-11DD-AB8C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89014>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> * xx/merge-in-c-into-next (Wed Jul 9 13:51:46 2008 -0700) 4 commits
>>  + Teach git-merge -X<option> again.
>>  + Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
>>  + builtin-merge.c: use parse_options_step() "incremental parsing"
>>    machinery
>>  + Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next
>>
>> This needs to be merged to master iff/when merge-theirs gets merged,
>> but I do not think this series is widely supported, so both are on hold.
>
> Why do you say it is not widely supported?  I may be wrong but I think
> you developed these patches after somebody from the mailing list asked
> for this feature.

Well, for one thing, I do not believe in their cause.  As I wrote in the
log messages for these commits (actually not these above which is a series
for merge fixup, but the other topic), I do not think it is a sensible
thing to say "let's take as much automerge results as possible to salvage
our changes where they do not overlap with what the upstream did, but I
would give up our changes to places that the upstream also touched,
because I do not understand what they did well enough to be able to
resolve the merge conflicts correctly", and "merge -Xtheirs" is exactly
that.

That also was the reason I did not add any documentation to it.  But I do
like the change to the infrastructure to allow passing strategy-specific
options through git-merge and git-pull.  Perhaps I should write something
up, if only to salvage that -X<option> part, even though I am very much
inclined to discard -Xtheirs (and -Xours) part.
