From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Sat, 14 May 2016 11:19:20 +0200
Message-ID: <CAP8UFD376guRRPpMVjC36K0dvWy17xdaHvV1WoRjMaNpdp0bqQ@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<alpine.DEB.2.20.1605130820160.4092@virtualbox>
	<CAP8UFD2fSW0nds7myfb_09c+EaCdn6+1OqsNEzfY2rVTeA5TAw@mail.gmail.com>
	<alpine.DEB.2.20.1605140807310.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 14 11:20:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1VkN-0006T4-46
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 11:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbcENJTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 05:19:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34592 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbcENJTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 05:19:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so8028716wmn.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7M3sJAFYkIqjsRkH8K0VKA4MCwDKTcaXLR1fMQU6Xck=;
        b=WucybAGrRYPTxmYNy0H/q3V92v6OW7kWsYuZK4skBjKXOWySdFGGOTY1u90HwZLgvQ
         AfK4AkSvMySyFDjzuv13lXFz67mhgxWhT2292nDKM8XNabY/nQsK6AhSnguwwMpVnIJb
         TpB6HvBFTD+Ts/BxPC8l1M8gG3Ag2ANl7T6b51sQ1BjobhAeIngCEf3foRYIdX4sBKp4
         NJvjJK5OPNXM5+33DjMFuPlDnDQV6qaJ4wU1z+/Z67pqNVxJ4QJ4SrnA7AvclJ2DZt2w
         UL6771sgPNGqTrzu7+lVQk9n3SEzXz0GclQCvjwuNT0RY/XSRPhRFrp82sIO+XzZ4rHS
         tUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7M3sJAFYkIqjsRkH8K0VKA4MCwDKTcaXLR1fMQU6Xck=;
        b=UnVtbsOhgSTQBJeJzAUBKRRUxoW4N1tMs2L8Y346M5mWzIT21z46vZN0aiwOvVYCxu
         a4VXqXly/k264rmpmyJ4aIi41PacNeEAYadyfGQU9FKbsVps9nSahQVyiyV5mJRA2hk6
         axwly8KwtpQfPZ+3gqubJ7knvHPxiCL8qdhsFmjF1hyyEUTUhsThYXtvruik4TY0ZJ9W
         oEngY3r2ztyWXO1H1B06ywcHvmOKprbVyDHnNR0xqdEz86zpmeB5fFDXypnpf90CusnH
         0eE7oljFPJtdkTelQz3uANuwIYfurKntUxSz17FaCcJsZezwhjQMUqz3zi+wABCHmerG
         sCng==
X-Gm-Message-State: AOPr4FVqWkuq+zFz8YDgQ0Lcu8x41ZNUGJRLgWJyR8kWMopDrcWAMVWQuGfnPZBMIbiZA22ZRDVVn405JC3L4Q==
X-Received: by 10.194.149.37 with SMTP id tx5mr5011627wjb.94.1463217560847;
 Sat, 14 May 2016 02:19:20 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 14 May 2016 02:19:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605140807310.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294606>

On Sat, May 14, 2016 at 8:26 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

[...]

>> >> By the way there are no tests yet for this new feature, and I am not
>> >> sure at all that "--silent" and "be_silent" are good names.
>> >
>> > If you want to follow existing code's example, we typically call this
>> > option "quiet".
>>
>> In the documentation there is: [... snip ...]
>> ...
>>
>> So it looks to me that --quiet means something like "don't tell the
>> story of your life, but in case of problem you are allowed to
>> complain". In other word --quiet generally doesn't suppress error
>> messages from error() or die().
>
> Right.
>
> And if you care to take a step back, this is most likely what we want in
> libified code.

In the previous discussion, Junio asked:

"How far can you go with just set-error-routine?  Are there things,
other than the file descriptors, that you need to futz with in order
to covert that "we'd fallback, so this early round must be silent"
codepath?"

So it looks to me that the goal is to have something that replicate
the current behavior, which is to not even display messages from
error().

[...]

>> >> Sorry if this patch series is long. I can split it into two or more
>> >> series if it is prefered.
>> >
>> > It is preferred. Much.
>>
>> Ok, I will split it then.
>
> Thank you. Maybe you take me off of the Cc: list, too?

Ok I will do that.
