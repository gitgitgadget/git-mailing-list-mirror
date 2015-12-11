From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Fri, 11 Dec 2015 09:39:49 -0800
Message-ID: <xmqqr3isg9zu.fsf@gitster.mtv.corp.google.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	<xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 18:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Rfh-0000is-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 18:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbLKRjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 12:39:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52439 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752093AbbLKRjw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 12:39:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C466E307DC;
	Fri, 11 Dec 2015 12:39:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HcMqyqqjmjfpm6GFVbvQ5VD/Pik=; b=C1F1zy
	fQfM5PYNzf4dxj0QGG5gI8KLzmQsuUYi97JnBD9tRiBFO5PpYJcCoZmZq23VJYf3
	PHc5rEEmbLaPjtptV+aJySHr9+AgppnckUfZ74PaksLkKGxfLct2d+uuVzIr4zQf
	hFJaMdAXHwBTu1/VPvBv3pm2QdskJQ/e14D6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FRYzZ7myFZgJ9DJR4pyunL3YnVzOVyK0
	XEnVcVFaJScPOL3EgPdi8mcvVWN9BndDz1f4pq2SW+RXoILPkQk5UTUr10pyiDSR
	BbJpO57XRQDkuZ6CEWM+6Az1tEop4FXuWhWDQLhalCTy31wLyjoexOVwjLcOGx++
	5pDqo0FDh6Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB886307DA;
	Fri, 11 Dec 2015 12:39:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3BF1C307D9;
	Fri, 11 Dec 2015 12:39:51 -0500 (EST)
In-Reply-To: <CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 10 Dec 2015 15:55:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2E6EA954-A02E-11E5-ADB2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282262>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Dec 10, 2015 at 3:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>>>> ...
>>>
>>> I assume you plan on merging this after 2.7 settled and then we can
>>> also get the above sb/submodule-parallel-update going again.
>>
>> Yeah, thanks for reminding me.  I think that would be a good plan
>> that gives us an opportunity to clean up this topic, some parts of
>> which are have "an early patch that was too hastily merged to 'next'
>> had to be tweaked by an 'oops' follow-up patch in the topic"
>> pattern, e.g. "make waitpid the secondary and closed pipe the
>> primary way to monitor children".
>>
>> Thanks.
>
> This makes it sound as if you would drop it from next once 2.7 is out,
> expecting a complete reroll, which does the right thing from the beginning?

Yes, what is still in 'next' when a new release is made has the
chance to (re)do the right thing from the beginning, and it also can
lose merges from other topics in the middle of the topic if they
have graduated to 'master'.

A topic that did the right thing from this cycle already, but needs
to stay in 'next' only because the area it touches is so important
and deserves more real world testing by those who run 'next', may
not have to reroll.

I think two sb/submodule-parallel-* topics fall into the former
category, i.e. ones that can take advantage of the chance to escape
the rigidity of 'next' at the release cycle boundary, and I think
we should grab that opportunity to clean these series up.

Thanks.
