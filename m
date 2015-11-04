From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Wed, 4 Nov 2015 13:41:04 -0800
Message-ID: <CAGZ79kYYvgLyDhNO5j=t-RPmKV_KHHMoN3xOV4Ygt2MwQe2HRQ@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<xmqq8u6da448.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbwJrQ9SrGkJsSx9oUcP98dn9wP=ZvgQLRjmPaZtOzanA@mail.gmail.com>
	<xmqqziyt8nth.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 22:41:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu5ns-0005aW-Rj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 22:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbbKDVlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 16:41:07 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34849 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965372AbbKDVlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 16:41:06 -0500
Received: by ykek133 with SMTP id k133so97697701yke.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XlrjTQ2YEHHGY5GTwCYheFakBle5aHYzl+5rpTgMhsY=;
        b=nGEcrG3dZ7WUJkpoF6KgqucPgCcNUqlDmLl5NjVNwdW/addAW8Enho6tDyd4fIIrRI
         rqthnyeSv86NKST37PeHHQcrHDYVHrJCxxrA2yqjLxCp692Z0pDkFUb0hPSuuGp3RRJW
         4wCP8Mp9HwCegbvCG7jOQUVyyehCgH5vx4hsKi324F3Ws0mYgWunb+ku61rd/xt0lJgW
         uYsNDfXUtAgVj9iglM8MGVss854Po87lOGxf7j1sK47bnkKsuuX4qvvZWxf4Vk32wNlG
         fXqJE/+1x7iGJvbJO0lHbAY6ZEOokKASuzEEINpP2RjByF1b35A+QVx8Dk6cvp71wTjU
         TqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XlrjTQ2YEHHGY5GTwCYheFakBle5aHYzl+5rpTgMhsY=;
        b=lz9MSHLOh2X3VUP2maRVhUXHkIaJ+eAqDsY7oY+WSznUGbMxtUU2OxTaQXO32yFu7v
         JbvhFJu88PAPu2UnOd/vaW/g4mAxzSbr55G8jimCchMG9KCRCpF2gDGb4j57LdZJmTDY
         dhrZA3ZvIY0y48d8dIbEL5DD+qDgh7nyPaO53W2TLCDRWGaOh/cbb7wdpdxSjvPPDzBw
         7N8GWROog3x7BKDkAjM4DM1KjXYvio8HChiBP0jqxKLlWjIf3y/QNQbObKv9/2a8G/fI
         QkqN9TIL/Fc+DjHWDjMAlpH+fNqc5/wMR9s6kvc3Uvuf0ZEjxdfuobXxWu+BuaQybgVV
         esKA==
X-Gm-Message-State: ALoCoQnxR0Yd5eG7o7ODpxFun6oCpcFjmojjttnjTGEmvOFXD2xN55FA3Cvv3nCXkgr98s+wNRPf
X-Received: by 10.13.251.2 with SMTP id l2mr3342196ywf.44.1446673264472; Wed,
 04 Nov 2015 13:41:04 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Wed, 4 Nov 2015 13:41:04 -0800 (PST)
In-Reply-To: <xmqqziyt8nth.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280888>

On Wed, Nov 4, 2015 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So more like:
>>
>>     if (platform_capable_non_blocking_IO())
>>         set_nonblocking_or_die(&pp->children[i].process.err);
>>     else
>>         pp->children[i].process.err = 2; /* ugly intermixed output is possible*/
>
> When I mentioned #if..#endif, I didn't mean it as a dogmatic
> "conditional compilation is wrong" sense.  It was more about "the
> high-level flow of logic should not have to know too much about
> platform peculiarities".  As platform_capable_non_blocking_IO()
> function would be a constant function after you compile it for a
> single platform, if you add 10 instances of such if/else in a patch
> that adds 250 lines, unless the change is to add a set of lowest
> level helpers to be called from the higher-level flow of logic so
> that the callers do not have to know about the platform details,
> that's just as bad as adding 10 instances of #if..#endif.

Right. Yeah I was just outlining the program flow as I understood it.

Specially:
 * It's fine if the platform doesn't support non blocking IO
 * but if the platform claims to support it and fails to, this is a hard error.
    How is this worse than the platform claiming to not support it at all?

I mean another solution there would be to try to set the non blocking IO
and if that fails we put that process-to-be-started into a special queue,
which will start the process once the stderr channel is not occupied any more
(i.e. the process which is the current output owner has ended or there is
no such process)

That way we would fall back to no parallelism in Windows and could
even gracefully fallback in other systems, which suddenly have problems
setting non blocking IO. (Though I suspect that isn't required here).

>
>>> On the other hand, on a platform that is known to be incapable
>>> (e.g. lacks SETFL or NONBLOCK), we have two options.
>>>
>>> 1. If we can arrange to omit the intermediary buffer processing
>>>    without butchering the flow of the main logic with many
>>>    #ifdef..#endif, then that would make a lot of sense to do so, and
>>>    running the processes in parallel with mixed output might be OK.
>>>    It may not be very nice, but should be an acceptable compromise.
>>
>> From what I hear this kind of output is very annoying. (One of the
>> main complaints of repo users beside missing atomic fetch transactions)
>
> When (1) "parallelism with sequential output" is the desired
> outcome, (2) on some platforms we haven't found a way to achieve
> both, and (3) a non-sequential output is unacceptable, then
> parallelism has to give :-(.

Ok, then I will go that route.

>
> I was getting an impression from your "not buffer" suggestion that
> "sequential output" would be the one that can be sacrificed, but
> that is OK.  Until we find a way to achieve both at the same time,
> achieving only either one or the other is better than achieving
> nothing.

I was not sure what is better to sacrifice. Scarifying parallelism sounds
safer to me (no apparent change compared to before).

>
>>> Either way, bringing "parallelism with sequential output" to
>>> platforms without nonblock IO can be left for a later day, when we
>>> find either (1) a good approach that does not require nonblock IO to
>>> do this, or (2) a good approach to do a nonblock IO on these
>>> platforms (we know about Windows, but there may be others; I dunno).
