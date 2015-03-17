From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 17 Mar 2015 13:46:05 -0700
Message-ID: <xmqq3853nyia.fsf@gitster.dls.corp.google.com>
References: <1425827005-9602-1-git-send-email-me@ikke.info>
	<1425934575-19581-1-git-send-email-me@ikke.info>
	<xmqqa8zkzeq5.fsf@gitster.dls.corp.google.com>
	<20150310225509.GA5442@vps892.directvps.nl>
	<xmqqoao0xx9p.fsf@gitster.dls.corp.google.com>
	<20150311184512.GB5442@vps892.directvps.nl>
	<xmqqsidb5m2r.fsf@gitster.dls.corp.google.com>
	<20150316163306.GB11832@vps892.directvps.nl>
	<xmqqbnjsrcyz.fsf@gitster.dls.corp.google.com>
	<065AE7977A54488198B39564E3E174E6@PhilipOakley>
	<xmqqr3sops9f.fsf@gitster.dls.corp.google.com>
	<CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com>
	<xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0Mn3SPimYU3fdF5pV1MDAHXhKUVSutfJKrXzPpaXM=bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>, Kevin Daudt <me@ikke.info>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXyNY-0004VW-HY
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754212AbbCQUqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:46:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753294AbbCQUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 16:46:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA8EC3F015;
	Tue, 17 Mar 2015 16:46:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SN9gh8ykdSzWcn5IdCaWEN/gRbQ=; b=IxlY/7
	Bkrdz3862GG+Pfm5ch2oLYTGTgL/2KDGUrgojcd8iB1zqi94+Q3f5AwhxtMFlldX
	1Jq+GnkR9YJalePQ22Ldd2Y3871CTu2Q1rrg8pHELxwjqehqs+Kvc63pm0FtjZ4w
	z0jA3H62fFCFe7qCKvNnQ8Ks0rorC1JJ+O+SA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wUW7JV+LQAWOFSRyL30ko8o7eniTKNBA
	JqmnhxShKkm2fxi9bmujOvoJ39JOA4lrEhAi00q/HHaWzDzRVueYLY1vp+AHei0D
	BvfijCQ4uJJg5UNaijLH2v4hU0gCaXYCvngp/rttcF2hAXt5qlVDo+evOURXycaZ
	7coNKxVAQPw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E17783F014;
	Tue, 17 Mar 2015 16:46:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14D313F008;
	Tue, 17 Mar 2015 16:46:07 -0400 (EDT)
In-Reply-To: <CAP8UFD0Mn3SPimYU3fdF5pV1MDAHXhKUVSutfJKrXzPpaXM=bA@mail.gmail.com>
	(Christian Couder's message of "Tue, 17 Mar 2015 20:49:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2AD4F94-CCE6-11E4-933B-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265664>

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 17, 2015 at 7:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Yes, but the user is supposed to not change the "bad" pointer for no
>>> good reason.
>>
>> That is irrelevant, no?  Nobody is questioning that the user is
>> supposed to judge if a commit is "good" or "bad" correctly.
>
> So if there is already a bad commit and the user gives another
> bad commit, that means that the user knows that it will replace the
> existing bad commit with the new one and that it's done for this
> purpose.

ECANNOTQUITEPARSE.  The user may say "git bisect bad $that" and we
do not question $that is bad. Git does not know better than the
user.

But that does not mean Git does not know better than the user how
the current bad commit and $that commit are related.  The user is
not interested in "replacing" at all.  The user is telling just one
single fact, that is, "$that is bad".

>> I am not quite sure if I am correctly getting what you meant to say,
>> but if you meant "only when --alternate is given, we should do the
>> merge-base thing; we should keep losing the current 'bad' and
>> replace it with the new one without the --alternate option", I would
>> see that as an exercise of a bad taste.
>
> What I wanted to say is that if we change "git bisect bad <commitish>",
> so that now it means "add a new bad commit" instead of the previous
> "replace the current bad commit, if any, with this one", then experienced
> users might see that change as a regression in the user interface and
> it might even break scripts.

Huh?  

Step back a bit.  The place you need to start from is to admit the
fact that what "git bisect bad <committish>" currently does is
broken.

Try creating this history yourself

    a---b---c---d---e---f

and start bisection this way:

    $ git bisect start f c
    $ git bisect bad a

Immediately after the second command, "git bisect" moans

    Some good revs are not ancestor of the bad rev.
    git bisect cannot work properly in this case.
    Maybe you mistake good and bad revs?

when it notices that the good rev (i.e. 'c') is no longer an
ancestor of the 'bad', which now points at 'a'.

But that is because "git bisect bad" _blindly_ moved 'bad' that used
to point at 'f' to 'a', making a good rev (i.e. 'c') an ancestor of
the bad rev, without even bothering to check.

Now, if we fixed this bug and made the bisect_state function more
careful (namely, when accepting "bad", make sure it is not beyond
any existing "good", or barf like the above, _without_ moving the
bad pointer), the user interface and behaviour would be changed.  Is
that a regression?  No, it is a usability fix and a progress.

Simply put, bisect_state function can become more careful and
intelligent to help users.

I view this "user goes out of way to tell us a commit that is known
to be bad as bad, even though it is not what we offered to test and
is not an ancestor of the commit that currently marked as bad" case
the same way.  We by now hopefully understand that blindly replacing
the current 'bad' is suboptimal.  By teaching bisect_state to do the
"merge-base thing", we would be fixing that.

Why is it a regression?
