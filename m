From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Sat, 15 Jun 2013 22:57:15 -0700
Message-ID: <7vip1ek37o.fsf@alter.siamese.dyndns.org>
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
	<7v7ghwmi9x.fsf@alter.siamese.dyndns.org>
	<CALkWK0nDwqqiAq044wwj__1XzAuFDBUG59_0zHRMNzQ6ARsiww@mail.gmail.com>
	<7vsj0jln23.fsf@alter.siamese.dyndns.org>
	<CALkWK0=R8h0_FUYMUFQ_qGC1Lf_Xvu84qigznYUK5MtzP8usPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 07:57:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uo5y7-0004hf-9H
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 07:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab3FPF5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 01:57:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111Ab3FPF5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 01:57:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 005D61A836;
	Sun, 16 Jun 2013 05:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vgo1AjCa7XXp5aBkOtZCh89tbxk=; b=RzpnEQ
	lfRxDh6bNG0anKx2jr7MuXMEZfdAUGy8nmDSkV+k7nVUNJM4q9a7nVVu1S0mlupy
	KU4V2O/bYFaQKrmxBoIA/vtgP2EDNaqt0YiDmj3aDQPt8e7tQB02nZmp3G/NrHv0
	kuUup1B0ntXIJ+CgvVDW8YOG1N+5YFUhEoiIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hhd7mkOc+acfPRCj7VihBvBkqjibKaIp
	a5PIN0HiBEaoh/G+dcEtjXdZXbWTGZPQHRStAvhQzyv2s48aylbjRE362R4/78jq
	xu/XLXuR8I2dpzbCU+YmqBXzy1Z0xIRR4xo8ZfzlHxg0HKF5Bb9bk2462rcPQ3eS
	puFnnpI4nw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D7D1A835;
	Sun, 16 Jun 2013 05:57:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 385281A834;
	Sun, 16 Jun 2013 05:57:18 +0000 (UTC)
In-Reply-To: <CALkWK0=R8h0_FUYMUFQ_qGC1Lf_Xvu84qigznYUK5MtzP8usPQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 15 Jun 2013 17:38:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A312C72-D649-11E2-AEEF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227989>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Two possibilities:
>>
>>  (1) Assume that the other thread will produce a more reasonable
>>      semantics when finished; perhaps the first line will go away
>>      entirely, or maybe it would say something like "# Rebasing;
>>      head at $commit".
>>
>>      Your topic does not _care_ what it would say, so you tweak the
>>      "status" test that is done during "rebase" so that they
>>      ignore the first lines; or
>
> You said you didn't want to regress to show senseless information,...

Go back and read it again.

    If you want to avoid regression, the codepath in wt-status.c
    should compensate for the change to "rebase" so that it checks
    $dotest/onto and show what is recorded in there.

> I agreed with that.  What is wrong with the patch I showed in the
> previous email?

Which previous?  My message you are responding to was a response to
your non-patch message, and tangling the In-reply-to backwards will
reach your original patch.

Puzzled....

> Smudging is a bad hack, and must only be used as a
> last resort: when an another topics updates status to say something
> sensible, it will have to unsmudge the tests.

Yes. I just got an impression, from your incessant arguing, that you
are resisting the "ignore the top" as "extra work that is not
interesting to _me_", while I was trying to see what is the best way
to go forward for the _project_.

Honestly, I didn't want to waste my time and was trying to come up
with a compromise, which would be a small regression to the tests
that we will need to fix with the other topic.  Because you already
said that you are not interested in that topic, I was anticipating
that the work to polish the topic would be a lot easier than
anything I would have to do with you in this topic, because others
are a lot easier to collaborate with than you are, and that is where
that suggestion comes from.

> diff --git a/wt-status.c b/wt-status.c
> index bf84a86..99c55e3 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1182,7 +1182,7 @@ void wt_status_print(struct wt_status *s)
>                                 if (!get_sha1("HEAD", sha1) &&
>                                     !hashcmp(sha1, state.detached_sha1))
>                                         on_what = _("HEAD detached at ");
> -                               else
> +                               else if (!state.rebase_in_progress)
>                                         on_what = _("HEAD detached from ");

Is this supposed to be on top of your original patch?

The primary reason I suggested to special case "rebase-in-progress"
in the "how about this" patch was because that way, you can have the
"have builtin/commit.c honor reflog-action" much earlier in the
series, because what this part of the code would say will not be
affected by what is recorded in the reflog.  If the above, together
with the original patch, makes the code match the expectation of the
"rebase stops in the middle and then status runs" tests, that's also
fine.  The other topic needs to redo it in either case anyway.

> Unless we change the first line drastically to say: "rebase in
> progress: rebasing onto $ONTO" (or something), I don't think this
> makes sense.  And if we were to do that, why not do it properly like
> "rebase ($N/$M): onto $ONTO, upstream $UPSTREAM, branch $BRANCH"?
> Other people on a different thread are already handling that,...

That is the thread I was referring to.


>
> So, you have three simple choices now:
>
> 1. Accept the simple patch I proposed above.
> 2. Propose an alternative patch quickly.  *Patch*.  No more English.
> 3. Reject all patches, and leave me no choice but to smudge.
>
> Which one is it going to be?

None of the above.  After going back and forth this long, I won't
want to pick an incremental from the middle of discussion, so (1) is
out.  This is not my itch and I am only helping you in a way that
the result will not hurt the project, so (2) is not it.  But
assuming that "checkout that is done as an implementation detail in
rebase is _not_ checkout from end user's point of view" is where we
want to go, discarding this series is not something we want to see,
either.

A rerolled series that does:

 - Tweak wt-status.c to take information not from reflog, when
   detached during rebase (this may need to tweak existing tests,
   as different "rebase" modes may use 'checkout' liberally in
   different ways);

 - Teach builtin/commit.c to pay attention to reflog-action; thanks
   to the previous step, this will not have to change the tests;

 - Update the reflog message rebase uses, but again this will not
   affect wt-status.c at all.

would be one way to go.
