From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] rev-list: refuse --first-parent combined with --bisect
Date: Tue, 17 Mar 2015 11:33:24 -0700
Message-ID: <xmqqtwxjo4nf.fsf@gitster.dls.corp.google.com>
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
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>, Kevin Daudt <me@ikke.info>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXwJ4-0001w4-VN
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbbCQSda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:33:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752679AbbCQSd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE1183E8DA;
	Tue, 17 Mar 2015 14:33:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r1B1H2lr6K6KJxr67nLVGIZv9QI=; b=AXQIg7
	w461ryaZWDjAIdlPx2GrZ8hrIHYGdI7RmGfIqA7kP1/LWH482A8KfBDrE/cDZhJr
	BfF5a5CkOsg6Uv1qO7rb08H04e6KX7//vqd6rzXiehEYDoBCvGkpfkx6biLg7Vt2
	4E31WMh5mFJrKdJ4w4+FhYB1RQLzSx5/tA7hI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NZzwXBU+6kf+9xB8ahkcSHrTdJK31myC
	NiXFixj6uIwd3wSnW4e1pkW3EaEwPnKEcwHR29v+sn/wbgbGNK/jwuqPka5WKw3K
	2VgRSsqqHZLMhw5+mpxJC7HeQz32EBbF/gCXCxmz7jAIu4GRMWJZ8bzTOanGEY8B
	0ZTl0Y/qc3c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C59883E8D7;
	Tue, 17 Mar 2015 14:33:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C91E3E8D3;
	Tue, 17 Mar 2015 14:33:27 -0400 (EDT)
In-Reply-To: <CAP8UFD12UX+3psD2=9_RsGv8JA2C8N54qAYGydYgr7n5ta7dzw@mail.gmail.com>
	(Christian Couder's message of "Tue, 17 Mar 2015 17:09:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A1EF4DC-CCD4-11E4-A55D-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265650>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Mar 16, 2015 at 10:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> However, you can say "git bisect bad <rev>" (and "git bisect good
>> <rev>" for that matter) on a rev that is unrelated to what the
>> current bisection state is.  E.g. after you mark the child of 8 as
>> "bad", the bisected graph would become
>>
>>    G...1---2---3---4---6---8---B
>>
>> and you would be offered to test somewhere in the middle, say, 4.
>> But it is perfectly OK for you to respond with "git bisect bad 7",
>> if you know 7 is bad.
>>
>> I _think_ the current code blindly overwrites the "bad" pointer,
>> making the bisection state into this graph if you do so.
>>
>>    G...1---2---3---4
>>                     \
>>                      5---B
>
> Yes, we keep only one "bad" pointer.
>
>> This is very suboptimal.  The side branch 4-to-7 could be much
>> longer than the original trunk 4-to-the-tip, in which case we would
>> have made the suspect space _larger_, not smaller.
>
> Yes, but the user is supposed to not change the "bad" pointer for no
> good reason.

That is irrelevant, no?  Nobody is questioning that the user is
supposed to judge if a commit is "good" or "bad" correctly.

And nobody sane is dreaming that "Git could do better and detect
user's mistakes when the user says 'bad' for a commit that is
actually 'good'"; if Git can do that, then it should be able to do
the bisect without any user input (including "bisect run") at all
;-).

>> We certainly should be able to take advantage of the fact that the
>> current "bad" commit (i.e. the child of 8) and the newly given "bad"
>> commit (i.e. 7) are both known to be bad and mark 4 as "bad" instead
>> when that happens, instead of doing the suboptimal thing the code
>> currently does.
>
> Yeah, we could do that, but we would have to allow it only if a
> special option is passed on the command line, for example:
> git bisect bad --alternate <commitish>

I am not quite sure if I am correctly getting what you meant to say,
but if you meant "only when --alternate is given, we should do the
merge-base thing; we should keep losing the current 'bad' and
replace it with the new one without the --alternate option", I would
see that as an exercise of a bad taste.

Because the merge-base thing is using both the current and the new
one, such a use is not "alternate" in the first place.

If the proposal were "with a new option, the user can say 'oh, I
made a mistake earlier and said that a commit that is not bad as
'bad'.  Let me replace the commit currently marked as 'bad' with
this one.", I would find it very sensible, actually.

I can see that such an operation can be called "alternate", but
"--fix" might be shorter-and-sweeter-and-to-the-point.

In the "normal" case, the commit we offer the user to check (and
respond with "git bisect bad" without any commit parameter) is
always an ancestor of the current 'bad', so the merge-base with
'bad' and the commit that was just checked would always be the
current commit.  Using the merge-base thing will be transparent to
the end users in the normal case, and when the user has off-line
knowledge that some other commit that is not an ancestor of the
current 'bad' commit is bad, the merge-base thing will give a better
behaviour than the current implementation that blindly replaces.

> and/or we could make "git bisect bad" accept any number of bad
> commitishs.

Yes, that is exactly what I meant.

The way I understand the Philip's point is that the user may have
a-priori knowledge that a breakage from the same cause appears in
both tips of these branches.  In such a case, we can start bisection
after marking the merge-base of two 'bad' commits, e.g. 4 in the
illustration in the message you are responding to, instead of
including 5, 6, and 8 in the suspect set.

You need to be careful, though.  An obvious pitfall is what you
should do when there is a criss-cross merge.

Thanks.
