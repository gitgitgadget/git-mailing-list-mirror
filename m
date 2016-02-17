From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 23:37:44 +0530
Message-ID: <CAOLa=ZQ4-Qwp84XgTS9joGW4rJRiw8VMTf+Y1Dzo5M-ZNPZXuA@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
 <1455649215-23260-3-git-send-email-Karthik.188@gmail.com> <20160216192231.GA16567@sigill.intra.peff.net>
 <CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
 <20160216204954.GC27484@sigill.intra.peff.net> <CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
 <CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com> <CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:08:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6WR-0000E0-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbcBQSIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:08:16 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35019 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964878AbcBQSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:08:15 -0500
Received: by mail-vk0-f53.google.com with SMTP id e6so21931115vkh.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/G1rWGJS2/7STIbHZyeI4zr+u620g0m8EW8BqeboSSc=;
        b=0mOe6m3jgD/gOPYpW/h595Bp9JbSlULob2pmWzYCXRaCfdunjZHPnY47v7VQPBHrJw
         jUWTgi4tEedu11OC6NJkzEWZinLfR4kFQ/+TPaqEj7kB6jkVNL0ue0m3UIHDNCsWKLLr
         UUUn7v6Jq5uhjZbb7T+S6eUmELVPT9/VKAiUxpkkUIAAsuAZSa2dDCzmKm8Z1YQszqMw
         J8jm177gnLqbYa5GS+4bg61lM0qFb4bzSTimkYoXc1UxHIOBk0M+pv0+RNoQPES+ZN9L
         2JrDOtK3jv0/TniwfvwZ7/ilcxdw0BW21HGu3DSwq1ULkHRm0fVwmQTpRAgRqRDAXmhI
         DMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/G1rWGJS2/7STIbHZyeI4zr+u620g0m8EW8BqeboSSc=;
        b=T/9KySvNjQomGenJ93CWaXq1+xz4sRt0DgM3AqZ75fYE+u+q/97cgNTmsSzNvcQNLy
         81mNCM6X0Fwer/q0QQM8QIoYq6MorZfPyAu0fdB1rQmp2zQi/INve2hE2mM7tsqNS+i8
         8N0VDIG0ni0Ug8U8/C1HdgfSlnNOwZDSlLE8mOfi+giQHKvEqiSOpxHMReh/JKUQL+V5
         sJ3O7lHBqSsqlO+tKQ9TYdwOKfqXhGlh0EPxTsksV2yc+2twXlnjmesye7JNzcd1RUUi
         zzKevICyKAvsZeGpr1XjZFrK7C+pHj7S+V27kJm5K4iG5EYuz6wnyitIknie83/x1zby
         vm0A==
X-Gm-Message-State: AG10YOQ/eL119gE/A8x6wq9aRgpS42wyKuoOVXfSdIrtfSJGxn8cbdzL+vaxFZSWad34o0PHo80MZc0K54w4uA==
X-Received: by 10.31.16.37 with SMTP id g37mr2390625vki.97.1455732494018; Wed,
 17 Feb 2016 10:08:14 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Wed, 17 Feb 2016 10:07:44 -0800 (PST)
In-Reply-To: <CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286529>

On Wed, Feb 17, 2016 at 11:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Feb 17, 2016 at 12:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Wed, Feb 17, 2016 at 2:39 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> My initial reaction was negative due to the heavy review burden this
>>> series has demanded thus far, however, my mind was changing even as I
>>> composed the above response. [...]
>>>
>>> So, I think I'm fine with it, if Karthik is game.
>>
>> Sounds good to me.
>>
>> I just read the conversation between Jeff, Junio and You about the whitespace
>> counter-argument and I think its good to go ahead with v6 with Jeff's suggested
>> change.
>>
>> Since he's already pushed the changes on top of my changes to:
>>  git://github.com/peff/git.git jk/tweaked-ref-filter
>> I'll just have a look and push that to the list as v6.
>
> I reviewed the entire series again, including Peff's changes, so this
> entire series is:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>
> Karthik, feel free to include my Reviewed-by: in all the patches
> (including Peff's) when you post v6.
>
> Thanks.

Oops! I just pushed v6 before I even saw this mail.

-- 
Regards,
Karthik Nayak
