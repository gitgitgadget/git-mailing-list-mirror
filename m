From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Sun, 15 May 2016 20:35:40 -0400
Message-ID: <CAPig+cRhfJbbP7FE-XkW4uaMu5Gy+UvBbh-rHOY5NK4_SrwjcA@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	<xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
	<CAFZEwPPZJqGHsHk0RLzo-pA8rUN0VP9-ricycNOnGbhO=2JZgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 02:35:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b26Vf-0001bk-U2
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 02:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbcEPAfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 20:35:42 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35986 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcEPAfl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 20:35:41 -0400
Received: by mail-ig0-f195.google.com with SMTP id c3so5679077igl.3
        for <git@vger.kernel.org>; Sun, 15 May 2016 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+PZIHjybw4vSex+Wf7lwmQsVLfQ9Svykg8yief1FzAk=;
        b=m5JkgMsvnxX6bbTEIJ5rz1SYfgFnvwSCNh3od5dqbNLgzHeVargEXe7lt72iMY3cZB
         bPuk+1aU12zFJ2REn3fg9udnAonWMGe8Mh+Tz8WPwFqAQsVXJn0DXXczkYHeLz5NVkLv
         WuZRPii8X58jg8xqf5wuK3DFosrFLkiQteXbp+GZc7nJpzZRIqkShRTCBPHpwOs1WmjK
         oQlmIuekA2ZzJocNBSrIp/hO8xqxq2QOzdFeJMVMSCIGU5gWEMtswQWgku/KStPksS3J
         JbQ1joGcPAuu+6qjQrAeUmtrcFl0y/OJau30mJbUWLdIX+lGntRM4OwBIgm1P3mns9GN
         FvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+PZIHjybw4vSex+Wf7lwmQsVLfQ9Svykg8yief1FzAk=;
        b=ZnJfcDM5BkeX2Ca/SqI+J3AqpjtSrxJyC5+NVX9tn1wI1I9IVNOQbLQ47dx5ZrCQ4j
         rEmMh8jtn54FvoqNCcLnX5jeMZNpjFurw2g/9spdRVEDgr+LjgPHHv1UnCY8N9oQMcKa
         UfRoRbE7pb50v4uyemP1rm4iBDwjsFY/hBWdA0o9psnhIOGipILOw5NHmhYWf1XjOste
         ip968Jl+2wOMuaO2jDAoQvsETWwuBFl75oxDShbFTAUMZ/NfUVLQBh8vOozHr4CEA4zR
         LkhImjGvCJgaGtueXhdQYWWKrAyrBDuzFcVJQ/IKcV64ccgHoYB1dsRCSA+n5+o5jrra
         BJSw==
X-Gm-Message-State: AOPr4FW9VuhLPRRw1N4WdPMPh12GMZBXK6974o5zwrsRGU/BRAItEE1NrlJ/hNJaAd/HjDws10pqZ5eg1LeqAA==
X-Received: by 10.50.3.105 with SMTP id b9mr8879333igb.17.1463358940826; Sun,
 15 May 2016 17:35:40 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 15 May 2016 17:35:40 -0700 (PDT)
In-Reply-To: <CAFZEwPPZJqGHsHk0RLzo-pA8rUN0VP9-ricycNOnGbhO=2JZgg@mail.gmail.com>
X-Google-Sender-Auth: AXVAyQCajnPhMEDMMR-7xZGrGvA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294708>

On Sun, May 8, 2016 at 9:34 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, May 8, 2016 at 11:53 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, May 8, 2016 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>> I completely missed your point and you want me to go the Eric Sunshine's way?
>>>
>>> I am neutral.
>>>
>>> When I read your response to Eric's "top down" suggestion, I didn't
>>> quite get much more than "I started going this way, and I do not
>>> want to change to the other direction.", which was what I had the
>>> most trouble with.  If your justification for the approach to start
>>> from building a tiny bottom layer that will need to be dismantled
>>> soon and repeat that (which sounds somewhat wasteful) were more
>>> convincing, I may have felt differently.
>>
>> Sorry if it seemed that "I have done quite some work and I don't want
>> to scrape it off and redo everything". This isn't a case for me. I
>> think of this as just a small part in the process of learning and my
>> efforts would be completely wasted as I can still reuse the methods I
>
> efforts would **not** be completely wasted
>
>> wrote. This is still open for a "philosophical" discussion. I am
>> assuming 1e1ea69fa4e is how Eric is suggesting.

Speaking of 1e1ea69 (pull: implement skeletal builtin pull,
2015-06-14), one of the (numerous) things Paul Tan did which impressed
me was to formally measure test suite coverage of the commands he was
converting to C, and then improve coverage where it was lacking. That
approach increases confidence in the conversion far more than fallible
human reviews do.

Setting aside the top-down vs. bottom-up discussion, as a reviewer
(and user) I'd be far more interested in seeing you spend a good
initial chunk of your project emulating Paul's approach to measuring
and improving test coverage (though I don't know how your GSoC mentors
feel about that).
