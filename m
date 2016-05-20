From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 0/2] bisect--helper: rewrite of check-term-format()
Date: Fri, 20 May 2016 12:29:21 +0530
Message-ID: <CAFZEwPM5AVx9ErCUCmEq=z5_8g9eL72BtqdEok+EMU0R8uC5JA@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<xmqqtwia25qc.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPOA9c8eQAacnuB1n=juOhN1zsMdzcupS3ijqwYFPRrW4A@mail.gmail.com>
	<xmqq60up1e24.fsf@gitster.mtv.corp.google.com>
	<CAFZEwPML8MCAL2quAN3ExMFXrhjS07g3KEC-WuSfYAXc2WQKuQ@mail.gmail.com>
	<CAFZEwPPZJqGHsHk0RLzo-pA8rUN0VP9-ricycNOnGbhO=2JZgg@mail.gmail.com>
	<CAPig+cRhfJbbP7FE-XkW4uaMu5Gy+UvBbh-rHOY5NK4_SrwjcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 20 08:59:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3eP9-0002AB-Eu
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbcETG7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 02:59:23 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34996 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903AbcETG7X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 02:59:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id n16so422305ywd.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wYwiaUHWobXUblojMbVQmLF0EgPVYagsVoP7L/h/SjU=;
        b=TsIKtrHiNiK8z+qKXhJahRHfOQNwABTE4o7YmD9qWB2QSPgiHUJP0PcQGis0R6FhbT
         4hwqEO0PM3GzjAa401wxfRBlN+8GwUTU59FIKj7JCdGRbhMMAa2TSLQbBODswbCs/y6J
         8oM/jd5Vov4aY3c3eGx5Nv8HjUcf/cNGxZiY3dn5sbCTCw1ABkcJpFyXF8iBHxxoaO3v
         hXeGkPHhBNsSNZUPd3E3QT51CMu1GAGolSFc//az0GlLD20B9+0oSF5SOwl886KZWXMA
         WqSucQ3rllfBrPS58PVmgRlElHGX5niGY7MgD39FEtyWDcc4dwhQ1rhAUNPoTwuBOhZx
         PKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wYwiaUHWobXUblojMbVQmLF0EgPVYagsVoP7L/h/SjU=;
        b=dmxcCeBVwhp+fURG3xhjKxNi9T96ebxrvfuYn70TGXCop1DrXDvKTojEeCxYLP1KVT
         kw2h1iLvaFoGNJ9Gz8RqUtglnz5+39Ok+lVecBLFXkt+uZIz056FiY4B7CUHdrQ2D0ro
         ZpKmiGAkUhxzzEOiWNXYv/2H3NvzmWG0dDg0qjBMwH3dQGj5U6b1dnoR1gMtAEx05hdR
         7ntQ6ncEXNb7zAEhTHHCjTH9ZqpMM7ZdqkjGN/N08L0rSyPc5MmvxXUgplwwaZ/ITxt4
         RPu5LHQUIlbTg6gdsfvcM22AGOXl1LTjBe+FPvbR460/8E0X1uncWo7r+g2KZIZe86Qm
         20zA==
X-Gm-Message-State: AOPr4FWjxe55CovBL0rdqDXCfrp3x20bNzSv+tv3PR0VqyFxmF0GaZ1EuD66zZLAlzBGYeyYGAmCdQN8xYqVIg==
X-Received: by 10.13.198.5 with SMTP id i5mr865597ywd.263.1463727561690; Thu,
 19 May 2016 23:59:21 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 19 May 2016 23:59:21 -0700 (PDT)
In-Reply-To: <CAPig+cRhfJbbP7FE-XkW4uaMu5Gy+UvBbh-rHOY5NK4_SrwjcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295151>

Hey Eric,
Sorry for the late reply. I was on vacation.

On Mon, May 16, 2016 at 6:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 8, 2016 at 9:34 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, May 8, 2016 at 11:53 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> On Sun, May 8, 2016 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Pranit Bauva <pranit.bauva@gmail.com> writes:
>>>>> I completely missed your point and you want me to go the Eric Sunshine's way?
>>>>
>>>> I am neutral.
>>>>
>>>> When I read your response to Eric's "top down" suggestion, I didn't
>>>> quite get much more than "I started going this way, and I do not
>>>> want to change to the other direction.", which was what I had the
>>>> most trouble with.  If your justification for the approach to start
>>>> from building a tiny bottom layer that will need to be dismantled
>>>> soon and repeat that (which sounds somewhat wasteful) were more
>>>> convincing, I may have felt differently.
>>>
>>> Sorry if it seemed that "I have done quite some work and I don't want
>>> to scrape it off and redo everything". This isn't a case for me. I
>>> think of this as just a small part in the process of learning and my
>>> efforts would be completely wasted as I can still reuse the methods I
>>
>> efforts would **not** be completely wasted
>>
>>> wrote. This is still open for a "philosophical" discussion. I am
>>> assuming 1e1ea69fa4e is how Eric is suggesting.
>
> Speaking of 1e1ea69 (pull: implement skeletal builtin pull,
> 2015-06-14), one of the (numerous) things Paul Tan did which impressed
> me was to formally measure test suite coverage of the commands he was
> converting to C, and then improve coverage where it was lacking. That
> approach increases confidence in the conversion far more than fallible
> human reviews do.
>
> Setting aside the top-down vs. bottom-up discussion, as a reviewer
> (and user) I'd be far more interested in seeing you spend a good
> initial chunk of your project emulating Paul's approach to measuring
> and improving test coverage (though I don't know how your GSoC mentors
> feel about that).

Just adding to the points mentioned by Christian.

I had initially planned to first improve test coverage and then start
with function conversion as I mentioned in my introductory mail[1]. I
also pointed out that I did some work searching about the tools to
test coverage (kcov as Matthieu) suggested and I found that it is not
that easy to set it up. Then Christian pointed it out (privately) that
I can do this afterwards too before the code is finally merged. And
also I am trying to see the test coverage as and when I am converting
each function.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/292308

Regards,
Pranit Bauva
