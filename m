From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 15:16:18 -0700
Message-ID: <7vfvwkmj7x.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	<7vppvosstl.fsf@alter.siamese.dyndns.org>
	<CALkWK0k28u583Jci+Dvad1pbu7_dJdnmz1WBkP790a_t2QdPTg@mail.gmail.com>
	<7v38sksq14.fsf@alter.siamese.dyndns.org>
	<CALkWK0n_Jsb46qPojbGL3S+mPunNQWUOmypQOvdaBjcT5wgJBg@mail.gmail.com>
	<7vsj0kpsb0.fsf@alter.siamese.dyndns.org>
	<CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 00:16:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UncIE-0006YQ-1j
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 00:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab3FNWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 18:16:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3FNWQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 18:16:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F6D227604;
	Fri, 14 Jun 2013 22:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2biHsW9pv/cwJB59jh8dlwRZQLE=; b=UGhIyD
	fKGm/5yxszN1ADdJ0w9eg6KsdsfNM5HM7MSiQ/KY+OdNX5HDeWY02fhg521immtc
	NC9IFcygkxbXDOYWafMWKzxFcce5eGO/3CH3At8PuKvSZ1DSmoiIqhSBJfJ5NVsp
	fDXt3GWWC9HESzhMLHgGQOeEvTDl+KLl6mv6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iq7EHoFh54MVqWQenP4mK+d3U1+2OuaY
	FaY5si/wO8SCX9tRQO1XEYgHl1PfbGql1LHC9nJlqMZEUBdR2haqFgZt1YB3cJOR
	5HjOnjtRZtv3Q+OpmU8sLOnPRVFMsoppkHA6OpAVBHMqJmL+3J8Mw3vkqj20AmgE
	jyWCYwMS/0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6484827602;
	Fri, 14 Jun 2013 22:16:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99672275F8;
	Fri, 14 Jun 2013 22:16:19 +0000 (UTC)
In-Reply-To: <CALkWK0==Phbe-9QaOa3jkYMEvxb6F3kypRkk9RbzrLco-HkHKw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 03:06:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F7922C-D540-11E2-9C21-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227928>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> If you first update "git checkout" so that it will pay attention to
>> a custom reflog-action exported by Porcelain scripts that may want
>> to internally use it to flip branches (and without a custom one, it
>> will still record "checkout: moving from A to B"), without exporting
>> custom reflog-action from "rebase" and other Porcelain scripts, that
>> would not affect any externally visible behaviour.
>
> rebase already sets a custom reflog-action; in fact,
> 'set_reflog_action rebase' is executed after it sources sh-setup.

Ah, OK, that is what I missed, so updating the "checkout" itself
will affect the test Duy's commit updated.

But that does not change anything.  The thing is, I fully agree with
this:

> the "detached HEAD from" message no longer has anything to do with
> the rebase itself; it is completely _random_ and _incidental_.

because at the end of this series, we will not be recording the
internal "checkout" as a checkout event in the reflog.
What the top-line of "git status" says does not matter.

If I were doing this series, the first commit before doing anything
else would be to strip that line from the expected output from "git
status" for tests Duy's commit changed, with the justification
perhaps like this:

    b397ea4863a1 (status: show more info than "currently not on any
    branch", 2013-03-13) wanted to make sure that after a checkout
    to detach HEAD, the user can see where the HEAD was originally
    detached from.

    The last test added by that commit to t7512 shows one example,
    immediately after HEAD is detached.  Add another test to show
    "detached HEAD from" form that should be shown when the user
    further resetted to another commit.

    The majority of tests in t7512 that commit updated, however, are
    looking at the status output while in "rebase", and the exact
    content of that first line relies on the fact that "git rebase"
    used "git checkout" to first detach HEAD before doing anything
    else, and allowed that to be recorded in the reflog just like a
    user initiated "checkout".  As far as the user is concerned,
    however, this operation is not a "checkout" that the user would
    want to count when later issuing "git checkout @{-1}", etc.

    We are going to fix "git rebase" not to let reflog record these
    internal events as "checkout"; these first lines will start
    saying different (and useless) things.  Improving them to give
    a message more appropriate during "rebase" (e.g. "# Rebasing
    branch X on top of Y", instead of "# Not currently on any
    branch" or "# HEAD detached from Z") is left to a separate
    future series, but until that happens, stop checking what
    appears on that first line.

and would keep the last one that shows "detached HEAD at".  That is
what that commit wantd to achieve.  This first commit in the series
would be a good place to add the missing one after that to show
"detached HEAD from", doing "reset HEAD^".  In other words, we can
make this tirst step as a pure clean-up.

If stripping the first line to compare is too much, then I think it
is an acceptable compromise to update the "# HEAD detached from
$ONTO" Duy's patch changed from "# Not currently on ..." to whatever
your updated "rebase" happens to produce, with the same (but weaker)
justification as the last sentence in my "perhaps like this" above.
