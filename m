From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Mon, 12 Oct 2015 11:59:15 -0700
Message-ID: <xmqq37xfncak.fsf@gitster.mtv.corp.google.com>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
	<vpqpp0ojvs6.fsf@grenoble-inp.fr>
	<xmqqfv1jq4jy.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQkjMFXVeJ==myQLjyRs6EcejnYnszYKJLyskFufjeqiA@mail.gmail.com>
	<xmqqbnc4ord4.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZT5AUAOgHNhX3AwpY20AZkm39=-JVQjUCgb0_x6LTHXaA@mail.gmail.com>
	<vpq7fms9cjs.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:59:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZliJl-0000tm-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbbJLS7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:59:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35234 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbbJLS7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:59:17 -0400
Received: by pabve7 with SMTP id ve7so103106324pab.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=EvKVYZl/VKQ/GOaWPVWRLGvitn181pfSLVVWkuc8rZw=;
        b=hQAgv1zp55mplgV07nIIO9F6ymFOXuBXX95/fLI/NeuYco82BUpnKb8WGGfhi62jFd
         CrPuXtl9FkMP8tS8YRQFVUUZtlRNGYH/O1gQ83u7+NvVV0vVuW+F12LyIuB8XrVDxYH+
         hAm7rTE/CYu6HXIDiGlvxd7oeF76EFnEy2cGwcDdyIooJJCUSqct0mKzNhsNdJrKWDle
         CzHJ5VkbqS6Fjzl4zwIuiNjfajNWcCh24Jt5Whg0iGOXqc6SisQbjn2QsuYJJMQWPqDi
         BlCSsR5vNVz9Lrll4K13U0ZpKWKws8zBA3h8YTEbcAcTaqE1hGeW6LHJLUh3wCCTINFU
         AkfA==
X-Received: by 10.68.111.129 with SMTP id ii1mr36254216pbb.1.1444676356778;
        Mon, 12 Oct 2015 11:59:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id yg2sm19649012pbb.79.2015.10.12.11.59.15
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 11:59:15 -0700 (PDT)
In-Reply-To: <vpq7fms9cjs.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 12 Oct 2015 20:17:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279403>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Oct 12, 2015 at 6:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>
>>>> On Fri, Oct 9, 2015 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> ...
>>>> Also does it make sense to integrate these changes here? Or would you like to
>>>> have another series on this?
>>>
>>> I do not think you would want to ask that question, as my answer
>>> would most likely be "The most preferable would be a series to clean
>>> up the existing codepath that deals with %(align) first, on top of
>>> which everything in flight that is not yet in 'next' is rebased."
>>
>> Ah, but I might take a while to get there, So I'd rather push code which
>> is almost ready and work on that slowly, if that's ok?
>
> That's OK to me. The "most preferable way" above would lead to a cleaner
> history, but also more work for you and for me as a reviewer.

I do not think the cleanliness of the resulting history is of prime
concern.  At least, that was not where my preference came from.

If you design a new infrastructure to help refactoring early
(i.e. before adding many copies of code that need to be cleaned up
later), it would make the work of reviewing of the design of the
helper and refactoring using that helper smaller, not larger.  And
the new codepaths that use the helper would become easier to follow
(otherwise we wouldn't be doing such a refactoring in the first
place), making the reviews easier.  That is where my preference
comes from.

There _is_ a sunk-cost that has already been invested in reviewing
the older round that added code that needs to be cleaned up; there
are some parts other than the "need to be cleaned-up" parts that we
would feel confortable having in the reroll without having to
re-review them.  I do not know if that is a very high cost, though,
especially for those who have already seen the previous rounds.

Anyway, I wouldn't insist and we can go either way.
