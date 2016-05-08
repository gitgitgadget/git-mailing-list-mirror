From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Sun, 8 May 2016 21:03:29 +0530
Message-ID: <CAFZEwPPsY=kf7KjmyGk6xcwzT8Yi_oAQiFAUWNLcU00WZT-1+w@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605080858190.4092@virtualbox>
	<CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
	<CAP8UFD1PqU+WeuDp0f0_yyrYsGt=qwbkTUXji4_DJiJoGf_nJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 17:33:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azQi7-0008KD-4O
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 17:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbcEHPdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 11:33:31 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36624 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbcEHPda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 11:33:30 -0400
Received: by mail-yw0-f195.google.com with SMTP id u62so21459852ywe.3
        for <git@vger.kernel.org>; Sun, 08 May 2016 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YRZH2fQdHz3jhr3fM+1mjAq2wU8dYcAfxAis0LInj7E=;
        b=a0A0iDvZw8SEDvE7MSxdfc9wcL/roQN2sVWlFpLaB0svoXEJbVg3YWlEF0W7XA2LCg
         NwcaNtVh+8JlSS2rK/0anUXdAnxjW4JLg4cDBFFP/G5K58oZcbGcCn185EV0mKRBSfXP
         1a3hn9m+Q76VKRbUdDa1VmmufLJPIu1ZVVD+9JSYxJHtMJQ5QsZe3hCjcz3BTSBw/26+
         Y8u61nZ5w2L5ZtGFDDZiR/cFHbOhCz9g6CGofvWQTNhAXpNcBTwwLUpREP4BMtJ92Y+W
         80qyuQ+b8gMj0THeakudzaZ9Dz3wOMvTGgzqkXnsJpgbTosSfYY+N90gqRLOhEgidpDh
         KMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YRZH2fQdHz3jhr3fM+1mjAq2wU8dYcAfxAis0LInj7E=;
        b=FYqcAIAccdANw4ODEtzsFV9UYNsK7Wk2vD9IEnrN79dZkzXhpnXO2bvn9fT5y1H6XZ
         Xe1TUigK+E+SdGEaODrWNOfVxp50ocYa4JvqgGoAxnajEeSVhDZGjOe6JAs5TDpDjhjF
         lR2WqQBUgr3KGhMpUhcmHHPxSXIEkv+ZUAhXiwFgtpEcNX4BdwS/xj2t2EL4J502T8DS
         ajy7O9tXwkMpiakHAcNxIfFSHs5JviJSxQw5K6OfYvhWNsKV3fs77qPPagwk4gmWAtb+
         1rQ8bFuDKqJWniEF/7QCSKx+EnsF1NZJGXcZt8opoKCF0U1LZsa9j3pHEZkwVSWnKsYG
         VXxw==
X-Gm-Message-State: AOPr4FWp0xaOYYsmXeOriNLOuoysGurKc+Bwg3JNuXIy7LVjPIQcJFvmaQbLo+hwEdNAjg8mD3YqAhVsWgUzlQ==
X-Received: by 10.37.118.69 with SMTP id r66mr2864142ybc.80.1462721610029;
 Sun, 08 May 2016 08:33:30 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 8 May 2016 08:33:29 -0700 (PDT)
In-Reply-To: <CAP8UFD1PqU+WeuDp0f0_yyrYsGt=qwbkTUXji4_DJiJoGf_nJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293969>

On Sun, May 8, 2016 at 9:00 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, May 8, 2016 at 9:17 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Sun, May 8, 2016 at 12:34 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Pranit,
>>>
>>> On Fri, 6 May 2016, Pranit Bauva wrote:
>>>
>>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>>> index 3324229..d8de651 100644
>>>> --- a/builtin/bisect--helper.c
>>>> +++ b/builtin/bisect--helper.c
>>>> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>>>>       NULL
>>>>  };
>>>>
>>>> +enum subcommand {
>>>> +     NEXT_ALL = 1
>>>> +};
>>>
>>> I still do not think that this enum needs to have file scope. Function
>>> scope is enough.
>>
>> In the very initial patch I made it in function scope. To which you
>> pointed out[1] that in all other examples but for one have file scope
>> so then I thought maybe that exception was a wrong example and I
>> should stick to the convention of putting it in file scope.
>
> In the message Dscho wrote:
>
> "Interesting. I did not think that Git's source code declares enums inside
> functions, but builtin/remote.c's config_read_branches() does, so this
> code is fine." So you didn't need to put it back in file scope.
>
> Please don't change things when you are told they are fine unless
> there is a good reason like a bug and in this case explain the reason.

I will keep this in mind.

>> But now I
>> also realize that builtin/replace.c uses "cmdmode" instead of
>> "subcommand" so I am still wondering what would be the most
>> appropriate?
>>
>>>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>>>  {
>>>> -     int next_all = 0;
>>>> +     int subcommand = 0;
>>>
>>> Since subcommand is not simply an integer, but wants to take on the values
>>> defined in the enum above, the type should be changed accordingly. You
>>> could do it this way (short and sweet, with the appropriate scope):
>>>
>>>         enum { NEXT_ALL = 1 } subcommand = 0;
>>>
>>> See https://github.com/git/git/blob/v2.8.2/builtin/replace.c#L423-L430 for
>>> an example (which uses "cmdmode" instead of "subcommand", too).
>
> Yeah, please use "cmdmode" as Junio already suggested and do it like
> in the example that Dscho points to.

Yes sure!

> Thanks,
> Christian.
