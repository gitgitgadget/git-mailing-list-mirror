From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: fix funny-sounding error message
Date: Tue, 05 May 2015 14:58:24 -0700
Message-ID: <xmqqvbg6d6v3.fsf@gitster.dls.corp.google.com>
References: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com>
	<xmqq8ud5usi6.fsf@gitster.dls.corp.google.com>
	<CAMMLpeTYhLwGmy11uGzZAVugQPO6qN6F6pxZ6BiUZKeKnir+zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 23:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpkrI-0002to-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 23:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbbEEV62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 17:58:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751926AbbEEV61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 17:58:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78F9D4DC2F;
	Tue,  5 May 2015 17:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+x5ra1AheedyGwcFmxg4vpDq3M=; b=rrFaSD
	/vHrE9cRQvjU59ALCQrjjgXLeim5UWry8MU0RMHgi1Z8ySxEUF+yB0+1cwK2NoB1
	MSEHCY0zwOPg9wuWsZqaY++9z8u8mbajMKN6UqN8Uw7CoTU8mrpI4KZZLNV0dAno
	qmJZAo690MGwk9a6nTX7J8tXooE6xaiZ/qQko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JyWBArSgmXZCeMUqgVIcYgSaOjuCkzGu
	LJ6zekz833ZDcYGx1VQVc/sqUWlJAquJ8aVKPSo4GUrhmXXFUpPNWQdSUBKKAJ45
	QQ3PSL35jagLJoMYLR4Q6+Rsmz0EinvTUzY2eiG+RR7f5FAOS7cMwbgglLIY6KRK
	shMfRQbhdpk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D874DC2E;
	Tue,  5 May 2015 17:58:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA7264DC2D;
	Tue,  5 May 2015 17:58:25 -0400 (EDT)
In-Reply-To: <CAMMLpeTYhLwGmy11uGzZAVugQPO6qN6F6pxZ6BiUZKeKnir+zw@mail.gmail.com>
	(Alex Henrie's message of "Tue, 5 May 2015 13:42:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB0B37AA-F371-11E4-9AFD-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268426>

Alex Henrie <alexhenrie24@gmail.com> writes:

> 2015-05-03 17:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>>> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
>>> ---
>>>  builtin/branch.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/branch.c b/builtin/branch.c
>>> index 1d15037..c0b4bae 100644
>>> --- a/builtin/branch.c
>>> +++ b/builtin/branch.c
>>> @@ -972,7 +972,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>>
>>>               if (!branch) {
>>>                       if (!argc || !strcmp(argv[0], "HEAD"))
>>> -                             die(_("could not set upstream of HEAD to %s when "
>>> +                             die(_("could not set upstream of HEAD to %s because "
>>>                                     "it does not point to any branch."),
>>>                                   new_upstream);
>>>                       die(_("no such branch '%s'"), argv[0]);
>>
>> Thanks.
>>
>> To me neither sounds so funny, but both sound somewhat awkward,
>> primarily because it is unclear in the first reading what "it" in
>> "it does not point at any branch" refers to.
>>
>> Perhaps if you explain in the log message to illustrate why you
>> found it funny (and the update text is not), it might help, e.g.
>>
>>     "git branch", ran with <this and that options>, when the current
>>     branch is <in what state>, dies with
>>
>>         fatal: could not set upstream of HEAD to frotz when it does not
>>         point to any branch.
>>
>>     which is funny <because of such and such reasons>.  Saying "because"
>>     makes it <better beause of such and such reasons>.
>>
>> I suspect that this message is about a nonsense attempt to set an
>> upstream for a detached HEAD perhaps?  Then
>>
>>     fatal: cannot set upstream for a detached HEAD
>>
>> may be shorter and more directly points at the root cause of the
>> error?
>
> I don't really understand what this code is doing.

To be honest, I didn't know what was going on at the first glance,
either.  AND I felt that it is unfair to say "when" was funny,
without understanding what it is trying to say---perhaps it may be
implying that upstream of HEAD could be set to "%s" when "it" does
point at some branch, or something, even though, as I said, "it" is
unclear without really knowing the context.

I think this "branch is NULL" condition is when an earlier call to
branch_get() returned a NULL, and _one_ way to make that happen is
to detach the HEAD.  There may be others, but I didn't check.

> This error message can be triggered by running `git branch
> --set-upstream-to=origin/master` from a detached head. But if running
> from a detached head is the only way to trigger the error message, why
> does the code use strcmp instead of if (detached) { ... } as other
> code in that function does?

The 'detached' merely is "Is the _current_ HEAD detached?", not "Is
the branch the user asked us to do something about the detached
HEAD?", I think.

If you are getting a NULL out of branch_get() but the user did
"branch -u foo thisbranch", then that is an indication that we
shouldn't be saying that "nono, detached HEAD will never have its
own upstream", because that is not what the user asked us to do.  So
"no argument (implying, we defaulted to HEAD) or the argument is
spelled HEAD" I think is the right thing to check.

And the other error message "no such branch" hints (again, I didn't
follow the codepath) that we may get a NULL in branch if you did
"git branch -u foo no-such-branch".
