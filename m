From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] ref-filter: fallback on alphabetical comparison
Date: Thu, 29 Oct 2015 19:47:35 +0530
Message-ID: <CAOLa=ZTKQb2RyBKN8+xmqvOhDwbfRjDKpNthdLT-wgCtGcB8-g@mail.gmail.com>
References: <1445972456-5621-1-git-send-email-Karthik.188@gmail.com>
 <xmqq7fm8ozu9.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSF5bJocJkMG70x0kTaU139pj0-ONypC=V2Tdnu3yQtow@mail.gmail.com>
 <xmqqy4emskod.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zro1v-0003Bo-7W
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 15:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbbJ2OSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 10:18:11 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34278 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbJ2OSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 10:18:10 -0400
Received: by vkgs66 with SMTP id s66so27257959vkg.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Gza/6lC953Qt7HptrB7pfbTIBDxV/iL45xv9xn56UkQ=;
        b=DT6lpBQIOewwzhFsJkDBtXYsIWe2YpClB/OJVNtD17aQYP4MkssimR7EaLqj7lZ8S7
         QcIN0WzSHFI3epWa5e4cX4NRNpVkNe2TfBWpLFWgvBJlTn07LzrFlkaMOC6gnRnUpicf
         yYWIyK7RnSzU0fT97Cx7jLmBi0zs8qP5iIAYAhRpbAxEUa7YQwOLR0QnK6LbgMzdZ5di
         JZ4zQDV+S8MFBFKrI2z3RD0ZdxJUorj0UDOuM7oA1bU87aEysm3VcL6ikjSrsVPXKICC
         Ylwvf5ePUeRwA1Tw2Y7rAy/eVAeTTPioHt3HAnIlRsQUHYnozFs/mhBPcXEuNRzG6bl8
         3o5Q==
X-Received: by 10.31.49.10 with SMTP id x10mr1348943vkx.46.1446128284777; Thu,
 29 Oct 2015 07:18:04 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Thu, 29 Oct 2015 07:17:35 -0700 (PDT)
In-Reply-To: <xmqqy4emskod.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280440>

On Thu, Oct 29, 2015 at 3:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Oct 28, 2015 at 1:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Hence, fallback to alphabetical comparison based on the refname
>>>> whenever the other criterion is equal. Fix the test in t3203 in this
>>>> regard.
>>>
>>> It is unclear what "in this regard" is.  Do you mean this (I am not
>>> suggesting you to spell these out in a very detailed way in the
>>> final log message; I am deliberately being detailed here to help me
>>> understand what you really mean)?
>>>
>>>     A test in t3203 was expecting that branch-two sorts before HEAD,
>>>     which happened to be how qsort(3) on Linux sorted the array, but
>>>     (1) that outcome was not even guaranteed, and (2) once we start
>>>     breaking ties with the refname, "HEAD" should sort before
>>>     "branch-two" so the original expectation was inconsistent with
>>>     the criterion we now use.
>>>
>>
>> Exactly what you're saying, they happened to have the same objectsize.
>> Hence sorting them would put them together, but since we compare the
>> refname's the "HEAD" ref would come before "branch-two".
>>
>>>     Update it to match the new world order, which we can now depend
>>>     on being stable.
>>>
>>> I am not sure about "HEAD" and "branch-two" in the above (it may be
>>> comparison between "HEAD" and "refs/heads/branch-two", for example).
>>
>> It actually is, we consider "refs/heads/branch-two rather then the shortened
>> version of this. It makes sense to classify refs this way, even though this
>> was a side effect of this commit.
>
> Now these are enough bits of info, that can and needs to be
> condenced into an updated log message to help future readers.
>
> Thanks.

Will update and send, thanks :)

-- 
Regards,
Karthik Nayak
