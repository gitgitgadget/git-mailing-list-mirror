From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 14:05:36 +0200
Message-ID: <CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
	<CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
	<alpine.DEB.2.20.1605041304050.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 14:05:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvYk-00062r-4T
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbcEDMFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:05:38 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37850 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbcEDMFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:05:38 -0400
Received: by mail-wm0-f48.google.com with SMTP id a17so90122794wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oC9g1/iH75AmqPM5Ee03gMQJVJd3Xi1pIn1C/zl5U2E=;
        b=Bo3iaVXbfUxsk7tVRKoddUeu1YO8eD/di2tGfvTefLLkJHRtfL0Y+ZL14u20G9EAfd
         5a22yU5byyXcb8xcb8Xn/80b7zxEMFYwJsqCbcqVYstfE7Qy50lhKZ1+BmwMySeZpAMu
         LWMRPyHfT+3PE3LT9AZktyBIJuRQk8Bdozp5BEsZBA3oj1xppnrWp5nJ4dAMSpZ/tXur
         u6xRGLNZTgaEkQIlS+7+PQgPm+DW6k5TmvEnrkaB+MDrse8Z+hgW+R84nnV5aXMIsNSY
         9BpJpZiV5SyvbHW8mxtWRG5WQ5we4dGjezMP1ecJyWKDKvA3hPvP2J5uGhWyERpc38up
         MOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oC9g1/iH75AmqPM5Ee03gMQJVJd3Xi1pIn1C/zl5U2E=;
        b=ivaNVCI+ZJVsTmT/rCNqsI1ZZc9jcAiIhEjebRhLvor5fgUXofuiwQfPKfDzl6guo4
         FQ5bD1RQeXYQvBn09FryOh5swO5T/NsxHamuOMFk9X5/l8KTI74zHi/VxLjOAy/0Lb1t
         Gy5EBH0AL3bN5yW8MIWgkeHQY1Rk51T66UUCwKrMlQTPjMSB6ShHehy1Bs/hWi9vaweA
         aNRR+of9g3T6ZQuT8cPeDcFqnPdy5AdF0nrQGdsaKf8yLO8ugLLjurWaVg7FdNOBhNNp
         pQSopVgKM78N6t+YMmsFQvDpwNOOwltiWzV9kSztcOMxP3RdqdUYwfKg5zJW8ubl8rd+
         gIAg==
X-Gm-Message-State: AOPr4FUDhqeJhO9ly7zKu55xfzYpbuCXWNnADbkqnzwf+12U/gOkU/jIl2+bP2l3E1AdJVZSxQ/F/Lpzl0WQ9w==
X-Received: by 10.194.20.162 with SMTP id o2mr8147674wje.78.1462363536695;
 Wed, 04 May 2016 05:05:36 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 05:05:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041304050.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293545>

On Wed, May 4, 2016 at 1:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Wed, 4 May 2016, Christian Couder wrote:
>
>> On Wed, May 4, 2016 at 8:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > On Wed, May 4, 2016 at 1:07 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> >> bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
>> >
>> > This subject is too low-level, talking about implementation details,
>> > whereas it should be giving a high-level summary of the change.
>>
>> When a patch is all about a low level detail, I think it is good to
>> talk about the detail in the subject.
>
> Well, this is not the case here. The intent of this commit is to prepare
> for other command modes.

It depends if you think that describing the long term intent of a
commit is more important than just describing what the commit actually
does in the subject.
In my opinion the long term intent of the commit is better explained
in the commit message. (And the patch indeed talks about what the long
term intent is, even if it could probably be improved.)

> So... why not just say "bisect--helper: prepare for modes other than
> 'next-all'"?

For (an extreme) example, in my patch series about libifying "git
apply" functionality, should many of the patches have subjects like
"builtin/apply: prepare for an apply.{c,h} lib"?
