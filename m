From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Tue, 03 Sep 2013 09:56:35 -0700
Message-ID: <xmqqr4d5u9mk.fsf@gitster.dls.corp.google.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
	<5221A510.2020206@web.de>
	<CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 18:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGtuF-0001lX-VC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 18:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569Ab3ICQ4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 12:56:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56415 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab3ICQ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 12:56:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CBE53E348;
	Tue,  3 Sep 2013 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EETZ/lNq7eRz0ClKCdQeFosQalY=; b=lS03f7
	2bUt3fTCgS90oACuG4BuelGHuCsS+0k/KXwtBJRuFuVBwQ/yiyBl5RYJmqYmzJ5j
	zKRTxtvfQyGSbC6Age2y1BKz132AMclo9KPFbPCZrrVKJYDNxw+a+jAhry43qP3A
	q90Ji6qsKeh7wzWPfGLW/HmwsmTHf2eXN7OmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CosFr0H5Z22gyd2hN3BXdrfzquWngp9C
	DOaK+0WNbF3YPCe2sqOyMOqyMtWsa6oCj3aKXxHVJrF2iAgR1sifthch0Lk/NvmZ
	nRddRtsg1FLwFJ0MXxqqWnIaVxw+VAHbH+POPbq4tD67A7s/sEBNYT/cFxoNN8L5
	wnQ269p9aEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A393E347;
	Tue,  3 Sep 2013 16:56:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48C0F3E341;
	Tue,  3 Sep 2013 16:56:37 +0000 (UTC)
In-Reply-To: <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 31 Aug 2013 03:22:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBDE0C46-14B9-11E3-8492-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233735>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Subject: branch: use $curr_branch_short more
>
> Why? I don't think that summary explains the reason for being for this
> patch, also, it starts with branch: instead of pull:
>
> Subject: pull: trivial simplification
>
> With that summary, people would have an easier time figuring out if
> they need to read more about the patch or not.

People, other than the author of the patch, use the subject line in
different ways.  It is unclear to me which usage the "trivial lets
them decide if it needs further reading" is trying to help.

 1. Those running "shortlog" to see how much impact each contributor
    had.

 2. Those viewing list of Subjects in their MUA to see which is
    worth reading and commenting on.

 3. Those viewing list of Subjects in their MUA to see which is
    worth reading and applying to their trees.

 4. Those trying to resolve conflicts during "git am -3" and "git
    merge" [*1*].

 5. Those who find that a commit broke the build after bisecting,
    and want to see what is the reasoning behind the broken change.

 6. Those who find an interesting section of the code, blamed its
    origin to a commit, and want to see what is the reasoning behind
    the broken change.

There may be others, but the above should cover most of the cases, I
think.

For 1., they may discount anything that says "trivial" as "not of
high impact".  There may be trivial but high impact changes, but I
do not know how much this mischaracterization hurts.  Probably not
that much.

For 2., they may either skip "trivial", thinking "if it is trivial,
it must be correct", or read "trivial", thinking "the author thinks
trivial, it is likely there are holes in the author's thinking".
Among the 6 patches in $gmane/233472 "Trivial cleanups and fixes",

 - 1, 2, 4 and 5 were trivially correct and good,
 - 3 was not a clear improvement,
 - 6 was wrong.

This is totally unscientific but if we take them as a representative
set of "trivial" patches, a "trivial" patch is correct only about
4.5/6 = 75% of the time.  As a consequence, people who do want to
help the project are better off reading "trivial" just like others,
so that breakages in the 25% do not go unnoticed.  The label does
not let them skip, and wastes one line that possibly could have
given them more information with non-descriptive word "trivial".

For 3., unless the author wants such a patch skipped and dropped on
the floor, "marking it 'trivial' to allow them skip" would not make
much sense, and with 75% success rate, it would be irresponsible for
those who apply patches not to read a "trivial" and blindly apply
it.  Labelling it "trivial" only wastes one line that possibly could
have given them more information with non-descriptive word "trivial".

For 4., 5., and 6., "allow them to skip" will not be in the picture,
as they already know they are interested in that particular change.
Labelling it "trivial" only wastes one line that possibly could have
given them more information with non-descriptive word "trivial"

So it seems to me that a title "trivial" only helps those running
"shortlog" to discount weight of contributor's contribution.

And the author who does not want to spend time on coming up with a
good title, but for each patch, there are a lot more readers than a
single author of that patch, so the benefit to the author does not
count much.


[Footnote]

*1* The former shows the title of the patch and the latter shows the
    branch name after a conflict marker, and it helps to have as
    much clue as possible to remind what is attempted on each side
    of the change.  It is a responsibility for the person who does
    the merge to give the branch a descriptive name, and the branch
    that queued a "trivial" patch does not have to be named
    "trivial", but the title of the patch is a large part of the
    input to naming the branch.
