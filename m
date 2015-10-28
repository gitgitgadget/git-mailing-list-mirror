From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 28 Oct 2015 17:43:14 -0500
Message-ID: <CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZRA-0000jw-15
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbJ1WnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:43:16 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36701 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbJ1WnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:43:15 -0400
Received: by ioll68 with SMTP id l68so27343823iol.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=xhUBzibMBfgiS6uSVHGc/O5fq8WQbaEtOl3yIQNRAv4=;
        b=NU2YxxhF2Ljw7oCz4+/WwhtNxQxvlTnUHamtv3gMYYWQB/XL5pf4vwE/aT7QwoJiYZ
         WT33pyCuhxtRj+Hmj0YaseWQzBav98tTZn4vaN+N7nvnDkx+0D4BpIrF6i5Wi7LZj9XV
         8d1XUyGu0Fs6p4T5ZgwHiLGJF3b20eIs9H12MD1QbBRPobx5m5UKN4/y2NpR4+3iWqyC
         V8PZl4zSn4y2v8s7D2JXsxyllwjoYcyLhAEbqxRR0CnixmCiaw4kn7QXc63aBX9cWwIV
         30InawrLpRSWijq60tNISR5w01kS7r7S9Lu+vTOwKzjDummuwU0XH1R3NoVinHqR0PS2
         cKTg==
X-Received: by 10.107.19.219 with SMTP id 88mr32204636iot.41.1446072194705;
 Wed, 28 Oct 2015 15:43:14 -0700 (PDT)
Received: by 10.79.104.199 with HTTP; Wed, 28 Oct 2015 15:43:14 -0700 (PDT)
In-Reply-To: <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280419>

On Wed, Oct 28, 2015 at 12:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> -static void real_report_garbage(const char *desc, const char *path)
>>>> +const char *bits_to_msg(unsigned seen_bits)
>>>
>>> If you don't expect other callers outside this file, then this should
>>> be declared 'static'. If you do expect future external callers, then
>>> this should be declared in a public header file (but renamed to be
>>> more meaningful).
>>
>> I think this can be private to this file.  The sole point of moving
>> this logic to this file is to make it private, after all ;-)  Thanks
>> for sharp eyes.
>>
>> Together with the need for a description on "why", this probably
>> deserves a test or two, probably at the end of t5304.
>>
>> Thanks.
>
> Does somebody want to help tying the final loose ends on this topic?
> It has been listed in the [Stalled] section for too long, I _think_
> what it attempts to do is a worthy thing, and it is shame to see the
> initial implementation and review cycles we have spent so far go to
> waste.
>
> If I find nothing else to do before any taker appears, I could
> volunteer myself, but thought I should ask first.
>
> Thanks.

I agree; I've been wanting to get back to it, but had some
higher-priority things at work for a while, so I've not had time.  I'd
be happy to get back into it, but if you get to it first, believe me,
I'm not going to be offended. :)

I'll see if I can't devote a little extra time to it this upcoming
week, though.  Hopefully it doesn't need too much additional polishing
to be ready.

P.S. Does a Googler want to tell the Inbox team that the inability to
send plain-text email is really annoying? :P
